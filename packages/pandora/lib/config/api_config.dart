import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'environment.dart';

/// API configuration and key management
class ApiConfig {
  static const String _geminiApiKeyKey = 'gemini_api_key';
  static const String _speechApiKeyKey = 'speech_api_key';
  static const String _firebaseApiKeyKey = 'firebase_api_key';
  
  static late FlutterSecureStorage _secureStorage;
  static late SharedPreferences _prefs;
  static bool _initialized = false;

  /// Initialize API configuration
  static Future<void> initialize() async {
    try {
      _secureStorage = const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      );
      
      _prefs = await SharedPreferences.getInstance();
      
      // Load API keys from environment if not stored securely
      await _loadInitialApiKeys();
      
      _initialized = true;
      print('✅ API configuration initialized');
    } catch (e) {
      print('❌ API configuration initialization failed: $e');
      rethrow;
    }
  }

  /// Load initial API keys from environment
  static Future<void> _loadInitialApiKeys() async {
    // Only load from environment if not already stored
    final storedGeminiKey = await _secureStorage.read(key: _geminiApiKeyKey);
    if (storedGeminiKey == null || storedGeminiKey.isEmpty) {
      final envGeminiKey = Environment.geminiApiKey;
      if (envGeminiKey.isNotEmpty) {
        await setGeminiApiKey(envGeminiKey);
      }
    }
    
    // Add other API keys as needed
  }

  /// Ensure API config is initialized
  static void _ensureInitialized() {
    if (!_initialized) {
      throw StateError('ApiConfig not initialized. Call ApiConfig.initialize() first.');
    }
  }

  // Gemini AI API Key Management
  
  /// Get Gemini AI API key
  static Future<String> getGeminiApiKey() async {
    _ensureInitialized();
    
    final key = await _secureStorage.read(key: _geminiApiKeyKey);
    if (key == null || key.isEmpty) {
      // Fallback to environment variable
      final envKey = Environment.geminiApiKey;
      if (envKey.isNotEmpty) {
        await setGeminiApiKey(envKey);
        return envKey;
      }
      throw Exception('Gemini API key not found. Please configure in settings.');
    }
    return key;
  }

  /// Set Gemini AI API key
  static Future<void> setGeminiApiKey(String apiKey) async {
    _ensureInitialized();
    
    if (apiKey.isEmpty) {
      throw ArgumentError('API key cannot be empty');
    }
    
    await _secureStorage.write(key: _geminiApiKeyKey, value: apiKey);
    await _prefs.setBool('gemini_api_key_configured', true);
  }

  /// Check if Gemini API key is configured
  static Future<bool> isGeminiApiKeyConfigured() async {
    _ensureInitialized();
    
    final key = await _secureStorage.read(key: _geminiApiKeyKey);
    return key != null && key.isNotEmpty;
  }

  /// Remove Gemini API key
  static Future<void> removeGeminiApiKey() async {
    _ensureInitialized();
    
    await _secureStorage.delete(key: _geminiApiKeyKey);
    await _prefs.remove('gemini_api_key_configured');
  }

  // Speech Recognition API Key Management
  
  /// Get Speech Recognition API key
  static Future<String> getSpeechApiKey() async {
    _ensureInitialized();
    
    final key = await _secureStorage.read(key: _speechApiKeyKey);
    if (key == null || key.isEmpty) {
      // For speech_to_text package, no API key is needed for on-device recognition
      return '';
    }
    return key;
  }

  /// Set Speech Recognition API key (for cloud-based services)
  static Future<void> setSpeechApiKey(String apiKey) async {
    _ensureInitialized();
    
    await _secureStorage.write(key: _speechApiKeyKey, value: apiKey);
    await _prefs.setBool('speech_api_key_configured', apiKey.isNotEmpty);
  }

  // Firebase API Key Management
  
  /// Get Firebase API key
  static Future<String> getFirebaseApiKey() async {
    _ensureInitialized();
    
    final key = await _secureStorage.read(key: _firebaseApiKeyKey);
    if (key == null || key.isEmpty) {
      // Fallback to environment variable
      final envKey = Environment.firebaseApiKey;
      if (envKey.isNotEmpty) {
        await setFirebaseApiKey(envKey);
        return envKey;
      }
      return '';
    }
    return key;
  }

  /// Set Firebase API key
  static Future<void> setFirebaseApiKey(String apiKey) async {
    _ensureInitialized();
    
    await _secureStorage.write(key: _firebaseApiKeyKey, value: apiKey);
    await _prefs.setBool('firebase_api_key_configured', apiKey.isNotEmpty);
  }

  // API Endpoints Configuration
  
  /// Get API base URL
  static String get baseUrl => Environment.apiBaseUrl;

  /// Get Firebase project configuration
  static Map<String, String> get firebaseConfig => {
    'projectId': Environment.firebaseProjectId,
    'authDomain': Environment.firebaseAuthDomain,
    'storageBucket': Environment.firebaseStorageBucket,
    'messagingSenderId': Environment.firebaseMessagingSenderId,
    'appId': Environment.firebaseAppId,
  };

  // API Settings
  
  /// Get API timeout duration
  static Duration get apiTimeout => Duration(
    seconds: Environment.isProduction ? 30 : 10,
  );

  /// Get retry attempts for API calls
  static int get maxRetryAttempts => Environment.isProduction ? 3 : 1;

  /// Check if API debugging is enabled
  static bool get isApiDebuggingEnabled => 
    Environment.enableLogging && !Environment.isProduction;

  // Validation Methods
  
  /// Validate all required API keys
  static Future<List<String>> validateConfiguration() async {
    final errors = <String>[];
    
    try {
      // Check Gemini API key
      if (!await isGeminiApiKeyConfigured()) {
        errors.add('Gemini AI API key is not configured');
      }
      
      // Check Firebase configuration
      if (Environment.firebaseProjectId.isEmpty) {
        errors.add('Firebase project ID is not configured');
      }
      
      // Add other validations as needed
      
    } catch (e) {
      errors.add('Configuration validation failed: $e');
    }
    
    return errors;
  }

  /// Clear all stored API keys (for logout/reset)
  static Future<void> clearAllApiKeys() async {
    _ensureInitialized();
    
    await _secureStorage.deleteAll();
    await _prefs.clear();
    
    print('🧹 All API keys cleared');
  }

  // Development/Testing Methods
  
  /// Get API configuration summary (without sensitive data)
  static Future<Map<String, dynamic>> getConfigurationSummary() async {
    _ensureInitialized();
    
    return {
      'environment': Environment.current.name,
      'baseUrl': baseUrl,
      'geminiConfigured': await isGeminiApiKeyConfigured(),
      'firebaseProjectId': Environment.firebaseProjectId,
      'apiTimeout': apiTimeout.inSeconds,
      'maxRetryAttempts': maxRetryAttempts,
      'debuggingEnabled': isApiDebuggingEnabled,
    };
  }
}
