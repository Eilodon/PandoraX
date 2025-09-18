import 'package:freezed_annotation/freezed_annotation.dart';

part 'accessibility_config.freezed.dart';
part 'accessibility_config.g.dart';

/// Accessibility configuration entity
@freezed
class AccessibilityConfig with _$AccessibilityConfig {
  const factory AccessibilityConfig({
    @Default(false) bool enableScreenReader,
    @Default(false) bool enableHighContrast,
    @Default(1.0) double fontSizeScale,
    @Default(1.0) double lineHeightScale,
    @Default(false) bool enableBoldText,
    @Default(false) bool enableReducedMotion,
    @Default(false) bool enableLargeText,
    @Default(false) bool enableVoiceOver,
  }) = _AccessibilityConfig;

  factory AccessibilityConfig.fromJson(Map<String, dynamic> json) =>
      _$AccessibilityConfigFromJson(json);
}
