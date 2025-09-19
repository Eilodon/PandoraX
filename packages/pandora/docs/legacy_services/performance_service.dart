import 'dart:async';
import 'dart:io';
import 'package:injectable/injectable.dart';

/// Performance monitoring service
@injectable
class PerformanceService {
  final Map<String, Stopwatch> _timers = {};
  final Map<String, List<double>> _metrics = {};
  
  /// Start timing an operation
  void startTimer(String operationName) {
    _timers[operationName] = Stopwatch()..start();
  }
  
  /// Stop timing and record the duration
  double stopTimer(String operationName) {
    final timer = _timers.remove(operationName);
    if (timer == null) return 0.0;
    
    timer.stop();
    final duration = timer.elapsedMilliseconds.toDouble();
    
    // Store metric for analysis
    _metrics.putIfAbsent(operationName, () => []).add(duration);
    
    return duration;
  }
  
  /// Record a performance metric
  void recordMetric(String metricName, double value) {
    _metrics.putIfAbsent(metricName, () => []).add(value);
  }
  
  /// Get average performance for a metric
  double getAveragePerformance(String metricName) {
    final values = _metrics[metricName];
    if (values == null || values.isEmpty) return 0.0;
    
    return values.reduce((a, b) => a + b) / values.length;
  }
  
  /// Get performance statistics
  Map<String, dynamic> getPerformanceStats() {
    final stats = <String, dynamic>{};
    
    for (final entry in _metrics.entries) {
      final values = entry.value;
      if (values.isEmpty) continue;
      
      values.sort();
      stats[entry.key] = {
        'count': values.length,
        'average': values.reduce((a, b) => a + b) / values.length,
        'min': values.first,
        'max': values.last,
        'median': values[values.length ~/ 2],
      };
    }
    
    return stats;
  }
  
  /// Monitor memory usage
  Future<Map<String, dynamic>> getMemoryUsage() async {
    try {
      final info = await ProcessInfo.currentRss;
      return {
        'rss': info,
        'rss_mb': (info / 1024 / 1024).toStringAsFixed(2),
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      return {
        'error': e.toString(),
        'timestamp': DateTime.now().toIso8601String(),
      };
    }
  }
  
  /// Monitor app startup time
  void trackAppStartup() {
    startTimer('app_startup');
  }
  
  /// Record app startup completion
  void recordAppStartupComplete() {
    final duration = stopTimer('app_startup');
    recordMetric('app_startup_time', duration);
  }
  
  /// Monitor screen load time
  void trackScreenLoad(String screenName) {
    startTimer('screen_load_$screenName');
  }
  
  /// Record screen load completion
  void recordScreenLoadComplete(String screenName) {
    final duration = stopTimer('screen_load_$screenName');
    recordMetric('screen_load_time', duration);
  }
  
  /// Monitor API call performance
  void trackApiCall(String apiName) {
    startTimer('api_call_$apiName');
  }
  
  /// Record API call completion
  void recordApiCallComplete(String apiName, {bool success = true}) {
    final duration = stopTimer('api_call_$apiName');
    recordMetric('api_call_time', duration);
    recordMetric('api_call_success', success ? 1.0 : 0.0);
  }
  
  /// Monitor database operations
  void trackDatabaseOperation(String operation) {
    startTimer('db_$operation');
  }
  
  /// Record database operation completion
  void recordDatabaseOperationComplete(String operation) {
    final duration = stopTimer('db_$operation');
    recordMetric('db_operation_time', duration);
  }
  
  /// Monitor sync operations
  void trackSyncOperation() {
    startTimer('sync_operation');
  }
  
  /// Record sync operation completion
  void recordSyncOperationComplete({bool success = true, int? notesCount}) {
    final duration = stopTimer('sync_operation');
    recordMetric('sync_time', duration);
    recordMetric('sync_success', success ? 1.0 : 0.0);
    if (notesCount != null) {
      recordMetric('sync_notes_count', notesCount.toDouble());
    }
  }
  
  /// Clear all metrics
  void clearMetrics() {
    _metrics.clear();
    _timers.clear();
  }
  
  /// Get performance report
  Map<String, dynamic> getPerformanceReport() {
    return {
      'timestamp': DateTime.now().toIso8601String(),
      'metrics': getPerformanceStats(),
      'active_timers': _timers.keys.toList(),
    };
  }
}
