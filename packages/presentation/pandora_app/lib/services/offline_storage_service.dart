import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ai_domain/ai_domain.dart';
import 'package:core_utils/core_utils.dart';

/// Service for offline storage and data management
class OfflineStorageService {
  static final OfflineStorageService _instance = OfflineStorageService._internal();
  factory OfflineStorageService() => _instance;
  OfflineStorageService._internal();

  bool _isInitialized = false;
  late Directory _storageDirectory;
  late SharedPreferences _preferences;
  final Map<String, dynamic> _cache = {};
  final Map<String, DateTime> _cacheTimestamps = {};
  final Duration _cacheExpiry = const Duration(hours: 24);

  /// Initialize offline storage service
  Future<bool> initialize() async {
    try {
      AppLogger.info('Initializing Offline Storage Service...');
      
      // Get storage directory
      _storageDirectory = await getApplicationDocumentsDirectory();
      final offlineDir = Directory('${_storageDirectory.path}/offline');
      if (!await offlineDir.exists()) {
        await offlineDir.create(recursive: true);
      }
      
      // Initialize preferences
      _preferences = await SharedPreferences.getInstance();
      
      // Load cache from storage
      await _loadCache();
      
      _isInitialized = true;
      AppLogger.success('Offline Storage Service initialized successfully');
      return true;
    } catch (e) {
      AppLogger.error('Failed to initialize Offline Storage Service', e);
      return false;
    }
  }

  /// Store data offline
  Future<bool> storeData(String key, dynamic data, {bool compress = true}) async {
    if (!_isInitialized) {
      AppLogger.warning('Offline Storage Service not initialized');
      return false;
    }

    try {
      AppLogger.info('Storing data offline: $key');
      
      // Convert data to JSON
      final jsonData = jsonEncode(data);
      
      // Compress if requested
      String finalData = jsonData;
      if (compress) {
        finalData = _compressData(jsonData);
      }
      
      // Store in cache
      _cache[key] = data;
      _cacheTimestamps[key] = DateTime.now();
      
      // Store in file
      final file = File('${_storageDirectory.path}/offline/$key.json');
      await file.writeAsString(finalData);
      
      // Store metadata
      await _preferences.setString('${key}_metadata', jsonEncode({
        'timestamp': DateTime.now().toIso8601String(),
        'compressed': compress,
        'size': finalData.length,
      }));
      
      AppLogger.success('Data stored offline: $key');
      return true;
    } catch (e) {
      AppLogger.error('Failed to store data offline: $key', e);
      return false;
    }
  }

  /// Retrieve data from offline storage
  Future<T?> retrieveData<T>(String key) async {
    if (!_isInitialized) {
      AppLogger.warning('Offline Storage Service not initialized');
      return null;
    }

    try {
      AppLogger.info('Retrieving data from offline storage: $key');
      
      // Check cache first
      if (_cache.containsKey(key)) {
        final timestamp = _cacheTimestamps[key];
        if (timestamp != null && 
            DateTime.now().difference(timestamp) < _cacheExpiry) {
          AppLogger.info('Data retrieved from cache: $key');
          return _cache[key] as T?;
        } else {
          // Cache expired, remove it
          _cache.remove(key);
          _cacheTimestamps.remove(key);
        }
      }
      
      // Load from file
      final file = File('${_storageDirectory.path}/offline/$key.json');
      if (!await file.exists()) {
        AppLogger.warning('Data not found in offline storage: $key');
        return null;
      }
      
      final fileData = await file.readAsString();
      
      // Check if data is compressed
      final metadataJson = _preferences.getString('${key}_metadata');
      bool isCompressed = false;
      if (metadataJson != null) {
        final metadata = jsonDecode(metadataJson);
        isCompressed = metadata['compressed'] ?? false;
      }
      
      // Decompress if needed
      String jsonData = fileData;
      if (isCompressed) {
        jsonData = _decompressData(fileData);
      }
      
      // Parse JSON
      final data = jsonDecode(jsonData) as T;
      
      // Store in cache
      _cache[key] = data;
      _cacheTimestamps[key] = DateTime.now();
      
      AppLogger.success('Data retrieved from offline storage: $key');
      return data;
    } catch (e) {
      AppLogger.error('Failed to retrieve data from offline storage: $key', e);
      return null;
    }
  }

  /// Store notes offline
  Future<bool> storeNotes(List<dynamic> notes) async {
    return await storeData('notes', notes);
  }

