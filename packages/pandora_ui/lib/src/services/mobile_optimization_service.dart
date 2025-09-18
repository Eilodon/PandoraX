import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

/// Pandora 4 Mobile Optimization Service
/// 
/// Comprehensive mobile-first optimization service for Phase 2
/// Includes advanced responsive design, touch optimization, and mobile UX enhancements
class MobileOptimizationService {
  // Private constructor to prevent instantiation
  MobileOptimizationService._();

  // Mobile-specific breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;
  static const double largeDesktopBreakpoint = 1600;

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

  // Mobile-specific spacing multipliers
  static const Map<MobileSize, double> mobileSpacingMultipliers = {
    MobileSize.compact: 0.75,
    MobileSize.regular: 1.0,
    MobileSize.comfortable: 1.25,
    MobileSize.spacious: 1.5,
  };

  // Mobile-specific font size multipliers
  static const Map<MobileSize, double> mobileFontSizeMultipliers = {
    MobileSize.compact: 0.9,
    MobileSize.regular: 1.0,
    MobileSize.comfortable: 1.1,
    MobileSize.spacious: 1.2,
  };

  /// Get mobile-optimized breakpoint
  static MobileBreakpoint getMobileBreakpoint(double width) {
    if (width < mobileBreakpoint) {
      return MobileBreakpoint.mobile;
    } else if (width < tabletBreakpoint) {
      return MobileBreakpoint.tablet;
    } else if (width < desktopBreakpoint) {
      return MobileBreakpoint.desktop;
    } else {
      return MobileBreakpoint.largeDesktop;
    }
  }

