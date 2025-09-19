import 'package:freezed_annotation/freezed_annotation.dart';

part 'performance_config.freezed.dart';
part 'performance_config.g.dart';

/// Performance configuration for the application
@freezed
class PerformanceConfig with _$PerformanceConfig {
  const factory PerformanceConfig({
    @Default(80.0) double maxCpuUsagePercent,
    @Default(5.0) double maxBatteryDrainPercentPerHour,
    @Default(100) int maxMemoryUsageMB,
    @Default(10) int maxConcurrentOperations,
    @Default(60) int maxNetworkRequestsPerMinute,
    @Default(1000) int maxResponseTimeMs,
    @Default(30) int minFrameRate,
    @Default(true) bool enableOptimization,
    @Default(true) bool enableCaching,
    @Default(true) bool enableLazyLoading,
    @Default(5) int maxCacheSizeMB,
    @Default(30) int cacheExpirationMinutes,
    @Default(true) bool enableImageCompression,
    @Default(0.8) double imageCompressionQuality,
    @Default(true) bool enableDataCompression,
    @Default(true) bool enableBackgroundSync,
    @Default(300) int backgroundSyncIntervalSeconds,
  }) = _PerformanceConfig;

  factory PerformanceConfig.fromJson(Map<String, dynamic> json) =>
      _$PerformanceConfigFromJson(json);
}

/// Performance metrics for monitoring
@freezed
class PerformanceMetrics with _$PerformanceMetrics {
  const factory PerformanceMetrics({
    required double cpuUsagePercent,
    required double memoryUsageMB,
    required int networkRequestsPerMinute,
    required double batteryDrainPercentPerHour,
    required int responseTimeMs,
    required int frameRate,
    required DateTime timestamp,
    @Default(0) int activeConnections,
    @Default(0) int queuedTasks,
    @Default(0) int completedTasks,
    @Default(0) int failedTasks,
  }) = _PerformanceMetrics;

  factory PerformanceMetrics.fromJson(Map<String, dynamic> json) =>
      _$PerformanceMetricsFromJson(json);
}

/// Task optimization levels
@freezed
class TaskOptimizationLevel with _$TaskOptimizationLevel {
  const factory TaskOptimizationLevel.low() = LowOptimization;
  const factory TaskOptimizationLevel.medium() = MediumOptimization;
  const factory TaskOptimizationLevel.high() = HighOptimization;
  const factory TaskOptimizationLevel.maximum() = MaximumOptimization;

  factory TaskOptimizationLevel.fromJson(Map<String, dynamic> json) =>
      _$TaskOptimizationLevelFromJson(json);
}

/// Performance optimization strategies
@freezed
class OptimizationStrategy with _$OptimizationStrategy {
  const factory OptimizationStrategy({
    required String name,
    required String description,
    required TaskOptimizationLevel level,
    required bool isEnabled,
    required Map<String, dynamic> parameters,
  }) = _OptimizationStrategy;

  factory OptimizationStrategy.fromJson(Map<String, dynamic> json) =>
      _$OptimizationStrategyFromJson(json);
}