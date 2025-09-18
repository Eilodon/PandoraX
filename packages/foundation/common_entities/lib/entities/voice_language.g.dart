// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VoiceLanguageImpl _$$VoiceLanguageImplFromJson(Map<String, dynamic> json) =>
    _$VoiceLanguageImpl(
      code: json['code'] as String,
      name: json['name'] as String,
      nativeName: json['nativeName'] as String,
      isSTTSupported: json['isSTTSupported'] as bool? ?? true,
      isTTSSupported: json['isTTSSupported'] as bool? ?? true,
      sttCode: json['sttCode'] as String,
      ttsCode: json['ttsCode'] as String,
      defaultSpeechRate: (json['defaultSpeechRate'] as num?)?.toDouble() ?? 1.0,
      defaultVolume: (json['defaultVolume'] as num?)?.toDouble() ?? 1.0,
      defaultPitch: (json['defaultPitch'] as num?)?.toDouble() ?? 1.0,
    );

Map<String, dynamic> _$$VoiceLanguageImplToJson(_$VoiceLanguageImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'nativeName': instance.nativeName,
      'isSTTSupported': instance.isSTTSupported,
      'isTTSSupported': instance.isTTSSupported,
      'sttCode': instance.sttCode,
      'ttsCode': instance.ttsCode,
      'defaultSpeechRate': instance.defaultSpeechRate,
      'defaultVolume': instance.defaultVolume,
      'defaultPitch': instance.defaultPitch,
    };
