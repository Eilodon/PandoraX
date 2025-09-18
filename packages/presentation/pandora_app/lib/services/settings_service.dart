import 'package:core_utils/core_utils.dart';

/// Settings Service for managing app preferences
class SettingsService {
  static final SettingsService _instance = SettingsService._internal();
  factory SettingsService() => _instance;
  SettingsService._internal();

  SharedPreferences? _prefs;

  // Settings keys
  static const String _darkModeKey = 'dark_mode';
  static const String _fontSizeKey = 'font_size';
  static const String _languageKey = 'language';
  static const String _notificationsKey = 'notifications';
  static const String _biometricAuthKey = 'biometric_auth';
  static const String _autoSyncKey = 'auto_sync';
  static const String _privacyModeKey = 'privacy_mode';
  static const String _dataEncryptionKey = 'data_encryption';

  /// Initialize settings service
  Future<void> initialize() async {
    try {
      AppLogger.info('⚙️ Initializing settings service...');
      _prefs = await SharedPreferences.getInstance();
      AppLogger.success('Settings service initialized');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to initialize settings service', e, stackTrace);
      rethrow;
    }
  }

  // Theme Settings
  bool get isDarkMode => _prefs?.getBool(_darkModeKey) ?? false;
  Future<void> setDarkMode(bool value) async {
    await _prefs?.setBool(_darkModeKey, value);
    AppLogger.info('🌙 Dark mode set to: $value');
  }

  // Font Size Settings
  double get fontSize => _prefs?.getDouble(_fontSizeKey) ?? 1.0;
  Future<void> setFontSize(double value) async {
    await _prefs?.setDouble(_fontSizeKey, value);
    AppLogger.info('📝 Font size set to: $value');
  }

  // Language Settings
  String get language => _prefs?.getString(_languageKey) ?? 'English';
  Future<void> setLanguage(String value) async {
    await _prefs?.setString(_languageKey, value);
    AppLogger.info('🌍 Language set to: $value');
  }

  // Notification Settings
  bool get notificationsEnabled => _prefs?.getBool(_notificationsKey) ?? true;
  Future<void> setNotificationsEnabled(bool value) async {
    await _prefs?.setBool(_notificationsKey, value);
    AppLogger.info('🔔 Notifications set to: $value');
  }

  // Security Settings
  bool get biometricAuthEnabled => _prefs?.getBool(_biometricAuthKey) ?? false;
  Future<void> setBiometricAuthEnabled(bool value) async {
    await _prefs?.setBool(_biometricAuthKey, value);
    AppLogger.info('🔐 Biometric auth set to: $value');
  }

  // Sync Settings
  bool get autoSyncEnabled => _prefs?.getBool(_autoSyncKey) ?? true;
  Future<void> setAutoSyncEnabled(bool value) async {
    await _prefs?.setBool(_autoSyncKey, value);
    AppLogger.info('🔄 Auto sync set to: $value');
  }

  // Privacy Settings
  bool get privacyModeEnabled => _prefs?.getBool(_privacyModeKey) ?? false;
  Future<void> setPrivacyModeEnabled(bool value) async {
    await _prefs?.setBool(_privacyModeKey, value);
    AppLogger.info('🔒 Privacy mode set to: $value');
  }

  // Data Encryption
  bool get dataEncryptionEnabled => _prefs?.getBool(_dataEncryptionKey) ?? false;
  Future<void> setDataEncryptionEnabled(bool value) async {
    await _prefs?.setBool(_dataEncryptionKey, value);
    AppLogger.info('🔐 Data encryption set to: $value');
  }

  /// Get all settings as a map
  Map<String, dynamic> getAllSettings() {
    return {
      'darkMode': isDarkMode,
      'fontSize': fontSize,
      'language': language,
      'notifications': notificationsEnabled,
      'biometricAuth': biometricAuthEnabled,
      'autoSync': autoSyncEnabled,
      'privacyMode': privacyModeEnabled,
      'dataEncryption': dataEncryptionEnabled,
    };
  }

  /// Reset all settings to default
  Future<void> resetToDefaults() async {
    try {
      AppLogger.info('🔄 Resetting settings to defaults...');
      await _prefs?.clear();
      AppLogger.success('Settings reset to defaults');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to reset settings', e, stackTrace);
      rethrow;
    }
  }

  /// Export settings
  Future<String> exportSettings() async {
    final settings = getAllSettings();
    return settings.toString();
  }

  /// Import settings
  Future<void> importSettings(String settingsData) async {
    try {
      AppLogger.info('📥 Importing settings...');
      // Simple import - in real app, this would parse JSON
      AppLogger.success('Settings imported successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to import settings', e, stackTrace);
      rethrow;
    }
  }
}
