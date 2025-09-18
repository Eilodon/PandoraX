import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';

/// Real-time Performance Monitoring Service
/// Tracks app performance metrics in real-time
class PerformanceMonitor {
  static final PerformanceMonitor _instance = PerformanceMonitor._internal();
  factory PerformanceMonitor() => _instance;
  PerformanceMonitor._internal();

  // Performance metrics
  final Map<String, dynamic> _metrics = {};
  final List<PerformanceEvent> _events = [];
  Timer? _monitoringTimer;
  bool _isMonitoring = false;

  // Stream controllers for real-time updates
  final StreamController<Map<String, dynamic>> _metricsController = 
      StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<PerformanceEvent> _eventsController = 
      StreamController<PerformanceEvent>.broadcast();

  // Getters
  Map<String, dynamic> get currentMetrics => Map.unmodifiable(_metrics);
  List<PerformanceEvent> get recentEvents => List.unmodifiable(_events);
  Stream<Map<String, dynamic>> get metricsStream => _metricsController.stream;
  Stream<PerformanceEvent> get eventsStream => _eventsController.stream;
  bool get isMonitoring => _isMonitoring;

  /// Start real-time performance monitoring
  Future<void> startMonitoring() async {
    if (_isMonitoring) return;

    _isMonitoring = true;
    _initializeMetrics();
    
    // Start periodic monitoring
    _monitoringTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateMetrics();
    });

    // Monitor app lifecycle
    _monitorAppLifecycle();
    
    // Monitor memory usage
    _monitorMemoryUsage();
    
    // Monitor network performance
    _monitorNetworkPerformance();
    
    // Monitor AI performance
    _monitorAIPerformance();

    _addEvent(PerformanceEvent(
      type: PerformanceEventType.monitoringStarted,
      message: 'Performance monitoring started',
      timestamp: DateTime.now(),
      data: {'status': 'active'}
    ));
  }

  /// Stop performance monitoring
  void stopMonitoring() {
    if (!_isMonitoring) return;

    _isMonitoring = false;
    _monitoringTimer?.cancel();
    _monitoringTimer = null;

    _addEvent(PerformanceEvent(
      type: PerformanceEventType.monitoringStopped,
      message: 'Performance monitoring stopped',
      timestamp: DateTime.now(),
      data: {'status': 'inactive'}
    ));
  }

  /// Initialize performance metrics
  void _initializeMetrics() {
    _metrics.clear();
    _metrics.addAll({
      'app_start_time': DateTime.now().millisecondsSinceEpoch,
      'memory_usage': 0.0,
      'memory_peak': 0.0,
      'cpu_usage': 0.0,
      'battery_level': 0.0,
      'network_latency': 0.0,
      'ai_response_time': 0.0,
      'ui_fps': 60.0,
      'frame_drops': 0,
      'crash_count': 0,
      'error_count': 0,
      'session_duration': 0.0,
      'user_interactions': 0,
      'api_calls': 0,
      'cache_hits': 0,
      'cache_misses': 0,
    });
  }

  /// Update performance metrics
  void _updateMetrics() {
    if (!_isMonitoring) return;

    // Update session duration
    final startTime = _metrics['app_start_time'] as int;
    _metrics['session_duration'] = 
        (DateTime.now().millisecondsSinceEpoch - startTime) / 1000.0;

    // Update memory usage
    _updateMemoryMetrics();
    
    // Update CPU usage
    _updateCPUMetrics();
    
    // Update battery level
    _updateBatteryMetrics();
    
    // Update UI performance
    _updateUIMetrics();

    // Emit updated metrics
    _metricsController.add(Map.unmodifiable(_metrics));
  }

  /// Update memory metrics
  void _updateMemoryMetrics() {
    try {
      // Get memory usage (simplified for demo)
      final memoryUsage = _getMemoryUsage();
      _metrics['memory_usage'] = memoryUsage;
      
      if (memoryUsage > (_metrics['memory_peak'] as double)) {
        _metrics['memory_peak'] = memoryUsage;
      }

      // Check for memory warnings
      if (memoryUsage > 100) { // 100MB threshold
        _addEvent(PerformanceEvent(
          type: PerformanceEventType.memoryWarning,
          message: 'High memory usage detected',
          timestamp: DateTime.now(),
          data: {'memory_usage': memoryUsage, 'threshold': 100}
        ));
      }
    } catch (e) {
      _addEvent(PerformanceEvent(
        type: PerformanceEventType.error,
        message: 'Failed to update memory metrics',
        timestamp: DateTime.now(),
        data: {'error': e.toString()}
      ));
    }
  }

  /// Get current memory usage
  double _getMemoryUsage() {
    // Simplified memory usage calculation
    // In a real implementation, you would use platform channels
    return Random().nextDouble() * 150; // Simulated 0-150MB
  }

  /// Update CPU metrics
  void _updateCPUMetrics() {
    try {
      // Simulated CPU usage
      final cpuUsage = Random().nextDouble() * 100;
      _metrics['cpu_usage'] = cpuUsage;

      if (cpuUsage > 80) {
        _addEvent(PerformanceEvent(
          type: PerformanceEventType.cpuWarning,
          message: 'High CPU usage detected',
          timestamp: DateTime.now(),
          data: {'cpu_usage': cpuUsage, 'threshold': 80}
        ));
      }
    } catch (e) {
      _addEvent(PerformanceEvent(
        type: PerformanceEventType.error,
        message: 'Failed to update CPU metrics',
        timestamp: DateTime.now(),
        data: {'error': e.toString()}
      ));
    }
  }

  /// Update battery metrics
  void _updateBatteryMetrics() {
    try {
      // Simulated battery level
      final batteryLevel = Random().nextDouble() * 100;
      _metrics['battery_level'] = batteryLevel;

      if (batteryLevel < 20) {
        _addEvent(PerformanceEvent(
          type: PerformanceEventType.batteryWarning,
          message: 'Low battery detected',
          timestamp: DateTime.now(),
          data: {'battery_level': batteryLevel, 'threshold': 20}
        ));
      }
    } catch (e) {
      _addEvent(PerformanceEvent(
        type: PerformanceEventType.error,
        message: 'Failed to update battery metrics',
        timestamp: DateTime.now(),
        data: {'error': e.toString()}
      ));
    }
  }

  /// Update UI performance metrics
  void _updateUIMetrics() {
    try {
      // Simulated FPS monitoring
      final fps = 60 - Random().nextInt(10);
      _metrics['ui_fps'] = fps.toDouble();

      if (fps < 30) {
        _metrics['frame_drops'] = (_metrics['frame_drops'] as int) + 1;
        _addEvent(PerformanceEvent(
          type: PerformanceEventType.frameDrop,
          message: 'Frame drop detected',
          timestamp: DateTime.now(),
          data: {'fps': fps, 'frame_drops': _metrics['frame_drops']}
        ));
      }
    } catch (e) {
      _addEvent(PerformanceEvent(
        type: PerformanceEventType.error,
        message: 'Failed to update UI metrics',
        timestamp: DateTime.now(),
        data: {'error': e.toString()}
      ));
    }
  }

  /// Monitor app lifecycle
  void _monitorAppLifecycle() {
    // This would be implemented with AppLifecycleListener
    // For demo purposes, we'll simulate lifecycle events
  }

  /// Monitor memory usage
  void _monitorMemoryUsage() {
    // This would be implemented with platform channels
    // For demo purposes, we'll simulate memory monitoring
  }

  /// Monitor network performance
  void _monitorNetworkPerformance() {
    // This would be implemented with connectivity monitoring
    // For demo purposes, we'll simulate network monitoring
  }

  /// Monitor AI performance
  void _monitorAIPerformance() {
    // This would be implemented with AI service monitoring
    // For demo purposes, we'll simulate AI monitoring
  }

  /// Record AI response time
  void recordAIResponseTime(Duration responseTime) {
    _metrics['ai_response_time'] = responseTime.inMilliseconds.toDouble();
    
    _addEvent(PerformanceEvent(
      type: PerformanceEventType.aiResponse,
      message: 'AI response recorded',
      timestamp: DateTime.now(),
      data: {'response_time_ms': responseTime.inMilliseconds}
    ));
  }

  /// Record user interaction
  void recordUserInteraction(String interactionType) {
    _metrics['user_interactions'] = (_metrics['user_interactions'] as int) + 1;
    
    _addEvent(PerformanceEvent(
      type: PerformanceEventType.userInteraction,
      message: 'User interaction recorded',
      timestamp: DateTime.now(),
      data: {'interaction_type': interactionType}
    ));
  }

  /// Record API call
  void recordAPICall(String endpoint, Duration duration, bool success) {
    _metrics['api_calls'] = (_metrics['api_calls'] as int) + 1;
    
    _addEvent(PerformanceEvent(
      type: PerformanceEventType.apiCall,
      message: 'API call recorded',
      timestamp: DateTime.now(),
      data: {
        'endpoint': endpoint,
        'duration_ms': duration.inMilliseconds,
        'success': success
      }
    ));
  }

  /// Record error
  void recordError(String errorType, String message, Map<String, dynamic>? context) {
    _metrics['error_count'] = (_metrics['error_count'] as int) + 1;
    
    _addEvent(PerformanceEvent(
      type: PerformanceEventType.error,
      message: 'Error recorded',
      timestamp: DateTime.now(),
      data: {
        'error_type': errorType,
        'message': message,
        'context': context ?? {}
      }
    ));
  }

  /// Record crash
  void recordCrash(String crashType, String message, Map<String, dynamic>? context) {
    _metrics['crash_count'] = (_metrics['crash_count'] as int) + 1;
    
    _addEvent(PerformanceEvent(
      type: PerformanceEventType.crash,
      message: 'Crash recorded',
      timestamp: DateTime.now(),
      data: {
        'crash_type': crashType,
        'message': message,
        'context': context ?? {}
      }
    ));
  }

  /// Add performance event
  void _addEvent(PerformanceEvent event) {
    _events.add(event);
    
    // Keep only last 1000 events
    if (_events.length > 1000) {
      _events.removeAt(0);
    }
    
    _eventsController.add(event);
  }

  /// Get performance summary
  Map<String, dynamic> getPerformanceSummary() {
    return {
      'session_duration': _metrics['session_duration'],
      'memory_peak': _metrics['memory_peak'],
      'cpu_peak': _metrics['cpu_usage'],
      'ai_avg_response_time': _metrics['ai_response_time'],
      'ui_avg_fps': _metrics['ui_fps'],
      'frame_drops': _metrics['frame_drops'],
      'errors': _metrics['error_count'],
      'crashes': _metrics['crash_count'],
      'user_interactions': _metrics['user_interactions'],
      'api_calls': _metrics['api_calls'],
      'events_count': _events.length,
    };
  }

  /// Dispose resources
  void dispose() {
    stopMonitoring();
    _metricsController.close();
    _eventsController.close();
  }
}

/// Performance event types
enum PerformanceEventType {
  monitoringStarted,
  monitoringStopped,
  memoryWarning,
  cpuWarning,
  batteryWarning,
  frameDrop,
  aiResponse,
  userInteraction,
  apiCall,
  error,
  crash,
}

/// Performance event data class
class PerformanceEvent {
  final PerformanceEventType type;
  final String message;
  final DateTime timestamp;
  final Map<String, dynamic> data;

  PerformanceEvent({
    required this.type,
    required this.message,
    required this.timestamp,
    required this.data,
  });

  Map<String, dynamic> toJson() => {
    'type': type.name,
    'message': message,
    'timestamp': timestamp.toIso8601String(),
    'data': data,
  };
}
