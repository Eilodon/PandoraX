// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ThemeConfigImpl _$$ThemeConfigImplFromJson(Map<String, dynamic> json) =>
    _$ThemeConfigImpl(
      themeMode: $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.system,
      accessibilityLevel: $enumDecodeNullable(
              _$AccessibilityLevelEnumMap, json['accessibilityLevel']) ??
          AccessibilityLevel.normal,
      contrastLevel:
          $enumDecodeNullable(_$ContrastLevelEnumMap, json['contrastLevel']) ??
              ContrastLevel.normal,
      sizeClass: $enumDecodeNullable(_$SizeClassEnumMap, json['sizeClass']) ??
          SizeClass.regular,
      enableAnimations: json['enableAnimations'] as bool? ?? true,
      enableHapticFeedback: json['enableHapticFeedback'] as bool? ?? true,
      enableSoundEffects: json['enableSoundEffects'] as bool? ?? true,
      pandoraTheme: json['pandoraTheme'] as String? ?? 'pandora',
    );

Map<String, dynamic> _$$ThemeConfigImplToJson(_$ThemeConfigImpl instance) =>
    <String, dynamic>{
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'accessibilityLevel':
          _$AccessibilityLevelEnumMap[instance.accessibilityLevel]!,
      'contrastLevel': _$ContrastLevelEnumMap[instance.contrastLevel]!,
      'sizeClass': _$SizeClassEnumMap[instance.sizeClass]!,
      'enableAnimations': instance.enableAnimations,
      'enableHapticFeedback': instance.enableHapticFeedback,
      'enableSoundEffects': instance.enableSoundEffects,
      'pandoraTheme': instance.pandoraTheme,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
  ThemeMode.system: 'system',
};

const _$AccessibilityLevelEnumMap = {
  AccessibilityLevel.normal: 'normal',
  AccessibilityLevel.high: 'high',
  AccessibilityLevel.extraHigh: 'extraHigh',
};

const _$ContrastLevelEnumMap = {
  ContrastLevel.normal: 'normal',
  ContrastLevel.high: 'high',
  ContrastLevel.extraHigh: 'extraHigh',
};

const _$SizeClassEnumMap = {
  SizeClass.compact: 'compact',
  SizeClass.regular: 'regular',
  SizeClass.large: 'large',
};
