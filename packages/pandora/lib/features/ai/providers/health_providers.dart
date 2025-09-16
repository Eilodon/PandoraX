import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/health_status.dart';

// AI Health Status Provider
final aiHealthStatusProvider = StateProvider<HealthStatusEnum>((ref) => HealthStatusEnum.healthy);

// Health Status Data Provider
final healthStatusDataProvider = StateProvider<HealthStatusData>((ref) => 
  HealthStatusData(
    isHealthy: true,
    successRate: 0.95,
    averageLatencyMs: 150,
    recommendation: 'System is running optimally',
    samples: [],
  )
);

// Health Report Provider
final healthReportProvider = StateProvider<HealthReport?>((ref) => null);

// Performance Trend Provider
final performanceTrendProvider = StateProvider<PerformanceTrend>((ref) => 
  const PerformanceTrend.stable()
);

// Health Status Data class for compatibility
class HealthStatusData {
  final bool isHealthy;
  final double successRate;
  final int averageLatencyMs;
  final String recommendation;
  final List<HealthSample> samples;

  const HealthStatusData({
    required this.isHealthy,
    required this.successRate,
    required this.averageLatencyMs,
    required this.recommendation,
    required this.samples,
  });
}
