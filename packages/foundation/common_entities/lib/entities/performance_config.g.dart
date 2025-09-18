// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PerformanceConfigImpl _$$PerformanceConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$PerformanceConfigImpl(
      enableMonitoring: json['enableMonitoring'] as bool? ?? true,
      enableOptimization: json['enableOptimization'] as bool? ?? true,
      enableAnalytics: json['enableAnalytics'] as bool? ?? true,
      enableCaching: json['enableCaching'] as bool? ?? true,
      maxMemoryUsageMB: (json['maxMemoryUsageMB'] as num?)?.toInt() ?? 100,
      maxCpuUsagePercent: (json['maxCpuUsagePercent'] as num?)?.toInt() ?? 80,
      maxNetworkRequestsPerMinute:
          (json['maxNetworkRequestsPerMinute'] as num?)?.toInt() ?? 60,
      maxBatteryDrainPercentPerHour:
          (json['maxBatteryDrainPercentPerHour'] as num?)?.toInt() ?? 5,
      maxConcurrentOperations:
          (json['maxConcurrentOperations'] as num?)?.toInt() ?? 10,
      cacheExpirationMinutes:
          (json['cacheExpirationMinutes'] as num?)?.toInt() ?? 30,
      enableGarbageCollection: json['enableGarbageCollection'] as bool? ?? true,
      maxResponseTimeMs: (json['maxResponseTimeMs'] as num?)?.toInt() ?? 1000,
      targetFrameRate: (json['targetFrameRate'] as num?)?.toInt() ?? 60,
    );

Map<String, dynamic> _$$PerformanceConfigImplToJson(
        _$PerformanceConfigImpl instance) =>
    <String, dynamic>{
      'enableMonitoring': instance.enableMonitoring,
      'enableOptimization': instance.enableOptimization,
      'enableAnalytics': instance.enableAnalytics,
      'enableCaching': instance.enableCaching,
      'maxMemoryUsageMB': instance.maxMemoryUsageMB,
      'maxCpuUsagePercent': instance.maxCpuUsagePercent,
      'maxNetworkRequestsPerMinute': instance.maxNetworkRequestsPerMinute,
      'maxBatteryDrainPercentPerHour': instance.maxBatteryDrainPercentPerHour,
      'maxConcurrentOperations': instance.maxConcurrentOperations,
      'cacheExpirationMinutes': instance.cacheExpirationMinutes,
      'enableGarbageCollection': instance.enableGarbageCollection,
      'maxResponseTimeMs': instance.maxResponseTimeMs,
      'targetFrameRate': instance.targetFrameRate,
    };
