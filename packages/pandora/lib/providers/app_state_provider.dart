import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../injection.dart';
import '../config/environment.dart';
import '../config/api_config.dart';

/// App-wide state management
class AppState {
  final bool isFirstLaunch;
  final bool isDarkMode;
  final String selectedLanguage;
  final bool isOfflineMode;
  final bool hasInternetConnection;
  final Map<String, bool> featureFlags;
  final DateTime lastSyncTime;

  const AppState({
    this.isFirstLaunch = true,
    this.isDarkMode = false,
    this.selectedLanguage = 'en',
    this.isOfflineMode = false,
    this.hasInternetConnection = true,
    this.featureFlags = const {},
    required this.lastSyncTime,
  });

  AppState copyWith({
    bool? isFirstLaunch,
    bool? isDarkMode,
    String? selectedLanguage,
    bool? isOfflineMode,
    bool? hasInternetConnection,
    Map<String, bool>? featureFlags,
    DateTime? lastSyncTime,
  }) {
    return AppState(
      isFirstLaunch: isFirstLaunch ?? this.isFirstLaunch,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      isOfflineMode: isOfflineMode ?? this.isOfflineMode,
      hasInternetConnection: hasInternetConnection ?? this.hasInternetConnection,
      featureFlags: featureFlags ?? this.featureFlags,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
    );
  }
}

/// App State Notifier
class AppStateNotifier extends StateNotifier<AppState> {
  late SharedPreferences _prefs;
  bool _isInitialized = false;

  AppStateNotifier() : super(AppState(lastSyncTime: DateTime.now())) {
    _initializeAppState();
  }

  /// Initialize app state from persistent storage
  Future<void> _initializeAppState() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      
      final isFirstLaunch = _prefs.getBool('isFirstLaunch') ?? true;
      final isDarkMode = _prefs.getBool('isDarkMode') ?? false;
      final selectedLanguage = _prefs.getString('selectedLanguage') ?? 'en';
      final isOfflineMode = _prefs.getBool('isOfflineMode') ?? false;
      final lastSyncTimeMs = _prefs.getInt('lastSyncTime') ?? DateTime.now().millisecondsSinceEpoch;
      
      // Load feature flags
      final featureFlags = <String, bool>{};
      featureFlags['aiChat'] = _prefs.getBool('feature_aiChat') ?? true;
      featureFlags['speechRecognition'] = _prefs.getBool('feature_speechRecognition') ?? true;
      featureFlags['notifications'] = _prefs.getBool('feature_notifications') ?? true;
      featureFlags['cloudSync'] = _prefs.getBool('feature_cloudSync') ?? true;

      state = AppState(
        isFirstLaunch: isFirstLaunch,
        isDarkMode: isDarkMode,
        selectedLanguage: selectedLanguage,
        isOfflineMode: isOfflineMode,
        hasInternetConnection: true, // Will be updated by connectivity service
        featureFlags: featureFlags,
        lastSyncTime: DateTime.fromMillisecondsSinceEpoch(lastSyncTimeMs),
      );

      _isInitialized = true;
      
