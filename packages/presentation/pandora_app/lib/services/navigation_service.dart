import 'package:flutter/material.dart';
import 'package:core_utils/core_utils.dart';

/// Navigation service for managing page transitions and navigation
class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Get current context
  BuildContext? get currentContext => navigatorKey.currentContext;

  /// Navigate to a new page with custom transition
  Future<T?> navigateTo<T>(
    String routeName, {
    Object? arguments,
    PageTransitionType transitionType = PageTransitionType.slideRight,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) async {
    AppLogger.info('🧭 Navigating to: $routeName');
    
    return await navigatorKey.currentState?.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  /// Navigate and replace current page
  Future<T?> navigateAndReplace<T>(
    String routeName, {
    Object? arguments,
    PageTransitionType transitionType = PageTransitionType.slideRight,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) async {
    AppLogger.info('🔄 Replacing with: $routeName');
    
    return await navigatorKey.currentState?.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  /// Navigate and clear stack
  Future<T?> navigateAndClearStack<T>(
    String routeName, {
    Object? arguments,
    PageTransitionType transitionType = PageTransitionType.fade,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) async {
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

  /// Pop until specific route
  void popUntil(String routeName) {
    AppLogger.info('🔄 Popping until: $routeName');
    navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
  }
}

/// Page transition types
enum PageTransitionType {
  slideRight,
  slideLeft,
  slideUp,
  slideDown,
  fade,
  scale,
  rotation,
  flip,
  cupertino,
  material,
}

/// Custom page route with transitions
class CustomPageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;
  final PageTransitionType transitionType;
  final Duration duration;
  final Curve curve;

  CustomPageRoute({
    required this.child,
    this.transitionType = PageTransitionType.slideRight,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _buildTransition(animation, child);
          },
        );

  Widget _buildTransition(Animation<double> animation, Widget child) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve,
    );

    switch (transitionType) {
      case PageTransitionType.slideRight:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        );
      
      case PageTransitionType.slideLeft:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        );
      
      case PageTransitionType.slideUp:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        );
      
      case PageTransitionType.slideDown:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, -1.0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        );
      
      case PageTransitionType.fade:
        return FadeTransition(
          opacity: curvedAnimation,
          child: child,
        );
      
      case PageTransitionType.scale:
        return ScaleTransition(
          scale: curvedAnimation,
          child: child,
        );
      
      case PageTransitionType.rotation:
        return RotationTransition(
          turns: curvedAnimation,
          child: child,
        );
      
      case PageTransitionType.flip:
        return AnimatedBuilder(
          animation: curvedAnimation,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(curvedAnimation.value * 3.14159),
              child: child,
            );
          },
          child: child,
        );
      
      case PageTransitionType.cupertino:
        return CupertinoPageTransition(
          primaryRouteAnimation: curvedAnimation,
          secondaryRouteAnimation: secondaryAnimation,
          child: child,
          linearTransition: false,
        );
      
      case PageTransitionType.material:
        return MaterialPageTransition(
          primaryRouteAnimation: curvedAnimation,
          secondaryRouteAnimation: secondaryAnimation,
          child: child,
        );
    }
  }
}

/// Cupertino page transition
class CupertinoPageTransition extends StatelessWidget {
  final Animation<double> primaryRouteAnimation;
  final Animation<double> secondaryRouteAnimation;
  final Widget child;
  final bool linearTransition;

  const CupertinoPageTransition({
    super.key,
    required this.primaryRouteAnimation,
    required this.secondaryRouteAnimation,
    required this.child,
    this.linearTransition = false,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: primaryRouteAnimation,
        curve: linearTransition ? Curves.linear : Curves.easeInOut,
      )),
      child: child,
    );
  }
}

/// Material page transition
class MaterialPageTransition extends StatelessWidget {
  final Animation<double> primaryRouteAnimation;
  final Animation<double> secondaryRouteAnimation;
  final Widget child;

  const MaterialPageTransition({
    super.key,
    required this.primaryRouteAnimation,
    required this.secondaryRouteAnimation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: primaryRouteAnimation,
        curve: Curves.easeInOut,
      )),
      child: child,
    );
  }
}
