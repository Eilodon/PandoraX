import 'package:flutter/material.dart';
import '../tokens/spacing_tokens.dart';

/// Pandora 4 Responsive Service
/// 
/// Comprehensive responsive design system for mobile-first development
class ResponsiveService {
  // Private constructor to prevent instantiation
  ResponsiveService._();

  // Breakpoint definitions
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;
  static const double largeDesktopBreakpoint = 1600;

  /// Get responsive size based on screen width
  static ResponsiveSize getResponsiveSize(double width) {
    if (width < mobileBreakpoint) {
      return ResponsiveSize.mobile;
    } else if (width < tabletBreakpoint) {
      return ResponsiveSize.tablet;
    } else if (width < desktopBreakpoint) {
      return ResponsiveSize.desktop;
    } else {
      return ResponsiveSize.largeDesktop;
    }
  }

  /// Get responsive size from context
  static ResponsiveSize getResponsiveSizeFromContext(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return getResponsiveSize(width);
  }

  /// Get responsive spacing
  static double getResponsiveSpacing(
    double baseSpacing, 
    ResponsiveSize size, {
    double? mobileMultiplier,
    double? tabletMultiplier,
    double? desktopMultiplier,
    double? largeDesktopMultiplier,
  }) {
    switch (size) {
      case ResponsiveSize.mobile:
        return baseSpacing * (mobileMultiplier ?? 0.75);
      case ResponsiveSize.tablet:
        return baseSpacing * (tabletMultiplier ?? 1.0);
      case ResponsiveSize.desktop:
        return baseSpacing * (desktopMultiplier ?? 1.25);
      case ResponsiveSize.largeDesktop:
        return baseSpacing * (largeDesktopMultiplier ?? 1.5);
    }
  }

  /// Get responsive padding
  static EdgeInsets getResponsivePadding(
    EdgeInsets basePadding,
    ResponsiveSize size,
  ) {
    final multiplier = _getPaddingMultiplier(size);
    return EdgeInsets.only(
      left: basePadding.left * multiplier,
      top: basePadding.top * multiplier,
      right: basePadding.right * multiplier,
      bottom: basePadding.bottom * multiplier,
    );
  }

  /// Get responsive margin
  static EdgeInsets getResponsiveMargin(
    EdgeInsets baseMargin,
    ResponsiveSize size,
  ) {
    final multiplier = _getMarginMultiplier(size);
    return EdgeInsets.only(
      left: baseMargin.left * multiplier,
      top: baseMargin.top * multiplier,
      right: baseMargin.right * multiplier,
      bottom: baseMargin.bottom * multiplier,
    );
  }

  /// Get responsive font size
  static double getResponsiveFontSize(
    double baseFontSize,
    ResponsiveSize size,
  ) {
    switch (size) {
      case ResponsiveSize.mobile:
        return baseFontSize * 0.9;
      case ResponsiveSize.tablet:
        return baseFontSize;
      case ResponsiveSize.desktop:
        return baseFontSize * 1.1;
      case ResponsiveSize.largeDesktop:
        return baseFontSize * 1.2;
    }
  }

  /// Get responsive icon size
  static double getResponsiveIconSize(
    double baseIconSize,
    ResponsiveSize size,
  ) {
    switch (size) {
      case ResponsiveSize.mobile:
        return baseIconSize * 0.9;
      case ResponsiveSize.tablet:
        return baseIconSize;
      case ResponsiveSize.desktop:
        return baseIconSize * 1.1;
      case ResponsiveSize.largeDesktop:
        return baseIconSize * 1.2;
    }
  }

  /// Get responsive border radius
  static double getResponsiveBorderRadius(
    double baseRadius,
    ResponsiveSize size,
  ) {
    switch (size) {
      case ResponsiveSize.mobile:
        return baseRadius * 0.8;
      case ResponsiveSize.tablet:
        return baseRadius;
      case ResponsiveSize.desktop:
        return baseRadius * 1.1;
      case ResponsiveSize.largeDesktop:
        return baseRadius * 1.2;
    }
  }

  /// Get responsive elevation
  static double getResponsiveElevation(
    double baseElevation,
    ResponsiveSize size,
  ) {
    switch (size) {
      case ResponsiveSize.mobile:
        return baseElevation * 0.8;
      case ResponsiveSize.tablet:
        return baseElevation;
      case ResponsiveSize.desktop:
        return baseElevation * 1.2;
      case ResponsiveSize.largeDesktop:
        return baseElevation * 1.4;
    }
  }

