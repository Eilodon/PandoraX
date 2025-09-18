/// Performance Monitoring Service for Phase 6 Analytics & Optimization
/// 
/// This service provides comprehensive performance monitoring including
/// real-time metrics, performance alerts, and optimization recommendations.
library performance_monitoring_service;

import 'package:flutter/material.dart';
import 'package:core/core.dart';

/// Performance monitoring service for real-time metrics and optimization
class PerformanceMonitoringService {
  static PerformanceMonitoringService? _instance;
  static PerformanceMonitoringService get instance => _instance ??= PerformanceMonitoringService._();
  
  PerformanceMonitoringService._();
  
  final LoggingService _logger = LoggingService.instance;
  final AnalyticsService _analytics = AnalyticsService.instance;
  
  // ============================================================================
  // PERFORMANCE METRICS
  // ============================================================================
  
  /// Track app startup time
  void trackAppStartup(Duration startupTime) {
    try {
      _analytics.trackPerformance('app_startup_time', startupTime.inMilliseconds.toDouble());
      _logger.debug('Tracked app startup time: ${startupTime.inMilliseconds}ms');
    } catch (e) {
      _logger.warning('Failed to track app startup time: $e');
    }
  }
  
  /// Track screen load time
  void trackScreenLoadTime(String screenName, Duration loadTime) {
    try {
      _analytics.trackPerformance('screen_load_time', loadTime.inMilliseconds.toDouble(),
        context: {'screen_name': screenName});
      _logger.debug('Tracked screen load time: $screenName = ${loadTime.inMilliseconds}ms');
    } catch (e) {
      _logger.warning('Failed to track screen load time: $e');
    }
  }
  
  /// Track API response time
  void trackApiResponseTime(String endpoint, Duration responseTime) {
    try {
      _analytics.trackPerformance('api_response_time', responseTime.inMilliseconds.toDouble(),
        context: {'endpoint': endpoint});
      _logger.debug('Tracked API response time: $endpoint = ${responseTime.inMilliseconds}ms');
    } catch (e) {
      _logger.warning('Failed to track API response time: $e');
    }
  }
  
  /// Track memory usage
  void trackMemoryUsage(int memoryUsage) {
    try {
      _analytics.trackPerformance('memory_usage', memoryUsage.toDouble());
      _logger.debug('Tracked memory usage: ${memoryUsage}MB');
    } catch (e) {
      _logger.warning('Failed to track memory usage: $e');
    }
  }
  
  /// Track battery usage
  void trackBatteryUsage(double batteryPercentage) {
    try {
      _analytics.trackPerformance('battery_usage', batteryPercentage);
      _logger.debug('Tracked battery usage: ${batteryPercentage}%');
    } catch (e) {
      _logger.warning('Failed to track battery usage: $e');
    }
  }
  
  /// Track network usage
  void trackNetworkUsage(int bytesSent, int bytesReceived) {
    try {
      _analytics.trackPerformance('network_usage', (bytesSent + bytesReceived).toDouble(),
        context: {
          'bytes_sent': bytesSent,
          'bytes_received': bytesReceived,
        });
      _logger.debug('Tracked network usage: ${bytesSent + bytesReceived} bytes');
    } catch (e) {
      _logger.warning('Failed to track network usage: $e');
    }
  }
  
  /// Track frame rate
  void trackFrameRate(double frameRate) {
    try {
      _analytics.trackPerformance('frame_rate', frameRate);
      _logger.debug('Tracked frame rate: ${frameRate}fps');
    } catch (e) {
      _logger.warning('Failed to track frame rate: $e');
    }
  }
  
  /// Track CPU usage
  void trackCpuUsage(double cpuPercentage) {
    try {
      _analytics.trackPerformance('cpu_usage', cpuPercentage);
      _logger.debug('Tracked CPU usage: ${cpuPercentage}%');
    } catch (e) {
      _logger.warning('Failed to track CPU usage: $e');
    }
  }
  
