import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../models/performance_metric.dart';

/// Collects various performance metrics from the system
class MetricsCollector {
  static final Logger _logger = Logger();

  /// Collect all available metrics
  Future<List<PerformanceMetric>> collectAllMetrics() async {
    final metrics = <PerformanceMetric>[];
    
    try {
      // Collect system metrics
      metrics.addAll(await _collectSystemMetrics());
      
      // Collect memory metrics
      metrics.addAll(await _collectMemoryMetrics());
      
      // Collect network metrics
      metrics.addAll(await _collectNetworkMetrics());
      
      // Collect UI metrics
      metrics.addAll(await _collectUIMetrics());
      
    } catch (e) {
      _logger.e('Error collecting metrics: $e');
    }
    
    return metrics;
  }

  /// Collect system performance metrics
  Future<List<PerformanceMetric>> _collectSystemMetrics() async {
    final metrics = <PerformanceMetric>[];
    
    try {
      // CPU usage (simplified)
      final cpuUsage = await _getCPUUsage();
      metrics.add(PerformanceMetric(
        name: 'CPU Usage',
        value: cpuUsage,
        unit: '%',
        threshold: 80.0,
        timestamp: DateTime.now(),
        category: 'performance',
        status: _getStatus(cpuUsage, 80.0, 95.0),
      ));
      
      // Battery level (if available)
      if (!kIsWeb) {
        final batteryLevel = await _getBatteryLevel();
        if (batteryLevel != null) {
          metrics.add(PerformanceMetric(
            name: 'Battery Level',
            value: batteryLevel,
            unit: '%',
            threshold: 20.0,
            timestamp: DateTime.now(),
            category: 'battery',
            status: _getStatus(batteryLevel, 20.0, 10.0),
          ));
        }
      }
      
    } catch (e) {
      _logger.e('Error collecting system metrics: $e');
    }
    
    return metrics;
  }

  /// Collect memory-related metrics
  Future<List<PerformanceMetric>> _collectMemoryMetrics() async {
    final metrics = <PerformanceMetric>[];
    
    try {
      // Memory usage
      final memoryInfo = await _getMemoryInfo();
      if (memoryInfo != null) {
        metrics.add(PerformanceMetric(
          name: 'Memory Usage',
          value: memoryInfo['used'] / (1024 * 1024), // Convert to MB
          unit: 'MB',
          threshold: 100.0,
          timestamp: DateTime.now(),
          category: 'memory',
          status: _getStatus(memoryInfo['used'] / (1024 * 1024), 100.0, 200.0),
        ));
        
        metrics.add(PerformanceMetric(
          name: 'Memory Available',
          value: memoryInfo['available'] / (1024 * 1024), // Convert to MB
          unit: 'MB',
          threshold: 50.0,
          timestamp: DateTime.now(),
          category: 'memory',
          status: _getStatus(memoryInfo['available'] / (1024 * 1024), 50.0, 20.0),
        ));
      }
      
    } catch (e) {
      _logger.e('Error collecting memory metrics: $e');
    }
    
    return metrics;
  }

  /// Collect network-related metrics
  Future<List<PerformanceMetric>> _collectNetworkMetrics() async {
    final metrics = <PerformanceMetric>[];
    
    try {
      // Network connectivity
      final isConnected = await _isNetworkConnected();
      metrics.add(PerformanceMetric(
        name: 'Network Connected',
        value: isConnected ? 1.0 : 0.0,
        unit: 'boolean',
        threshold: 1.0,
        timestamp: DateTime.now(),
        category: 'network',
        status: isConnected ? MetricStatus.normal : MetricStatus.critical,
      ));
      
      // Network latency (simplified)
      final latency = await _getNetworkLatency();
      if (latency != null) {
        metrics.add(PerformanceMetric(
          name: 'Network Latency',
          value: latency,
          unit: 'ms',
          threshold: 1000.0,
          timestamp: DateTime.now(),
          category: 'network',
          status: _getStatus(latency, 1000.0, 3000.0),
        ));
      }
      
    } catch (e) {
      _logger.e('Error collecting network metrics: $e');
    }
    
    return metrics;
  }

  /// Collect UI-related metrics
  Future<List<PerformanceMetric>> _collectUIMetrics() async {
    final metrics = <PerformanceMetric>[];
    
    try {
      // Frame rate (simplified)
      final frameRate = await _getFrameRate();
      metrics.add(PerformanceMetric(
        name: 'Frame Rate',
        value: frameRate,
        unit: 'fps',
        threshold: 30.0,
        timestamp: DateTime.now(),
        category: 'ui',
        status: _getStatus(frameRate, 30.0, 15.0),
      ));
      
    } catch (e) {
      _logger.e('Error collecting UI metrics: $e');
    }
    
    return metrics;
  }

  /// Get CPU usage percentage
  Future<double> _getCPUUsage() async {
    try {
      // This is a simplified implementation
      // In a real app, you'd use platform-specific APIs
      return 25.0; // Placeholder
    } catch (e) {
      _logger.e('Error getting CPU usage: $e');
      return 0.0;
    }
  }

  /// Get battery level percentage
  Future<double?> _getBatteryLevel() async {
    try {
      // This would require platform-specific implementation
      // For now, return null to indicate not available
      return null;
    } catch (e) {
      _logger.e('Error getting battery level: $e');
      return null;
    }
  }

  /// Get memory information
  Future<Map<String, int>?> _getMemoryInfo() async {
    try {
      // This is a simplified implementation
      // In a real app, you'd use platform-specific APIs
      return {
        'total': 8 * 1024 * 1024 * 1024, // 8GB
        'used': 2 * 1024 * 1024 * 1024,  // 2GB
        'available': 6 * 1024 * 1024 * 1024, // 6GB
      };
    } catch (e) {
      _logger.e('Error getting memory info: $e');
      return null;
    }
  }

  /// Check if network is connected
  Future<bool> _isNetworkConnected() async {
    try {
      // This is a simplified implementation
      // In a real app, you'd use connectivity_plus package
      return true; // Placeholder
    } catch (e) {
      _logger.e('Error checking network connectivity: $e');
      return false;
    }
  }

  /// Get network latency
  Future<double?> _getNetworkLatency() async {
    try {
      // This is a simplified implementation
      // In a real app, you'd ping a server
      return 50.0; // Placeholder
    } catch (e) {
      _logger.e('Error getting network latency: $e');
      return null;
    }
  }

  /// Get current frame rate
  Future<double> _getFrameRate() async {
    try {
      // This is a simplified implementation
      // In a real app, you'd use Flutter's frame rate monitoring
      return 60.0; // Placeholder
    } catch (e) {
      _logger.e('Error getting frame rate: $e');
      return 0.0;
    }
  }

  /// Get metric status based on value and thresholds
  MetricStatus _getStatus(double value, double warning, double critical) {
    if (value >= critical) return MetricStatus.critical;
    if (value >= warning) return MetricStatus.warning;
    return MetricStatus.normal;
  }
}
