import 'package:freezed_annotation/freezed_annotation.dart';

part 'performance_event.freezed.dart';
part 'performance_event.g.dart';

/// Performance event types
enum PerformanceEventType {
  memoryUsage,
  cpuUsage,
  networkRequest,
  batteryDrain,
  responseTime,
  frameRate,
  error,
  warning,
  info,
}

/// Performance event entity
@freezed
class PerformanceEvent with _$PerformanceEvent {
  const factory PerformanceEvent({
    required String id,
    required PerformanceEventType type,
    required String message,
    required DateTime timestamp,
    Map<String, dynamic>? metadata,
  }) = _PerformanceEvent;

  factory PerformanceEvent.fromJson(Map<String, dynamic> json) =>
      _$PerformanceEventFromJson(json);
}