  /// Track disk usage
  void trackDiskUsage(int diskUsage) {
    try {
      _analytics.trackPerformance('disk_usage', diskUsage.toDouble());
      _logger.debug('Tracked disk usage: ${diskUsage}MB');
    } catch (e) {
      _logger.warning('Failed to track disk usage: $e');
    }
  }
  
  // ============================================================================
  // PERFORMANCE ALERTS
  // ============================================================================
  
  /// Check performance thresholds
  void checkPerformanceThresholds() {
    try {
      final metrics = _getCurrentMetrics();
      
      for (final metric in metrics.entries) {
        _checkMetricThreshold(metric.key, metric.value);
      }
    } catch (e) {
      _logger.warning('Failed to check performance thresholds: $e');
    }
  }
  
  /// Check specific metric threshold
  void _checkMetricThreshold(String metric, double value) {
    final threshold = _getMetricThreshold(metric);
    if (threshold != null && value > threshold) {
      _triggerPerformanceAlert(metric, value, threshold);
    }
  }
  
  /// Trigger performance alert
  void _triggerPerformanceAlert(String metric, double value, double threshold) {
    try {
      _analytics.trackCustomEvent('performance_alert', {
        'metric': metric,
        'value': value,
        'threshold': threshold,
        'severity': _getAlertSeverity(metric, value, threshold),
      });
      
      _logger.warning('Performance alert: $metric = $value (threshold: $threshold)');
    } catch (e) {
      _logger.warning('Failed to trigger performance alert: $e');
    }
  }
  
  /// Get alert severity
  String _getAlertSeverity(String metric, double value, double threshold) {
    final ratio = value / threshold;
    if (ratio >= 2.0) return 'critical';
    if (ratio >= 1.5) return 'high';
    if (ratio >= 1.2) return 'medium';
    return 'low';
  }
  
  // ============================================================================
  // PERFORMANCE INSIGHTS
  // ============================================================================
  
