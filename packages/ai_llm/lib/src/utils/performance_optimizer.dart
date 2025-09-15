import 'dart:async';
import 'dart:collection';
import 'dart:isolate';
import 'package:flutter/foundation.dart';

/// Performance optimizer for AI system
class PerformanceOptimizer {
  static final PerformanceOptimizer _instance = PerformanceOptimizer._internal();
  factory PerformanceOptimizer() => _instance;
  PerformanceOptimizer._internal();

  // Performance metrics
  final Map<String, PerformanceMetric> _metrics = {};
  final Queue<PerformanceEvent> _eventQueue = Queue<PerformanceEvent>();
  Timer? _cleanupTimer;
  Timer? _reportTimer;

  // Configuration
  static const int _maxMetrics = 1000;
  static const Duration _cleanupInterval = Duration(minutes: 5);
  static const Duration _reportInterval = Duration(minutes: 1);

  /// Initialize performance monitoring
  void initialize() {
    _cleanupTimer = Timer.periodic(_cleanupInterval, (_) => _cleanupOldMetrics());
    _reportTimer = Timer.periodic(_reportInterval, (_) => _generateReport());
  }

  /// Dispose resources
  void dispose() {
    _cleanupTimer?.cancel();
    _reportTimer?.cancel();
    _metrics.clear();
    _eventQueue.clear();
  }

  /// Start timing an operation
  PerformanceTimer startTimer(String operation) {
    return PerformanceTimer(operation, this);
  }

  /// Record a performance metric
  void recordMetric(String operation, Duration duration, {Map<String, dynamic>? metadata}) {
    final event = PerformanceEvent(
      operation: operation,
      duration: duration,
      timestamp: DateTime.now(),
      metadata: metadata ?? {},
    );

    _eventQueue.add(event);
    _updateMetric(operation, duration);
  }

  /// Record memory usage
  void recordMemoryUsage(String context, int bytes) {
    recordMetric('memory_usage', Duration.zero, metadata: {
      'context': context,
      'bytes': bytes,
      'mb': bytes / (1024 * 1024),
    });
  }

  /// Record AI response metrics
  void recordAIResponse(String model, Duration duration, int tokenCount, bool isOnDevice) {
    recordMetric('ai_response', duration, metadata: {
      'model': model,
      'tokens': tokenCount,
      'is_on_device': isOnDevice,
      'tokens_per_second': tokenCount / duration.inMilliseconds * 1000,
    });
  }

  /// Record model loading metrics
  void recordModelLoading(String model, Duration duration, int sizeBytes) {
    recordMetric('model_loading', duration, metadata: {
      'model': model,
      'size_bytes': sizeBytes,
      'size_mb': sizeBytes / (1024 * 1024),
      'mb_per_second': (sizeBytes / (1024 * 1024)) / (duration.inMilliseconds / 1000),
    });
  }

  /// Record network metrics
  void recordNetworkOperation(String operation, Duration duration, int bytesTransferred) {
    recordMetric('network_operation', duration, metadata: {
      'operation': operation,
      'bytes_transferred': bytesTransferred,
      'mb_per_second': (bytesTransferred / (1024 * 1024)) / (duration.inMilliseconds / 1000),
    });
  }

  /// Get performance report
  PerformanceReport getReport() {
    final now = DateTime.now();
    final recentEvents = _eventQueue.where((e) => 
        now.difference(e.timestamp).inMinutes < 10).toList();

    return PerformanceReport(
      totalOperations: _metrics.length,
      recentEvents: recentEvents.length,
      averageLatency: _calculateAverageLatency(),
      slowestOperation: _findSlowestOperation(),
      fastestOperation: _findFastestOperation(),
      memoryUsage: _calculateMemoryUsage(),
      recommendations: _generateRecommendations(),
      timestamp: now,
    );
  }

  /// Get metrics for specific operation
  PerformanceMetric? getMetric(String operation) {
    return _metrics[operation];
  }

  /// Get all metrics
  Map<String, PerformanceMetric> getAllMetrics() {
    return Map.unmodifiable(_metrics);
  }

  /// Clear all metrics
  void clearMetrics() {
    _metrics.clear();
    _eventQueue.clear();
  }

