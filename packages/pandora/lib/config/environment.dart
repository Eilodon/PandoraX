import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../services/logger_service.dart';

/// Environment types
enum EnvironmentType {
  development,
  staging,
  production,
}

/// Environment configuration class
class Environment {
  static EnvironmentType _current = EnvironmentType.development;
  static bool _initialized = false;

  /// Current environment
  static EnvironmentType get current => _current;

  /// Check if environment is initialized
  static bool get isInitialized => _initialized;

  /// Initialize environment configuration
  static Future<void> initialize({EnvironmentType? environment}) async {
    try {
      // Determine environment
      _current = environment ?? _determineEnvironment();
      
      // Load environment variables
      await _loadEnvironmentFile();
      
      _initialized = true;
      LoggerService.info('Environment initialized: ${_current.name}', tag: 'Environment');
    } catch (e) {
      LoggerService.error('Environment initialization failed: $e', tag: 'Environment');
      // Use development as fallback
      _current = EnvironmentType.development;
      _initialized = true;
    }
  }

  /// Determine environment from build mode
  static EnvironmentType _determineEnvironment() {
    const String flavor = String.fromEnvironment('FLAVOR', defaultValue: 'development');
    
    switch (flavor.toLowerCase()) {
      case 'production':
      case 'prod':
        return EnvironmentType.production;
      case 'staging':
      case 'stage':
        return EnvironmentType.staging;
      default:
        return EnvironmentType.development;
    }
  }

  /// Load environment file based on current environment
  static Future<void> _loadEnvironmentFile() async {
    String fileName;
    switch (_current) {
      case EnvironmentType.production:
        fileName = '.env.production';
        break;
      case EnvironmentType.staging:
        fileName = '.env.staging';
        break;
      case EnvironmentType.development:
        fileName = '.env.development';
        break;
    }

    try {
      await dotenv.load(fileName: fileName);
    } catch (e) {
      LoggerService.warning('Could not load $fileName, using default values', tag: 'Environment');
      // Create empty dotenv for fallback
      dotenv.env.clear();
    }
  }

  /// Get environment variable
  static String get(String key, {String defaultValue = ''}) {
    if (!_initialized) {
      throw StateError('Environment not initialized. Call Environment.initialize() first.');
    }
    return dotenv.get(key, fallback: defaultValue);
  }

  /// Check if environment variable exists
  static bool has(String key) {
    if (!_initialized) return false;
    return dotenv.env.containsKey(key);
  }

  /// Get all environment variables
  static Map<String, String> get all {
    if (!_initialized) return {};
    return Map<String, String>.from(dotenv.env);
  }

  // Convenience getters for common environment variables
  
  /// API Base URL
  static String get apiBaseUrl => get('API_BASE_URL', defaultValue: 'https://api.pandora-notes.com');

  /// Google Gemini AI API Key
  static String get geminiApiKey => get('GEMINI_API_KEY');

  /// Firebase project ID
  static String get firebaseProjectId => get('FIREBASE_PROJECT_ID', defaultValue: 'pandora-notes-dev');

  /// App version
  static String get appVersion => get('APP_VERSION', defaultValue: '1.0.0');

  /// Build number
  static String get buildNumber => get('BUILD_NUMBER', defaultValue: '1');

  /// Enable analytics
  static bool get enableAnalytics => get('ENABLE_ANALYTICS', defaultValue: 'false').toLowerCase() == 'true';

  /// Enable crashlytics
  static bool get enableCrashlytics => get('ENABLE_CRASHLYTICS', defaultValue: 'false').toLowerCase() == 'true';

  /// Debug mode
  static bool get isDebugMode => _current == EnvironmentType.development;

  /// Production mode
  static bool get isProduction => _current == EnvironmentType.production;

  /// Staging mode
  static bool get isStaging => _current == EnvironmentType.staging;

  /// Enable logging
  static bool get enableLogging => get('ENABLE_LOGGING', defaultValue: isDebugMode.toString()).toLowerCase() == 'true';

  /// Firebase API key (for manual configuration)
  static String get firebaseApiKey => get('FIREBASE_API_KEY');

  /// Firebase auth domain
  static String get firebaseAuthDomain => get('FIREBASE_AUTH_DOMAIN', 
    defaultValue: '$firebaseProjectId.firebaseapp.com');

  /// Firebase storage bucket
  static String get firebaseStorageBucket => get('FIREBASE_STORAGE_BUCKET',
    defaultValue: '$firebaseProjectId.appspot.com');

  /// Firebase messaging sender ID
  static String get firebaseMessagingSenderId => get('FIREBASE_MESSAGING_SENDER_ID');

  /// Firebase app ID
  static String get firebaseAppId => get('FIREBASE_APP_ID');
}
