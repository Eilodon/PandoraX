import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_config.freezed.dart';
part 'theme_config.g.dart';

/// Theme configuration for UI/UX
@freezed
class ThemeConfig with _$ThemeConfig {
  const factory ThemeConfig({
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(PandoraTheme.light) PandoraTheme pandoraTheme,
    @Default(12.0) double fontSize,
    @Default(1.0) double fontScale,
    @Default(16.0) double lineHeight,
    @Default(8.0) double borderRadius,
    @Default(16.0) double padding,
    @Default(8.0) double margin,
    @Default(4.0) double spacing,
    @Default(2.0) double elevation,
    @Default(0.3) double opacity,
    @Default(200.0) double animationDuration,
    @Default(Curves.easeInOut) Curve animationCurve,
    @Default(true) bool enableAnimations,
    @Default(true) bool enableHapticFeedback,
    @Default(true) bool enableSoundEffects,
    @Default(true) bool enableAccessibility,
    @Default(AccessibilityLevel.standard) AccessibilityLevel accessibilityLevel,
    @Default(ColorSchemeType.material3) ColorSchemeType colorSchemeType,
    @Default(ContrastLevel.standard) ContrastLevel contrastLevel,
    @Default(SizeClass.medium) SizeClass sizeClass,
    @Default(OrientationMode.auto) OrientationMode orientationMode,
    Map<String, dynamic>? customSettings,
  }) = _ThemeConfig;

  const ThemeConfig._();

  factory ThemeConfig.fromJson(Map<String, dynamic> json) =>
      _$ThemeConfigFromJson(json);

  /// Get default theme configuration
  static ThemeConfig get defaultConfig => const ThemeConfig();

  /// Get light theme configuration
  static ThemeConfig get lightConfig => const ThemeConfig(
    themeMode: ThemeMode.light,
    pandoraTheme: PandoraTheme.light,
    fontSize: 14.0,
    fontScale: 1.0,
    lineHeight: 1.5,
    borderRadius: 12.0,
    padding: 16.0,
    margin: 12.0,
    spacing: 8.0,
    elevation: 2.0,
    opacity: 0.3,
    animationDuration: 300.0,
    animationCurve: Curves.easeInOut,
    enableAnimations: true,
    enableHapticFeedback: true,
    enableSoundEffects: true,
    enableAccessibility: true,
    accessibilityLevel: AccessibilityLevel.standard,
    colorSchemeType: ColorSchemeType.material3,
    contrastLevel: ContrastLevel.standard,
    sizeClass: SizeClass.medium,
    orientationMode: OrientationMode.auto,
  );

  /// Get dark theme configuration
  static ThemeConfig get darkConfig => const ThemeConfig(
    themeMode: ThemeMode.dark,
    pandoraTheme: PandoraTheme.dark,
    fontSize: 14.0,
    fontScale: 1.0,
    lineHeight: 1.5,
    borderRadius: 12.0,
    padding: 16.0,
    margin: 12.0,
    spacing: 8.0,
    elevation: 4.0,
    opacity: 0.5,
    animationDuration: 300.0,
    animationCurve: Curves.easeInOut,
    enableAnimations: true,
    enableHapticFeedback: true,
    enableSoundEffects: true,
    enableAccessibility: true,
    accessibilityLevel: AccessibilityLevel.standard,
    colorSchemeType: ColorSchemeType.material3,
    contrastLevel: ContrastLevel.standard,
    sizeClass: SizeClass.medium,
    orientationMode: OrientationMode.auto,
  );

  /// Get high contrast theme configuration
  static ThemeConfig get highContrastConfig => const ThemeConfig(
    themeMode: ThemeMode.light,
    pandoraTheme: PandoraTheme.highContrast,
    fontSize: 16.0,
    fontScale: 1.2,
    lineHeight: 1.6,
    borderRadius: 8.0,
    padding: 20.0,
    margin: 16.0,
    spacing: 12.0,
    elevation: 6.0,
    opacity: 0.8,
    animationDuration: 200.0,
    animationCurve: Curves.easeInOut,
    enableAnimations: false,
    enableHapticFeedback: true,
    enableSoundEffects: true,
    enableAccessibility: true,
    accessibilityLevel: AccessibilityLevel.high,
    colorSchemeType: ColorSchemeType.highContrast,
    contrastLevel: ContrastLevel.high,
    sizeClass: SizeClass.large,
    orientationMode: OrientationMode.portrait,
  );

