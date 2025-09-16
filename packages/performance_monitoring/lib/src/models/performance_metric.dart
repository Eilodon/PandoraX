import 'package:freezed_annotation/freezed_annotation.dart';

part 'performance_metric.freezed.dart';
part 'performance_metric.g.dart';

@freezed
class PerformanceMetric with _$PerformanceMetric {
  const factory PerformanceMetric({
    required String name,
    required double value,
    required String unit,
    required double threshold,
    required DateTime timestamp,
    String? category,
    Map<String, dynamic>? metadata,
    @Default(MetricStatus.normal) MetricStatus status,
  }) = _PerformanceMetric;

  factory PerformanceMetric.fromJson(Map<String, dynamic> json) =>
      _$PerformanceMetricFromJson(json);
}

@freezed
class PerformanceSnapshot with _$PerformanceSnapshot {
  const factory PerformanceSnapshot({
    required DateTime timestamp,
    required List<PerformanceMetric> metrics,
    required String deviceId,
    required String appVersion,
    Map<String, dynamic>? deviceInfo,
  }) = _PerformanceSnapshot;

  factory PerformanceSnapshot.fromJson(Map<String, dynamic> json) =>
      _$PerformanceSnapshotFromJson(json);
}

enum MetricStatus {
  normal,
  warning,
  critical,
  error,
}

enum MetricCategory {
  performance,
  memory,
  network,
  battery,
  ui,
  ai,
  database,
  storage,
}

class PerformanceThresholds {
  static const double appStartupWarning = 3000; // 3 seconds
  static const double appStartupCritical = 5000; // 5 seconds
  
  static const double aiResponseWarning = 2000; // 2 seconds
  static const double aiResponseCritical = 5000; // 5 seconds
  
  static const double memoryWarning = 100; // 100MB
  static const double memoryCritical = 200; // 200MB
  
  static const double batteryWarning = 20; // 20%
  static const double batteryCritical = 10; // 10%
  
  static const double networkLatencyWarning = 1000; // 1 second
  static const double networkLatencyCritical = 3000; // 3 seconds
}
