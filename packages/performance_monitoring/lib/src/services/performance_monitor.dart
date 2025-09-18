import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import '../models/performance_metric.dart';
import 'metrics_collector.dart';
import 'alert_manager.dart';
import '../realtime/realtime_monitor.dart';

/// Production-ready performance monitoring service
class PerformanceMonitor {
  static final PerformanceMonitor _instance = PerformanceMonitor._internal();
  factory PerformanceMonitor() => _instance;
  PerformanceMonitor._internal();

  static final Logger _logger = Logger();
  static final Uuid _uuid = const Uuid();
  
  // Core services
  late MetricsCollector _metricsCollector;
  late AlertManager _alertManager;
  late RealtimeMonitor _realtimeMonitor;
  
  // Performance tracking
  final Map<String, Trace> _activeTraces = {};
  final Map<String, HttpMetric> _activeHttpMetrics = {};
  
  // Configuration
  bool _isInitialized = false;
  bool _isEnabled = true;
  Duration _collectionInterval = const Duration(seconds: 30);
  
  // Streams
  final StreamController<PerformanceMetric> _metricController = 
      StreamController.broadcast();
  final StreamController<PerformanceSnapshot> _snapshotController = 
      StreamController.broadcast();

  /// Initialize the performance monitoring system
  Future<void> initialize({
    bool enableFirebase = true,
    bool enableRealtime = true,
    Duration? collectionInterval,
  }) async {
    if (_isInitialized) return;

    _logger.i('Initializing Performance Monitor...');
    
    // Initialize core services
    _metricsCollector = MetricsCollector();
    _alertManager = AlertManager();
    
    if (enableRealtime) {
      _realtimeMonitor = RealtimeMonitor();
      await _realtimeMonitor.initialize();
    }
    
    // Set collection interval
    if (collectionInterval != null) {
      _collectionInterval = collectionInterval;
    }
    
    // Initialize Firebase Performance if enabled
    if (enableFirebase && !kIsWeb) {
      await _initializeFirebasePerformance();
    }
    
    // Start metrics collection
    _startMetricsCollection();
    
    _isInitialized = true;
    _logger.i('Performance Monitor initialized successfully');
  }

  /// Initialize Firebase Performance monitoring
  Future<void> _initializeFirebasePerformance() async {
    try {
      final performance = FirebasePerformance.instance;
      await performance.setPerformanceCollectionEnabled(true);
      _logger.i('Firebase Performance initialized');
    } catch (e) {
      _logger.e('Failed to initialize Firebase Performance: $e');
    }
  }

  /// Start collecting performance metrics
  void _startMetricsCollection() {
    Timer.periodic(_collectionInterval, (timer) {
      if (_isEnabled) {
        _collectMetrics();
      }
    });
  }

  /// Collect current performance metrics
  Future<void> _collectMetrics() async {
    try {
      final metrics = await _metricsCollector.collectAllMetrics();
      
      // Process each metric
      for (final metric in metrics) {
        _metricController.add(metric);
        
        // Check for alerts
        await _alertManager.checkMetric(metric);
        
        // Send to realtime monitor
        if (_realtimeMonitor.isConnected) {
          await _realtimeMonitor.sendMetric(metric);
        }
      }
      
      // Create snapshot
      final snapshot = PerformanceSnapshot(
        timestamp: DateTime.now(),
        metrics: metrics,
        deviceId: await _getDeviceId(),
        appVersion: await _getAppVersion(),
        deviceInfo: await _getDeviceInfo(),
      );
      
      _snapshotController.add(snapshot);
      
    } catch (e) {
      _logger.e('Error collecting metrics: $e');
      await FirebaseCrashlytics.instance.recordError(e, null);
    }
  }

  /// Start tracking a performance trace
  Future<void> startTrace(String traceName) async {
    if (!_isEnabled) return;
    
    try {
      final trace = FirebasePerformance.instance.newTrace(traceName);
      await trace.start();
      _activeTraces[traceName] = trace;
      _logger.d('Started trace: $traceName');
    } catch (e) {
      _logger.e('Failed to start trace $traceName: $e');
    }
  }

  /// Stop tracking a performance trace
  Future<void> stopTrace(String traceName) async {
    if (!_isEnabled) return;
    
    try {
      final trace = _activeTraces.remove(traceName);
      if (trace != null) {
        await trace.stop();
        _logger.d('Stopped trace: $traceName');
      }
    } catch (e) {
      _logger.e('Failed to stop trace $traceName: $e');
    }
  }

