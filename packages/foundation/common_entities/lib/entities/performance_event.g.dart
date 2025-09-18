// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PerformanceEventImpl _$$PerformanceEventImplFromJson(
        Map<String, dynamic> json) =>
    _$PerformanceEventImpl(
      id: json['id'] as String,
      type: $enumDecode(_$PerformanceEventTypeEnumMap, json['type']),
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$PerformanceEventImplToJson(
        _$PerformanceEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$PerformanceEventTypeEnumMap[instance.type]!,
      'message': instance.message,
      'timestamp': instance.timestamp.toIso8601String(),
      'metadata': instance.metadata,
    };

const _$PerformanceEventTypeEnumMap = {
  PerformanceEventType.memoryUsage: 'memoryUsage',
  PerformanceEventType.cpuUsage: 'cpuUsage',
  PerformanceEventType.networkRequest: 'networkRequest',
  PerformanceEventType.batteryDrain: 'batteryDrain',
  PerformanceEventType.responseTime: 'responseTime',
  PerformanceEventType.frameRate: 'frameRate',
  PerformanceEventType.error: 'error',
  PerformanceEventType.warning: 'warning',
  PerformanceEventType.info: 'info',
};
