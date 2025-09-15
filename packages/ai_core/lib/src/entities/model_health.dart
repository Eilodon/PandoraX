import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_health.freezed.dart';
part 'model_health.g.dart';

@freezed
class ModelHealth with _$ModelHealth {
  const factory ModelHealth({
    required double successRate,
    required int p50LatencyMs,
    required int p95LatencyMs,
    required int totalRequests,
    required int successfulRequests,
    required int failedRequests,
    required DateTime lastUpdated,
  }) = _ModelHealth;

  factory ModelHealth.fromJson(Map<String, dynamic> json) => _$ModelHealthFromJson(json);

  const ModelHealth._();

  factory ModelHealth.empty() => ModelHealth(
    successRate: 1.0,
    p50LatencyMs: 0,
    p95LatencyMs: 0,
    totalRequests: 0,
    successfulRequests: 0,
    failedRequests: 0,
    lastUpdated: DateTime.now(),
  );

  bool get isHealthy => successRate >= 0.8 && p95LatencyMs < 5000;
  
  String get healthStatus {
    if (successRate >= 0.9 && p95LatencyMs < 2000) return 'Excellent';
    if (successRate >= 0.8 && p95LatencyMs < 5000) return 'Good';
    if (successRate >= 0.6) return 'Fair';
    return 'Poor';
  }
}