      if (Environment.enableLogging) {
        print('✅ App state initialized: ${state.toString()}');
      }
    } catch (e) {
      if (Environment.enableLogging) {
        print('❌ App state initialization failed: $e');
      }
      _isInitialized = true; // Still mark as initialized to prevent hanging
    }
  }

  /// Mark first launch as completed
  Future<void> completeFirstLaunch() async {
    if (!_isInitialized) return;
    
    await _prefs.setBool('isFirstLaunch', false);
    state = state.copyWith(isFirstLaunch: false);
  }

  /// Toggle dark mode
  Future<void> toggleDarkMode() async {
    if (!_isInitialized) return;
    
    final newValue = !state.isDarkMode;
    await _prefs.setBool('isDarkMode', newValue);
    state = state.copyWith(isDarkMode: newValue);
  }

  /// Update selected language
  Future<void> updateLanguage(String languageCode) async {
    if (!_isInitialized) return;
    
    await _prefs.setString('selectedLanguage', languageCode);
    state = state.copyWith(selectedLanguage: languageCode);
  }

  /// Toggle offline mode
  Future<void> toggleOfflineMode() async {
    if (!_isInitialized) return;
    
    final newValue = !state.isOfflineMode;
    await _prefs.setBool('isOfflineMode', newValue);
    state = state.copyWith(isOfflineMode: newValue);
  }

  /// Update internet connection status
  void updateConnectionStatus(bool hasConnection) {
    state = state.copyWith(hasInternetConnection: hasConnection);
  }

  /// Update feature flag
  Future<void> updateFeatureFlag(String feature, bool enabled) async {
    if (!_isInitialized) return;
    
    await _prefs.setBool('feature_$feature', enabled);
    final newFlags = Map<String, bool>.from(state.featureFlags);
    newFlags[feature] = enabled;
    state = state.copyWith(featureFlags: newFlags);
  }

  /// Update last sync time
  Future<void> updateLastSyncTime([DateTime? time]) async {
    if (!_isInitialized) return;
    
    final syncTime = time ?? DateTime.now();
    await _prefs.setInt('lastSyncTime', syncTime.millisecondsSinceEpoch);
    state = state.copyWith(lastSyncTime: syncTime);
  }

  /// Check if feature is enabled
  bool isFeatureEnabled(String feature) {
    return state.featureFlags[feature] ?? false;
  }

  /// Get app configuration summary
  Map<String, dynamic> getConfigSummary() {
    return {
      'environment': Environment.current.name,
      'version': Environment.appVersion,
      'buildNumber': Environment.buildNumber,
      'isFirstLaunch': state.isFirstLaunch,
      'isDarkMode': state.isDarkMode,
      'selectedLanguage': state.selectedLanguage,
      'isOfflineMode': state.isOfflineMode,
      'hasInternetConnection': state.hasInternetConnection,
      'enabledFeatures': state.featureFlags.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList(),
      'lastSyncTime': state.lastSyncTime.toIso8601String(),
    };
  }
}

/// App State Provider
final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier();
});

/// Convenience providers for specific app state properties
final isFirstLaunchProvider = Provider<bool>((ref) {
  return ref.watch(appStateProvider).isFirstLaunch;
});

final isDarkModeProvider = Provider<bool>((ref) {
  return ref.watch(appStateProvider).isDarkMode;
});

final selectedLanguageProvider = Provider<String>((ref) {
  return ref.watch(appStateProvider).selectedLanguage;
});

final isOfflineModeProvider = Provider<bool>((ref) {
  return ref.watch(appStateProvider).isOfflineMode;
});

final hasInternetConnectionProvider = Provider<bool>((ref) {
  return ref.watch(appStateProvider).hasInternetConnection;
});

final lastSyncTimeProvider = Provider<DateTime>((ref) {
  return ref.watch(appStateProvider).lastSyncTime;
});

/// Feature flag providers
final aiChatEnabledProvider = Provider<bool>((ref) {
  return ref.watch(appStateProvider).featureFlags['aiChat'] ?? true;
});

final speechRecognitionEnabledProvider = Provider<bool>((ref) {
  return ref.watch(appStateProvider).featureFlags['speechRecognition'] ?? true;
});

final notificationsEnabledProvider = Provider<bool>((ref) {
  return ref.watch(appStateProvider).featureFlags['notifications'] ?? true;
});

final cloudSyncEnabledProvider = Provider<bool>((ref) {
  return ref.watch(appStateProvider).featureFlags['cloudSync'] ?? true;
});

/// API Configuration status provider
final apiConfigStatusProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  try {
    return await ApiConfig.getConfigurationSummary();
  } catch (e) {
    return {'error': e.toString()};
  }
});
