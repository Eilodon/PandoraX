import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'theme_config.freezed.dart';
part 'theme_config.g.dart';

/// Theme configuration for the application
@freezed
class ThemeConfig with _$ThemeConfig {
  const factory ThemeConfig({
    required PandoraTheme pandoraTheme,
    @JsonKey(fromJson: _themeModeFromJson, toJson: _themeModeToJson) required ThemeMode themeMode,
    required AccessibilityLevel accessibilityLevel,
    required ContrastLevel contrastLevel,
    required SizeClass sizeClass,
    @Default(true) bool enableAnimations,
    @Default(true) bool enableHapticFeedback,
    @Default(true) bool enableSoundEffects,
    @Default(1.0) double animationSpeed,
    @Default(1.0) double textScaleFactor,
    @Default(1.0) double iconScaleFactor,
    @Default(16.0) double baseFontSize,
    @Default(1.5) double lineHeight,
    @Default(8.0) double spacingUnit,
    @Default(4.0) double borderRadius,
    @Default(2.0) double borderWidth,
    @Default(8.0) double elevation,
    @Default(0.1) double opacity,
  }) = _ThemeConfig;

  factory ThemeConfig.fromJson(Map<String, dynamic> json) =>
      _$ThemeConfigFromJson(json);
}

/// Pandora theme variants
@freezed
class PandoraTheme with _$PandoraTheme {
  const factory PandoraTheme.classic() = ClassicTheme;
  const factory PandoraTheme.modern() = ModernTheme;
  const factory PandoraTheme.minimal() = MinimalTheme;
  const factory PandoraTheme.dark() = DarkTheme;
  const factory PandoraTheme.light() = LightTheme;
  const factory PandoraTheme.auto() = AutoTheme;

  factory PandoraTheme.fromJson(Map<String, dynamic> json) =>
      _$PandoraThemeFromJson(json);
}

/// Accessibility levels
@freezed
class AccessibilityLevel with _$AccessibilityLevel {
  const factory AccessibilityLevel.none() = NoneAccessibility;
  const factory AccessibilityLevel.basic() = BasicAccessibility;
  const factory AccessibilityLevel.enhanced() = EnhancedAccessibility;
  const factory AccessibilityLevel.maximum() = MaximumAccessibility;

  factory AccessibilityLevel.fromJson(Map<String, dynamic> json) =>
      _$AccessibilityLevelFromJson(json);
}

/// Contrast levels
@freezed
class ContrastLevel with _$ContrastLevel {
  const factory ContrastLevel.normal() = NormalContrast;
  const factory ContrastLevel.high() = HighContrast;
  const factory ContrastLevel.maximum() = MaximumContrast;

  factory ContrastLevel.fromJson(Map<String, dynamic> json) =>
      _$ContrastLevelFromJson(json);
}

/// Size classes for responsive design
@freezed
class SizeClass with _$SizeClass {
  const factory SizeClass.compact() = CompactSize;
  const factory SizeClass.regular() = RegularSize;
  const factory SizeClass.large() = LargeSize;
  const factory SizeClass.extraLarge() = ExtraLargeSize;

  factory SizeClass.fromJson(Map<String, dynamic> json) =>
      _$SizeClassFromJson(json);
}

// Helper functions for ThemeMode serialization
ThemeMode _themeModeFromJson(String value) {
  switch (value) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    case 'system':
      return ThemeMode.system;
    default:
      return ThemeMode.system;
  }
}

String _themeModeToJson(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.light:
      return 'light';
    case ThemeMode.dark:
      return 'dark';
    case ThemeMode.system:
      return 'system';
  }
}