  /// Get responsive grid columns
  static int getResponsiveGridColumns(ResponsiveSize size) {
    switch (size) {
      case ResponsiveSize.mobile:
        return 1;
      case ResponsiveSize.tablet:
        return 2;
      case ResponsiveSize.desktop:
        return 3;
      case ResponsiveSize.largeDesktop:
        return 4;
    }
  }

  /// Get responsive aspect ratio
  static double getResponsiveAspectRatio(ResponsiveSize size) {
    switch (size) {
      case ResponsiveSize.mobile:
        return 16 / 9;
      case ResponsiveSize.tablet:
        return 4 / 3;
      case ResponsiveSize.desktop:
        return 16 / 10;
      case ResponsiveSize.largeDesktop:
        return 21 / 9;
    }
  }

  /// Get responsive container width
  static double getResponsiveContainerWidth(
    double screenWidth,
    ResponsiveSize size,
  ) {
    switch (size) {
      case ResponsiveSize.mobile:
        return screenWidth - 32; // 16px margin on each side
      case ResponsiveSize.tablet:
        return screenWidth * 0.9;
      case ResponsiveSize.desktop:
        return screenWidth * 0.8;
      case ResponsiveSize.largeDesktop:
        return screenWidth * 0.7;
    }
  }

  /// Get responsive max width
  static double getResponsiveMaxWidth(ResponsiveSize size) {
    switch (size) {
      case ResponsiveSize.mobile:
        return 600;
      case ResponsiveSize.tablet:
        return 800;
      case ResponsiveSize.desktop:
        return 1200;
      case ResponsiveSize.largeDesktop:
        return 1600;
    }
  }

  /// Check if current size is mobile
  static bool isMobile(ResponsiveSize size) {
    return size == ResponsiveSize.mobile;
  }

  /// Check if current size is tablet
  static bool isTablet(ResponsiveSize size) {
    return size == ResponsiveSize.tablet;
  }

  /// Check if current size is desktop
  static bool isDesktop(ResponsiveSize size) {
    return size == ResponsiveSize.desktop || size == ResponsiveSize.largeDesktop;
  }

  /// Get responsive orientation
  static ResponsiveOrientation getResponsiveOrientation(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait 
        ? ResponsiveOrientation.portrait 
        : ResponsiveOrientation.landscape;
  }

  /// Get responsive safe area padding
  static EdgeInsets getResponsiveSafeAreaPadding(
    BuildContext context,
    ResponsiveSize size,
  ) {
    final mediaQuery = MediaQuery.of(context);
    final padding = mediaQuery.padding;
    
    switch (size) {
      case ResponsiveSize.mobile:
        return EdgeInsets.only(
          top: padding.top,
          bottom: padding.bottom,
          left: 16,
          right: 16,
        );
      case ResponsiveSize.tablet:
        return EdgeInsets.only(
          top: padding.top,
          bottom: padding.bottom,
          left: 24,
          right: 24,
        );
      case ResponsiveSize.desktop:
        return EdgeInsets.only(
          top: padding.top,
          bottom: padding.bottom,
          left: 32,
          right: 32,
        );
      case ResponsiveSize.largeDesktop:
        return EdgeInsets.only(
          top: padding.top,
          bottom: padding.bottom,
          left: 48,
          right: 48,
        );
    }
  }

  /// Get responsive touch target size
  static double getResponsiveTouchTargetSize(ResponsiveSize size) {
    switch (size) {
      case ResponsiveSize.mobile:
        return 48; // iOS guideline
      case ResponsiveSize.tablet:
        return 44; // Material guideline
      case ResponsiveSize.desktop:
        return 40; // Desktop can be smaller
      case ResponsiveSize.largeDesktop:
        return 40;
    }
  }

  /// Get responsive animation duration
  static Duration getResponsiveAnimationDuration(
    Duration baseDuration,
    ResponsiveSize size,
  ) {
    switch (size) {
      case ResponsiveSize.mobile:
        return Duration(milliseconds: (baseDuration.inMilliseconds * 0.8).round());
      case ResponsiveSize.tablet:
        return baseDuration;
      case ResponsiveSize.desktop:
        return Duration(milliseconds: (baseDuration.inMilliseconds * 1.2).round());
      case ResponsiveSize.largeDesktop:
        return Duration(milliseconds: (baseDuration.inMilliseconds * 1.4).round());
    }
  }

