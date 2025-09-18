import 'package:freezed_annotation/freezed_annotation.dart';

part 'performance_config.freezed.dart';
part 'performance_config.g.dart';

/// Performance configuration for optimization
@freezed
class PerformanceConfig with _$PerformanceConfig {
  const factory PerformanceConfig({
    @Default(true) bool enableMemoryOptimization,
    @Default(true) bool enableCpuOptimization,
    @Default(true) bool enableNetworkOptimization,
    @Default(true) bool enableBatteryOptimization,
    @Default(100) int maxMemoryUsageMB,
    @Default(50) int maxCpuUsagePercent,
    @Default(1000) int maxNetworkRequestsPerMinute,
    @Default(60) int maxBatteryDrainPercentPerHour,
    @Default(30) int cacheExpirationMinutes,
    @Default(100) int maxCacheSizeMB,
    @Default(10) int maxConcurrentOperations,
    @Default(5000) int maxQueueSize,
    @Default(1000) int maxLogEntries,
    @Default(true) bool enableGarbageCollection,
    @Default(true) bool enableImageCompression,
    @Default(true) bool enableDataCompression,
    @Default(true) bool enableLazyLoading,
    @Default(true) bool enablePrefetching,
    @Default(true) bool enableCaching,
    @Default(PerformanceLevel.standard) PerformanceLevel performanceLevel,
    @Default(OptimizationStrategy.balanced) OptimizationStrategy optimizationStrategy,
    @Default(MonitoringLevel.standard) MonitoringLevel monitoringLevel,
    Map<String, dynamic>? customSettings,
  }) = _PerformanceConfig;

  const PerformanceConfig._();

  factory PerformanceConfig.fromJson(Map<String, dynamic> json) =>
      _$PerformanceConfigFromJson(json);

  /// Get default performance configuration
  static PerformanceConfig get defaultConfig => const PerformanceConfig();

  /// Get high performance configuration
  static PerformanceConfig get highPerformanceConfig => const PerformanceConfig(
    enableMemoryOptimization: true,
    enableCpuOptimization: true,
    enableNetworkOptimization: true,
    enableBatteryOptimization: true,
    maxMemoryUsageMB: 200,
    maxCpuUsagePercent: 80,
    maxNetworkRequestsPerMinute: 2000,
    maxBatteryDrainPercentPerHour: 30,
    cacheExpirationMinutes: 60,
    maxCacheSizeMB: 200,
    maxConcurrentOperations: 20,
    maxQueueSize: 10000,
    maxLogEntries: 2000,
    enableGarbageCollection: true,
    enableImageCompression: true,
    enableDataCompression: true,
    enableLazyLoading: true,
    enablePrefetching: true,
    enableCaching: true,
    performanceLevel: PerformanceLevel.high,
    optimizationStrategy: OptimizationStrategy.performance,
    monitoringLevel: MonitoringLevel.detailed,
  );

  /// Get battery saver configuration
  static PerformanceConfig get batterySaverConfig => const PerformanceConfig(
    enableMemoryOptimization: true,
    enableCpuOptimization: true,
    enableNetworkOptimization: true,
    enableBatteryOptimization: true,
    maxMemoryUsageMB: 50,
    maxCpuUsagePercent: 30,
    maxNetworkRequestsPerMinute: 100,
    maxBatteryDrainPercentPerHour: 10,
    cacheExpirationMinutes: 5,
    maxCacheSizeMB: 25,
    maxConcurrentOperations: 3,
    maxQueueSize: 1000,
    maxLogEntries: 100,
    enableGarbageCollection: true,
    enableImageCompression: true,
    enableDataCompression: true,
    enableLazyLoading: true,
    enablePrefetching: false,
    enableCaching: false,
    performanceLevel: PerformanceLevel.low,
    optimizationStrategy: OptimizationStrategy.battery,
    monitoringLevel: MonitoringLevel.minimal,
  );

