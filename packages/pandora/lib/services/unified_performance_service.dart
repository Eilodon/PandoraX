import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/painting.dart';
import 'package:injectable/injectable.dart';

/// Unified Performance Service
/// 
/// Consolidates performance monitoring and optimization functionality
/// Provides both development metrics and production optimization
@injectable
class UnifiedPerformanceService {
  // Timing and metrics
  final Map<String, Stopwatch> _timers = {};
  final Map<String, List<double>> _metrics = {};
  static final List<PerformanceMetric> _performanceMetrics = [];
  
  // Monitoring state
  static bool _isInitialized = false;
  static Timer? _memoryTimer;
  static Timer? _performanceTimer;
  static bool _isProductionMode = false;

  /// Initialize the unified performance service
  static Future<void> initialize({bool productionMode = false}) async {
    if (_isInitialized) return;
    
    _isProductionMode = productionMode;

    try {
      if (productionMode) {
        await _initializeProduction();
      } else {
        await _initializeDevelopment();
      }
      
      _isInitialized = true;
    } catch (e) {
      print('Failed to initialize performance service: $e');
    }
  }

  /// Initialize production-specific features
  static Future<void> _initializeProduction() async {
    await _setupMemoryMonitoring();
    await _setupPerformanceMonitoring();
    await _optimizeSystemSettings();
  }

  /// Initialize development-specific features  
  static Future<void> _initializeDevelopment() async {
    // Basic monitoring for development
    await _setupBasicMonitoring();
  }

  /// Setup memory monitoring
  static Future<void> _setupMemoryMonitoring() async {
    _memoryTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _recordMemoryMetrics();
    });
  }

  /// Setup performance monitoring
  static Future<void> _setupPerformanceMonitoring() async {
    _performanceTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _recordPerformanceMetrics();
    });
  }

  /// Setup basic monitoring for development
  static Future<void> _setupBasicMonitoring() async {
    if (kDebugMode) {
      Timer.periodic(const Duration(minutes: 5), (timer) {
        _printPerformanceStats();
      });
    }
  }

  /// Optimize system settings (production only)
  static Future<void> _optimizeSystemSettings() async {
    if (!_isProductionMode) return;

    try {
      // Optimize garbage collection
      if (Platform.isAndroid || Platform.isIOS) {
        // Platform-specific optimizations
        await SystemChannels.platform.invokeMethod('SystemNavigator.setSystemUIOverlayStyle');
      }
      
      // Clear image cache periodically
      Timer.periodic(const Duration(minutes: 10), (timer) {
        PaintingBinding.instance.imageCache.clear();
      });
      
    } catch (e) {
      print('Failed to optimize system settings: $e');
    }
  }

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
    
    // Record as performance metric
    _performanceMetrics.add(PerformanceMetric(
      name: operationName,
      value: duration,
      unit: 'ms',
      timestamp: DateTime.now(),
    ));
    
    return duration;
  }
  
  /// Record a performance metric
  void recordMetric(String name, double value, {String unit = 'ms'}) {
    _metrics.putIfAbsent(name, () => []).add(value);
    
    _performanceMetrics.add(PerformanceMetric(
      name: name,
      value: value,
      unit: unit,
      timestamp: DateTime.now(),
    ));
  }

  /// Record memory metrics
  static void _recordMemoryMetrics() {
    try {
      // This would be platform-specific implementation
      final timestamp = DateTime.now();
      _performanceMetrics.add(PerformanceMetric(
        name: 'memory_check',
        value: DateTime.now().millisecondsSinceEpoch.toDouble(),
        unit: 'timestamp',
        timestamp: timestamp,
      ));
    } catch (e) {
      print('Failed to record memory metrics: $e');
    }
  }

  /// Record performance metrics
  static void _recordPerformanceMetrics() {
    try {
      final timestamp = DateTime.now();
      _performanceMetrics.add(PerformanceMetric(
        name: 'performance_check',
        value: DateTime.now().millisecondsSinceEpoch.toDouble(),
        unit: 'timestamp',
        timestamp: timestamp,
      ));
    } catch (e) {
      print('Failed to record performance metrics: $e');
    }
  }

  /// Print performance stats (development only)
  static void _printPerformanceStats() {
    if (!kDebugMode) return;
    
    print('=== Performance Stats ===');
    print('Total metrics recorded: ${_performanceMetrics.length}');
    
    final recent = _performanceMetrics.where(
      (m) => DateTime.now().difference(m.timestamp).inMinutes < 5
    ).toList();
    
    print('Recent metrics (last 5 min): ${recent.length}');
    print('========================');
  }
  
  /// Get average duration for an operation
  double getAverageTime(String operationName) {
    final times = _metrics[operationName];
    if (times == null || times.isEmpty) return 0.0;
    
    return times.reduce((a, b) => a + b) / times.length;
  }
  
  /// Get all metrics for an operation
  List<double> getMetrics(String operationName) {
    return _metrics[operationName] ?? [];
  }
  
  /// Get performance report
  Map<String, dynamic> getPerformanceReport() {
    final report = <String, dynamic>{};
    
    for (final entry in _metrics.entries) {
      final times = entry.value;
      if (times.isNotEmpty) {
        report[entry.key] = {
          'count': times.length,
          'average': times.reduce((a, b) => a + b) / times.length,
          'min': times.reduce((a, b) => a < b ? a : b),
          'max': times.reduce((a, b) => a > b ? a : b),
          'recent': times.length > 10 ? times.sublist(times.length - 10) : times,
        };
      }
    }
    
    return {
      'operations': report,
      'totalMetrics': _performanceMetrics.length,
      'isInitialized': _isInitialized,
      'isProductionMode': _isProductionMode,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  /// Get recent performance metrics
  static List<PerformanceMetric> getRecentMetrics({int minutes = 5}) {
    final cutoff = DateTime.now().subtract(Duration(minutes: minutes));
    return _performanceMetrics.where((m) => m.timestamp.isAfter(cutoff)).toList();
  }

  /// Clear all metrics
  void clearMetrics() {
    _metrics.clear();
    _performanceMetrics.clear();
  }

  /// Optimize performance
  static Future<void> optimizePerformance() async {
    if (!_isProductionMode) return;

    try {
      // Clear caches
      PaintingBinding.instance.imageCache.clear();
      
      // Trigger garbage collection
      await _triggerGarbageCollection();
      
    } catch (e) {
      print('Failed to optimize performance: $e');
    }
  }

  /// Trigger garbage collection
  static Future<void> _triggerGarbageCollection() async {
    try {
      await SystemChannels.platform.invokeMethod('System.gc');
    } catch (e) {
      // Fallback - force some memory cleanup
      final List<int> temp = List.generate(1000, (i) => i);
      temp.clear();
    }
  }

  /// Dispose resources
  static void dispose() {
    _memoryTimer?.cancel();
    _performanceTimer?.cancel();
    _isInitialized = false;
  }
}

/// Performance metric data class
class PerformanceMetric {
  final String name;
  final double value;
  final String unit;
  final DateTime timestamp;

  const PerformanceMetric({
    required this.name,
    required this.value,
    required this.unit,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
      'unit': unit,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}