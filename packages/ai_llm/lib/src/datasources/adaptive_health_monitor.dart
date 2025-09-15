import 'dart:collection';
import '../models/health_sample.dart';

/// Health monitor interface
abstract class HealthMonitor {
  void record(bool success, int latencyMs);
  HealthSnapshot snapshot();
  void clear();
  bool get isHealthy;
}

/// Adaptive health monitor that tracks model performance over time
class AdaptiveHealthMonitor implements HealthMonitor {
  final Queue<HealthSample> _samples = Queue<HealthSample>();
  final int _windowSize;
  final Duration _maxAge;
  final double _successThreshold;
  final int _minSamples;

  AdaptiveHealthMonitor({
    int windowSize = 100,
    Duration maxAge = const Duration(hours: 1),
    double successThreshold = 0.8,
    int minSamples = 5,
  }) : _windowSize = windowSize,
       _maxAge = maxAge,
       _successThreshold = successThreshold,
       _minSamples = minSamples;

  @override
  void record(bool success, int latencyMs) {
    final sample = success 
        ? HealthSample.success(latencyMs)
        : HealthSample.failure(latencyMs, 'Unknown error');
    
    _samples.add(sample);
    _cleanupOldSamples();
    _trimToWindowSize();
  }

  @override
  HealthSnapshot snapshot() {
    if (_samples.isEmpty) {
      return HealthSnapshot(
        successRate: 1.0,
        p50LatencyMs: 0,
        p95LatencyMs: 0,
        totalSamples: 0,
        isHealthy: true,
      );
    }

    final validSamples = _samples.toList();
    final successRate = validSamples.where((s) => s.success).length / validSamples.length;
    
    final latencies = validSamples.map((s) => s.latencyMs).toList()..sort();
    final p50Latency = _percentile(latencies, 0.5);
    final p95Latency = _percentile(latencies, 0.95);
    
    final isHealthy = successRate >= _successThreshold && 
                     validSamples.length >= _minSamples;

    return HealthSnapshot(
      successRate: successRate,
      p50LatencyMs: p50Latency,
      p95LatencyMs: p95Latency,
      totalSamples: validSamples.length,
      isHealthy: isHealthy,
    );
  }

  /// Get recent error samples for debugging
  List<HealthSample> getRecentErrors({int limit = 10}) {
    return _samples
        .where((s) => !s.success)
        .take(limit)
        .toList()
        .reversed
        .toList();
  }

  /// Get performance trend over time
  PerformanceTrend getTrend() {
    if (_samples.length < 10) {
      return PerformanceTrend.stable;
    }

    final recent = _samples.take(10).toList();
    final older = _samples.skip(10).take(10).toList();
    
    if (older.isEmpty) return PerformanceTrend.stable;

    final recentSuccessRate = recent.where((s) => s.success).length / recent.length;
    final olderSuccessRate = older.where((s) => s.success).length / older.length;
    
    final recentLatency = recent.map((s) => s.latencyMs).reduce((a, b) => a + b) / recent.length;
    final olderLatency = older.map((s) => s.latencyMs).reduce((a, b) => a + b) / older.length;

    if (recentSuccessRate > olderSuccessRate + 0.1) {
      return PerformanceTrend.improving;
    } else if (recentSuccessRate < olderSuccessRate - 0.1) {
      return PerformanceTrend.declining;
    } else if (recentLatency > olderLatency * 1.2) {
      return PerformanceTrend.slowing;
    } else if (recentLatency < olderLatency * 0.8) {
      return PerformanceTrend.speeding;
    }

    return PerformanceTrend.stable;
  }

  /// Reset all samples
  void reset() {
    _samples.clear();
  }

  @override
  void clear() {
    _samples.clear();
  }

  @override
  bool get isHealthy {
    final snap = snapshot();
    return snap.isHealthy;
  }

  /// Get detailed health report
  HealthReport getDetailedReport() {
    final snapshot = this.snapshot();
    final trend = getTrend();
    final recentErrors = getRecentErrors(limit: 5);
    
    return HealthReport(
      snapshot: snapshot,
      trend: trend,
      recentErrors: recentErrors,
      recommendations: _generateRecommendations(snapshot, trend),
    );
  }

  void _cleanupOldSamples() {
    final cutoff = DateTime.now().subtract(_maxAge);
    while (_samples.isNotEmpty && _samples.first.timestamp.isBefore(cutoff)) {
      _samples.removeFirst();
    }
  }

  void _trimToWindowSize() {
    while (_samples.length > _windowSize) {
      _samples.removeFirst();
    }
  }

  int _percentile(List<int> sortedList, double percentile) {
    if (sortedList.isEmpty) return 0;
    
    final index = (sortedList.length - 1) * percentile;
    final lower = sortedList[index.floor()];
    final upper = sortedList[index.ceil()];
    
    return ((upper - lower) * (index - index.floor()) + lower).round();
  }

  List<String> _generateRecommendations(HealthSnapshot snapshot, PerformanceTrend trend) {
    final recommendations = <String>[];
    
    if (!snapshot.isHealthy) {
      if (snapshot.successRate < _successThreshold) {
        recommendations.add('Model reliability is low. Consider switching to cloud service.');
      }
      if (snapshot.totalSamples < _minSamples) {
        recommendations.add('Insufficient data for reliable health assessment.');
      }
    }
    
    if (snapshot.p95LatencyMs > 5000) {
      recommendations.add('Response times are slow. Consider using a smaller model.');
    }
    
    switch (trend) {
      case PerformanceTrend.declining:
        recommendations.add('Performance is declining. Monitor for potential issues.');
        break;
      case PerformanceTrend.slowing:
        recommendations.add('Response times are increasing. Check system resources.');
        break;
      case PerformanceTrend.improving:
        recommendations.add('Performance is improving. Current settings are optimal.');
        break;
      case PerformanceTrend.speeding:
        recommendations.add('Response times are improving. System is performing well.');
        break;
      case PerformanceTrend.stable:
        recommendations.add('Performance is stable. No immediate action needed.');
        break;
    }
    
    return recommendations;
  }
}

/// Performance trend over time
enum PerformanceTrend {
  improving,
  declining,
  speeding,
  slowing,
  stable,
}

/// Detailed health report
class HealthReport {
  final HealthSnapshot snapshot;
  final PerformanceTrend trend;
  final List<HealthSample> recentErrors;
  final List<String> recommendations;

  const HealthReport({
    required this.snapshot,
    required this.trend,
    required this.recentErrors,
    required this.recommendations,
  });
}

/// Enhanced health snapshot with additional metrics
class HealthSnapshot {
  final double successRate;
  final int p50LatencyMs;
  final int p95LatencyMs;
  final int totalSamples;
  final bool isHealthy;

  const HealthSnapshot({
    required this.successRate,
    required this.p50LatencyMs,
    required this.p95LatencyMs,
    required this.totalSamples,
    required this.isHealthy,
  });

  @override
  String toString() {
    return 'HealthSnapshot(successRate: ${(successRate * 100).toStringAsFixed(1)}%, '
           'p50: ${p50LatencyMs}ms, p95: ${p95LatencyMs}ms, '
           'samples: $totalSamples, healthy: $isHealthy)';
  }
}