  /// Get data saver configuration
  static PerformanceConfig get dataSaverConfig => const PerformanceConfig(
    enableMemoryOptimization: true,
    enableCpuOptimization: true,
    enableNetworkOptimization: true,
    enableBatteryOptimization: true,
    maxMemoryUsageMB: 75,
    maxCpuUsagePercent: 40,
    maxNetworkRequestsPerMinute: 50,
    maxBatteryDrainPercentPerHour: 20,
    cacheExpirationMinutes: 120,
    maxCacheSizeMB: 150,
    maxConcurrentOperations: 5,
    maxQueueSize: 2000,
    maxLogEntries: 500,
    enableGarbageCollection: true,
    enableImageCompression: true,
    enableDataCompression: true,
    enableLazyLoading: true,
    enablePrefetching: false,
    enableCaching: true,
    performanceLevel: PerformanceLevel.medium,
    optimizationStrategy: OptimizationStrategy.data,
    monitoringLevel: MonitoringLevel.standard,
  );

  /// Check if memory optimization is enabled
  bool get isMemoryOptimized => enableMemoryOptimization;

  /// Check if CPU optimization is enabled
  bool get isCpuOptimized => enableCpuOptimization;

  /// Check if network optimization is enabled
  bool get isNetworkOptimized => enableNetworkOptimization;

  /// Check if battery optimization is enabled
  bool get isBatteryOptimized => enableBatteryOptimization;

  /// Get memory limit in bytes
  int get memoryLimitBytes => maxMemoryUsageMB * 1024 * 1024;

  /// Get cache limit in bytes
  int get cacheLimitBytes => maxCacheSizeMB * 1024 * 1024;

  /// Get cache expiration duration
  Duration get cacheExpirationDuration => Duration(minutes: cacheExpirationMinutes);

  /// Get performance description
  String get description {
    final level = performanceLevel.displayName;
    final strategy = optimizationStrategy.displayName;
    final monitoring = monitoringLevel.displayName;
    
    return '$level performance with $strategy strategy and $monitoring monitoring';
  }
}

/// Performance levels
enum PerformanceLevel {
  low,
  standard,
  medium,
  high,
  maximum,
}

/// Optimization strategies
enum OptimizationStrategy {
  balanced,
  performance,
  battery,
  data,
  memory,
  custom,
}

/// Monitoring levels
enum MonitoringLevel {
  minimal,
  standard,
  detailed,
  maximum,
}

/// Performance metrics
@freezed
class PerformanceMetrics with _$PerformanceMetrics {
  const factory PerformanceMetrics({
    required double memoryUsageMB,
    required double cpuUsagePercent,
    required int networkRequestsPerMinute,
    required double batteryDrainPercentPerHour,
    required int cacheSizeMB,
    required int activeOperations,
    required int queueSize,
    required int logEntries,
    required double responseTimeMs,
    required double frameRate,
    required int memoryLeaks,
    required int garbageCollections,
    required DateTime timestamp,
    Map<String, dynamic>? metadata,
  }) = _PerformanceMetrics;

  const PerformanceMetrics._();

  factory PerformanceMetrics.fromJson(Map<String, dynamic> json) =>
      _$PerformanceMetricsFromJson(json);

  /// Get performance score (0-100)
  int get performanceScore {
    int score = 100;
    
    // Memory usage penalty
    if (memoryUsageMB > 100) score -= 20;
    else if (memoryUsageMB > 50) score -= 10;
    
    // CPU usage penalty
    if (cpuUsagePercent > 80) score -= 20;
    else if (cpuUsagePercent > 50) score -= 10;
    
    // Network requests penalty
    if (networkRequestsPerMinute > 1000) score -= 15;
    else if (networkRequestsPerMinute > 500) score -= 5;
    
    // Battery drain penalty
    if (batteryDrainPercentPerHour > 30) score -= 15;
    else if (batteryDrainPercentPerHour > 20) score -= 5;
    
    // Response time penalty
    if (responseTimeMs > 1000) score -= 20;
    else if (responseTimeMs > 500) score -= 10;
    
    // Frame rate penalty
    if (frameRate < 30) score -= 25;
    else if (frameRate < 45) score -= 15;
    else if (frameRate < 55) score -= 5;
    
    // Memory leaks penalty
    if (memoryLeaks > 10) score -= 20;
    else if (memoryLeaks > 5) score -= 10;
    else if (memoryLeaks > 0) score -= 5;
    
    return score.clamp(0, 100);
  }

