import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'logger.dart';

/// Global service locator instance
final GetIt getIt = GetIt.instance;

/// Dependency injection configuration
@InjectableInit()
void configureDependencies() {
  // TODO: Implement dependency injection setup
  // getIt.init();
}

/// Service locator wrapper for easier access
abstract class ServiceLocator {
  /// Get instance of type T
  static T get<T extends Object>() => getIt.get<T>();

  /// Get instance of type T with parameter
  static T getWithParam<T extends Object, P>(P param) => getIt.get<T>(param1: param);

  /// Register singleton instance
  static void registerSingleton<T extends Object>(T instance) {
    getIt.registerSingleton(instance);
  }

  /// Register factory
  static void registerFactory<T extends Object>(T Function() factory) {
    getIt.registerFactory(factory);
  }

  /// Register lazy singleton
  static void registerLazySingleton<T extends Object>(T Function() factory) {
    getIt.registerLazySingleton(factory);
  }

  /// Check if type is registered
  static bool isRegistered<T extends Object>() => getIt.isRegistered<T>();

  /// Reset all registrations
  static void reset() {
    getIt.reset();
  }

  /// Initialize all dependencies
  static Future<void> initialize() async {
    try {
      AppLogger.info('🔧 Initializing dependency injection...');
      // TODO: Implement dependency injection setup
      AppLogger.success('Dependency injection initialized successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to initialize dependency injection', e, stackTrace);
      rethrow;
    }
  }
}
