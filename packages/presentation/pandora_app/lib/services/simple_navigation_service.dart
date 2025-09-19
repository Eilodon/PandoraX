import 'package:flutter/material.dart';
import 'package:core_utils/core_utils.dart';

/// Simple navigation service for managing page transitions
class SimpleNavigationService {
  static final SimpleNavigationService _instance = SimpleNavigationService._internal();
  factory SimpleNavigationService() => _instance;
  SimpleNavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Get current context
  BuildContext? get currentContext => navigatorKey.currentContext;

  /// Navigate to a new page
  Future<T?> navigateTo<T>(String routeName, {Object? arguments}) async {
    AppLogger.info('🧭 Navigating to: $routeName');
    
    return await navigatorKey.currentState?.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  /// Navigate and replace current page
  Future<T?> navigateAndReplace<T>(String routeName, {Object? arguments}) async {
    AppLogger.info('🔄 Replacing with: $routeName');
    
    return await navigatorKey.currentState?.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  /// Navigate and clear stack
  Future<T?> navigateAndClearStack<T>(String routeName, {Object? arguments}) async {
    AppLogger.info('🗑️ Clearing stack and navigating to: $routeName');
    
    return await navigatorKey.currentState?.pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Go back
  void goBack<T>([T? result]) {
    AppLogger.info('⬅️ Going back');
    navigatorKey.currentState?.pop<T>(result);
  }

  /// Check if can go back
  bool canGoBack() {
    return navigatorKey.currentState?.canPop() ?? false;
  }
}