  /// Get performance level
  PerformanceLevel get performanceLevel {
    final score = performanceScore;
    
    if (score >= 90) return PerformanceLevel.maximum;
    if (score >= 80) return PerformanceLevel.high;
    if (score >= 70) return PerformanceLevel.medium;
    if (score >= 60) return PerformanceLevel.standard;
    return PerformanceLevel.low;
  }

  /// Check if performance is good
  bool get isGoodPerformance => performanceScore >= 70;

  /// Check if performance is critical
  bool get isCriticalPerformance => performanceScore < 40;

  /// Get performance status
  String get status {
    final score = performanceScore;
    
    if (score >= 90) return 'Excellent';
    if (score >= 80) return 'Good';
    if (score >= 70) return 'Fair';
    if (score >= 60) return 'Poor';
    return 'Critical';
  }

  /// Get performance recommendations
  List<String> get recommendations {
    final recommendations = <String>[];
    
    if (memoryUsageMB > 100) {
      recommendations.add('Reduce memory usage - consider enabling memory optimization');
    }
    
    if (cpuUsagePercent > 80) {
      recommendations.add('Reduce CPU usage - consider enabling CPU optimization');
    }
    
    if (networkRequestsPerMinute > 1000) {
      recommendations.add('Reduce network requests - consider enabling network optimization');
    }
    
    if (batteryDrainPercentPerHour > 30) {
      recommendations.add('Reduce battery drain - consider enabling battery optimization');
    }
    
    if (responseTimeMs > 1000) {
      recommendations.add('Improve response time - consider optimizing operations');
    }
    
    if (frameRate < 30) {
      recommendations.add('Improve frame rate - consider reducing UI complexity');
    }
    
    if (memoryLeaks > 5) {
      recommendations.add('Fix memory leaks - consider enabling garbage collection');
    }
    
    if (recommendations.isEmpty) {
      recommendations.add('Performance is well optimized');
    }
    
    return recommendations;
  }
}

/// Performance event types
enum PerformanceEventType {
  memoryOptimization,
  cpuOptimization,
  networkOptimization,
  batteryOptimization,
  cacheOptimization,
  garbageCollection,
  imageCompression,
  dataCompression,
  lazyLoading,
  prefetching,
  caching,
  performanceAlert,
  performanceWarning,
  performanceCritical,
  optimizationApplied,
  optimizationFailed,
}

/// Performance event
@freezed
class PerformanceEvent with _$PerformanceEvent {
  const factory PerformanceEvent({
    required String id,
    required PerformanceEventType type,
    required DateTime timestamp,
    required String description,
    required PerformanceSeverity severity,
    Map<String, dynamic>? metadata,
    double? impactScore,
    String? recommendation,
  }) = _PerformanceEvent;

  const PerformanceEvent._();

  factory PerformanceEvent.fromJson(Map<String, dynamic> json) =>
      _$PerformanceEventFromJson(json);

  /// Get event icon
  String get icon {
    switch (type) {
      case PerformanceEventType.memoryOptimization:
        return '🧠';
      case PerformanceEventType.cpuOptimization:
        return '⚡';
      case PerformanceEventType.networkOptimization:
        return '🌐';
      case PerformanceEventType.batteryOptimization:
        return '🔋';
      case PerformanceEventType.cacheOptimization:
        return '💾';
      case PerformanceEventType.garbageCollection:
        return '🗑️';
      case PerformanceEventType.imageCompression:
        return '🖼️';
      case PerformanceEventType.dataCompression:
        return '📦';
      case PerformanceEventType.lazyLoading:
        return '⏳';
      case PerformanceEventType.prefetching:
        return '🔮';
      case PerformanceEventType.caching:
        return '📚';
      case PerformanceEventType.performanceAlert:
        return '⚠️';
      case PerformanceEventType.performanceWarning:
        return '⚠️';
      case PerformanceEventType.performanceCritical:
        return '🚨';
      case PerformanceEventType.optimizationApplied:
        return '✅';
      case PerformanceEventType.optimizationFailed:
        return '❌';
    }
  }
}

