// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VoiceCommandImpl _$$VoiceCommandImplFromJson(Map<String, dynamic> json) =>
    _$VoiceCommandImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$VoiceCommandTypeEnumMap, json['type']),
      keywords:
          (json['keywords'] as List<dynamic>).map((e) => e as String).toList(),
      isEnabled: json['isEnabled'] as bool? ?? true,
      parameters: json['parameters'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$VoiceCommandImplToJson(_$VoiceCommandImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': _$VoiceCommandTypeEnumMap[instance.type]!,
      'keywords': instance.keywords,
      'isEnabled': instance.isEnabled,
      'parameters': instance.parameters,
    };

const _$VoiceCommandTypeEnumMap = {
  VoiceCommandType.createNote: 'createNote',
  VoiceCommandType.searchNote: 'searchNote',
  VoiceCommandType.deleteNote: 'deleteNote',
  VoiceCommandType.openSettings: 'openSettings',
  VoiceCommandType.enableVoice: 'enableVoice',
  VoiceCommandType.disableVoice: 'disableVoice',
  VoiceCommandType.translate: 'translate',
  VoiceCommandType.summarize: 'summarize',
  VoiceCommandType.help: 'help',
  VoiceCommandType.quit: 'quit',
};
