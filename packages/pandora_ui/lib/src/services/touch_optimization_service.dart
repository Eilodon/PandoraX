import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

/// Pandora 4 Touch Optimization Service
/// 
/// Comprehensive touch optimization for mobile devices
/// with gesture recognition, haptic feedback, and touch target management
class TouchOptimizationService {
  // Private constructor to prevent instantiation
  TouchOptimizationService._();

  // Touch target constants
  static const double minimumTouchTarget = 44.0; // iOS guideline
  static const double minimumTouchTargetAndroid = 48.0; // Material guideline
  static const double recommendedTouchTarget = 56.0; // Recommended size
  static const double maximumTouchTarget = 72.0; // Maximum for single finger

  // Gesture recognition thresholds
  static const double tapThreshold = 10.0;
  static const double longPressThreshold = 500; // milliseconds
  static const double doubleTapThreshold = 300; // milliseconds
  static const double swipeThreshold = 50.0;
  static const double pinchThreshold = 0.1;

  // Haptic feedback patterns
  static const Map<String, HapticFeedbackType> hapticPatterns = {
    'light': HapticFeedbackType.lightImpact,
    'medium': HapticFeedbackType.mediumImpact,
    'heavy': HapticFeedbackType.heavyImpact,
    'selection': HapticFeedbackType.selectionClick,
    'error': HapticFeedbackType.heavyImpact,
    'success': HapticFeedbackType.lightImpact,
  };

  /// Get optimal touch target size for platform
  static double getOptimalTouchTargetSize(PlatformType platform) {
    switch (platform) {
      case PlatformType.ios:
        return minimumTouchTarget;
      case PlatformType.android:
        return minimumTouchTargetAndroid;
      case PlatformType.mobile:
        return minimumTouchTarget;
      case PlatformType.web:
        return recommendedTouchTarget;
      case PlatformType.desktop:
        return 32.0; // Desktop can be smaller
    }
  }

  /// Check if touch target meets accessibility guidelines
  static bool isTouchTargetAccessible(double size, PlatformType platform) {
    final minimumSize = getOptimalTouchTargetSize(platform);
    return size >= minimumSize;
  }

  /// Get recommended touch target size with padding
  static EdgeInsets getTouchTargetPadding(
    Widget child, 
    PlatformType platform, {
    double? customSize,
  }) {
    final targetSize = customSize ?? getOptimalTouchTargetSize(platform);
    final childSize = _getChildSize(child);
    
    if (childSize.width >= targetSize && childSize.height >= targetSize) {
      return EdgeInsets.zero;
    }

    final horizontalPadding = math.max(0.0, (targetSize - childSize.width) / 2);
    final verticalPadding = math.max(0.0, (targetSize - childSize.height) / 2);

    return EdgeInsets.symmetric(
      horizontal: horizontalPadding,
      vertical: verticalPadding,
    );
  }