  /// Export metrics for analysis
  Map<String, dynamic> exportMetrics() {
    return {
      'metrics': _metrics.map((key, value) => MapEntry(key, value.toJson())),
      'recent_events': _eventQueue.map((e) => e.toJson()).toList(),
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  // Private methods

  void _updateMetric(String operation, Duration duration) {
    if (_metrics.containsKey(operation)) {
      _metrics[operation]!.addSample(duration);
    } else {
      _metrics[operation] = PerformanceMetric(operation, duration);
    }

    // Limit number of metrics
    if (_metrics.length > _maxMetrics) {
      final oldestKey = _metrics.keys.first;
      _metrics.remove(oldestKey);
    }
  }

  Duration _calculateAverageLatency() {
    if (_metrics.isEmpty) return Duration.zero;

    final totalDuration = _metrics.values
        .map((m) => m.averageLatency)
        .reduce((a, b) => a + b);

    return Duration(
      milliseconds: (totalDuration.inMilliseconds / _metrics.length).round(),
    );
  }

  String? _findSlowestOperation() {
    if (_metrics.isEmpty) return null;

    return _metrics.entries
        .reduce((a, b) => a.value.averageLatency > b.value.averageLatency ? a : b)
        .key;
  }

  String? _findFastestOperation() {
    if (_metrics.isEmpty) return null;

    return _metrics.entries
        .reduce((a, b) => a.value.averageLatency < b.value.averageLatency ? a : b)
        .key;
  }

  int _calculateMemoryUsage() {
    return _eventQueue
        .where((e) => e.operation == 'memory_usage')
        .map((e) => e.metadata['bytes'] as int? ?? 0)
        .fold(0, (a, b) => a + b);
  }

  List<String> _generateRecommendations() {
    final recommendations = <String>[];

    // Check for slow operations
    final slowOperations = _metrics.entries
        .where((e) => e.value.averageLatency.inMilliseconds > 5000)
        .map((e) => e.key)
        .toList();

    if (slowOperations.isNotEmpty) {
      recommendations.add('Consider optimizing slow operations: ${slowOperations.join(', ')}');
    }

    // Check for high memory usage
    final memoryUsage = _calculateMemoryUsage();
    if (memoryUsage > 100 * 1024 * 1024) { // 100MB
      recommendations.add('High memory usage detected. Consider implementing memory management.');
    }

    // Check for frequent operations
    final frequentOperations = _metrics.entries
        .where((e) => e.value.sampleCount > 100)
        .map((e) => e.key)
        .toList();

    if (frequentOperations.isNotEmpty) {
      recommendations.add('Consider caching for frequent operations: ${frequentOperations.join(', ')}');
    }

    return recommendations;
  }

  void _cleanupOldMetrics() {
    final cutoff = DateTime.now().subtract(const Duration(hours: 1));
    _eventQueue.removeWhere((e) => e.timestamp.isBefore(cutoff));

    // Remove metrics with no recent activity
    final keysToRemove = _metrics.entries
        .where((e) => e.value.lastActivity.isBefore(cutoff))
        .map((e) => e.key)
        .toList();

    for (final key in keysToRemove) {
      _metrics.remove(key);
    }
  }

  void _generateReport() {
    if (kDebugMode) {
      final report = getReport();
      print('Performance Report: ${report.totalOperations} operations, '
            'avg latency: ${report.averageLatency.inMilliseconds}ms');
    }
  }
}

/// Performance timer for measuring operation duration
class PerformanceTimer {
  final String operation;
  final PerformanceOptimizer optimizer;
  final Stopwatch _stopwatch;

  PerformanceTimer(this.operation, this.optimizer) : _stopwatch = Stopwatch()..start();

  /// Stop timing and record the metric
  void stop({Map<String, dynamic>? metadata}) {
    _stopwatch.stop();
    optimizer.recordMetric(operation, _stopwatch.elapsed, metadata: metadata);
  }

  /// Get elapsed time without stopping
  Duration get elapsed => _stopwatch.elapsed;
}

/// Performance metric for tracking operation statistics
class PerformanceMetric {
  final String operation;
  final List<Duration> _samples = [];
  DateTime _lastActivity;

  PerformanceMetric(this.operation, Duration initialSample) : _lastActivity = DateTime.now() {
    _samples.add(initialSample);
  }

  void addSample(Duration sample) {
    _samples.add(sample);
    _lastActivity = DateTime.now();
  }

  int get sampleCount => _samples.length;

  Duration get averageLatency {
    if (_samples.isEmpty) return Duration.zero;
    
    final totalMs = _samples.map((d) => d.inMilliseconds).reduce((a, b) => a + b);
    return Duration(milliseconds: totalMs ~/ _samples.length);
  }

  Duration get minLatency {
    if (_samples.isEmpty) return Duration.zero;
    return _samples.reduce((a, b) => a < b ? a : b);
  }

  Duration get maxLatency {
    if (_samples.isEmpty) return Duration.zero;
    return _samples.reduce((a, b) => a > b ? a : b);
  }

  Duration get p95Latency {
    if (_samples.isEmpty) return Duration.zero;
    
    final sorted = List<Duration>.from(_samples)..sort();
    final index = (sorted.length * 0.95).floor();
    return sorted[index];
  }

  DateTime get lastActivity => _lastActivity;

  Map<String, dynamic> toJson() {
    return {
      'operation': operation,
      'sample_count': sampleCount,
      'average_latency_ms': averageLatency.inMilliseconds,
      'min_latency_ms': minLatency.inMilliseconds,
      'max_latency_ms': maxLatency.inMilliseconds,
      'p95_latency_ms': p95Latency.inMilliseconds,
      'last_activity': _lastActivity.toIso8601String(),
    };
  }
}

/// Performance event for detailed tracking
class PerformanceEvent {
  final String operation;
  final Duration duration;
  final DateTime timestamp;
  final Map<String, dynamic> metadata;

  const PerformanceEvent({
    required this.operation,
    required this.duration,
    required this.timestamp,
    required this.metadata,
  });

  Map<String, dynamic> toJson() {
    return {
      'operation': operation,
      'duration_ms': duration.inMilliseconds,
      'timestamp': timestamp.toIso8601String(),
      'metadata': metadata,
    };
  }
}

/// Performance report with aggregated statistics
class PerformanceReport {
  final int totalOperations;
  final int recentEvents;
  final Duration averageLatency;
  final String? slowestOperation;
  final String? fastestOperation;
  final int memoryUsage;
  final List<String> recommendations;
  final DateTime timestamp;

  const PerformanceReport({
    required this.totalOperations,
    required this.recentEvents,
    required this.averageLatency,
    this.slowestOperation,
    this.fastestOperation,
    required this.memoryUsage,
    required this.recommendations,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'total_operations': totalOperations,
      'recent_events': recentEvents,
      'average_latency_ms': averageLatency.inMilliseconds,
      'slowest_operation': slowestOperation,
      'fastest_operation': fastestOperation,
      'memory_usage_bytes': memoryUsage,
      'memory_usage_mb': memoryUsage / (1024 * 1024),
      'recommendations': recommendations,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
