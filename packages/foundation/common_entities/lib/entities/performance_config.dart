import 'package:freezed_annotation/freezed_annotation.dart';

part 'performance_config.freezed.dart';
part 'performance_config.g.dart';

/// Performance configuration entity
@freezed
class PerformanceConfig with _$PerformanceConfig {
  const factory PerformanceConfig({
    @Default(true) bool enableMonitoring,
    @Default(true) bool enableOptimization,
    @Default(true) bool enableAnalytics,
    @Default(true) bool enableCaching,
    @Default(100) int maxMemoryUsageMB,
    @Default(80) int maxCpuUsagePercent,
    @Default(60) int maxNetworkRequestsPerMinute,
    @Default(5) int maxBatteryDrainPercentPerHour,
    @Default(10) int maxConcurrentOperations,
    @Default(30) int cacheExpirationMinutes,
    @Default(true) bool enableGarbageCollection,
    @Default(1000) int maxResponseTimeMs,
    @Default(60) int targetFrameRate,
  }) = _PerformanceConfig;

  factory PerformanceConfig.fromJson(Map<String, dynamic> json) =>
      _$PerformanceConfigFromJson(json);
}
