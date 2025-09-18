// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_metrics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PerformanceMetricsImpl _$$PerformanceMetricsImplFromJson(
        Map<String, dynamic> json) =>
    _$PerformanceMetricsImpl(
      memoryUsageMB: (json['memoryUsageMB'] as num).toDouble(),
      cpuUsagePercent: (json['cpuUsagePercent'] as num).toDouble(),
      responseTimeMs: (json['responseTimeMs'] as num).toDouble(),
      frameRate: (json['frameRate'] as num).toDouble(),
      networkRequestsPerMinute:
          (json['networkRequestsPerMinute'] as num).toDouble(),
      batteryDrainPercentPerHour:
          (json['batteryDrainPercentPerHour'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$PerformanceMetricsImplToJson(
        _$PerformanceMetricsImpl instance) =>
    <String, dynamic>{
      'memoryUsageMB': instance.memoryUsageMB,
      'cpuUsagePercent': instance.cpuUsagePercent,
      'responseTimeMs': instance.responseTimeMs,
      'frameRate': instance.frameRate,
      'networkRequestsPerMinute': instance.networkRequestsPerMinute,
      'batteryDrainPercentPerHour': instance.batteryDrainPercentPerHour,
      'timestamp': instance.timestamp.toIso8601String(),
    };
