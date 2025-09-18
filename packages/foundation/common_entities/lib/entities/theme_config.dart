import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_config.freezed.dart';
part 'theme_config.g.dart';

/// Theme modes
enum ThemeMode {
  light,
  dark,
  system,
}

/// Accessibility levels
enum AccessibilityLevel {
  normal,
  high,
  extraHigh,
}

/// Contrast levels
enum ContrastLevel {
  normal,
  high,
  extraHigh,
}

/// Size classes
enum SizeClass {
  compact,
  regular,
  large,
}

/// Theme configuration entity
@freezed
class ThemeConfig with _$ThemeConfig {
  const factory ThemeConfig({
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(AccessibilityLevel.normal) AccessibilityLevel accessibilityLevel,
    @Default(ContrastLevel.normal) ContrastLevel contrastLevel,
    @Default(SizeClass.regular) SizeClass sizeClass,
    @Default(true) bool enableAnimations,
    @Default(true) bool enableHapticFeedback,
    @Default(true) bool enableSoundEffects,
    @Default('pandora') String pandoraTheme,
  }) = _ThemeConfig;

  factory ThemeConfig.fromJson(Map<String, dynamic> json) =>
      _$ThemeConfigFromJson(json);
}
