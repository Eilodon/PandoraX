// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ThemeConfigImpl _$$ThemeConfigImplFromJson(Map<String, dynamic> json) =>
    _$ThemeConfigImpl(
      pandoraTheme:
          PandoraTheme.fromJson(json['pandoraTheme'] as Map<String, dynamic>),
      themeMode: _themeModeFromJson(json['themeMode'] as String),
      accessibilityLevel: AccessibilityLevel.fromJson(
          json['accessibilityLevel'] as Map<String, dynamic>),
      contrastLevel:
          ContrastLevel.fromJson(json['contrastLevel'] as Map<String, dynamic>),
      sizeClass: SizeClass.fromJson(json['sizeClass'] as Map<String, dynamic>),
      enableAnimations: json['enableAnimations'] as bool? ?? true,
      enableHapticFeedback: json['enableHapticFeedback'] as bool? ?? true,
      enableSoundEffects: json['enableSoundEffects'] as bool? ?? true,
      animationSpeed: (json['animationSpeed'] as num?)?.toDouble() ?? 1.0,
      textScaleFactor: (json['textScaleFactor'] as num?)?.toDouble() ?? 1.0,
      iconScaleFactor: (json['iconScaleFactor'] as num?)?.toDouble() ?? 1.0,
      baseFontSize: (json['baseFontSize'] as num?)?.toDouble() ?? 16.0,
      lineHeight: (json['lineHeight'] as num?)?.toDouble() ?? 1.5,
      spacingUnit: (json['spacingUnit'] as num?)?.toDouble() ?? 8.0,
      borderRadius: (json['borderRadius'] as num?)?.toDouble() ?? 4.0,
      borderWidth: (json['borderWidth'] as num?)?.toDouble() ?? 2.0,
      elevation: (json['elevation'] as num?)?.toDouble() ?? 8.0,
      opacity: (json['opacity'] as num?)?.toDouble() ?? 0.1,
    );

Map<String, dynamic> _$$ThemeConfigImplToJson(_$ThemeConfigImpl instance) =>
    <String, dynamic>{
      'pandoraTheme': instance.pandoraTheme,
      'themeMode': _themeModeToJson(instance.themeMode),
      'accessibilityLevel': instance.accessibilityLevel,
      'contrastLevel': instance.contrastLevel,
      'sizeClass': instance.sizeClass,
      'enableAnimations': instance.enableAnimations,
      'enableHapticFeedback': instance.enableHapticFeedback,
      'enableSoundEffects': instance.enableSoundEffects,
      'animationSpeed': instance.animationSpeed,
      'textScaleFactor': instance.textScaleFactor,
      'iconScaleFactor': instance.iconScaleFactor,
      'baseFontSize': instance.baseFontSize,
      'lineHeight': instance.lineHeight,
      'spacingUnit': instance.spacingUnit,
      'borderRadius': instance.borderRadius,
      'borderWidth': instance.borderWidth,
      'elevation': instance.elevation,
      'opacity': instance.opacity,
    };

_$ClassicThemeImpl _$$ClassicThemeImplFromJson(Map<String, dynamic> json) =>
    _$ClassicThemeImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ClassicThemeImplToJson(_$ClassicThemeImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$ModernThemeImpl _$$ModernThemeImplFromJson(Map<String, dynamic> json) =>
    _$ModernThemeImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ModernThemeImplToJson(_$ModernThemeImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$MinimalThemeImpl _$$MinimalThemeImplFromJson(Map<String, dynamic> json) =>
    _$MinimalThemeImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$MinimalThemeImplToJson(_$MinimalThemeImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$DarkThemeImpl _$$DarkThemeImplFromJson(Map<String, dynamic> json) =>
    _$DarkThemeImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DarkThemeImplToJson(_$DarkThemeImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$LightThemeImpl _$$LightThemeImplFromJson(Map<String, dynamic> json) =>
    _$LightThemeImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LightThemeImplToJson(_$LightThemeImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$AutoThemeImpl _$$AutoThemeImplFromJson(Map<String, dynamic> json) =>
    _$AutoThemeImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AutoThemeImplToJson(_$AutoThemeImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$NoneAccessibilityImpl _$$NoneAccessibilityImplFromJson(
        Map<String, dynamic> json) =>
    _$NoneAccessibilityImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$NoneAccessibilityImplToJson(
        _$NoneAccessibilityImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$BasicAccessibilityImpl _$$BasicAccessibilityImplFromJson(
        Map<String, dynamic> json) =>
    _$BasicAccessibilityImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$BasicAccessibilityImplToJson(
        _$BasicAccessibilityImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$EnhancedAccessibilityImpl _$$EnhancedAccessibilityImplFromJson(
        Map<String, dynamic> json) =>
    _$EnhancedAccessibilityImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$EnhancedAccessibilityImplToJson(
        _$EnhancedAccessibilityImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$MaximumAccessibilityImpl _$$MaximumAccessibilityImplFromJson(
        Map<String, dynamic> json) =>
    _$MaximumAccessibilityImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$MaximumAccessibilityImplToJson(
        _$MaximumAccessibilityImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$NormalContrastImpl _$$NormalContrastImplFromJson(Map<String, dynamic> json) =>
    _$NormalContrastImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$NormalContrastImplToJson(
        _$NormalContrastImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$HighContrastImpl _$$HighContrastImplFromJson(Map<String, dynamic> json) =>
    _$HighContrastImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$HighContrastImplToJson(_$HighContrastImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$MaximumContrastImpl _$$MaximumContrastImplFromJson(
        Map<String, dynamic> json) =>
    _$MaximumContrastImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$MaximumContrastImplToJson(
        _$MaximumContrastImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$CompactSizeImpl _$$CompactSizeImplFromJson(Map<String, dynamic> json) =>
    _$CompactSizeImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CompactSizeImplToJson(_$CompactSizeImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$RegularSizeImpl _$$RegularSizeImplFromJson(Map<String, dynamic> json) =>
    _$RegularSizeImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$RegularSizeImplToJson(_$RegularSizeImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$LargeSizeImpl _$$LargeSizeImplFromJson(Map<String, dynamic> json) =>
    _$LargeSizeImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LargeSizeImplToJson(_$LargeSizeImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$ExtraLargeSizeImpl _$$ExtraLargeSizeImplFromJson(Map<String, dynamic> json) =>
    _$ExtraLargeSizeImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ExtraLargeSizeImplToJson(
        _$ExtraLargeSizeImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };
