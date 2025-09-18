import 'dart:async';
import 'package:flutter/foundation.dart';
import 'performance_monitor.dart';
import 'error_recovery_service.dart';
import 'user_analytics_service.dart';

/// Centralized Monitoring Service
/// Coordinates all monitoring, error recovery, and analytics services
class MonitoringService {
  static final MonitoringService _instance = MonitoringService._internal();
  factory MonitoringService() => _instance;
  MonitoringService._internal();

  // Services
  final PerformanceMonitor _performanceMonitor = PerformanceMonitor();
  final ErrorRecoveryService _errorService = ErrorRecoveryService();
  final UserAnalyticsService _analyticsService = UserAnalyticsService();

  // State
  bool _isInitialized = false;
  Timer? _healthCheckTimer;

  // Getters
  bool get isInitialized => _isInitialized;
  PerformanceMonitor get performanceMonitor => _performanceMonitor;
  ErrorRecoveryService get errorService => _errorService;
  UserAnalyticsService get analyticsService => _analyticsService;

  /// Initialize all monitoring services
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Initialize all services
      await _performanceMonitor.startMonitoring();
      await _errorService.initialize();
      await _analyticsService.initialize();

      // Start health check
      _startHealthCheck();

      _isInitialized = true;
      
      // Track initialization
      _analyticsService.trackEvent(
        UserEventType.appLaunch,
        {'monitoring_initialized': true},
      );

      if (kDebugMode) {
        print('✅ MonitoringService initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Failed to initialize MonitoringService: $e');
      }
      rethrow;
    }
  }

  /// Start periodic health check
  void _startHealthCheck() {
    _healthCheckTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      _performHealthCheck();
    });
  }

  /// Perform health check
  void _performHealthCheck() {
    try {
      // Check performance metrics
      final metrics = _performanceMonitor.currentMetrics;
      final memoryUsage = metrics['memory_usage'] as double? ?? 0;
      final cpuUsage = metrics['cpu_usage'] as double? ?? 0;

      // Check for critical issues
      if (memoryUsage > 200) { // 200MB threshold
        _errorService.handleError(
          ErrorType.memory,
          'Critical memory usage detected',
          Exception('Memory usage: ${memoryUsage}MB'),
          null,
          context: {'memory_usage': memoryUsage},
        );
      }

      if (cpuUsage > 90) { // 90% CPU threshold
        _errorService.handleError(
          ErrorType.platform,
          'Critical CPU usage detected',
          Exception('CPU usage: ${cpuUsage}%'),
          null,
          context: {'cpu_usage': cpuUsage},
        );
      }

      // Track health check
      _analyticsService.trackPerformance('health_check', 1.0);

    } catch (e) {
      if (kDebugMode) {
        print('❌ Health check failed: $e');
      }
    }
  }

  /// Track user interaction
  void trackUserInteraction(String interactionType, {
    String? elementId,
    String? elementType,
    Map<String, dynamic>? properties,
  }) {
    _analyticsService.trackUserInteraction(
      interactionType,
      elementId: elementId,
      elementType: elementType,
      properties: properties,
    );

    _performanceMonitor.recordUserInteraction(interactionType);
  }

  /// Track screen view
  void trackScreenView(String screenName, {Map<String, dynamic>? properties}) {
    _analyticsService.trackScreenView(screenName, properties: properties);
  }

  /// Track feature usage
  void trackFeatureUsage(String featureName, {
    String? action,
    Map<String, dynamic>? properties,
  }) {
    _analyticsService.trackFeatureUsage(featureName, action: action, properties: properties);
  }

  /// Track AI interaction
  void trackAIInteraction(String aiType, String action, {
    Duration? responseTime,
    bool? success,
    Map<String, dynamic>? properties,
  }) {
    _analyticsService.trackAIInteraction(aiType, action,
      responseTime: responseTime,
      success: success,
      properties: properties,
    );

    if (responseTime != null) {
      _performanceMonitor.recordAIResponseTime(responseTime);
    }
  }

  /// Track error
  void trackError(String errorType, String errorMessage, {
    String? screen,
    Map<String, dynamic>? properties,
  }) {
    _analyticsService.trackError(errorType, errorMessage,
      screen: screen,
      properties: properties,
    );

    // Determine error type for error service
    ErrorType type = ErrorType.unknown;
    switch (errorType.toLowerCase()) {
      case 'network':
        type = ErrorType.network;
        break;
      case 'ai':
      case 'ai_service':
        type = ErrorType.aiService;
        break;
      case 'database':
        type = ErrorType.database;
        break;
      case 'memory':
        type = ErrorType.memory;
        break;
      case 'ui':
        type = ErrorType.ui;
        break;
      case 'platform':
        type = ErrorType.platform;
        break;
    }

    _errorService.handleError(
      type,
      errorMessage,
      Exception(errorMessage),
      null,
      context: properties,
    );
  }

  /// Track performance metric
  void trackPerformance(String metricName, double value, {
    String? unit,
    Map<String, dynamic>? properties,
  }) {
    _analyticsService.trackPerformance(metricName, value,
      unit: unit,
      properties: properties,
    );
  }

  /// Get comprehensive monitoring report
  Map<String, dynamic> getMonitoringReport() {
    return {
      'performance': {
        'metrics': _performanceMonitor.currentMetrics,
        'summary': _performanceMonitor.getPerformanceSummary(),
        'events_count': _performanceMonitor.recentEvents.length,
      },
      'errors': {
        'statistics': _errorService.getErrorStatistics(),
        'recent_errors': _errorService.errorHistory.take(10).map((e) => e.toJson()).toList(),
      },
      'analytics': {
        'summary': _analyticsService.getUserAnalyticsSummary(),
        'events_count': _analyticsService.events.length,
        'feature_usage': _analyticsService.featureUsage,
      },
      'health_status': {
        'is_initialized': _isInitialized,
        'uptime': _performanceMonitor.currentMetrics['session_duration'],
        'memory_usage': _performanceMonitor.currentMetrics['memory_usage'],
        'cpu_usage': _performanceMonitor.currentMetrics['cpu_usage'],
      },
    };
  }

  /// Export all monitoring data
  String exportMonitoringData() {
    return _analyticsService.exportAnalyticsData();
  }

  /// Clear all monitoring data
  void clearMonitoringData() {
    _analyticsService.clearAnalyticsData();
    _errorService.clearErrorHistory();
    // Note: Performance monitor doesn't have clear method
  }

  /// Dispose all services
  void dispose() {
    _healthCheckTimer?.cancel();
    _performanceMonitor.dispose();
    _errorService.dispose();
    _analyticsService.dispose();
    _isInitialized = false;
  }
}