  /// Get mobile-optimized spacing
  static double getMobileSpacing(
    double baseSpacing,
    MobileBreakpoint breakpoint, {
    MobileSize? size,
  }) {
    final effectiveSize = size ?? MobileSize.regular;
    final multiplier = mobileSpacingMultipliers[effectiveSize] ?? 1.0;
    
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        return baseSpacing * multiplier * 0.8;
      case MobileBreakpoint.tablet:
        return baseSpacing * multiplier;
      case MobileBreakpoint.desktop:
        return baseSpacing * multiplier * 1.2;
      case MobileBreakpoint.largeDesktop:
        return baseSpacing * multiplier * 1.4;
    }
  }

  /// Get mobile-optimized font size
  static double getMobileFontSize(
    double baseFontSize,
    MobileBreakpoint breakpoint, {
    MobileSize? size,
  }) {
    final effectiveSize = size ?? MobileSize.regular;
    final multiplier = mobileFontSizeMultipliers[effectiveSize] ?? 1.0;
    
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        return baseFontSize * multiplier * 0.9;
      case MobileBreakpoint.tablet:
        return baseFontSize * multiplier;
      case MobileBreakpoint.desktop:
        return baseFontSize * multiplier * 1.1;
      case MobileBreakpoint.largeDesktop:
        return baseFontSize * multiplier * 1.2;
    }
  }

  /// Get mobile-optimized padding
  static EdgeInsets getMobilePadding(
    EdgeInsets basePadding,
    MobileBreakpoint breakpoint, {
    MobileSize? size,
  }) {
    final effectiveSize = size ?? MobileSize.regular;
    final multiplier = mobileSpacingMultipliers[effectiveSize] ?? 1.0;
    
    double paddingMultiplier;
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        paddingMultiplier = 0.8 * multiplier;
        break;
      case MobileBreakpoint.tablet:
        paddingMultiplier = 1.0 * multiplier;
        break;
      case MobileBreakpoint.desktop:
        paddingMultiplier = 1.2 * multiplier;
        break;
      case MobileBreakpoint.largeDesktop:
        paddingMultiplier = 1.4 * multiplier;
        break;
    }

    return EdgeInsets.only(
      left: basePadding.left * paddingMultiplier,
      top: basePadding.top * paddingMultiplier,
      right: basePadding.right * paddingMultiplier,
      bottom: basePadding.bottom * paddingMultiplier,
    );
  }

  /// Get mobile-optimized margin
  static EdgeInsets getMobileMargin(
    EdgeInsets baseMargin,
    MobileBreakpoint breakpoint, {
    MobileSize? size,
  }) {
    final effectiveSize = size ?? MobileSize.regular;
    final multiplier = mobileSpacingMultipliers[effectiveSize] ?? 1.0;
    
    double marginMultiplier;
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        marginMultiplier = 0.75 * multiplier;
        break;
      case MobileBreakpoint.tablet:
        marginMultiplier = 1.0 * multiplier;
        break;
      case MobileBreakpoint.desktop:
        marginMultiplier = 1.25 * multiplier;
        break;
      case MobileBreakpoint.largeDesktop:
        marginMultiplier = 1.5 * multiplier;
        break;
    }

    return EdgeInsets.only(
      left: baseMargin.left * marginMultiplier,
      top: baseMargin.top * marginMultiplier,
      right: baseMargin.right * marginMultiplier,
      bottom: baseMargin.bottom * marginMultiplier,
    );
  }

  /// Get mobile-optimized border radius
  static double getMobileBorderRadius(
    double baseRadius,
    MobileBreakpoint breakpoint, {
    MobileSize? size,
  }) {
    final effectiveSize = size ?? MobileSize.regular;
    final multiplier = mobileSpacingMultipliers[effectiveSize] ?? 1.0;
    
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        return baseRadius * 0.8 * multiplier;
      case MobileBreakpoint.tablet:
        return baseRadius * multiplier;
      case MobileBreakpoint.desktop:
        return baseRadius * 1.1 * multiplier;
      case MobileBreakpoint.largeDesktop:
        return baseRadius * 1.2 * multiplier;
    }
  }

  /// Get mobile-optimized elevation
  static double getMobileElevation(
    double baseElevation,
    MobileBreakpoint breakpoint, {
    MobileSize? size,
  }) {
    final effectiveSize = size ?? MobileSize.regular;
    final multiplier = mobileSpacingMultipliers[effectiveSize] ?? 1.0;
    
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        return baseElevation * 0.8 * multiplier;
      case MobileBreakpoint.tablet:
        return baseElevation * multiplier;
      case MobileBreakpoint.desktop:
        return baseElevation * 1.2 * multiplier;
      case MobileBreakpoint.largeDesktop:
        return baseElevation * 1.4 * multiplier;
    }
  }

  /// Get mobile-optimized touch target size
  static double getMobileTouchTargetSize(
    MobileBreakpoint breakpoint, {
    MobileSize? size,
  }) {
    final effectiveSize = size ?? MobileSize.regular;
    final multiplier = mobileSpacingMultipliers[effectiveSize] ?? 1.0;
    
    double baseSize;
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        baseSize = minimumTouchTarget;
        break;
      case MobileBreakpoint.tablet:
        baseSize = recommendedTouchTarget;
        break;
      case MobileBreakpoint.desktop:
        baseSize = 40.0; // Desktop can be smaller
        break;
      case MobileBreakpoint.largeDesktop:
        baseSize = 40.0;
        break;
    }

    return baseSize * multiplier;
  }

  /// Get mobile-optimized animation duration
  static Duration getMobileAnimationDuration(
    Duration baseDuration,
    MobileBreakpoint breakpoint, {
    MobileSize? size,
  }) {
    final effectiveSize = size ?? MobileSize.regular;
    final multiplier = mobileSpacingMultipliers[effectiveSize] ?? 1.0;
    
    double durationMultiplier;
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        durationMultiplier = 0.8 * multiplier;
        break;
      case MobileBreakpoint.tablet:
        durationMultiplier = 1.0 * multiplier;
        break;
      case MobileBreakpoint.desktop:
        durationMultiplier = 1.2 * multiplier;
        break;
      case MobileBreakpoint.largeDesktop:
        durationMultiplier = 1.4 * multiplier;
        break;
    }

    return Duration(
      milliseconds: (baseDuration.inMilliseconds * durationMultiplier).round(),
    );
  }

  /// Get mobile-optimized curve
  static Curve getMobileCurve(MobileBreakpoint breakpoint) {
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        return Curves.easeOutCubic; // Snappier for mobile
      case MobileBreakpoint.tablet:
        return Curves.easeInOut;
      case MobileBreakpoint.desktop:
        return Curves.easeInOutCubic; // Smoother for desktop
      case MobileBreakpoint.largeDesktop:
        return Curves.easeInOutCubic;
    }
  }

  /// Get mobile-optimized grid columns
  static int getMobileGridColumns(MobileBreakpoint breakpoint) {
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        return 1;
      case MobileBreakpoint.tablet:
        return 2;
      case MobileBreakpoint.desktop:
        return 3;
      case MobileBreakpoint.largeDesktop:
        return 4;
    }
  }

  /// Get mobile-optimized aspect ratio
  static double getMobileAspectRatio(MobileBreakpoint breakpoint) {
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        return 16 / 9;
      case MobileBreakpoint.tablet:
        return 4 / 3;
      case MobileBreakpoint.desktop:
        return 16 / 10;
      case MobileBreakpoint.largeDesktop:
        return 21 / 9;
    }
  }

  /// Get mobile-optimized container width
  static double getMobileContainerWidth(
    double screenWidth,
    MobileBreakpoint breakpoint, {
    MobileSize? size,
  }) {
    final effectiveSize = size ?? MobileSize.regular;
    final multiplier = mobileSpacingMultipliers[effectiveSize] ?? 1.0;
    
    double widthMultiplier;
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        widthMultiplier = 0.95 * multiplier; // More space on mobile
        break;
      case MobileBreakpoint.tablet:
        widthMultiplier = 0.9 * multiplier;
        break;
      case MobileBreakpoint.desktop:
        widthMultiplier = 0.8 * multiplier;
        break;
      case MobileBreakpoint.largeDesktop:
        widthMultiplier = 0.7 * multiplier;
        break;
    }

    return screenWidth * widthMultiplier;
  }

  /// Get mobile-optimized max width
  static double getMobileMaxWidth(MobileBreakpoint breakpoint) {
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        return 600;
      case MobileBreakpoint.tablet:
        return 800;
      case MobileBreakpoint.desktop:
        return 1200;
      case MobileBreakpoint.largeDesktop:
        return 1600;
    }
  }

  /// Check if current breakpoint is mobile
  static bool isMobile(MobileBreakpoint breakpoint) {
    return breakpoint == MobileBreakpoint.mobile;
  }

  /// Check if current breakpoint is tablet
  static bool isTablet(MobileBreakpoint breakpoint) {
    return breakpoint == MobileBreakpoint.tablet;
  }

  /// Check if current breakpoint is desktop
  static bool isDesktop(MobileBreakpoint breakpoint) {
    return breakpoint == MobileBreakpoint.desktop || 
           breakpoint == MobileBreakpoint.largeDesktop;
  }

  /// Get mobile-optimized orientation
  static MobileOrientation getMobileOrientation(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait 
        ? MobileOrientation.portrait 
        : MobileOrientation.landscape;
  }

  /// Get mobile-optimized safe area padding
  static EdgeInsets getMobileSafeAreaPadding(
    BuildContext context,
    MobileBreakpoint breakpoint, {
    MobileSize? size,
  }) {
    final mediaQuery = MediaQuery.of(context);
    final padding = mediaQuery.padding;
    final effectiveSize = size ?? MobileSize.regular;
    final multiplier = mobileSpacingMultipliers[effectiveSize] ?? 1.0;
    
    double horizontalPadding;
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        horizontalPadding = 16 * multiplier;
        break;
      case MobileBreakpoint.tablet:
        horizontalPadding = 24 * multiplier;
        break;
      case MobileBreakpoint.desktop:
        horizontalPadding = 32 * multiplier;
        break;
      case MobileBreakpoint.largeDesktop:
        horizontalPadding = 48 * multiplier;
        break;
    }

    return EdgeInsets.only(
      top: padding.top,
      bottom: padding.bottom,
      left: horizontalPadding,
      right: horizontalPadding,
    );
  }

  /// Get mobile-optimized haptic feedback
  static void triggerMobileHapticFeedback(
    MobileHapticType type, {
    MobileBreakpoint? breakpoint,
  }) {
    // Adjust haptic intensity based on breakpoint
    final effectiveBreakpoint = breakpoint ?? MobileBreakpoint.mobile;
    final intensity = _getHapticIntensity(effectiveBreakpoint);
    
    switch (type) {
      case MobileHapticType.light:
        HapticFeedback.lightImpact();
        break;
      case MobileHapticType.medium:
        HapticFeedback.mediumImpact();
        break;
      case MobileHapticType.heavy:
        HapticFeedback.heavyImpact();
        break;
      case MobileHapticType.selection:
        HapticFeedback.selectionClick();
        break;
      case MobileHapticType.error:
        HapticFeedback.heavyImpact();
        break;
      case MobileHapticType.success:
        HapticFeedback.lightImpact();
        break;
    }
  }

  /// Get haptic intensity based on breakpoint
  static double _getHapticIntensity(MobileBreakpoint breakpoint) {
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        return 1.0; // Full intensity on mobile
      case MobileBreakpoint.tablet:
        return 0.8; // Slightly reduced on tablet
      case MobileBreakpoint.desktop:
        return 0.6; // Reduced on desktop
      case MobileBreakpoint.largeDesktop:
        return 0.6;
    }
  }

  /// Get mobile-optimized gesture threshold
  static double getMobileGestureThreshold(
    MobileGestureType type,
    MobileBreakpoint breakpoint, {
    MobileSize? size,
  }) {
    final effectiveSize = size ?? MobileSize.regular;
    final multiplier = mobileSpacingMultipliers[effectiveSize] ?? 1.0;
    
    double baseThreshold;
    switch (type) {
      case MobileGestureType.tap:
        baseThreshold = tapThreshold;
        break;
      case MobileGestureType.longPress:
        baseThreshold = longPressThreshold.toDouble();
        break;
      case MobileGestureType.doubleTap:
        baseThreshold = doubleTapThreshold.toDouble();
        break;
      case MobileGestureType.swipe:
        baseThreshold = swipeThreshold;
        break;
      case MobileGestureType.pinch:
        baseThreshold = pinchThreshold;
        break;
    }

    // Adjust threshold based on breakpoint
    double breakpointMultiplier;
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        breakpointMultiplier = 1.0; // Standard on mobile
        break;
      case MobileBreakpoint.tablet:
        breakpointMultiplier = 1.1; // Slightly more sensitive on tablet
        break;
      case MobileBreakpoint.desktop:
        breakpointMultiplier = 1.2; // More sensitive on desktop
        break;
      case MobileBreakpoint.largeDesktop:
        breakpointMultiplier = 1.2;
        break;
    }

    return baseThreshold * multiplier * breakpointMultiplier;
  }

  /// Get mobile-optimized performance settings
  static MobilePerformanceSettings getMobilePerformanceSettings(
    MobileBreakpoint breakpoint, {
    MobileSize? size,
  }) {
    final effectiveSize = size ?? MobileSize.regular;
    final multiplier = mobileSpacingMultipliers[effectiveSize] ?? 1.0;
    
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        return MobilePerformanceSettings(
          enableAnimations: true,
          animationDuration: Duration(milliseconds: (200 * multiplier).round()),
          enableHapticFeedback: true,
          enableRippleEffects: true,
          enableScaleAnimations: true,
          enableParallax: false, // Disable on mobile for performance
          enableBlurEffects: false, // Disable on mobile for performance
          enableShadows: true,
          enableGradients: true,
          maxWidgetsPerScreen: 50,
          enableLazyLoading: true,
          enableVirtualization: true,
        );
      case MobileBreakpoint.tablet:
        return MobilePerformanceSettings(
          enableAnimations: true,
          animationDuration: Duration(milliseconds: (250 * multiplier).round()),
          enableHapticFeedback: true,
          enableRippleEffects: true,
          enableScaleAnimations: true,
          enableParallax: true,
          enableBlurEffects: true,
          enableShadows: true,
          enableGradients: true,
          maxWidgetsPerScreen: 100,
          enableLazyLoading: true,
          enableVirtualization: true,
        );
      case MobileBreakpoint.desktop:
        return MobilePerformanceSettings(
          enableAnimations: true,
          animationDuration: Duration(milliseconds: (300 * multiplier).round()),
          enableHapticFeedback: false, // No haptic on desktop
          enableRippleEffects: true,
          enableScaleAnimations: true,
          enableParallax: true,
          enableBlurEffects: true,
          enableShadows: true,
          enableGradients: true,
          maxWidgetsPerScreen: 200,
          enableLazyLoading: false, // Less needed on desktop
          enableVirtualization: false,
        );
      case MobileBreakpoint.largeDesktop:
        return MobilePerformanceSettings(
          enableAnimations: true,
          animationDuration: Duration(milliseconds: (350 * multiplier).round()),
          enableHapticFeedback: false,
          enableRippleEffects: true,
          enableScaleAnimations: true,
          enableParallax: true,
          enableBlurEffects: true,
          enableShadows: true,
          enableGradients: true,
          maxWidgetsPerScreen: 300,
          enableLazyLoading: false,
          enableVirtualization: false,
        );
    }
  }
}

