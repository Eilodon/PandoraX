import 'package:get_it/get_it.dart';
import '../repositories/note_repository.dart';
import '../state/app_state_notifier.dart';

/// Service Locator
/// 
/// Manages dependency injection for the application
class ServiceLocator {
  static final GetIt _instance = GetIt.instance;

  /// Register all dependencies
  static Future<void> registerDependencies() async {
    // Register repositories
    _instance.registerLazySingleton<NoteRepository>(
      () => throw UnimplementedError('NoteRepository must be registered'),
    );

    // Register state notifiers
    _instance.registerLazySingleton<AppStateNotifier>(
      () => AppStateNotifier(),
    );

    // Register services
    _instance.registerLazySingleton<ThemeService>(
      () => ThemeService(),
    );

    _instance.registerLazySingleton<NavigationService>(
      () => NavigationService(),
    );

    _instance.registerLazySingleton<AIService>(
      () => AIService(),
    );

    _instance.registerLazySingleton<AnalyticsService>(
      () => AnalyticsService(),
    );
  }

  /// Get a service by type
  static T get<T extends Object>() {
    return _instance.get<T>();
  }

  /// Register a service
  static void register<T extends Object>(T service) {
    _instance.registerSingleton<T>(service);
  }

  /// Reset all services
  static void reset() {
    _instance.reset();
  }
}

/// Theme Service
class ThemeService {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void setDarkMode(bool isDarkMode) {
    _isDarkMode = isDarkMode;
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
  }
}

/// Navigation Service
class NavigationService {
  String _currentScreen = 'home';

  String get currentScreen => _currentScreen;

  void navigateTo(String screen) {
    _currentScreen = screen;
  }

  void goBack() {
    // Implementation for going back
  }
}

/// AI Service
class AIService {
  Future<String> generateResponse(String prompt) async {
    // Implementation for AI response generation
    return 'AI response for: $prompt';
  }

  Future<List<String>> getSuggestions(String input) async {
    // Implementation for AI suggestions
    return ['Suggestion 1', 'Suggestion 2'];
  }

  Future<List<double>> createEmbedding(String content) async {
    // Implementation for creating embeddings
    // Return a dummy embedding vector
    return List.generate(384, (index) => (index * 0.01).toDouble());
  }
}

/// Analytics Service
class AnalyticsService {
  void trackEvent(String eventName, Map<String, dynamic> parameters) {
    // Implementation for analytics tracking
    print('Analytics: $eventName - $parameters');
  }

  void trackScreenView(String screenName) {
    // Implementation for screen view tracking
    print('Screen view: $screenName');
  }
}