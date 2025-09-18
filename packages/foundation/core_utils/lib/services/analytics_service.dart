import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:core_utils/core_utils.dart';

/// Service for analytics and performance monitoring
class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  late SharedPreferences _prefs;
  final List<Map<String, dynamic>> _eventQueue = [];
  final List<Map<String, dynamic>> _performanceQueue = [];
  Timer? _flushTimer;
  bool _isInitialized = false;

  /// Initialize analytics service
  Future<void> initialize() async {
    try {
      AppLogger.info('Initializing Analytics Service...');
      
      _prefs = await SharedPreferences.getInstance();
      
      // Start periodic flush timer (every 30 seconds)
      _flushTimer = Timer.periodic(const Duration(seconds: 30), (_) {
        _flushEvents();
      });
      
      _isInitialized = true;
      AppLogger.success('Analytics Service initialized successfully');
    } catch (e) {
      AppLogger.error('Failed to initialize Analytics Service', e);
    }
  }

  /// Track user event
  void trackEvent(String eventName, Map<String, dynamic> parameters) {
    if (!_isInitialized) {
      AppLogger.warning('Analytics Service not initialized');
      return;
    }

    try {
      final event = {
        'event_name': eventName,
        'parameters': parameters,
        'timestamp': DateTime.now().toIso8601String(),
        'session_id': _getSessionId(),
      };

      _eventQueue.add(event);
      AppLogger.info('Event tracked: $eventName');
    } catch (e) {
      AppLogger.error('Failed to track event: $eventName', e);
    }
  }

  /// Track performance metric
  void trackPerformance(String operation, Duration duration, {Map<String, dynamic>? metadata}) {
    if (!_isInitialized) {
      AppLogger.warning('Analytics Service not initialized');
      return;
    }

    try {
      final performance = {
        'operation': operation,
        'duration_ms': duration.inMilliseconds,
        'metadata': metadata ?? {},
        'timestamp': DateTime.now().toIso8601String(),
        'session_id': _getSessionId(),
      };

      _performanceQueue.add(performance);
      AppLogger.info('Performance tracked: $operation (${duration.inMilliseconds}ms)');
    } catch (e) {
      AppLogger.error('Failed to track performance: $operation', e);
    }
  }

  /// Track error
  void trackError(String errorType, String errorMessage, StackTrace? stackTrace, {Map<String, dynamic>? context}) {
    if (!_isInitialized) {
      AppLogger.warning('Analytics Service not initialized');
      return;
    }

    try {
      final error = {
        'error_type': errorType,
        'error_message': errorMessage,
        'stack_trace': stackTrace?.toString(),
        'context': context ?? {},
        'timestamp': DateTime.now().toIso8601String(),
        'session_id': _getSessionId(),
      };

      _eventQueue.add({
        'event_name': 'error_occurred',
        'parameters': error,
        'timestamp': DateTime.now().toIso8601String(),
        'session_id': _getSessionId(),
      });

      AppLogger.error('Error tracked: $errorType - $errorMessage');
    } catch (e) {
      AppLogger.error('Failed to track error: $errorType', e);
    }
  }

  /// Track user action
  void trackUserAction(String action, {Map<String, dynamic>? parameters}) {
    trackEvent('user_action', {
      'action': action,
      ...?parameters,
    });
  }

  /// Track screen view
  void trackScreenView(String screenName, {Map<String, dynamic>? parameters}) {
    trackEvent('screen_view', {
      'screen_name': screenName,
      ...?parameters,
    });
  }

  /// Track feature usage
  void trackFeatureUsage(String featureName, {Map<String, dynamic>? parameters}) {
    trackEvent('feature_usage', {
      'feature_name': featureName,
      ...?parameters,
    });
  }

  /// Track app lifecycle events
  void trackAppLifecycle(String lifecycleState) {
    trackEvent('app_lifecycle', {
      'lifecycle_state': lifecycleState,
    });
  }

  /// Get session ID
  String _getSessionId() {
    final sessionId = _prefs.getString('analytics_session_id');
    if (sessionId == null) {
      final newSessionId = DateTime.now().millisecondsSinceEpoch.toString();
      _prefs.setString('analytics_session_id', newSessionId);
      return newSessionId;
    }
    return sessionId;
  }

  /// Flush events to storage
  Future<void> _flushEvents() async {
    if (_eventQueue.isEmpty && _performanceQueue.isEmpty) {
      return;
    }

    try {
      // Get existing events
      final existingEvents = _prefs.getStringList('analytics_events') ?? [];
      final existingPerformance = _prefs.getStringList('analytics_performance') ?? [];

      // Add new events
      final allEvents = [
        ...existingEvents,
        ..._eventQueue.map((e) => jsonEncode(e)),
      ];
      final allPerformance = [
        ...existingPerformance,
        ..._performanceQueue.map((p) => jsonEncode(p)),
      ];

      // Save to storage
      await _prefs.setStringList('analytics_events', allEvents);
      await _prefs.setStringList('analytics_performance', allPerformance);

      // Clear queues
      _eventQueue.clear();
      _performanceQueue.clear();

      AppLogger.info('Analytics events flushed to storage');
    } catch (e) {
      AppLogger.error('Failed to flush analytics events', e);
    }
  }

  /// Get analytics data
  Future<Map<String, dynamic>> getAnalyticsData() async {
    try {
      final events = _prefs.getStringList('analytics_events') ?? [];
      final performance = _prefs.getStringList('analytics_performance') ?? [];

      return {
        'events': events.map((e) => jsonDecode(e)).toList(),
        'performance': performance.map((p) => jsonDecode(p)).toList(),
        'total_events': events.length,
        'total_performance_metrics': performance.length,
      };
    } catch (e) {
      AppLogger.error('Failed to get analytics data', e);
      return {};
    }
  }

  /// Clear analytics data
  Future<void> clearAnalyticsData() async {
    try {
      await _prefs.remove('analytics_events');
      await _prefs.remove('analytics_performance');
      await _prefs.remove('analytics_session_id');
      _eventQueue.clear();
      _performanceQueue.clear();
      AppLogger.info('Analytics data cleared');
    } catch (e) {
      AppLogger.error('Failed to clear analytics data', e);
    }
  }

  /// Force flush events
  Future<void> forceFlush() async {
    await _flushEvents();
  }

  /// Dispose resources
  void dispose() {
    _flushTimer?.cancel();
    _flushTimer = null;
    _isInitialized = false;
  }
}
