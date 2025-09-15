import 'package:flutter/material.dart';
import '../tokens/color_tokens.dart';

/// Pandora 4 Accessibility Colors
/// 
/// Provides color contrast validation and accessibility-compliant colors
/// following WCAG 2.1 AA standards
class AccessibilityColors {
  // Private constructor to prevent instantiation
  AccessibilityColors._();

  // WCAG 2.1 AA contrast ratios
  static const double normalTextContrast = 4.5;
  static const double largeTextContrast = 3.0;
  static const double uiComponentContrast = 3.0;

  /// Calculate relative luminance of a color
  static double getRelativeLuminance(Color color) {
    final r = _getLinearValue(color.red / 255.0);
    final g = _getLinearValue(color.green / 255.0);
    final b = _getLinearValue(color.blue / 255.0);
    
    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  /// Get linear value for luminance calculation
  static double _getLinearValue(double value) {
    return value <= 0.03928 
        ? value / 12.92 
        : ((value + 0.055) / 1.055).pow(2.4);
  }

  /// Calculate contrast ratio between two colors
  static double calculateContrast(Color foreground, Color background) {
    final lum1 = getRelativeLuminance(foreground);
    final lum2 = getRelativeLuminance(background);
    
    final lighter = lum1 > lum2 ? lum1 : lum2;
    final darker = lum1 > lum2 ? lum2 : lum1;
    
    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Check if color combination meets WCAG AA standards
  static bool isAccessibleContrast(
    Color foreground, 
    Color background, {
    bool isLargeText = false,
    bool isUIComponent = false,
  }) {
    final contrast = calculateContrast(foreground, background);
    final requiredContrast = isUIComponent 
        ? uiComponentContrast
        : isLargeText 
            ? largeTextContrast 
            : normalTextContrast;
    
    return contrast >= requiredContrast;
  }

  /// Get accessibility level for color combination
  static AccessibilityLevel getAccessibilityLevel(
    Color foreground, 
    Color background, {
    bool isLargeText = false,
    bool isUIComponent = false,
  }) {
    final contrast = calculateContrast(foreground, background);
    final requiredContrast = isUIComponent 
        ? uiComponentContrast
        : isLargeText 
            ? largeTextContrast 
            : normalTextContrast;
    
    if (contrast >= requiredContrast) {
      return AccessibilityLevel.aa;
    } else if (contrast >= requiredContrast * 0.8) {
      return AccessibilityLevel.aaLarge;
    } else {
      return AccessibilityLevel.fail;
    }
  }

  /// Get accessible color for given background
  static Color getAccessibleColor(
    Color desiredColor, 
    Color background, {
    bool isLargeText = false,
    bool isUIComponent = false,
    Color? fallbackColor,
  }) {
    if (isAccessibleContrast(
      desiredColor, 
      background,
      isLargeText: isLargeText,
      isUIComponent: isUIComponent,
    )) {
      return desiredColor;
    }

    // Try to find a darker/lighter version that works
    final hsl = HSLColor.fromColor(desiredColor);
    final backgroundLuminance = getRelativeLuminance(background);
    
    // If background is dark, we need lighter text
    if (backgroundLuminance < 0.5) {
      return _findAccessibleLightColor(desiredColor, background, isLargeText, isUIComponent);
    } else {
      return _findAccessibleDarkColor(desiredColor, background, isLargeText, isUIComponent);
    }
  }

  /// Find accessible light color
  static Color _findAccessibleLightColor(
    Color baseColor, 
    Color background, 
    bool isLargeText, 
    bool isUIComponent,
  ) {
    final hsl = HSLColor.fromColor(baseColor);
    final requiredContrast = isUIComponent 
        ? uiComponentContrast
        : isLargeText 
            ? largeTextContrast 
            : normalTextContrast;

    // Try increasing lightness
    for (double lightness = hsl.lightness; lightness <= 1.0; lightness += 0.1) {
      final testColor = hsl.withLightness(lightness).toColor();
      if (calculateContrast(testColor, background) >= requiredContrast) {
        return testColor;
      }
    }

    // Fallback to white
    return Colors.white;
  }

  /// Find accessible dark color
  static Color _findAccessibleDarkColor(
    Color baseColor, 
    Color background, 
    bool isLargeText, 
    bool isUIComponent,
  ) {
    final hsl = HSLColor.fromColor(baseColor);
    final requiredContrast = isUIComponent 
        ? uiComponentContrast
        : isLargeText 
            ? largeTextContrast 
            : normalTextContrast;

    // Try decreasing lightness
    for (double lightness = hsl.lightness; lightness >= 0.0; lightness -= 0.1) {
      final testColor = hsl.withLightness(lightness).toColor();
      if (calculateContrast(testColor, background) >= requiredContrast) {
        return testColor;
      }
    }

    // Fallback to black
    return Colors.black;
  }

  /// Get accessible color palette for theme
  static AccessibleColorPalette getAccessiblePalette(Color primaryColor) {
    return AccessibleColorPalette(
      primary: primaryColor,
      onPrimary: getAccessibleColor(
        Colors.white, 
        primaryColor,
        isUIComponent: true,
      ),
      secondary: _getAccessibleSecondary(primaryColor),
      onSecondary: getAccessibleColor(
        Colors.white, 
        _getAccessibleSecondary(primaryColor),
        isUIComponent: true,
      ),
      surface: _getAccessibleSurface(primaryColor),
      onSurface: getAccessibleColor(
        Colors.black, 
        _getAccessibleSurface(primaryColor),
      ),
      error: Colors.red.shade700,
      onError: Colors.white,
      background: _getAccessibleBackground(primaryColor),
      onBackground: getAccessibleColor(
        Colors.black, 
        _getAccessibleBackground(primaryColor),
      ),
    );
  }

  /// Get accessible secondary color
  static Color _getAccessibleSecondary(Color primary) {
    final hsl = HSLColor.fromColor(primary);
    return hsl.withHue((hsl.hue + 120) % 360).toColor();
  }

  /// Get accessible surface color
  static Color _getAccessibleSurface(Color primary) {
    final hsl = HSLColor.fromColor(primary);
    return hsl.withLightness(0.95).withSaturation(0.1).toColor();
  }

  /// Get accessible background color
  static Color _getAccessibleBackground(Color primary) {
    final hsl = HSLColor.fromColor(primary);
    return hsl.withLightness(0.98).withSaturation(0.05).toColor();
  }

  /// Validate color palette accessibility
  static Map<String, bool> validatePalette(AccessibleColorPalette palette) {
    return {
      'primaryOnPrimary': isAccessibleContrast(palette.primary, palette.onPrimary, isUIComponent: true),
      'secondaryOnSecondary': isAccessibleContrast(palette.secondary, palette.onSecondary, isUIComponent: true),
      'surfaceOnSurface': isAccessibleContrast(palette.surface, palette.onSurface),
      'errorOnError': isAccessibleContrast(palette.error, palette.onError, isUIComponent: true),
      'backgroundOnBackground': isAccessibleContrast(palette.background, palette.onBackground),
    };
  }

  /// Get high contrast colors
  static HighContrastColors getHighContrastColors() {
    return HighContrastColors(
      foreground: Colors.black,
      background: Colors.white,
      accent: Colors.blue.shade800,
      error: Colors.red.shade800,
      success: Colors.green.shade800,
      warning: Colors.orange.shade800,
    );
  }

  /// Check if high contrast mode should be used
  static bool shouldUseHighContrast(BuildContext context) {
    return MediaQuery.of(context).highContrast;
  }

  /// Get appropriate colors based on accessibility settings
  static Color getAdaptiveColor(
    BuildContext context, 
    Color normalColor, 
    Color highContrastColor,
  ) {
    return shouldUseHighContrast(context) ? highContrastColor : normalColor;
  }
}

/// Accessibility levels
enum AccessibilityLevel {
  fail,
  aaLarge,
  aa,
  aaa,
}

/// Accessible color palette
class AccessibleColorPalette {
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color surface;
  final Color onSurface;
  final Color error;
  final Color onError;
  final Color background;
  final Color onBackground;

  const AccessibleColorPalette({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.surface,
    required this.onSurface,
    required this.error,
    required this.onError,
    required this.background,
    required this.onBackground,
  });
}

/// High contrast colors
class HighContrastColors {
  final Color foreground;
  final Color background;
  final Color accent;
  final Color error;
  final Color success;
  final Color warning;

  const HighContrastColors({
    required this.foreground,
    required this.background,
    required this.accent,
    required this.error,
    required this.success,
    required this.warning,
  });
}

/// Accessibility color extensions
extension AccessibilityColorExtensions on Color {
  /// Check if this color is accessible on given background
  bool isAccessibleOn(Color background, {bool isLargeText = false, bool isUIComponent = false}) {
    return AccessibilityColors.isAccessibleContrast(
      this, 
      background,
      isLargeText: isLargeText,
      isUIComponent: isUIComponent,
    );
  }

  /// Get accessible version of this color on given background
  Color getAccessibleOn(Color background, {bool isLargeText = false, bool isUIComponent = false}) {
    return AccessibilityColors.getAccessibleColor(
      this, 
      background,
      isLargeText: isLargeText,
      isUIComponent: isUIComponent,
    );
  }

  /// Get contrast ratio with another color
  double contrastWith(Color other) {
    return AccessibilityColors.calculateContrast(this, other);
  }
}
