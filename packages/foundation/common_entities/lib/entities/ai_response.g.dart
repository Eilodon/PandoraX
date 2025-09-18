// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AIResponseImpl _$$AIResponseImplFromJson(Map<String, dynamic> json) =>
    _$AIResponseImpl(
      id: json['id'] as String,
      query: json['query'] as String,
      response: json['response'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$AIResponseImplToJson(_$AIResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'query': instance.query,
      'response': instance.response,
      'timestamp': instance.timestamp.toIso8601String(),
      'confidence': instance.confidence,
      'metadata': instance.metadata,
    };