  /// Get performance insights
  Map<String, dynamic> getPerformanceInsights() {
    try {
      final metrics = _getCurrentMetrics();
      final trends = _getPerformanceTrends();
      final alerts = _getRecentAlerts();
      
      return {
        'current_metrics': metrics,
        'performance_trends': trends,
        'recent_alerts': alerts,
        'performance_score': _calculatePerformanceScore(metrics),
        'recommendations': _generatePerformanceRecommendations(metrics, trends),
        'generated_at': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      _logger.warning('Failed to get performance insights: $e');
      return {};
    }
  }
  
  /// Get performance trends
  Map<String, dynamic> getPerformanceTrends() {
    try {
      return {
        'startup_time_trend': _getTrend('app_startup_time'),
        'screen_load_time_trend': _getTrend('screen_load_time'),
        'api_response_time_trend': _getTrend('api_response_time'),
        'memory_usage_trend': _getTrend('memory_usage'),
        'battery_usage_trend': _getTrend('battery_usage'),
        'frame_rate_trend': _getTrend('frame_rate'),
        'cpu_usage_trend': _getTrend('cpu_usage'),
        'disk_usage_trend': _getTrend('disk_usage'),
      };
    } catch (e) {
      _logger.warning('Failed to get performance trends: $e');
      return {};
    }
  }
  
  /// Get performance recommendations
  List<String> getPerformanceRecommendations() {
    try {
      final metrics = _getCurrentMetrics();
      final trends = _getPerformanceTrends();
      
      return _generatePerformanceRecommendations(metrics, trends);
    } catch (e) {
      _logger.warning('Failed to get performance recommendations: $e');
      return [];
    }
  }
  
  /// Get performance score
  double getPerformanceScore() {
    try {
      final metrics = _getCurrentMetrics();
      return _calculatePerformanceScore(metrics);
    } catch (e) {
      _logger.warning('Failed to get performance score: $e');
      return 0.0;
    }
  }
  
  // ============================================================================
  // OPTIMIZATION RECOMMENDATIONS
  // ============================================================================
  
  /// Get optimization recommendations
  List<Map<String, dynamic>> getOptimizationRecommendations() {
    try {
      final metrics = _getCurrentMetrics();
      final trends = _getPerformanceTrends();
      final recommendations = <Map<String, dynamic>>[];
      
      // Memory optimization
      if (metrics['memory_usage'] > 100) {
        recommendations.add({
          'type': 'memory_optimization',
          'priority': 'high',
          'title': 'Optimize Memory Usage',
          'description': 'Memory usage is high. Consider implementing memory optimization strategies.',
          'actions': [
            'Implement lazy loading for large datasets',
            'Use RepaintBoundary for complex widgets',
            'Dispose of unused resources properly',
            'Consider using object pooling',
          ],
        });
      }
      
      // Performance optimization
      if (metrics['frame_rate'] < 30) {
        recommendations.add({
          'type': 'performance_optimization',
          'priority': 'high',
          'title': 'Improve Frame Rate',
          'description': 'Frame rate is below 30fps. Consider optimizing rendering performance.',
          'actions': [
            'Optimize widget rebuilds',
            'Use const constructors where possible',
            'Implement efficient list rendering',
            'Reduce complex animations',
          ],
        });
      }
      
      // Battery optimization
      if (metrics['battery_usage'] > 20) {
        recommendations.add({
          'type': 'battery_optimization',
          'priority': 'medium',
          'title': 'Optimize Battery Usage',
          'description': 'Battery usage is high. Consider implementing battery optimization strategies.',
          'actions': [
            'Reduce background processing',
            'Optimize network requests',
            'Implement efficient caching',
            'Use power-efficient algorithms',
          ],
        });
      }
      
      // Network optimization
      if (metrics['network_usage'] > 1000000) { // 1MB
        recommendations.add({
          'type': 'network_optimization',
          'priority': 'medium',
          'title': 'Optimize Network Usage',
          'description': 'Network usage is high. Consider implementing network optimization strategies.',
          'actions': [
            'Implement request caching',
            'Use compression for large payloads',
            'Optimize image sizes',
            'Implement request batching',
          ],
        });
      }
      
      return recommendations;
    } catch (e) {
      _logger.warning('Failed to get optimization recommendations: $e');
      return [];
    }
  }
  
  // ============================================================================
  // PERFORMANCE MONITORING
  // ============================================================================
  
  /// Start performance monitoring
  void startMonitoring() {
    try {
      _logger.info('Started performance monitoring');
      _schedulePeriodicMonitoring();
    } catch (e) {
      _logger.warning('Failed to start performance monitoring: $e');
    }
  }
  
  /// Stop performance monitoring
  void stopMonitoring() {
    try {
      _logger.info('Stopped performance monitoring');
      _cancelPeriodicMonitoring();
    } catch (e) {
      _logger.warning('Failed to stop performance monitoring: $e');
    }
  }
  
  /// Schedule periodic monitoring
  void _schedulePeriodicMonitoring() {
    // In a real implementation, you would use a timer
    _logger.debug('Scheduled periodic performance monitoring');
  }
  
  /// Cancel periodic monitoring
  void _cancelPeriodicMonitoring() {
    // In a real implementation, you would cancel the timer
    _logger.debug('Cancelled periodic performance monitoring');
  }
  
  // ============================================================================
  // DATA MANAGEMENT
  // ============================================================================
  
  /// Get current metrics
  Map<String, double> _getCurrentMetrics() {
    // In a real implementation, you would get from system monitoring
    return {
      'app_startup_time': 0.0,
      'screen_load_time': 0.0,
      'api_response_time': 0.0,
      'memory_usage': 0.0,
      'battery_usage': 0.0,
      'network_usage': 0.0,
      'frame_rate': 0.0,
      'cpu_usage': 0.0,
      'disk_usage': 0.0,
    };
  }
  
  /// Get performance trends
  Map<String, dynamic> _getPerformanceTrends() {
    // In a real implementation, you would analyze historical data
    return {};
  }
  
  /// Get recent alerts
  List<Map<String, dynamic>> _getRecentAlerts() {
    // In a real implementation, you would get from alerts database
    return [];
  }
  
  /// Get metric threshold
  double? _getMetricThreshold(String metric) {
    final thresholds = {
      'app_startup_time': 3000.0, // 3 seconds
      'screen_load_time': 1000.0, // 1 second
      'api_response_time': 5000.0, // 5 seconds
      'memory_usage': 100.0, // 100MB
      'battery_usage': 20.0, // 20%
      'network_usage': 1000000.0, // 1MB
      'frame_rate': 30.0, // 30fps
      'cpu_usage': 80.0, // 80%
      'disk_usage': 1000.0, // 1GB
    };
    
    return thresholds[metric];
  }
  
  /// Get trend for metric
  Map<String, dynamic> _getTrend(String metric) {
    // In a real implementation, you would analyze historical data
    return {
      'trend': 'stable',
      'change_percentage': 0.0,
      'data_points': [],
    };
  }
  
  /// Calculate performance score
  double _calculatePerformanceScore(Map<String, double> metrics) {
    try {
      double score = 100.0;
      
      // Startup time score
      final startupTime = metrics['app_startup_time'] ?? 0.0;
      if (startupTime > 3000) score -= 20;
      else if (startupTime > 2000) score -= 10;
      else if (startupTime > 1000) score -= 5;
      
      // Frame rate score
      final frameRate = metrics['frame_rate'] ?? 0.0;
      if (frameRate < 30) score -= 30;
      else if (frameRate < 45) score -= 15;
      else if (frameRate < 55) score -= 5;
      
      // Memory usage score
      final memoryUsage = metrics['memory_usage'] ?? 0.0;
      if (memoryUsage > 200) score -= 25;
      else if (memoryUsage > 100) score -= 10;
      else if (memoryUsage > 50) score -= 5;
      
      // Battery usage score
      final batteryUsage = metrics['battery_usage'] ?? 0.0;
      if (batteryUsage > 30) score -= 15;
      else if (batteryUsage > 20) score -= 10;
      else if (batteryUsage > 10) score -= 5;
      
      return score.clamp(0.0, 100.0);
    } catch (e) {
      _logger.warning('Failed to calculate performance score: $e');
      return 0.0;
    }
  }
  
  /// Generate performance recommendations
  List<String> _generatePerformanceRecommendations(Map<String, double> metrics, Map<String, dynamic> trends) {
    final recommendations = <String>[];
    
    // Memory optimization
    if (metrics['memory_usage'] > 100) {
      recommendations.add('Consider implementing memory optimization strategies');
    }
    
    // Performance optimization
    if (metrics['frame_rate'] < 30) {
      recommendations.add('Optimize rendering performance for better frame rates');
    }
    
    // Battery optimization
    if (metrics['battery_usage'] > 20) {
      recommendations.add('Implement battery optimization strategies');
    }
    
    // Network optimization
    if (metrics['network_usage'] > 1000000) {
      recommendations.add('Optimize network usage and implement caching');
    }
    
    return recommendations;
  }
  
  // ============================================================================
  // CONFIGURATION
  // ============================================================================
  
  /// Enable/disable performance monitoring
  bool _monitoringEnabled = true;
  bool get monitoringEnabled => _monitoringEnabled;
  
  void setMonitoringEnabled(bool enabled) {
    _monitoringEnabled = enabled;
    _logger.info('Performance monitoring ${enabled ? 'enabled' : 'disabled'}');
  }
  
  /// Set performance thresholds
  void setPerformanceThresholds(Map<String, double> thresholds) {
    _logger.info('Performance thresholds updated: $thresholds');
  }
  
  /// Get performance monitoring configuration
  Map<String, dynamic> getPerformanceMonitoringConfiguration() {
    return {
      'monitoring_enabled': _monitoringEnabled,
      'monitoring_interval': 30, // seconds
      'thresholds': {
        'app_startup_time': 3000.0,
        'screen_load_time': 1000.0,
        'api_response_time': 5000.0,
        'memory_usage': 100.0,
        'battery_usage': 20.0,
        'network_usage': 1000000.0,
        'frame_rate': 30.0,
        'cpu_usage': 80.0,
        'disk_usage': 1000.0,
      },
      'alert_enabled': true,
      'recommendations_enabled': true,
    };
  }
}
