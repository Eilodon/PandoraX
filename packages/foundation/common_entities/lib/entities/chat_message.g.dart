// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      id: json['id'] as String,
      content: json['content'] as String,
      type: $enumDecode(_$ChatMessageTypeEnumMap, json['type']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'type': _$ChatMessageTypeEnumMap[instance.type]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'attachments': instance.attachments,
      'metadata': instance.metadata,
    };

const _$ChatMessageTypeEnumMap = {
  ChatMessageType.user: 'user',
  ChatMessageType.ai: 'ai',
  ChatMessageType.system: 'system',
  ChatMessageType.error: 'error',
};
