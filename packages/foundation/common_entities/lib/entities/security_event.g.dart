// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SecurityEventImpl _$$SecurityEventImplFromJson(Map<String, dynamic> json) =>
    _$SecurityEventImpl(
      id: json['id'] as String,
      type: $enumDecode(_$SecurityEventTypeEnumMap, json['type']),
      severity: $enumDecode(_$SecurityEventSeverityEnumMap, json['severity']),
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$SecurityEventImplToJson(_$SecurityEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$SecurityEventTypeEnumMap[instance.type]!,
      'severity': _$SecurityEventSeverityEnumMap[instance.severity]!,
      'message': instance.message,
      'timestamp': instance.timestamp.toIso8601String(),
      'metadata': instance.metadata,
    };

const _$SecurityEventTypeEnumMap = {
  SecurityEventType.login: 'login',
  SecurityEventType.logout: 'logout',
  SecurityEventType.failedLogin: 'failedLogin',
  SecurityEventType.suspiciousActivity: 'suspiciousActivity',
  SecurityEventType.dataAccess: 'dataAccess',
  SecurityEventType.dataModification: 'dataModification',
  SecurityEventType.permissionChange: 'permissionChange',
  SecurityEventType.encryption: 'encryption',
  SecurityEventType.decryption: 'decryption',
  SecurityEventType.backup: 'backup',
  SecurityEventType.restore: 'restore',
};

const _$SecurityEventSeverityEnumMap = {
  SecurityEventSeverity.low: 'low',
  SecurityEventSeverity.medium: 'medium',
  SecurityEventSeverity.high: 'high',
  SecurityEventSeverity.critical: 'critical',
};