/// Mobile breakpoint enum
enum MobileBreakpoint {
  mobile,
  tablet,
  desktop,
  largeDesktop,
}

/// Mobile size enum
enum MobileSize {
  compact,
  regular,
  comfortable,
  spacious,
}

/// Mobile orientation enum
enum MobileOrientation {
  portrait,
  landscape,
}

/// Mobile haptic type enum
enum MobileHapticType {
  light,
  medium,
  heavy,
  selection,
  error,
  success,
}

/// Mobile gesture type enum
enum MobileGestureType {
  tap,
  longPress,
  doubleTap,
  swipe,
  pinch,
}

/// Mobile performance settings
class MobilePerformanceSettings {
  final bool enableAnimations;
  final Duration animationDuration;
  final bool enableHapticFeedback;
  final bool enableRippleEffects;
  final bool enableScaleAnimations;
  final bool enableParallax;
  final bool enableBlurEffects;
  final bool enableShadows;
  final bool enableGradients;
  final int maxWidgetsPerScreen;
  final bool enableLazyLoading;
  final bool enableVirtualization;

  const MobilePerformanceSettings({
    required this.enableAnimations,
    required this.animationDuration,
    required this.enableHapticFeedback,
    required this.enableRippleEffects,
    required this.enableScaleAnimations,
    required this.enableParallax,
    required this.enableBlurEffects,
    required this.enableShadows,
    required this.enableGradients,
    required this.maxWidgetsPerScreen,
    required this.enableLazyLoading,
    required this.enableVirtualization,
  });
}

