import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:workmanager/workmanager.dart';
import 'package:note_domain/note_domain.dart';
import '../injection.dart';

/// Unified Sync Service
/// 
/// Consolidates sync functionality from both sync_service.dart and sync_service_production.dart
/// Provides both development and production sync capabilities
class UnifiedSyncService {
  static final UnifiedSyncService _instance = UnifiedSyncService._internal();
  factory UnifiedSyncService() => _instance;
  UnifiedSyncService._internal();

  // Task identifiers
  static const String _periodicTaskName = 'syncNotesTask';
  static const String _oneOffTaskName = 'syncOnConnect';
  static const String _periodicTaskId = '1';
  static const String _oneOffTaskId = '2';

  // Services
  FirebaseFirestore? _firestore;
  Connectivity? _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  
  // State
  bool _isOnline = false;
  bool _isInitialized = false;
  bool _isProductionMode = false;

  /// Initialize the unified sync service
  Future<void> initialize({bool productionMode = false}) async {
    if (_isInitialized) return;
    
    _isProductionMode = productionMode;
    _connectivity = Connectivity();

    if (productionMode) {
      await _initializeProduction();
    } else {
      await _initializeDevelopment();
    }

    await _setupConnectivityMonitoring();
    _isInitialized = true;
  }

  /// Initialize production-specific features
  Future<void> _initializeProduction() async {
    _firestore = FirebaseFirestore.instance;
    
    // Configure Firestore settings for production
    _firestore?.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }

  /// Initialize development-specific features  
  Future<void> _initializeDevelopment() async {
    _firestore = FirebaseFirestore.instance;
    
    // Register periodic task (every 15 minutes)
    await Workmanager().registerPeriodicTask(
      _periodicTaskId,
      _periodicTaskName,
      frequency: const Duration(minutes: 15),
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresDeviceIdle: false,
        requiresStorageNotLow: false,
      ),
    );
  }

  /// Setup connectivity monitoring
  Future<void> _setupConnectivityMonitoring() async {
    _connectivitySubscription = _connectivity!.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        final wasOnline = _isOnline;
        _isOnline = results.any((result) => result != ConnectivityResult.none);
        
        if (!wasOnline && _isOnline) {
          // Just connected - trigger sync
          _onConnectivityRestored();
        }
      },
    );

    // Check initial connectivity
    final results = await _connectivity!.checkConnectivity();
    _isOnline = results.any((result) => result != ConnectivityResult.none);
  }

  /// Handle connectivity restoration
  void _onConnectivityRestored() {
    if (_isProductionMode) {
      _triggerProductionSync();
    } else {
      _triggerDevelopmentSync();
    }
  }

  /// Trigger production sync
  void _triggerProductionSync() {
    // Production sync logic
    _syncWithFirestore();
  }

  /// Trigger development sync
  void _triggerDevelopmentSync() {
    // Register one-off task for immediate sync
    Workmanager().registerOneOffTask(
      _oneOffTaskId,
      _oneOffTaskName,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }

  /// Sync with Firestore
  Future<void> _syncWithFirestore() async {
    if (!_isOnline || _firestore == null) return;

    try {
      final noteRepository = getIt<NoteRepository>();
      final localNotes = await noteRepository.getNotes();
      
      for (final note in localNotes) {
        await _firestore!.collection('notes').doc(note.id).set({
          'title': note.title,
          'content': note.content,
          'createdAt': note.createdAt.toIso8601String(),
          'updatedAt': note.updatedAt.toIso8601String(),
        });
      }
    } catch (e) {
      print('Sync error: $e');
    }
  }

  /// Manual sync trigger
  Future<void> syncNow() async {
    await _syncWithFirestore();
  }

  /// Get connectivity status
  bool get isOnline => _isOnline;

  /// Get initialization status
  bool get isInitialized => _isInitialized;

  /// Dispose resources
  void dispose() {
    _connectivitySubscription?.cancel();
    _isInitialized = false;
  }
}