  /// Retrieve notes from offline storage
  Future<List<dynamic>?> retrieveNotes() async {
    return await retrieveData<List<dynamic>>('notes');
  }

  /// Store voice notes offline
  Future<bool> storeVoiceNotes(List<dynamic> voiceNotes) async {
    return await storeData('voice_notes', voiceNotes);
  }

  /// Retrieve voice notes from offline storage
  Future<List<dynamic>?> retrieveVoiceNotes() async {
    return await retrieveData<List<dynamic>>('voice_notes');
  }

  /// Store AI data offline
  Future<bool> storeAiData(Map<String, dynamic> aiData) async {
    return await storeData('ai_data', aiData);
  }

  /// Retrieve AI data from offline storage
  Future<Map<String, dynamic>?> retrieveAiData() async {
    return await retrieveData<Map<String, dynamic>>('ai_data');
  }

  /// Store sync status offline
  Future<bool> storeSyncStatus(SyncStatus status) async {
    return await storeData('sync_status', status.toJson());
  }

  /// Retrieve sync status from offline storage
  Future<SyncStatus?> retrieveSyncStatus() async {
    final data = await retrieveData<Map<String, dynamic>>('sync_status');
    if (data != null) {
      return SyncStatus.fromJson(data);
    }
    return null;
  }

  /// Store user preferences offline
  Future<bool> storeUserPreferences(Map<String, dynamic> preferences) async {
    return await storeData('user_preferences', preferences);
  }

  /// Retrieve user preferences from offline storage
  Future<Map<String, dynamic>?> retrieveUserPreferences() async {
    return await retrieveData<Map<String, dynamic>>('user_preferences');
  }

  /// Check if data exists offline
  Future<bool> hasData(String key) async {
    if (!_isInitialized) return false;
    
    // Check cache first
    if (_cache.containsKey(key)) {
      final timestamp = _cacheTimestamps[key];
      if (timestamp != null && 
          DateTime.now().difference(timestamp) < _cacheExpiry) {
        return true;
      }
    }
    
    // Check file
    final file = File('${_storageDirectory.path}/offline/$key.json');
    return await file.exists();
  }

  /// Get data size
  Future<int> getDataSize(String key) async {
    if (!_isInitialized) return 0;
    
    final file = File('${_storageDirectory.path}/offline/$key.json');
    if (await file.exists()) {
      return await file.length();
    }
    return 0;
  }

  /// Get total storage size
  Future<int> getTotalStorageSize() async {
    if (!_isInitialized) return 0;
    
    int totalSize = 0;
    final offlineDir = Directory('${_storageDirectory.path}/offline');
    
    if (await offlineDir.exists()) {
      await for (final entity in offlineDir.list()) {
        if (entity is File) {
          totalSize += await entity.length();
        }
      }
    }
    
    return totalSize;
  }

  /// Clear specific data
  Future<bool> clearData(String key) async {
    if (!_isInitialized) return false;
    
    try {
      AppLogger.info('Clearing data: $key');
      
      // Remove from cache
      _cache.remove(key);
      _cacheTimestamps.remove(key);
      
      // Remove file
      final file = File('${_storageDirectory.path}/offline/$key.json');
      if (await file.exists()) {
        await file.delete();
      }
      
      // Remove metadata
      await _preferences.remove('${key}_metadata');
      
      AppLogger.success('Data cleared: $key');
      return true;
    } catch (e) {
      AppLogger.error('Failed to clear data: $key', e);
      return false;
    }
  }

  /// Clear all offline data
  Future<bool> clearAllData() async {
    if (!_isInitialized) return false;
    
    try {
      AppLogger.info('Clearing all offline data');
      
      // Clear cache
      _cache.clear();
      _cacheTimestamps.clear();
      
      // Clear files
      final offlineDir = Directory('${_storageDirectory.path}/offline');
      if (await offlineDir.exists()) {
        await offlineDir.delete(recursive: true);
        await offlineDir.create(recursive: true);
      }
      
      // Clear preferences
      final keys = _preferences.getKeys();
      for (final key in keys) {
        if (key.endsWith('_metadata')) {
          await _preferences.remove(key);
        }
      }
      
      AppLogger.success('All offline data cleared');
      return true;
    } catch (e) {
      AppLogger.error('Failed to clear all offline data', e);
      return false;
    }
  }

