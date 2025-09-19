// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PerformanceConfigImpl _$$PerformanceConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$PerformanceConfigImpl(
      maxCpuUsagePercent:
          (json['maxCpuUsagePercent'] as num?)?.toDouble() ?? 80.0,
      maxBatteryDrainPercentPerHour:
          (json['maxBatteryDrainPercentPerHour'] as num?)?.toDouble() ?? 5.0,
      maxMemoryUsageMB: (json['maxMemoryUsageMB'] as num?)?.toInt() ?? 100,
      maxConcurrentOperations:
          (json['maxConcurrentOperations'] as num?)?.toInt() ?? 10,
      maxNetworkRequestsPerMinute:
          (json['maxNetworkRequestsPerMinute'] as num?)?.toInt() ?? 60,
      maxResponseTimeMs: (json['maxResponseTimeMs'] as num?)?.toInt() ?? 1000,
      minFrameRate: (json['minFrameRate'] as num?)?.toInt() ?? 30,
      enableOptimization: json['enableOptimization'] as bool? ?? true,
      enableCaching: json['enableCaching'] as bool? ?? true,
      enableLazyLoading: json['enableLazyLoading'] as bool? ?? true,
      maxCacheSizeMB: (json['maxCacheSizeMB'] as num?)?.toInt() ?? 5,
      cacheExpirationMinutes:
          (json['cacheExpirationMinutes'] as num?)?.toInt() ?? 30,
      enableImageCompression: json['enableImageCompression'] as bool? ?? true,
      imageCompressionQuality:
          (json['imageCompressionQuality'] as num?)?.toDouble() ?? 0.8,
      enableDataCompression: json['enableDataCompression'] as bool? ?? true,
      enableBackgroundSync: json['enableBackgroundSync'] as bool? ?? true,
      backgroundSyncIntervalSeconds:
          (json['backgroundSyncIntervalSeconds'] as num?)?.toInt() ?? 300,
    );

Map<String, dynamic> _$$PerformanceConfigImplToJson(
        _$PerformanceConfigImpl instance) =>
    <String, dynamic>{
      'maxCpuUsagePercent': instance.maxCpuUsagePercent,
      'maxBatteryDrainPercentPerHour': instance.maxBatteryDrainPercentPerHour,
      'maxMemoryUsageMB': instance.maxMemoryUsageMB,
      'maxConcurrentOperations': instance.maxConcurrentOperations,
      'maxNetworkRequestsPerMinute': instance.maxNetworkRequestsPerMinute,
      'maxResponseTimeMs': instance.maxResponseTimeMs,
      'minFrameRate': instance.minFrameRate,
      'enableOptimization': instance.enableOptimization,
      'enableCaching': instance.enableCaching,
      'enableLazyLoading': instance.enableLazyLoading,
      'maxCacheSizeMB': instance.maxCacheSizeMB,
      'cacheExpirationMinutes': instance.cacheExpirationMinutes,
      'enableImageCompression': instance.enableImageCompression,
      'imageCompressionQuality': instance.imageCompressionQuality,
      'enableDataCompression': instance.enableDataCompression,
      'enableBackgroundSync': instance.enableBackgroundSync,
      'backgroundSyncIntervalSeconds': instance.backgroundSyncIntervalSeconds,
    };

_$PerformanceMetricsImpl _$$PerformanceMetricsImplFromJson(
        Map<String, dynamic> json) =>
    _$PerformanceMetricsImpl(
      cpuUsagePercent: (json['cpuUsagePercent'] as num).toDouble(),
      memoryUsageMB: (json['memoryUsageMB'] as num).toDouble(),
      networkRequestsPerMinute:
          (json['networkRequestsPerMinute'] as num).toInt(),
      batteryDrainPercentPerHour:
          (json['batteryDrainPercentPerHour'] as num).toDouble(),
      responseTimeMs: (json['responseTimeMs'] as num).toInt(),
      frameRate: (json['frameRate'] as num).toInt(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      activeConnections: (json['activeConnections'] as num?)?.toInt() ?? 0,
      queuedTasks: (json['queuedTasks'] as num?)?.toInt() ?? 0,
      completedTasks: (json['completedTasks'] as num?)?.toInt() ?? 0,
      failedTasks: (json['failedTasks'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$PerformanceMetricsImplToJson(
        _$PerformanceMetricsImpl instance) =>
    <String, dynamic>{
      'cpuUsagePercent': instance.cpuUsagePercent,
      'memoryUsageMB': instance.memoryUsageMB,
      'networkRequestsPerMinute': instance.networkRequestsPerMinute,
      'batteryDrainPercentPerHour': instance.batteryDrainPercentPerHour,
      'responseTimeMs': instance.responseTimeMs,
      'frameRate': instance.frameRate,
      'timestamp': instance.timestamp.toIso8601String(),
      'activeConnections': instance.activeConnections,
      'queuedTasks': instance.queuedTasks,
      'completedTasks': instance.completedTasks,
      'failedTasks': instance.failedTasks,
    };

_$LowOptimizationImpl _$$LowOptimizationImplFromJson(
        Map<String, dynamic> json) =>
    _$LowOptimizationImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LowOptimizationImplToJson(
        _$LowOptimizationImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$MediumOptimizationImpl _$$MediumOptimizationImplFromJson(
        Map<String, dynamic> json) =>
    _$MediumOptimizationImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$MediumOptimizationImplToJson(
        _$MediumOptimizationImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$HighOptimizationImpl _$$HighOptimizationImplFromJson(
        Map<String, dynamic> json) =>
    _$HighOptimizationImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$HighOptimizationImplToJson(
        _$HighOptimizationImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$MaximumOptimizationImpl _$$MaximumOptimizationImplFromJson(
        Map<String, dynamic> json) =>
    _$MaximumOptimizationImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$MaximumOptimizationImplToJson(
        _$MaximumOptimizationImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$OptimizationStrategyImpl _$$OptimizationStrategyImplFromJson(
        Map<String, dynamic> json) =>
    _$OptimizationStrategyImpl(
      name: json['name'] as String,
      description: json['description'] as String,
      level:
          TaskOptimizationLevel.fromJson(json['level'] as Map<String, dynamic>),
      isEnabled: json['isEnabled'] as bool,
      parameters: json['parameters'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$OptimizationStrategyImplToJson(
        _$OptimizationStrategyImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'level': instance.level,
      'isEnabled': instance.isEnabled,
      'parameters': instance.parameters,
    };