/// Mobile optimization extensions
extension MobileOptimizationExtensions on Widget {
  /// Apply mobile optimization
  Widget withMobileOptimization({
    MobileBreakpoint? breakpoint,
    MobileSize? size,
    bool enableHapticFeedback = true,
    bool enableRippleEffects = true,
    bool enableScaleAnimations = true,
    String? tooltip,
  }) {
    return Builder(
      builder: (context) {
        final effectiveBreakpoint = breakpoint ?? 
            MobileOptimizationService.getMobileBreakpoint(
              MediaQuery.of(context).size.width,
            );
        
        return _MobileOptimizedWidget(
          breakpoint: effectiveBreakpoint,
          size: size,
          enableHapticFeedback: enableHapticFeedback,
          enableRippleEffects: enableRippleEffects,
          enableScaleAnimations: enableScaleAnimations,
          tooltip: tooltip,
          child: this,
        );
      },
    );
  }
}

/// Mobile optimized widget wrapper
class _MobileOptimizedWidget extends StatefulWidget {
  final Widget child;
  final MobileBreakpoint breakpoint;
  final MobileSize? size;
  final bool enableHapticFeedback;
  final bool enableRippleEffects;
  final bool enableScaleAnimations;
  final String? tooltip;

  const _MobileOptimizedWidget({
    required this.child,
    required this.breakpoint,
    this.size,
    this.enableHapticFeedback = true,
    this.enableRippleEffects = true,
    this.enableScaleAnimations = true,
    this.tooltip,
  });

  @override
  State<_MobileOptimizedWidget> createState() => _MobileOptimizedWidgetState();
}

class _MobileOptimizedWidgetState extends State<_MobileOptimizedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: MobileOptimizationService.getMobileAnimationDuration(
        const Duration(milliseconds: 200),
        widget.breakpoint,
        size: widget.size,
      ),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: MobileOptimizationService.getMobileCurve(widget.breakpoint),
    ));
    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: MobileOptimizationService.getMobileCurve(widget.breakpoint),
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.enableScaleAnimations) {
      _animationController.forward();
    }
    
    if (widget.enableHapticFeedback) {
      MobileOptimizationService.triggerMobileHapticFeedback(
        MobileHapticType.light,
        breakpoint: widget.breakpoint,
      );
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.enableScaleAnimations) {
      _animationController.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.enableScaleAnimations) {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;

    // Add scale animation
    if (widget.enableScaleAnimations) {
      child = AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: child,
            ),
          );
        },
        child: child,
      );
    }

    // Add gesture detection
    child = GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: child,
    );

    // Add ripple effect
    if (widget.enableRippleEffects) {
      child = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {}, // Empty tap handler
          borderRadius: BorderRadius.circular(8),
          child: child,
        ),
      );
    }

    // Add tooltip
    if (widget.tooltip != null) {
      child = Tooltip(
        message: widget.tooltip!,
        child: child,
      );
    }

    return child;
  }
}
