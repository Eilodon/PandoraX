/// Service Locator for Phase 4 Architecture
/// 
/// This file provides a simplified dependency injection system
/// using GetIt for better testability and maintainability.
library service_locator;

import 'package:get_it/get_it.dart';
import 'package:note_domain/note_domain.dart';
import 'package:note_data/note_data.dart';
import 'app_state.dart';
import 'app_state_notifier.dart';

/// Global service locator instance
final GetIt _instance = GetIt.instance;

/// Service Locator for dependency injection
class ServiceLocator {
  /// Initialize all services
  static void setup() {
    // Core services
    _instance.registerLazySingleton<AppStateNotifier>(() => AppStateNotifier());
    
    // Data services
    _instance.registerLazySingleton<IsarService>(() => IsarService());
    _instance.registerLazySingleton<NoteRepository>(
      () => NoteRepositoryImpl(_instance<IsarService>()),
    );
    
    // Theme service
    _instance.registerLazySingleton<ThemeService>(() => ThemeService());
    
    // Navigation service
    _instance.registerLazySingleton<NavigationService>(() => NavigationService());
    
    // AI service
    _instance.registerLazySingleton<AIService>(() => AIService());
    
    // Analytics service
    _instance.registerLazySingleton<AnalyticsService>(() => AnalyticsService());
  }

  /// Get a service by type
  static T get<T extends Object>() => _instance.get<T>();

  /// Check if a service is registered
  static bool isRegistered<T extends Object>() => _instance.isRegistered<T>();

  /// Reset all services (useful for testing)
  static void reset() {
    _instance.reset();
  }
}

/// Theme Service for managing app themes
class ThemeService {
  bool _isDarkMode = false;
  
  bool get isDarkMode => _isDarkMode;
  
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
  }
  
  void setTheme(bool isDark) {
    _isDarkMode = isDark;
  }
}

/// Navigation Service for managing app navigation
class NavigationService {
  String _currentScreen = 'welcome';
  
  String get currentScreen => _currentScreen;
  
  void navigateTo(String screen) {
    _currentScreen = screen;
  }
  
  void goBack() {
    // Implement back navigation logic
  }
}

/// AI Service for AI-related operations
class AIService {
  Future<String> generateSummary(String content) async {
    // Implement AI summary generation
    await Future.delayed(const Duration(seconds: 1));
    return 'AI generated summary for: ${content.substring(0, 50)}...';
  }
  
  Future<String> generateTitle(String content) async {
    // Implement AI title generation
    await Future.delayed(const Duration(milliseconds: 500));
    return 'AI Generated Title';
  }
  
  Future<List<String>> generateTags(String content) async {
    // Implement AI tag generation
    await Future.delayed(const Duration(milliseconds: 300));
    return ['AI', 'Generated', 'Tags'];
  }
}

/// Analytics Service for tracking user behavior
class AnalyticsService {
  void trackEvent(String eventName, Map<String, dynamic> properties) {
    // Implement analytics tracking
    print('Analytics: $eventName with properties: $properties');
  }
  
  void trackScreenView(String screenName) {
    trackEvent('screen_view', {'screen_name': screenName});
  }
  
  void trackUserAction(String action, Map<String, dynamic> context) {
    trackEvent('user_action', {'action': action, 'context': context});
  }
}
