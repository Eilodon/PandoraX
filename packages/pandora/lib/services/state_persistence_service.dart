import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/environment.dart';

/// Service for persisting app state securely
class StatePersistenceService {
  static late SharedPreferences _prefs;
  static late FlutterSecureStorage _secureStorage;
  static bool _isInitialized = false;

  /// Initialize the persistence service
  static Future<void> initialize() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _secureStorage = const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      );
      
      _isInitialized = true;
      
      if (Environment.enableLogging) {
        print('✅ State persistence service initialized');
      }
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ State persistence service initialization failed: $e');
      }
      rethrow;
    }
  }

  /// Ensure service is initialized
  static void _ensureInitialized() {
    if (!_isInitialized) {
      throw StateError('StatePersistenceService not initialized. Call initialize() first.');
    }
  }

  // Non-sensitive data storage (SharedPreferences)

  /// Save non-sensitive state data
  static Future<void> saveState<T>(String key, T value) async {
    _ensureInitialized();
    
    try {
      if (value is bool) {
        await _prefs.setBool(key, value);
      } else if (value is int) {
        await _prefs.setInt(key, value);
      } else if (value is double) {
        await _prefs.setDouble(key, value);
      } else if (value is String) {
        await _prefs.setString(key, value);
      } else if (value is List<String>) {
        await _prefs.setStringList(key, value);
      } else {
        // Serialize complex objects to JSON
        final jsonString = jsonEncode(value);
        await _prefs.setString(key, jsonString);
      }
      
      if (Environment.enableLogging) {
        print('💾 Saved state: $key');
      }
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Failed to save state $key: $e');
      }
      rethrow;
    }
  }

  /// Load non-sensitive state data
  static T? loadState<T>(String key, {T? defaultValue}) {
    _ensureInitialized();
    
    try {
      if (T == bool) {
        return _prefs.getBool(key) as T? ?? defaultValue;
      } else if (T == int) {
        return _prefs.getInt(key) as T? ?? defaultValue;
      } else if (T == double) {
        return _prefs.getDouble(key) as T? ?? defaultValue;
      } else if (T == String) {
        return _prefs.getString(key) as T? ?? defaultValue;
      } else if (T == List<String>) {
        return _prefs.getStringList(key) as T? ?? defaultValue;
      } else {
        // Deserialize complex objects from JSON
        final jsonString = _prefs.getString(key);
        if (jsonString != null) {
          return jsonDecode(jsonString) as T;
        }
        return defaultValue;
      }
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Failed to load state $key: $e');
      }
      return defaultValue;
    }
  }

  /// Check if state exists
  static bool hasState(String key) {
    _ensureInitialized();
    return _prefs.containsKey(key);
  }

  /// Remove non-sensitive state
  static Future<void> removeState(String key) async {
    _ensureInitialized();
    
    try {
      await _prefs.remove(key);
      
      if (Environment.enableLogging) {
        print('🗑️ Removed state: $key');
      }
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Failed to remove state $key: $e');
      }
    }
  }

  // Sensitive data storage (SecureStorage)

  /// Save sensitive state data
  static Future<void> saveSecureState<T>(String key, T value) async {
    _ensureInitialized();
    
    try {
      String stringValue;
      if (value is String) {
        stringValue = value;
      } else {
        stringValue = jsonEncode(value);
      }
      
      await _secureStorage.write(key: key, value: stringValue);
      
      if (Environment.enableLogging) {
        print('🔐 Saved secure state: $key');
      }
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Failed to save secure state $key: $e');
      }
      rethrow;
    }
  }

  /// Load sensitive state data
  static Future<T?> loadSecureState<T>(String key, {T? defaultValue}) async {
    _ensureInitialized();
    
    try {
      final stringValue = await _secureStorage.read(key: key);
      if (stringValue == null) {
        return defaultValue;
      }
      
      if (T == String) {
        return stringValue as T;
      } else {
        return jsonDecode(stringValue) as T;
      }
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Failed to load secure state $key: $e');
      }
      return defaultValue;
    }
  }

  /// Check if secure state exists
  static Future<bool> hasSecureState(String key) async {
    _ensureInitialized();
    
    try {
      final value = await _secureStorage.read(key: key);
      return value != null;
    } catch (e) {
      return false;
    }
  }

  /// Remove sensitive state
  static Future<void> removeSecureState(String key) async {
    _ensureInitialized();
    
    try {
      await _secureStorage.delete(key: key);
      
      if (Environment.enableLogging) {
        print('🗑️ Removed secure state: $key');
      }
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Failed to remove secure state $key: $e');
      }
    }
  }

  // Batch operations

  /// Save multiple states at once
  static Future<void> saveMultipleStates(Map<String, dynamic> states) async {
    _ensureInitialized();
    
    final futures = <Future>[];
    for (final entry in states.entries) {
      futures.add(saveState(entry.key, entry.value));
    }
    
    await Future.wait(futures);
  }

  /// Load multiple states at once
  static Map<String, dynamic> loadMultipleStates(List<String> keys) {
    _ensureInitialized();
    
    final result = <String, dynamic>{};
    for (final key in keys) {
      result[key] = loadState<dynamic>(key);
    }
    
    return result;
  }

  /// Save multiple secure states at once
  static Future<void> saveMultipleSecureStates(Map<String, dynamic> states) async {
    _ensureInitialized();
    
    final futures = <Future>[];
    for (final entry in states.entries) {
      futures.add(saveSecureState(entry.key, entry.value));
    }
    
    await Future.wait(futures);
  }

  /// Load multiple secure states at once
  static Future<Map<String, dynamic>> loadMultipleSecureStates(List<String> keys) async {
    _ensureInitialized();
    
    final result = <String, dynamic>{};
    final futures = <Future>[];
    
    for (final key in keys) {
      futures.add(
        loadSecureState<dynamic>(key).then((value) {
          if (value != null) {
            result[key] = value;
          }
        }),
      );
    }
    
    await Future.wait(futures);
    return result;
  }

  // Cleanup operations

  /// Clear all non-sensitive state
  static Future<void> clearAllState() async {
    _ensureInitialized();
    
    try {
      await _prefs.clear();
      
      if (Environment.enableLogging) {
        print('🧹 Cleared all state');
      }
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Failed to clear all state: $e');
      }
    }
  }

  /// Clear all sensitive state
  static Future<void> clearAllSecureState() async {
    _ensureInitialized();
    
    try {
      await _secureStorage.deleteAll();
      
      if (Environment.enableLogging) {
        print('🧹 Cleared all secure state');
      }
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Failed to clear all secure state: $e');
      }
    }
  }

  /// Clear all state (both secure and non-secure)
  static Future<void> clearEverything() async {
    await Future.wait([
      clearAllState(),
      clearAllSecureState(),
    ]);
  }

  // Utility methods

  /// Get all non-sensitive state keys
  static Set<String> getAllStateKeys() {
    _ensureInitialized();
    return _prefs.getKeys();
  }

  /// Get all secure state keys
  static Future<Set<String>> getAllSecureStateKeys() async {
    _ensureInitialized();
    
    try {
      final result = await _secureStorage.readAll();
      return result.keys.toSet();
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ Failed to get secure state keys: $e');
      }
      return <String>{};
    }
  }

  /// Get storage statistics
  static Future<Map<String, dynamic>> getStorageStats() async {
    _ensureInitialized();
    
    final stateKeys = getAllStateKeys();
    final secureKeys = await getAllSecureStateKeys();
    
    return {
      'nonSecureStateCount': stateKeys.length,
      'secureStateCount': secureKeys.length,
      'totalStateCount': stateKeys.length + secureKeys.length,
      'nonSecureKeys': stateKeys.toList(),
      'secureKeys': secureKeys.toList(),
    };
  }

  /// Export non-sensitive state for backup
  static Map<String, dynamic> exportState() {
    _ensureInitialized();
    
    final result = <String, dynamic>{};
    final keys = getAllStateKeys();
    
    for (final key in keys) {
      result[key] = loadState<dynamic>(key);
    }
    
    return result;
  }

  /// Import non-sensitive state from backup
  static Future<void> importState(Map<String, dynamic> stateData) async {
    _ensureInitialized();
    
    for (final entry in stateData.entries) {
      await saveState(entry.key, entry.value);
    }
    
    if (Environment.enableLogging) {
      print('📥 Imported ${stateData.length} state entries');
    }
  }
}
