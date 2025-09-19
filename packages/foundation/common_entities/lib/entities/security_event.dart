import 'package:freezed_annotation/freezed_annotation.dart';

part 'security_event.freezed.dart';
part 'security_event.g.dart';

/// Security event for monitoring and logging
@freezed
class SecurityEvent with _$SecurityEvent {
  const factory SecurityEvent({
    required String id,
    required SecurityEventType type,
    required SecuritySeverity severity,
    required DateTime timestamp,
    required String description,
    required String source,
    required Map<String, dynamic> metadata,
    String? userId,
    String? sessionId,
    String? ipAddress,
    String? userAgent,
    String? location,
    bool? isResolved,
    DateTime? resolvedAt,
    String? resolutionNote,
  }) = _SecurityEvent;

  factory SecurityEvent.fromJson(Map<String, dynamic> json) =>
      _$SecurityEventFromJson(json);
}

/// Security event types
@freezed
class SecurityEventType with _$SecurityEventType {
  const factory SecurityEventType.login() = LoginEvent;
  const factory SecurityEventType.logout() = LogoutEvent;
  const factory SecurityEventType.authenticationFailure() = AuthenticationFailureEvent;
  const factory SecurityEventType.authorizationFailure() = AuthorizationFailureEvent;
  const factory SecurityEventType.dataAccess() = DataAccessEvent;
  const factory SecurityEventType.dataModification() = DataModificationEvent;
  const factory SecurityEventType.dataExport() = DataExportEvent;
  const factory SecurityEventType.dataImport() = DataImportEvent;
  const factory SecurityEventType.systemAccess() = SystemAccessEvent;
  const factory SecurityEventType.configurationChange() = ConfigurationChangeEvent;
  const factory SecurityEventType.securityPolicyViolation() = SecurityPolicyViolationEvent;
  const factory SecurityEventType.suspiciousActivity() = SuspiciousActivityEvent;
  const factory SecurityEventType.threatDetected() = ThreatDetectedEvent;
  const factory SecurityEventType.incident() = IncidentEvent;

  factory SecurityEventType.fromJson(Map<String, dynamic> json) =>
      _$SecurityEventTypeFromJson(json);
}

/// Security severity levels
@freezed
class SecuritySeverity with _$SecuritySeverity {
  const factory SecuritySeverity.low() = LowSeverity;
  const factory SecuritySeverity.medium() = MediumSeverity;
  const factory SecuritySeverity.high() = HighSeverity;
  const factory SecuritySeverity.critical() = CriticalSeverity;

  factory SecuritySeverity.fromJson(Map<String, dynamic> json) =>
      _$SecuritySeverityFromJson(json);
}