import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../config/environment.dart';
import 'state_persistence_service.dart';

/// Production sync service for offline/online synchronization
class SyncServiceProduction {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final Connectivity _connectivity = Connectivity();
  
  static bool _isInitialized = false;
  static bool _isSyncing = false;
  static bool _hasInternetConnection = false;
  static DateTime? _lastSyncTime;
  
  static StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  static final StreamController<SyncStatus> _syncStatusController = 
      StreamController<SyncStatus>.broadcast();

  /// Initialize the sync service
  static Future<void> initialize() async {
    try {
      // Load last sync time from storage
      _lastSyncTime = await _loadLastSyncTime();
      
      // Check initial connectivity
      await _checkConnectivity();
      
      // Listen to connectivity changes
      _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_onConnectivityChanged);
      
      // Setup Firestore settings for offline support
      await _setupFirestoreOfflineSupport();
      
      _isInitialized = true;
      
      if (Environment.enableLogging) {
        print('✅ Sync service initialized');
        print('📶 Internet connection: $_hasInternetConnection');
        print('⏰ Last sync: ${_lastSyncTime?.toIso8601String() ?? 'Never'}');
      }
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Sync service initialization failed: $e');
      }
      rethrow;
    }
  }

  /// Dispose the sync service
  static Future<void> dispose() async {
    await _connectivitySubscription?.cancel();
    await _syncStatusController.close();
    _isInitialized = false;
  }

  /// Check current connectivity status
  static Future<void> _checkConnectivity() async {
    try {
      final results = await _connectivity.checkConnectivity();
      _hasInternetConnection = results.isNotEmpty && 
          results.any((result) => result != ConnectivityResult.none);
    } catch (e) {
      _hasInternetConnection = false;
      if (Environment.enableLogging) {
        print('❌ Connectivity check failed: $e');
      }
    }
  }

  /// Handle connectivity changes
  static void _onConnectivityChanged(List<ConnectivityResult> results) {
    final wasConnected = _hasInternetConnection;
    _hasInternetConnection = results.isNotEmpty && 
        results.any((result) => result != ConnectivityResult.none);
    
    if (Environment.enableLogging) {
      print('📶 Connectivity changed: $_hasInternetConnection');
    }
    
    // If we just came online, trigger sync
    if (!wasConnected && _hasInternetConnection) {
      _triggerAutoSync();
    }
    
    _notifySyncStatus(SyncStatus.connectivityChanged(_hasInternetConnection));
  }

  /// Setup Firestore for offline support
  static Future<void> _setupFirestoreOfflineSupport() async {
    try {
      // Enable offline persistence
      await _firestore.enablePersistence();
      
      if (Environment.enableLogging) {
        print('✅ Firestore offline persistence enabled');
      }
    } catch (e) {
      // Persistence might already be enabled
      if (Environment.enableLogging) {
        print('⚠️ Firestore persistence setup: $e');
      }
    }
  }

  /// Sync data with cloud
  static Future<SyncResult> syncData({
    bool forceSync = false,
    List<String> collections = const ['notes', 'settings', 'chat_history'],
  }) async {
    if (!_isInitialized) {
      throw StateError('Sync service not initialized');
    }

    if (_isSyncing && !forceSync) {
      return SyncResult.alreadyInProgress();
    }

    _isSyncing = true;
    final startTime = DateTime.now();
    
    _notifySyncStatus(SyncStatus.syncing());

    try {
      int uploadedCount = 0;
      int downloadedCount = 0;
      final errors = <String>[];

      // Check if we have internet connection
      if (!_hasInternetConnection) {
        if (Environment.enableLogging) {
          print('📱 Offline mode: Queuing changes for later sync');
        }
        return SyncResult.offline();
      }

      // Sync each collection
      for (final collection in collections) {
        try {
          final result = await _syncCollection(collection);
          uploadedCount += result.uploaded;
          downloadedCount += result.downloaded;
        } catch (e) {
          errors.add('$collection: $e');
          if (Environment.enableLogging) {
            print('❌ Error syncing $collection: $e');
          }
        }
      }

      // Update last sync time
      _lastSyncTime = DateTime.now();
      await _saveLastSyncTime(_lastSyncTime!);

      final duration = DateTime.now().difference(startTime);
      final result = SyncResult.success(
        uploadedCount: uploadedCount,
        downloadedCount: downloadedCount,
        duration: duration,
        errors: errors,
      );

      _notifySyncStatus(SyncStatus.completed(result));
      
      if (Environment.enableLogging) {
        print('✅ Sync completed: ${result.toString()}');
      }

      return result;
    } catch (e) {
      final error = 'Sync failed: $e';
      _notifySyncStatus(SyncStatus.failed(error));
      
      if (Environment.enableLogging) {
        print('❌ Sync failed: $e');
      }
      
      return SyncResult.failed(error);
    } finally {
      _isSyncing = false;
    }
  }

  /// Sync a specific collection
  static Future<CollectionSyncResult> _syncCollection(String collectionName) async {
    int uploaded = 0;
    int downloaded = 0;

    try {
      // Get local changes that need to be uploaded
      final localChanges = await _getLocalChanges(collectionName);
      
      // Upload local changes
      for (final change in localChanges) {
        await _uploadChange(collectionName, change);
        uploaded++;
      }

      // Get remote changes since last sync
      final remoteChanges = await _getRemoteChanges(collectionName);
      
      // Download and apply remote changes
      for (final change in remoteChanges) {
        await _applyRemoteChange(collectionName, change);
        downloaded++;
      }

      return CollectionSyncResult(uploaded: uploaded, downloaded: downloaded);
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Collection sync failed for $collectionName: $e');
      }
      rethrow;
    }
  }

  /// Get local changes that need to be synced
  static Future<List<Map<String, dynamic>>> _getLocalChanges(String collection) async {
    try {
      // Load pending changes from local storage
      final changes = await StatePersistenceService.loadState<List<dynamic>>('pending_changes_$collection', defaultValue: []);
      return changes?.cast<Map<String, dynamic>>() ?? [];
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Failed to get local changes for $collection: $e');
      }
      return [];
    }
  }

  /// Upload a change to the cloud
  static Future<void> _uploadChange(String collection, Map<String, dynamic> change) async {
    try {
      final docRef = _firestore.collection(collection).doc(change['id']);
      
      switch (change['operation']) {
        case 'create':
        case 'update':
          await docRef.set(change['data'], SetOptions(merge: true));
          break;
        case 'delete':
          await docRef.delete();
          break;
      }

      // Remove from pending changes
      await _removePendingChange(collection, change['id']);
      
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Failed to upload change: $e');
      }
      rethrow;
    }
  }

  /// Get remote changes since last sync
  static Future<List<QueryDocumentSnapshot>> _getRemoteChanges(String collection) async {
    try {
      Query query = _firestore.collection(collection);
      
      // Filter by last sync time if available
      if (_lastSyncTime != null) {
        query = query.where('updatedAt', isGreaterThan: Timestamp.fromDate(_lastSyncTime!));
      }
      
      final snapshot = await query.get();
      return snapshot.docs;
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Failed to get remote changes for $collection: $e');
      }
      return [];
    }
  }

  /// Apply a remote change locally
  static Future<void> _applyRemoteChange(String collection, QueryDocumentSnapshot doc) async {
    try {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      
      // Save to local storage
      await StatePersistenceService.saveState('${collection}_${doc.id}', data);
      
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Failed to apply remote change: $e');
      }
    }
  }

  /// Queue a change for later sync
  static Future<void> queueChange({
    required String collection,
    required String id,
    required String operation, // 'create', 'update', 'delete'
    Map<String, dynamic>? data,
  }) async {
    if (!_isInitialized) return;

    try {
      final change = {
        'id': id,
        'operation': operation,
        'data': data,
        'timestamp': DateTime.now().toIso8601String(),
      };

      // Add to pending changes
      final pendingChanges = await StatePersistenceService.loadState<List<dynamic>>('pending_changes_$collection', defaultValue: []);
      final changes = pendingChanges?.cast<Map<String, dynamic>>() ?? <Map<String, dynamic>>[];
      
      // Remove existing change for same ID if exists
      changes.removeWhere((c) => c['id'] == id);
      
      // Add new change
      changes.add(change);
      
      await StatePersistenceService.saveState('pending_changes_$collection', changes);
      
      if (Environment.enableLogging) {
        print('📥 Queued change: $collection.$id ($operation)');
      }

      // Try to sync immediately if online
      if (_hasInternetConnection) {
        _triggerAutoSync();
      }
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Failed to queue change: $e');
      }
    }
  }

  /// Remove a pending change
  static Future<void> _removePendingChange(String collection, String id) async {
    try {
      final pendingChanges = await StatePersistenceService.loadState<List<dynamic>>('pending_changes_$collection', defaultValue: []);
      final changes = pendingChanges?.cast<Map<String, dynamic>>() ?? <Map<String, dynamic>>[];
      
      changes.removeWhere((c) => c['id'] == id);
      
      await StatePersistenceService.saveState('pending_changes_$collection', changes);
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Failed to remove pending change: $e');
      }
    }
  }

  /// Trigger automatic sync
  static void _triggerAutoSync() {
    if (_isSyncing) return;
    
    // Debounce auto sync
    Timer(const Duration(seconds: 2), () {
      if (_hasInternetConnection && !_isSyncing) {
        syncData();
      }
    });
  }

  /// Get sync status stream
  static Stream<SyncStatus> get syncStatusStream => _syncStatusController.stream;

  /// Notify sync status change
  static void _notifySyncStatus(SyncStatus status) {
    if (!_syncStatusController.isClosed) {
      _syncStatusController.add(status);
    }
  }

  /// Get current sync status
  static SyncStatus getCurrentStatus() {
    if (_isSyncing) {
      return SyncStatus.syncing();
    } else if (!_hasInternetConnection) {
      return SyncStatus.offline();
    } else {
      return SyncStatus.idle();
    }
  }

  /// Load last sync time from storage
  static Future<DateTime?> _loadLastSyncTime() async {
    try {
      final timeMs = await StatePersistenceService.loadState<int>('last_sync_time');
      return timeMs != null ? DateTime.fromMillisecondsSinceEpoch(timeMs) : null;
    } catch (e) {
      return null;
    }
  }

  /// Save last sync time to storage
  static Future<void> _saveLastSyncTime(DateTime time) async {
    try {
      await StatePersistenceService.saveState('last_sync_time', time.millisecondsSinceEpoch);
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Failed to save last sync time: $e');
      }
    }
  }

  /// Get sync statistics
  static Future<Map<String, dynamic>> getSyncStats() async {
    final pendingChanges = <String, int>{};
    final collections = ['notes', 'settings', 'chat_history'];
    
    for (final collection in collections) {
      final changes = await StatePersistenceService.loadState<List<dynamic>>('pending_changes_$collection', defaultValue: []);
      pendingChanges[collection] = changes?.length ?? 0;
    }

    return {
      'isInitialized': _isInitialized,
      'isSyncing': _isSyncing,
      'hasInternetConnection': _hasInternetConnection,
      'lastSyncTime': _lastSyncTime?.toIso8601String(),
      'pendingChanges': pendingChanges,
      'totalPendingChanges': pendingChanges.values.fold(0, (sum, count) => sum + count),
    };
  }

  /// Force full resync
  static Future<SyncResult> forceFullResync() async {
    // Clear last sync time to trigger full sync
    await StatePersistenceService.removeState('last_sync_time');
    _lastSyncTime = null;
    
    return await syncData(forceSync: true);
  }
}

/// Sync status
class SyncStatus {
  final SyncStatusType type;
  final String? message;
  final SyncResult? result;
  final bool hasInternetConnection;

  const SyncStatus._(this.type, {this.message, this.result, this.hasInternetConnection = true});

  factory SyncStatus.idle() => const SyncStatus._(SyncStatusType.idle);
  factory SyncStatus.syncing() => const SyncStatus._(SyncStatusType.syncing, message: 'Syncing...');
  factory SyncStatus.completed(SyncResult result) => SyncStatus._(SyncStatusType.completed, result: result, message: 'Sync completed');
  factory SyncStatus.failed(String error) => SyncStatus._(SyncStatusType.failed, message: error);
  factory SyncStatus.offline() => const SyncStatus._(SyncStatusType.offline, message: 'Offline', hasInternetConnection: false);
  factory SyncStatus.connectivityChanged(bool connected) => SyncStatus._(SyncStatusType.connectivityChanged, hasInternetConnection: connected);
}

enum SyncStatusType {
  idle,
  syncing,
  completed,
  failed,
  offline,
  connectivityChanged,
}

/// Sync result
class SyncResult {
  final bool success;
  final int uploadedCount;
  final int downloadedCount;
  final Duration? duration;
  final List<String> errors;
  final String? errorMessage;

  const SyncResult._(
    this.success, {
    this.uploadedCount = 0,
    this.downloadedCount = 0,
    this.duration,
    this.errors = const [],
    this.errorMessage,
  });

  factory SyncResult.success({
    int uploadedCount = 0,
    int downloadedCount = 0,
    Duration? duration,
    List<String> errors = const [],
  }) => SyncResult._(
    true,
    uploadedCount: uploadedCount,
    downloadedCount: downloadedCount,
    duration: duration,
    errors: errors,
  );

  factory SyncResult.failed(String error) => SyncResult._(false, errorMessage: error);
  factory SyncResult.offline() => const SyncResult._(false, errorMessage: 'Offline');
  factory SyncResult.alreadyInProgress() => const SyncResult._(false, errorMessage: 'Sync already in progress');

  @override
  String toString() {
    if (!success) {
      return 'SyncResult(failed: $errorMessage)';
    }
    return 'SyncResult(success: uploaded=$uploadedCount, downloaded=$downloadedCount, duration=${duration?.inMilliseconds}ms, errors=${errors.length})';
  }
}

/// Collection sync result
class CollectionSyncResult {
  final int uploaded;
  final int downloaded;

  const CollectionSyncResult({
    required this.uploaded,
    required this.downloaded,
  });
}