  /// Create touch-optimized widget
  static Widget createTouchOptimized({
    required Widget child,
    required VoidCallback onTap,
    PlatformType? platform,
    double? touchTargetSize,
    bool enableHapticFeedback = true,
    String? hapticPattern,
    bool enableRipple = true,
    bool enableScale = true,
    VoidCallback? onLongPress,
    VoidCallback? onDoubleTap,
    String? tooltip,
  }) {
    final effectivePlatform = platform ?? _getCurrentPlatform();
    final effectiveSize = touchTargetSize ?? getOptimalTouchTargetSize(effectivePlatform);
    
    Widget touchWidget = child;

    // Add padding to meet touch target requirements
    final padding = getTouchTargetPadding(child, effectivePlatform, customSize: effectiveSize);
    if (padding != EdgeInsets.zero) {
      touchWidget = Padding(
        padding: padding,
        child: child,
      );
    }

    // Add gesture detection
    touchWidget = _createGestureDetector(
      child: touchWidget,
      onTap: onTap,
      onLongPress: onLongPress,
      onDoubleTap: onDoubleTap,
      enableHapticFeedback: enableHapticFeedback,
      hapticPattern: hapticPattern,
    );

    // Add ripple effect
    if (enableRipple) {
      touchWidget = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          onDoubleTap: onDoubleTap,
          borderRadius: BorderRadius.circular(8),
          child: touchWidget,
        ),
      );
    }

    // Add scale animation
    if (enableScale) {
      touchWidget = _ScaleOnTap(
        onTap: onTap,
        child: touchWidget,
      );
    }

    // Add tooltip
    if (tooltip != null) {
      touchWidget = Tooltip(
        message: tooltip,
        child: touchWidget,
      );
    }

    return touchWidget;
  }

  /// Create gesture detector with touch optimization
  static Widget _createGestureDetector({
    required Widget child,
    required VoidCallback onTap,
    VoidCallback? onLongPress,
    VoidCallback? onDoubleTap,
    bool enableHapticFeedback = true,
    String? hapticPattern,
  }) {
    return GestureDetector(
      onTap: () {
        if (enableHapticFeedback) {
          _triggerHapticFeedback(hapticPattern ?? 'light');
        }
        onTap();
      },
      onLongPress: onLongPress != null ? () {
        if (enableHapticFeedback) {
          _triggerHapticFeedback('medium');
        }
        onLongPress();
      } : null,
      onDoubleTap: onDoubleTap != null ? () {
        if (enableHapticFeedback) {
          _triggerHapticFeedback('selection');
        }
        onDoubleTap();
      } : null,
      child: child,
    );
  }

  /// Trigger haptic feedback
  static void _triggerHapticFeedback(String pattern) {
    final hapticType = hapticPatterns[pattern] ?? HapticFeedbackType.lightImpact;
    
    switch (hapticType) {
      case HapticFeedbackType.lightImpact:
        HapticFeedback.lightImpact();
        break;
      case HapticFeedbackType.mediumImpact:
        HapticFeedback.mediumImpact();
        break;
      case HapticFeedbackType.heavyImpact:
        HapticFeedback.heavyImpact();
        break;
      case HapticFeedbackType.selectionClick:
        HapticFeedback.selectionClick();
        break;
    }
  }

  /// Get child size for touch target calculation
  static Size _getChildSize(Widget child) {
    // This is a simplified implementation
    // In a real app, you'd need to measure the actual child size
    return const Size(24, 24); // Default size
  }

  /// Get current platform
  static PlatformType _getCurrentPlatform() {
    // This would be determined at runtime
    return PlatformType.mobile;
  }

  /// Create swipe gesture detector
  static Widget createSwipeDetector({
    required Widget child,
    VoidCallback? onSwipeLeft,
    VoidCallback? onSwipeRight,
    VoidCallback? onSwipeUp,
    VoidCallback? onSwipeDown,
    double threshold = swipeThreshold,
  }) {
    return GestureDetector(
      onPanEnd: (details) {
        final velocity = details.velocity.pixelsPerSecond;
        
        if (velocity.dx.abs() > velocity.dy.abs()) {
          // Horizontal swipe
          if (velocity.dx > threshold && onSwipeRight != null) {
            onSwipeRight();
          } else if (velocity.dx < -threshold && onSwipeLeft != null) {
            onSwipeLeft();
          }
        } else {
          // Vertical swipe
          if (velocity.dy > threshold && onSwipeDown != null) {
            onSwipeDown();
          } else if (velocity.dy < -threshold && onSwipeUp != null) {
            onSwipeUp();
          }
        }
      },
      child: child,
    );
  }

  /// Create pinch gesture detector
  static Widget createPinchDetector({
    required Widget child,
    ValueChanged<double>? onPinch,
    double threshold = pinchThreshold,
  }) {
    return GestureDetector(
      onScaleUpdate: (details) {
        if (details.scale != 1.0) {
          final scaleChange = details.scale - 1.0;
          if (scaleChange.abs() > threshold) {
            onPinch?.call(scaleChange);
          }
        }
      },
      child: child,
    );
  }

  /// Create drag gesture detector
  static Widget createDragDetector({
    required Widget child,
    ValueChanged<Offset>? onDrag,
    VoidCallback? onDragStart,
    VoidCallback? onDragEnd,
  }) {
    return GestureDetector(
      onPanStart: (_) => onDragStart?.call(),
      onPanUpdate: (details) => onDrag?.call(details.delta),
      onPanEnd: (_) => onDragEnd?.call(),
      child: child,
    );
  }

  /// Validate touch target accessibility
  static TouchTargetValidation validateTouchTarget(
    Widget widget, 
    PlatformType platform,
  ) {
    final size = _getChildSize(widget);
    final minimumSize = getOptimalTouchTargetSize(platform);
    
    return TouchTargetValidation(
      isAccessible: isTouchTargetAccessible(
        math.min(size.width, size.height), 
        platform,
      ),
      currentSize: math.min(size.width, size.height),
      minimumSize: minimumSize,
      recommendation: size.width < minimumSize || size.height < minimumSize
          ? 'Increase touch target size to at least ${minimumSize}px'
          : 'Touch target size is adequate',
    );
  }

  /// Get touch target recommendations
  static List<String> getTouchTargetRecommendations(PlatformType platform) {
    final recommendations = <String>[];
    final minimumSize = getOptimalTouchTargetSize(platform);
    
    recommendations.add('Minimum touch target: ${minimumSize}px');
    recommendations.add('Recommended touch target: ${recommendedTouchTarget}px');
    recommendations.add('Maximum touch target: ${maximumTouchTarget}px');
    recommendations.add('Add padding if target is too small');
    recommendations.add('Test with different finger sizes');
    
    return recommendations;
  }
}