  /// Track app startup time
  Future<void> trackAppStartup(Duration duration) async {
    final metric = PerformanceMetric(
      name: 'App Startup',
      value: duration.inMilliseconds.toDouble(),
      unit: 'ms',
      threshold: PerformanceThresholds.appStartupWarning,
      timestamp: DateTime.now(),
      category: 'performance',
      status: _getMetricStatus(duration.inMilliseconds.toDouble(), 
          PerformanceThresholds.appStartupWarning, 
          PerformanceThresholds.appStartupCritical),
    );
    
    _metricController.add(metric);
    await _alertManager.checkMetric(metric);
  }

  /// Track AI response time
  Future<void> trackAIResponse(Duration duration, String model) async {
    final metric = PerformanceMetric(
      name: 'AI Response ($model)',
      value: duration.inMilliseconds.toDouble(),
      unit: 'ms',
      threshold: PerformanceThresholds.aiResponseWarning,
      timestamp: DateTime.now(),
      category: 'ai',
      metadata: {'model': model},
      status: _getMetricStatus(duration.inMilliseconds.toDouble(), 
          PerformanceThresholds.aiResponseWarning, 
          PerformanceThresholds.aiResponseCritical),
    );
    
    _metricController.add(metric);
    await _alertManager.checkMetric(metric);
  }

  /// Track memory usage
  Future<void> trackMemoryUsage(int bytes) async {
    final mb = bytes / (1024 * 1024);
    final metric = PerformanceMetric(
      name: 'Memory Usage',
      value: mb,
      unit: 'MB',
      threshold: PerformanceThresholds.memoryWarning,
      timestamp: DateTime.now(),
      category: 'memory',
      status: _getMetricStatus(mb, 
          PerformanceThresholds.memoryWarning, 
          PerformanceThresholds.memoryCritical),
    );
    
    _metricController.add(metric);
    await _alertManager.checkMetric(metric);
  }

  /// Track network request
  Future<void> trackNetworkRequest(
    String url,
    String method,
    int statusCode,
    Duration duration,
  ) async {
    final metric = PerformanceMetric(
      name: 'Network Request',
      value: duration.inMilliseconds.toDouble(),
      unit: 'ms',
      threshold: PerformanceThresholds.networkLatencyWarning,
      timestamp: DateTime.now(),
      category: 'network',
      metadata: {
        'url': url,
        'method': method,
        'statusCode': statusCode,
      },
      status: _getMetricStatus(duration.inMilliseconds.toDouble(), 
          PerformanceThresholds.networkLatencyWarning, 
          PerformanceThresholds.networkLatencyCritical),
    );
    
    _metricController.add(metric);
    await _alertManager.checkMetric(metric);
  }

  /// Get metric status based on value and thresholds
  MetricStatus _getMetricStatus(double value, double warning, double critical) {
    if (value >= critical) return MetricStatus.critical;
    if (value >= warning) return MetricStatus.warning;
    return MetricStatus.normal;
  }

  /// Get device ID
  Future<String> _getDeviceId() async {
    // In a real implementation, you'd get this from device info
    return _uuid.v4();
  }

  /// Get app version
  Future<String> _getAppVersion() async {
    // In a real implementation, you'd get this from package info
    return '1.0.0';
  }

  /// Get device information
  Future<Map<String, dynamic>> _getDeviceInfo() async {
    return {
      'platform': Platform.operatingSystem,
      'version': Platform.operatingSystemVersion,
      'isWeb': kIsWeb,
    };
  }

  /// Enable/disable monitoring
  void setEnabled(bool enabled) {
    _isEnabled = enabled;
    _logger.i('Performance monitoring ${enabled ? 'enabled' : 'disabled'}');
  }

  /// Get metric stream
  Stream<PerformanceMetric> get metricStream => _metricController.stream;

  /// Get snapshot stream
  Stream<PerformanceSnapshot> get snapshotStream => _snapshotController.stream;

  /// Get current metrics
  Future<List<PerformanceMetric>> getCurrentMetrics() async {
    return await _metricsCollector.collectAllMetrics();
  }

  /// Dispose resources
  void dispose() {
    _metricController.close();
    _snapshotController.close();
    _realtimeMonitor.dispose();
  }
}
