import 'package:freezed_annotation/freezed_annotation.dart';

part 'security_event.freezed.dart';
part 'security_event.g.dart';

/// Security event types
enum SecurityEventType {
  login,
  logout,
  failedLogin,
  suspiciousActivity,
  dataAccess,
  dataModification,
  permissionChange,
  encryption,
  decryption,
  backup,
  restore,
}

/// Security event severity levels
enum SecurityEventSeverity {
  low,
  medium,
  high,
  critical,
}

/// Security event entity
@freezed
class SecurityEvent with _$SecurityEvent {
  const factory SecurityEvent({
    required String id,
    required SecurityEventType type,
    required SecurityEventSeverity severity,
    required String message,
    required DateTime timestamp,
    Map<String, dynamic>? metadata,
  }) = _SecurityEvent;

  factory SecurityEvent.fromJson(Map<String, dynamic> json) =>
      _$SecurityEventFromJson(json);
}