  /// Get responsive curve
  static Curve getResponsiveCurve(ResponsiveSize size) {
    switch (size) {
      case ResponsiveSize.mobile:
        return Curves.easeOutCubic; // Snappier for mobile
      case ResponsiveSize.tablet:
        return Curves.easeInOut;
      case ResponsiveSize.desktop:
        return Curves.easeInOutCubic; // Smoother for desktop
      case ResponsiveSize.largeDesktop:
        return Curves.easeInOutCubic;
    }
  }

  /// Helper methods
  static double _getPaddingMultiplier(ResponsiveSize size) {
    switch (size) {
      case ResponsiveSize.mobile:
        return 0.8;
      case ResponsiveSize.tablet:
        return 1.0;
      case ResponsiveSize.desktop:
        return 1.2;
      case ResponsiveSize.largeDesktop:
        return 1.4;
    }
  }

  static double _getMarginMultiplier(ResponsiveSize size) {
    switch (size) {
      case ResponsiveSize.mobile:
        return 0.75;
      case ResponsiveSize.tablet:
        return 1.0;
      case ResponsiveSize.desktop:
        return 1.25;
      case ResponsiveSize.largeDesktop:
        return 1.5;
    }
  }
}

/// Responsive size enum
enum ResponsiveSize {
  mobile,
  tablet,
  desktop,
  largeDesktop,
}

/// Responsive orientation enum
enum ResponsiveOrientation {
  portrait,
  landscape,
}

/// Responsive breakpoint extensions
extension ResponsiveSizeExtensions on ResponsiveSize {
  /// Get breakpoint value
  double get breakpoint {
    switch (this) {
      case ResponsiveSize.mobile:
        return ResponsiveService.mobileBreakpoint;
      case ResponsiveSize.tablet:
        return ResponsiveService.tabletBreakpoint;
      case ResponsiveSize.desktop:
        return ResponsiveService.desktopBreakpoint;
      case ResponsiveSize.largeDesktop:
        return ResponsiveService.largeDesktopBreakpoint;
    }
  }

  /// Get display name
  String get displayName {
    switch (this) {
      case ResponsiveSize.mobile:
        return 'Mobile';
      case ResponsiveSize.tablet:
        return 'Tablet';
      case ResponsiveSize.desktop:
        return 'Desktop';
      case ResponsiveSize.largeDesktop:
        return 'Large Desktop';
    }
  }

  /// Get icon for size
  IconData get icon {
    switch (this) {
      case ResponsiveSize.mobile:
        return Icons.phone_android;
      case ResponsiveSize.tablet:
        return Icons.tablet;
      case ResponsiveSize.desktop:
        return Icons.desktop_windows;
      case ResponsiveSize.largeDesktop:
        return Icons.desktop_mac;
    }
  }
}

/// Responsive widget extensions
extension ResponsiveWidgetExtensions on Widget {
  /// Wrap widget with responsive behavior
  Widget responsive({
    Widget? mobile,
    Widget? tablet,
    Widget? desktop,
    Widget? largeDesktop,
  }) {
    return ResponsiveBuilder(
      mobile: mobile ?? this,
      tablet: tablet ?? this,
      desktop: desktop ?? this,
      largeDesktop: largeDesktop ?? this,
    );
  }

  /// Apply responsive padding
  Widget withResponsivePadding(
    EdgeInsets basePadding, {
    ResponsiveSize? size,
  }) {
    return Builder(
      builder: (context) {
        final responsiveSize = size ?? ResponsiveService.getResponsiveSizeFromContext(context);
        final padding = ResponsiveService.getResponsivePadding(basePadding, responsiveSize);
        return Padding(
          padding: padding,
          child: this,
        );
      },
    );
  }

  /// Apply responsive margin
  Widget withResponsiveMargin(
    EdgeInsets baseMargin, {
    ResponsiveSize? size,
  }) {
    return Builder(
      builder: (context) {
        final responsiveSize = size ?? ResponsiveService.getResponsiveSizeFromContext(context);
        final margin = ResponsiveService.getResponsiveMargin(baseMargin, responsiveSize);
        return Container(
          margin: margin,
          child: this,
        );
      },
    );
  }
}

/// Responsive builder widget
class ResponsiveBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  final Widget largeDesktop;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
    required this.largeDesktop,
  });

  @override
  Widget build(BuildContext context) {
    final size = ResponsiveService.getResponsiveSizeFromContext(context);
    
    switch (size) {
      case ResponsiveSize.mobile:
        return mobile;
      case ResponsiveSize.tablet:
        return tablet;
      case ResponsiveSize.desktop:
        return desktop;
      case ResponsiveSize.largeDesktop:
        return largeDesktop;
    }
  }
}