  /// Get compact theme configuration
  static ThemeConfig get compactConfig => const ThemeConfig(
    themeMode: ThemeMode.light,
    pandoraTheme: PandoraTheme.compact,
    fontSize: 12.0,
    fontScale: 0.9,
    lineHeight: 1.3,
    borderRadius: 6.0,
    padding: 12.0,
    margin: 8.0,
    spacing: 6.0,
    elevation: 1.0,
    opacity: 0.2,
    animationDuration: 150.0,
    animationCurve: Curves.easeInOut,
    enableAnimations: true,
    enableHapticFeedback: true,
    enableSoundEffects: false,
    enableAccessibility: true,
    accessibilityLevel: AccessibilityLevel.standard,
    colorSchemeType: ColorSchemeType.material3,
    contrastLevel: ContrastLevel.standard,
    sizeClass: SizeClass.small,
    orientationMode: OrientationMode.auto,
  );

  /// Get accessibility theme configuration
  static ThemeConfig get accessibilityConfig => const ThemeConfig(
    themeMode: ThemeMode.light,
    pandoraTheme: PandoraTheme.accessibility,
    fontSize: 18.0,
    fontScale: 1.5,
    lineHeight: 1.8,
    borderRadius: 16.0,
    padding: 24.0,
    margin: 20.0,
    spacing: 16.0,
    elevation: 8.0,
    opacity: 0.9,
    animationDuration: 400.0,
    animationCurve: Curves.easeInOut,
    enableAnimations: false,
    enableHapticFeedback: true,
    enableSoundEffects: true,
    enableAccessibility: true,
    accessibilityLevel: AccessibilityLevel.maximum,
    colorSchemeType: ColorSchemeType.highContrast,
    contrastLevel: ContrastLevel.maximum,
    sizeClass: SizeClass.extraLarge,
    orientationMode: OrientationMode.portrait,
  );

  /// Check if theme is dark
  bool get isDark => pandoraTheme == PandoraTheme.dark;

  /// Check if theme is light
  bool get isLight => pandoraTheme == PandoraTheme.light;

  /// Check if theme is high contrast
  bool get isHighContrast => contrastLevel == ContrastLevel.high || contrastLevel == ContrastLevel.maximum;

  /// Check if theme is compact
  bool get isCompact => sizeClass == SizeClass.small;

  /// Check if theme is large
  bool get isLarge => sizeClass == SizeClass.large || sizeClass == SizeClass.extraLarge;

  /// Get effective font size
  double get effectiveFontSize => fontSize * fontScale;

  /// Get effective line height
  double get effectiveLineHeight => effectiveFontSize * lineHeight;

  /// Get animation duration in milliseconds
  int get animationDurationMs => animationDuration.round();

  /// Get theme description
  String get description {
    final themeName = pandoraTheme.displayName;
    final modeName = themeMode.name;
    final sizeName = sizeClass.displayName;
    final contrastName = contrastLevel.displayName;
    
    return '$themeName ($modeName) - $sizeName, $contrastName contrast';
  }
}

/// Pandora theme types
enum PandoraTheme {
  light,
  dark,
  highContrast,
  compact,
  accessibility,
  custom,
}

/// Color scheme types
enum ColorSchemeType {
  material3,
  material2,
  cupertino,
  highContrast,
  custom,
}

/// Contrast levels
enum ContrastLevel {
  low,
  standard,
  high,
  maximum,
}

/// Accessibility levels
enum AccessibilityLevel {
  minimal,
  standard,
  high,
  maximum,
}

/// Size classes
enum SizeClass {
  small,
  medium,
  large,
  extraLarge,
}

/// Orientation modes
enum OrientationMode {
  auto,
  portrait,
  landscape,
}

/// Extension for PandoraTheme
extension PandoraThemeExtension on PandoraTheme {
  String get displayName {
    switch (this) {
      case PandoraTheme.light:
        return 'Light';
      case PandoraTheme.dark:
        return 'Dark';
      case PandoraTheme.highContrast:
        return 'High Contrast';
      case PandoraTheme.compact:
        return 'Compact';
      case PandoraTheme.accessibility:
        return 'Accessibility';
      case PandoraTheme.custom:
        return 'Custom';
    }
  }

