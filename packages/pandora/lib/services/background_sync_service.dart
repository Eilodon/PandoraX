import 'package:workmanager/workmanager.dart';
import '../config/environment.dart';
import 'sync_service_production.dart';
import 'state_persistence_service.dart';

/// Background sync service using WorkManager
class BackgroundSyncService {
  static const String _syncTaskName = 'pandora_sync_task';
  static const String _periodicSyncTask = 'pandora_periodic_sync';
  static const String _oneTimeSyncTask = 'pandora_onetime_sync';
  
  static bool _isInitialized = false;

  /// Initialize background sync service
  static Future<void> initialize() async {
    try {
      // Initialize WorkManager
      await Workmanager().initialize(
        callbackDispatcher,
        isInDebugMode: Environment.enableLogging,
      );

      // Initialize state persistence (required for sync)
      if (!StatePersistenceService._isInitialized) {
        await StatePersistenceService.initialize();
      }

      // Register periodic sync task
      await _registerPeriodicSync();
      
      _isInitialized = true;
      
      if (Environment.enableLogging) {
        print('✅ Background sync service initialized');
      }
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Background sync service initialization failed: $e');
      }
      rethrow;
    }
  }

  /// Register periodic sync task
  static Future<void> _registerPeriodicSync() async {
    try {
      // Cancel existing periodic tasks
      await Workmanager().cancelByUniqueName(_periodicSyncTask);
      
      // Register new periodic sync (every 15 minutes)
      await Workmanager().registerPeriodicTask(
        _periodicSyncTask,
        _syncTaskName,
        frequency: const Duration(minutes: 15),
        constraints: Constraints(
          networkType: NetworkType.connected,
          requiresBatteryNotLow: true,
          requiresCharging: false,
          requiresDeviceIdle: false,
          requiresStorageNotLow: true,
        ),
        inputData: {
          'task_type': 'periodic',
          'collections': ['notes', 'settings', 'chat_history'],
        },
      );
      
      if (Environment.enableLogging) {
        print('📅 Periodic sync task registered (15 min interval)');
      }
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Failed to register periodic sync: $e');
      }
    }
  }

  /// Schedule one-time sync
  static Future<void> scheduleOneTimeSync({
    Duration delay = Duration.zero,
    List<String> collections = const ['notes', 'settings', 'chat_history'],
    bool requiresNetwork = true,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      await Workmanager().registerOneOffTask(
        '${_oneTimeSyncTask}_${DateTime.now().millisecondsSinceEpoch}',
        _syncTaskName,
        initialDelay: delay,
        constraints: Constraints(
          networkType: requiresNetwork ? NetworkType.connected : NetworkType.not_required,
          requiresBatteryNotLow: true,
          requiresCharging: false,
          requiresDeviceIdle: false,
          requiresStorageNotLow: true,
        ),
        inputData: {
          'task_type': 'onetime',
          'collections': collections,
          'requires_network': requiresNetwork,
        },
      );
      
      if (Environment.enableLogging) {
        print('⏰ One-time sync scheduled with ${delay.inSeconds}s delay');
      }
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Failed to schedule one-time sync: $e');
      }
    }
  }

  /// Schedule sync when app goes to background
  static Future<void> scheduleBackgroundSync() async {
    await scheduleOneTimeSync(
      delay: const Duration(minutes: 1),
      collections: ['notes', 'settings'],
    );
  }

  /// Schedule sync when connectivity is restored
  static Future<void> scheduleConnectivityRestoredSync() async {
    await scheduleOneTimeSync(
      delay: const Duration(seconds: 5),
      requiresNetwork: true,
    );
  }

  /// Cancel all sync tasks
  static Future<void> cancelAllSyncTasks() async {
    try {
      await Workmanager().cancelByUniqueName(_periodicSyncTask);
      await Workmanager().cancelByTag(_syncTaskName);
      
      if (Environment.enableLogging) {
        print('🚫 All sync tasks cancelled');
      }
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Failed to cancel sync tasks: $e');
      }
    }
  }

  /// Enable/disable background sync
  static Future<void> setBackgroundSyncEnabled(bool enabled) async {
    try {
      await StatePersistenceService.saveState('background_sync_enabled', enabled);
      
      if (enabled) {
        await _registerPeriodicSync();
      } else {
        await cancelAllSyncTasks();
      }
      
      if (Environment.enableLogging) {
        print('🔄 Background sync ${enabled ? 'enabled' : 'disabled'}');
      }
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Failed to set background sync enabled: $e');
      }
    }
  }

  /// Check if background sync is enabled
  static Future<bool> isBackgroundSyncEnabled() async {
    try {
      return StatePersistenceService.loadState<bool>('background_sync_enabled', defaultValue: true) ?? true;
    } catch (e) {
      return true; // Default to enabled
    }
  }

  /// Get background sync statistics
  static Future<Map<String, dynamic>> getBackgroundSyncStats() async {
    try {
      final lastRunTime = StatePersistenceService.loadState<int>('last_background_sync');
      final runCount = StatePersistenceService.loadState<int>('background_sync_count', defaultValue: 0) ?? 0;
      final lastError = StatePersistenceService.loadState<String>('last_background_sync_error');
      
      return {
        'isEnabled': await isBackgroundSyncEnabled(),
        'lastRunTime': lastRunTime != null ? DateTime.fromMillisecondsSinceEpoch(lastRunTime).toIso8601String() : null,
        'runCount': runCount,
        'lastError': lastError,
      };
    } catch (e) {
      return {
        'error': e.toString(),
      };
    }
  }
}