/// Platform type enum
enum PlatformType {
  ios,
  android,
  web,
  desktop,
  mobile,
}

/// Haptic feedback type enum
enum HapticFeedbackType {
  lightImpact,
  mediumImpact,
  heavyImpact,
  selectionClick,
}

/// Touch target validation result
class TouchTargetValidation {
  final bool isAccessible;
  final double currentSize;
  final double minimumSize;
  final String recommendation;

  const TouchTargetValidation({
    required this.isAccessible,
    required this.currentSize,
    required this.minimumSize,
    required this.recommendation,
  });
}

/// Scale on tap widget
class _ScaleOnTap extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _ScaleOnTap({
    required this.child,
    required this.onTap,
  });

  @override
  State<_ScaleOnTap> createState() => _ScaleOnTapState();
}

class _ScaleOnTapState extends State<_ScaleOnTap>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          );
        },
      ),
    );
  }
}

/// Touch optimization extensions
extension TouchOptimizationExtensions on Widget {
  /// Make widget touch-optimized
  Widget withTouchOptimization({
    required VoidCallback onTap,
    PlatformType? platform,
    double? touchTargetSize,
    bool enableHapticFeedback = true,
    String? hapticPattern,
    bool enableRipple = true,
    bool enableScale = true,
    VoidCallback? onLongPress,
    VoidCallback? onDoubleTap,
    String? tooltip,
  }) {
    return TouchOptimizationService.createTouchOptimized(
      child: this,
      onTap: onTap,
      platform: platform,
      touchTargetSize: touchTargetSize,
      enableHapticFeedback: enableHapticFeedback,
      hapticPattern: hapticPattern,
      enableRipple: enableRipple,
      enableScale: enableScale,
      onLongPress: onLongPress,
      onDoubleTap: onDoubleTap,
      tooltip: tooltip,
    );
  }

  /// Add swipe gestures
  Widget withSwipeGestures({
    VoidCallback? onSwipeLeft,
    VoidCallback? onSwipeRight,
    VoidCallback? onSwipeUp,
    VoidCallback? onSwipeDown,
    double threshold = TouchOptimizationService.swipeThreshold,
  }) {
    return TouchOptimizationService.createSwipeDetector(
      child: this,
      onSwipeLeft: onSwipeLeft,
      onSwipeRight: onSwipeRight,
      onSwipeUp: onSwipeUp,
      onSwipeDown: onSwipeDown,
      threshold: threshold,
    );
  }

  /// Add pinch gestures
  Widget withPinchGestures({
    ValueChanged<double>? onPinch,
    double threshold = TouchOptimizationService.pinchThreshold,
  }) {
    return TouchOptimizationService.createPinchDetector(
      child: this,
      onPinch: onPinch,
      threshold: threshold,
    );
  }

  /// Add drag gestures
  Widget withDragGestures({
    ValueChanged<Offset>? onDrag,
    VoidCallback? onDragStart,
    VoidCallback? onDragEnd,
  }) {
    return TouchOptimizationService.createDragDetector(
      child: this,
      onDrag: onDrag,
      onDragStart: onDragStart,
      onDragEnd: onDragEnd,
    );
  }
}