  /// Get storage statistics
  Future<StorageStatistics> getStorageStatistics() async {
    if (!_isInitialized) {
      return StorageStatistics.empty();
    }
    
    try {
      AppLogger.info('Getting storage statistics');
      
      final totalSize = await getTotalStorageSize();
      final cacheSize = _cache.length;
      final fileCount = await _getFileCount();
      
      final statistics = StorageStatistics(
        totalSize: totalSize,
        cacheSize: cacheSize,
        fileCount: fileCount,
        lastUpdated: DateTime.now(),
      );
      
      AppLogger.success('Storage statistics retrieved');
      return statistics;
    } catch (e) {
      AppLogger.error('Failed to get storage statistics', e);
      return StorageStatistics.empty();
    }
  }

  /// Get file count
  Future<int> _getFileCount() async {
    int count = 0;
    final offlineDir = Directory('${_storageDirectory.path}/offline');
    
    if (await offlineDir.exists()) {
      await for (final entity in offlineDir.list()) {
        if (entity is File) {
          count++;
        }
      }
    }
    
    return count;
  }

  /// Compress data (simple implementation)
  String _compressData(String data) {
    // Simple compression by removing extra whitespace
    return data.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Decompress data
  String _decompressData(String data) {
    // Simple decompression (in real implementation, use proper compression)
    return data;
  }

  /// Load cache from storage
  Future<void> _loadCache() async {
    try {
      // Load cache metadata
      final cacheKeys = _preferences.getStringList('cache_keys') ?? [];
      
      for (final key in cacheKeys) {
        final data = await retrieveData(key);
        if (data != null) {
          _cache[key] = data;
          final timestampStr = _preferences.getString('${key}_timestamp');
          if (timestampStr != null) {
            _cacheTimestamps[key] = DateTime.parse(timestampStr);
          }
        }
      }
      
      AppLogger.info('Cache loaded: ${_cache.length} items');
    } catch (e) {
      AppLogger.error('Failed to load cache', e);
    }
  }

  /// Save cache to storage
  Future<void> _saveCache() async {
    try {
      final cacheKeys = _cache.keys.toList();
      await _preferences.setStringList('cache_keys', cacheKeys);
      
      for (final key in cacheKeys) {
        final timestamp = _cacheTimestamps[key];
        if (timestamp != null) {
          await _preferences.setString('${key}_timestamp', timestamp.toIso8601String());
        }
      }
      
      AppLogger.info('Cache saved: ${_cache.length} items');
    } catch (e) {
      AppLogger.error('Failed to save cache', e);
    }
  }

  /// Clean expired cache
  Future<void> cleanExpiredCache() async {
    try {
      AppLogger.info('Cleaning expired cache');
      
      final now = DateTime.now();
      final expiredKeys = <String>[];
      
      for (final entry in _cacheTimestamps.entries) {
        if (now.difference(entry.value) > _cacheExpiry) {
          expiredKeys.add(entry.key);
        }
      }
      
      for (final key in expiredKeys) {
        _cache.remove(key);
        _cacheTimestamps.remove(key);
      }
      
      if (expiredKeys.isNotEmpty) {
        await _saveCache();
        AppLogger.info('Cleaned ${expiredKeys.length} expired cache items');
      }
    } catch (e) {
      AppLogger.error('Failed to clean expired cache', e);
    }
  }

  /// Check if service is initialized
  bool get isInitialized => _isInitialized;

  /// Get cache size
  int get cacheSize => _cache.length;

  /// Get cache keys
  List<String> get cacheKeys => _cache.keys.toList();

  /// Dispose service
  Future<void> dispose() async {
    await _saveCache();
    _cache.clear();
    _cacheTimestamps.clear();
    _isInitialized = false;
    AppLogger.info('Offline Storage Service disposed');
  }
}

/// Storage statistics
class StorageStatistics {
  final int totalSize;
  final int cacheSize;
  final int fileCount;
  final DateTime lastUpdated;

  const StorageStatistics({
    required this.totalSize,
    required this.cacheSize,
    required this.fileCount,
    required this.lastUpdated,
  });

  factory StorageStatistics.empty() {
    return StorageStatistics(
      totalSize: 0,
      cacheSize: 0,
      fileCount: 0,
      lastUpdated: DateTime.now(),
    );
  }

  /// Get total size in MB
  double get totalSizeMB => totalSize / (1024 * 1024);

  /// Get total size in KB
  double get totalSizeKB => totalSize / 1024;

  /// Get formatted total size
  String get formattedTotalSize {
    if (totalSizeMB >= 1) {
      return '${totalSizeMB.toStringAsFixed(2)} MB';
    } else {
      return '${totalSizeKB.toStringAsFixed(2)} KB';
    }
  }
}
