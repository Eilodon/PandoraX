// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accessibility_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccessibilityConfigImpl _$$AccessibilityConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$AccessibilityConfigImpl(
      enableScreenReader: json['enableScreenReader'] as bool? ?? false,
      enableHighContrast: json['enableHighContrast'] as bool? ?? false,
      fontSizeScale: (json['fontSizeScale'] as num?)?.toDouble() ?? 1.0,
      lineHeightScale: (json['lineHeightScale'] as num?)?.toDouble() ?? 1.0,
      enableBoldText: json['enableBoldText'] as bool? ?? false,
      enableReducedMotion: json['enableReducedMotion'] as bool? ?? false,
      enableLargeText: json['enableLargeText'] as bool? ?? false,
      enableVoiceOver: json['enableVoiceOver'] as bool? ?? false,
    );

Map<String, dynamic> _$$AccessibilityConfigImplToJson(
        _$AccessibilityConfigImpl instance) =>
    <String, dynamic>{
      'enableScreenReader': instance.enableScreenReader,
      'enableHighContrast': instance.enableHighContrast,
      'fontSizeScale': instance.fontSizeScale,
      'lineHeightScale': instance.lineHeightScale,
      'enableBoldText': instance.enableBoldText,
      'enableReducedMotion': instance.enableReducedMotion,
      'enableLargeText': instance.enableLargeText,
      'enableVoiceOver': instance.enableVoiceOver,
    };