/// WorkManager callback dispatcher
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      if (Environment.enableLogging) {
        print('🔄 Background task started: $task');
        print('📥 Input data: $inputData');
      }

      // Initialize required services
      await StatePersistenceService.initialize();
      await SyncServiceProduction.initialize();

      // Check if background sync is enabled
      final isEnabled = await BackgroundSyncService.isBackgroundSyncEnabled();
      if (!isEnabled) {
        if (Environment.enableLogging) {
          print('⏸️ Background sync is disabled, skipping');
        }
        return Future.value(true);
      }

      // Extract task parameters
      final taskType = inputData?['task_type'] ?? 'periodic';
      final collections = (inputData?['collections'] as List<dynamic>?)?.cast<String>() ?? 
          ['notes', 'settings', 'chat_history'];
      final requiresNetwork = inputData?['requires_network'] ?? true;

      // Check network requirement (accessing private field correctly)
      if (requiresNetwork) {
        final syncStats = await SyncServiceProduction.getSyncStats();
        if (!(syncStats['hasInternetConnection'] as bool? ?? false)) {
          if (Environment.enableLogging) {
            print('📱 No internet connection, skipping sync');
          }
          return Future.value(true);
        }
      }

      // Record sync attempt
      await StatePersistenceService.saveState('last_background_sync', DateTime.now().millisecondsSinceEpoch);
      final runCount = StatePersistenceService.loadState<int>('background_sync_count', defaultValue: 0) ?? 0;
      await StatePersistenceService.saveState('background_sync_count', runCount + 1);

      // Perform sync
      final result = await SyncServiceProduction.syncData(
        collections: collections,
        forceSync: taskType == 'onetime',
      );

      if (result.success) {
        // Clear any previous error
        await StatePersistenceService.removeState('last_background_sync_error');
        
        if (Environment.enableLogging) {
          print('✅ Background sync completed: ${result.toString()}');
        }
      } else {
        // Record error
        await StatePersistenceService.saveState('last_background_sync_error', result.errorMessage ?? 'Unknown error');
        
        if (Environment.enableLogging) {
          print('❌ Background sync failed: ${result.errorMessage}');
        }
      }

      return Future.value(true);
    } catch (e) {
      // Record error
      await StatePersistenceService.saveState('last_background_sync_error', e.toString());
      
      if (Environment.enableLogging) {
        print('❌ Background task error: $e');
      }
      
      // Return true to avoid WorkManager retrying immediately
      return Future.value(true);
    }
  });
}

/// Background sync configuration
class BackgroundSyncConfig {
  /// Minimum interval between background syncs (in minutes)
  static const int minSyncInterval = 15;
  
  /// Maximum number of retry attempts
  static const int maxRetryAttempts = 3;
  
  /// Timeout for background sync operations (in seconds)
  static const int syncTimeoutSeconds = 30;
  
  /// Battery level threshold for background sync
  static const int batteryThreshold = 20;
  
  /// Maximum size of pending changes queue
  static const int maxPendingChanges = 1000;
  
  /// Default collections to sync
  static const List<String> defaultCollections = [
    'notes',
    'settings', 
    'chat_history',
  ];
  
  /// High priority collections (synced more frequently)
  static const List<String> highPriorityCollections = [
    'notes',
  ];
  
  /// Low priority collections (synced less frequently)
  static const List<String> lowPriorityCollections = [
    'chat_history',
    'analytics',
  ];
}
