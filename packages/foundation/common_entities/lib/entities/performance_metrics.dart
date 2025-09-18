import 'package:freezed_annotation/freezed_annotation.dart';

part 'performance_metrics.freezed.dart';
part 'performance_metrics.g.dart';

/// Performance metrics entity
@freezed
class PerformanceMetrics with _$PerformanceMetrics {
  const factory PerformanceMetrics({
    required double memoryUsageMB,
    required double cpuUsagePercent,
    required double responseTimeMs,
    required double frameRate,
    required double networkRequestsPerMinute,
    required double batteryDrainPercentPerHour,
    required DateTime timestamp,
  }) = _PerformanceMetrics;

  factory PerformanceMetrics.fromJson(Map<String, dynamic> json) =>
      _$PerformanceMetricsFromJson(json);
}