/// Performance severity levels
enum PerformanceSeverity {
  low,
  medium,
  high,
  critical,
}

/// Extension for PerformanceLevel
extension PerformanceLevelExtension on PerformanceLevel {
  String get displayName {
    switch (this) {
      case PerformanceLevel.low:
        return 'Low';
      case PerformanceLevel.standard:
        return 'Standard';
      case PerformanceLevel.medium:
        return 'Medium';
      case PerformanceLevel.high:
        return 'High';
      case PerformanceLevel.maximum:
        return 'Maximum';
    }
  }

  String get icon {
    switch (this) {
      case PerformanceLevel.low:
        return '🐌';
      case PerformanceLevel.standard:
        return '🚀';
      case PerformanceLevel.medium:
        return '🚀';
      case PerformanceLevel.high:
        return '🚀';
      case PerformanceLevel.maximum:
        return '🚀';
    }
  }

  String get description {
    switch (this) {
      case PerformanceLevel.low:
        return 'Basic performance with minimal optimizations';
      case PerformanceLevel.standard:
        return 'Standard performance with balanced optimizations';
      case PerformanceLevel.medium:
        return 'Good performance with moderate optimizations';
      case PerformanceLevel.high:
        return 'High performance with extensive optimizations';
      case PerformanceLevel.maximum:
        return 'Maximum performance with all optimizations';
    }
  }
}

/// Extension for OptimizationStrategy
extension OptimizationStrategyExtension on OptimizationStrategy {
  String get displayName {
    switch (this) {
      case OptimizationStrategy.balanced:
        return 'Balanced';
      case OptimizationStrategy.performance:
        return 'Performance';
      case OptimizationStrategy.battery:
        return 'Battery';
      case OptimizationStrategy.data:
        return 'Data';
      case OptimizationStrategy.memory:
        return 'Memory';
      case OptimizationStrategy.custom:
        return 'Custom';
    }
  }

  String get icon {
    switch (this) {
      case OptimizationStrategy.balanced:
        return '⚖️';
      case OptimizationStrategy.performance:
        return '⚡';
      case OptimizationStrategy.battery:
        return '🔋';
      case OptimizationStrategy.data:
        return '📊';
      case OptimizationStrategy.memory:
        return '🧠';
      case OptimizationStrategy.custom:
        return '⚙️';
    }
  }

  String get description {
    switch (this) {
      case OptimizationStrategy.balanced:
        return 'Balanced optimization across all areas';
      case OptimizationStrategy.performance:
        return 'Optimized for maximum performance';
      case OptimizationStrategy.battery:
        return 'Optimized for battery life';
      case OptimizationStrategy.data:
        return 'Optimized for data usage';
      case OptimizationStrategy.memory:
        return 'Optimized for memory usage';
      case OptimizationStrategy.custom:
        return 'Custom optimization settings';
    }
  }
}

/// Extension for MonitoringLevel
extension MonitoringLevelExtension on MonitoringLevel {
  String get displayName {
    switch (this) {
      case MonitoringLevel.minimal:
        return 'Minimal';
      case MonitoringLevel.standard:
        return 'Standard';
      case MonitoringLevel.detailed:
        return 'Detailed';
      case MonitoringLevel.maximum:
        return 'Maximum';
    }
  }

  String get icon {
    switch (this) {
      case MonitoringLevel.minimal:
        return '👁️';
      case MonitoringLevel.standard:
        return '👁️';
      case MonitoringLevel.detailed:
        return '🔍';
      case MonitoringLevel.maximum:
        return '🔬';
    }
  }

  String get description {
    switch (this) {
      case MonitoringLevel.minimal:
        return 'Minimal performance monitoring';
      case MonitoringLevel.standard:
        return 'Standard performance monitoring';
      case MonitoringLevel.detailed:
        return 'Detailed performance monitoring';
      case MonitoringLevel.maximum:
        return 'Maximum performance monitoring';
    }
  }
}
