import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_sample.freezed.dart';
part 'health_sample.g.dart';

@freezed
class HealthSample with _$HealthSample {
  const factory HealthSample({
    required bool success,
    required int latencyMs,
    required DateTime timestamp,
    String? error,
    Map<String, dynamic>? metadata,
  }) = _HealthSample;

  factory HealthSample.fromJson(Map<String, dynamic> json) => _$HealthSampleFromJson(json);

  const HealthSample._();

  factory HealthSample.success(int latencyMs) => HealthSample(
    success: true,
    latencyMs: latencyMs,
    timestamp: DateTime.now(),
  );

  factory HealthSample.failure(int latencyMs, String error) => HealthSample(
    success: false,
    latencyMs: latencyMs,
    timestamp: DateTime.now(),
    error: error,
  );
}
