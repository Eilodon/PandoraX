import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_status.freezed.dart';
part 'health_status.g.dart';

@freezed
class HealthStatus with _$HealthStatus {
  const factory HealthStatus({
    required bool isHealthy,
    required double successRate,
    required int averageLatencyMs,
    required String recommendation,
    @Default([]) List<HealthSample> samples,
  }) = _HealthStatus;

  factory HealthStatus.fromJson(Map<String, dynamic> json) =>
      _$HealthStatusFromJson(json);
}

@freezed
class HealthSample with _$HealthSample {
  const factory HealthSample({
    required DateTime timestamp,
    required bool success,
    required int latencyMs,
    String? error,
  }) = _HealthSample;

  factory HealthSample.fromJson(Map<String, dynamic> json) =>
      _$HealthSampleFromJson(json);
}

@freezed
class HealthReport with _$HealthReport {
  const factory HealthReport({
    required HealthStatus status,
    required List<HealthSample> samples,
    required PerformanceTrend trend,
    required DateTime generatedAt,
  }) = _HealthReport;

  factory HealthReport.fromJson(Map<String, dynamic> json) =>
      _$HealthReportFromJson(json);
}

@freezed
class PerformanceTrend with _$PerformanceTrend {
  const factory PerformanceTrend.improving() = _Improving;
  const factory PerformanceTrend.stable() = _Stable;
  const factory PerformanceTrend.declining() = _Declining;
  const factory PerformanceTrend.volatile() = _Volatile;
  const factory PerformanceTrend.unknown() = _Unknown;

  factory PerformanceTrend.fromJson(Map<String, dynamic> json) =>
      _$PerformanceTrendFromJson(json);
}

// Health Status enum for compatibility
enum HealthStatusEnum {
  healthy,
  warning,
  error,
  unknown,
}

@freezed
class HealthSnapshot with _$HealthSnapshot {
  const factory HealthSnapshot({
    required HealthStatus status,
    required PerformanceTrend trend,
    required DateTime timestamp,
  }) = _HealthSnapshot;

  factory HealthSnapshot.fromJson(Map<String, dynamic> json) =>
      _$HealthSnapshotFromJson(json);
}
