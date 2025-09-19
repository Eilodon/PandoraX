// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SecurityEventImpl _$$SecurityEventImplFromJson(Map<String, dynamic> json) =>
    _$SecurityEventImpl(
      id: json['id'] as String,
      type: SecurityEventType.fromJson(json['type'] as Map<String, dynamic>),
      severity:
          SecuritySeverity.fromJson(json['severity'] as Map<String, dynamic>),
      timestamp: DateTime.parse(json['timestamp'] as String),
      description: json['description'] as String,
      source: json['source'] as String,
      metadata: json['metadata'] as Map<String, dynamic>,
      userId: json['userId'] as String?,
      sessionId: json['sessionId'] as String?,
      ipAddress: json['ipAddress'] as String?,
      userAgent: json['userAgent'] as String?,
      location: json['location'] as String?,
      isResolved: json['isResolved'] as bool?,
      resolvedAt: json['resolvedAt'] == null
          ? null
          : DateTime.parse(json['resolvedAt'] as String),
      resolutionNote: json['resolutionNote'] as String?,
    );

Map<String, dynamic> _$$SecurityEventImplToJson(_$SecurityEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'severity': instance.severity,
      'timestamp': instance.timestamp.toIso8601String(),
      'description': instance.description,
      'source': instance.source,
      'metadata': instance.metadata,
      'userId': instance.userId,
      'sessionId': instance.sessionId,
      'ipAddress': instance.ipAddress,
      'userAgent': instance.userAgent,
      'location': instance.location,
      'isResolved': instance.isResolved,
      'resolvedAt': instance.resolvedAt?.toIso8601String(),
      'resolutionNote': instance.resolutionNote,
    };

_$LoginEventImpl _$$LoginEventImplFromJson(Map<String, dynamic> json) =>
    _$LoginEventImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LoginEventImplToJson(_$LoginEventImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$LogoutEventImpl _$$LogoutEventImplFromJson(Map<String, dynamic> json) =>
    _$LogoutEventImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LogoutEventImplToJson(_$LogoutEventImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$AuthenticationFailureEventImpl _$$AuthenticationFailureEventImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthenticationFailureEventImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AuthenticationFailureEventImplToJson(
        _$AuthenticationFailureEventImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$AuthorizationFailureEventImpl _$$AuthorizationFailureEventImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthorizationFailureEventImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AuthorizationFailureEventImplToJson(
        _$AuthorizationFailureEventImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$DataAccessEventImpl _$$DataAccessEventImplFromJson(
        Map<String, dynamic> json) =>
    _$DataAccessEventImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DataAccessEventImplToJson(
        _$DataAccessEventImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$DataModificationEventImpl _$$DataModificationEventImplFromJson(
        Map<String, dynamic> json) =>
    _$DataModificationEventImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DataModificationEventImplToJson(
        _$DataModificationEventImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$DataExportEventImpl _$$DataExportEventImplFromJson(
        Map<String, dynamic> json) =>
    _$DataExportEventImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DataExportEventImplToJson(
        _$DataExportEventImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$DataImportEventImpl _$$DataImportEventImplFromJson(
        Map<String, dynamic> json) =>
    _$DataImportEventImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DataImportEventImplToJson(
        _$DataImportEventImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$SystemAccessEventImpl _$$SystemAccessEventImplFromJson(
        Map<String, dynamic> json) =>
    _$SystemAccessEventImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SystemAccessEventImplToJson(
        _$SystemAccessEventImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$ConfigurationChangeEventImpl _$$ConfigurationChangeEventImplFromJson(
        Map<String, dynamic> json) =>
    _$ConfigurationChangeEventImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ConfigurationChangeEventImplToJson(
        _$ConfigurationChangeEventImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$SecurityPolicyViolationEventImpl _$$SecurityPolicyViolationEventImplFromJson(
        Map<String, dynamic> json) =>
    _$SecurityPolicyViolationEventImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SecurityPolicyViolationEventImplToJson(
        _$SecurityPolicyViolationEventImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$SuspiciousActivityEventImpl _$$SuspiciousActivityEventImplFromJson(
        Map<String, dynamic> json) =>
    _$SuspiciousActivityEventImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SuspiciousActivityEventImplToJson(
        _$SuspiciousActivityEventImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$ThreatDetectedEventImpl _$$ThreatDetectedEventImplFromJson(
        Map<String, dynamic> json) =>
    _$ThreatDetectedEventImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ThreatDetectedEventImplToJson(
        _$ThreatDetectedEventImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$IncidentEventImpl _$$IncidentEventImplFromJson(Map<String, dynamic> json) =>
    _$IncidentEventImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$IncidentEventImplToJson(_$IncidentEventImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$LowSeverityImpl _$$LowSeverityImplFromJson(Map<String, dynamic> json) =>
    _$LowSeverityImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LowSeverityImplToJson(_$LowSeverityImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$MediumSeverityImpl _$$MediumSeverityImplFromJson(Map<String, dynamic> json) =>
    _$MediumSeverityImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$MediumSeverityImplToJson(
        _$MediumSeverityImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$HighSeverityImpl _$$HighSeverityImplFromJson(Map<String, dynamic> json) =>
    _$HighSeverityImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$HighSeverityImplToJson(_$HighSeverityImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$CriticalSeverityImpl _$$CriticalSeverityImplFromJson(
        Map<String, dynamic> json) =>
    _$CriticalSeverityImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CriticalSeverityImplToJson(
        _$CriticalSeverityImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };
