import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core_utils/core_utils.dart';
import '../services/navigation_service.dart';

/// Navigation state for managing current page and navigation history
class NavigationState {
  final int currentIndex;
  final List<String> navigationHistory;
  final bool isNavigating;
  final PageTransitionType lastTransitionType;

  const NavigationState({
    this.currentIndex = 0,
    this.navigationHistory = const [],
    this.isNavigating = false,
    this.lastTransitionType = PageTransitionType.slideRight,
  });

  NavigationState copyWith({
    int? currentIndex,
    List<String>? navigationHistory,
    bool? isNavigating,
    PageTransitionType? lastTransitionType,
  }) {
    return NavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
      navigationHistory: navigationHistory ?? this.navigationHistory,
      isNavigating: isNavigating ?? this.isNavigating,
      lastTransitionType: lastTransitionType ?? this.lastTransitionType,
    );
  }
}

/// Navigation notifier for managing navigation state
class NavigationNotifier extends StateNotifier<NavigationState> {
  final NavigationService _navigationService;

  NavigationNotifier(this._navigationService) : super(const NavigationState());

  /// Navigate to specific tab
  void navigateToTab(int index) {
    AppLogger.info('🧭 Navigating to tab: $index');
    
    state = state.copyWith(
      currentIndex: index,
      isNavigating: true,
    );

    // Simulate navigation delay
    Future.delayed(const Duration(milliseconds: 100), () {
      state = state.copyWith(isNavigating: false);
    });
  }

  /// Navigate to specific route
  Future<void> navigateToRoute(
    String routeName, {
    PageTransitionType transitionType = PageTransitionType.slideRight,
  }) async {
    AppLogger.info('🧭 Navigating to route: $routeName');
    
    state = state.copyWith(
      isNavigating: true,
      lastTransitionType: transitionType,
    );

    await _navigationService.navigateTo(
      routeName,
      transitionType: transitionType,
    );

    state = state.copyWith(isNavigating: false);
  }

  /// Go back
  void goBack() {
    AppLogger.info('⬅️ Going back');
    
    if (state.navigationHistory.isNotEmpty) {
      final newHistory = List<String>.from(state.navigationHistory);
      newHistory.removeLast();
      
      state = state.copyWith(
        navigationHistory: newHistory,
        isNavigating: true,
      );

      _navigationService.goBack();

      Future.delayed(const Duration(milliseconds: 100), () {
        state = state.copyWith(isNavigating: false);
      });
    }
  }

  /// Add to navigation history
  void addToHistory(String routeName) {
    final newHistory = List<String>.from(state.navigationHistory);
    newHistory.add(routeName);
    
    state = state.copyWith(navigationHistory: newHistory);
  }

  /// Clear navigation history
  void clearHistory() {
    AppLogger.info('🗑️ Clearing navigation history');
    state = state.copyWith(navigationHistory: []);
  }

  /// Check if can go back
  bool canGoBack() {
    return _navigationService.canGoBack() || state.navigationHistory.isNotEmpty;
  }
}

/// Navigation provider
final navigationProvider = StateNotifierProvider<NavigationNotifier, NavigationState>((ref) {
  return NavigationNotifier(NavigationService());
});

/// Current tab index provider
final currentTabIndexProvider = Provider<int>((ref) {
  return ref.watch(navigationProvider).currentIndex;
});

/// Navigation history provider
final navigationHistoryProvider = Provider<List<String>>((ref) {
  return ref.watch(navigationProvider).navigationHistory;
});

/// Is navigating provider
final isNavigatingProvider = Provider<bool>((ref) {
  return ref.watch(navigationProvider).isNavigating;
});