  String get icon {
    switch (this) {
      case PandoraTheme.light:
        return '☀️';
      case PandoraTheme.dark:
        return '🌙';
      case PandoraTheme.highContrast:
        return '🔆';
      case PandoraTheme.compact:
        return '📱';
      case PandoraTheme.accessibility:
        return '♿';
      case PandoraTheme.custom:
        return '🎨';
    }
  }

  String get description {
    switch (this) {
      case PandoraTheme.light:
        return 'Clean and bright interface';
      case PandoraTheme.dark:
        return 'Easy on the eyes in low light';
      case PandoraTheme.highContrast:
        return 'High contrast for better visibility';
      case PandoraTheme.compact:
        return 'Compact layout for small screens';
      case PandoraTheme.accessibility:
        return 'Optimized for accessibility';
      case PandoraTheme.custom:
        return 'Customized theme settings';
    }
  }
}

/// Extension for ContrastLevel
extension ContrastLevelExtension on ContrastLevel {
  String get displayName {
    switch (this) {
      case ContrastLevel.low:
        return 'Low';
      case ContrastLevel.standard:
        return 'Standard';
      case ContrastLevel.high:
        return 'High';
      case ContrastLevel.maximum:
        return 'Maximum';
    }
  }

  String get icon {
    switch (this) {
      case ContrastLevel.low:
        return '🔅';
      case ContrastLevel.standard:
        return '🔆';
      case ContrastLevel.high:
        return '🔆';
      case ContrastLevel.maximum:
        return '🔆';
    }
  }

  double get ratio {
    switch (this) {
      case ContrastLevel.low:
        return 3.0;
      case ContrastLevel.standard:
        return 4.5;
      case ContrastLevel.high:
        return 7.0;
      case ContrastLevel.maximum:
        return 10.0;
    }
  }
}

/// Extension for AccessibilityLevel
extension AccessibilityLevelExtension on AccessibilityLevel {
  String get displayName {
    switch (this) {
      case AccessibilityLevel.minimal:
        return 'Minimal';
      case AccessibilityLevel.standard:
        return 'Standard';
      case AccessibilityLevel.high:
        return 'High';
      case AccessibilityLevel.maximum:
        return 'Maximum';
    }
  }

  String get icon {
    switch (this) {
      case AccessibilityLevel.minimal:
        return '♿';
      case AccessibilityLevel.standard:
        return '♿';
      case AccessibilityLevel.high:
        return '♿';
      case AccessibilityLevel.maximum:
        return '♿';
    }
  }

  String get description {
    switch (this) {
      case AccessibilityLevel.minimal:
        return 'Basic accessibility features';
      case AccessibilityLevel.standard:
        return 'Standard accessibility features';
      case AccessibilityLevel.high:
        return 'Enhanced accessibility features';
      case AccessibilityLevel.maximum:
        return 'Maximum accessibility features';
    }
  }
}

/// Extension for SizeClass
extension SizeClassExtension on SizeClass {
  String get displayName {
    switch (this) {
      case SizeClass.small:
        return 'Small';
      case SizeClass.medium:
        return 'Medium';
      case SizeClass.large:
        return 'Large';
      case SizeClass.extraLarge:
        return 'Extra Large';
    }
  }

  String get icon {
    switch (this) {
      case SizeClass.small:
        return '📱';
      case SizeClass.medium:
        return '💻';
      case SizeClass.large:
        return '🖥️';
      case SizeClass.extraLarge:
        return '📺';
    }
  }

  String get description {
    switch (this) {
      case SizeClass.small:
        return 'Optimized for mobile devices';
      case SizeClass.medium:
        return 'Optimized for tablets';
      case SizeClass.large:
        return 'Optimized for desktop';
      case SizeClass.extraLarge:
        return 'Optimized for large screens';
    }
  }
}

/// Extension for OrientationMode
extension OrientationModeExtension on OrientationMode {
  String get displayName {
    switch (this) {
      case OrientationMode.auto:
        return 'Auto';
      case OrientationMode.portrait:
        return 'Portrait';
      case OrientationMode.landscape:
        return 'Landscape';
    }
  }

  String get icon {
    switch (this) {
      case OrientationMode.auto:
        return '🔄';
      case OrientationMode.portrait:
        return '📱';
      case OrientationMode.landscape:
        return '📱';
    }
  }

  String get description {
    switch (this) {
      case OrientationMode.auto:
        return 'Automatically adjust to device orientation';
      case OrientationMode.portrait:
        return 'Force portrait orientation';
      case OrientationMode.landscape:
        return 'Force landscape orientation';
    }
  }
}
