import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// User Analytics & Behavior Tracking Service
/// Tracks user behavior, app usage patterns, and provides insights
class UserAnalyticsService {
  static final UserAnalyticsService _instance = UserAnalyticsService._internal();
  factory UserAnalyticsService() => _instance;
  UserAnalyticsService._internal();

  // Analytics data
  final List<UserEvent> _events = [];
  final Map<String, dynamic> _userProfile = {};
  final Map<String, int> _featureUsage = {};
  final Map<String, Duration> _sessionData = {};
  
  // Stream controllers
  final StreamController<UserEvent> _eventController = 
      StreamController<UserEvent>.broadcast();
  final StreamController<Map<String, dynamic>> _insightsController = 
      StreamController<Map<String, dynamic>>.broadcast();

  // Session tracking
  DateTime? _sessionStartTime;
  String? _currentScreen;
  int _screenViews = 0;
  int _userInteractions = 0;

  // Configuration
  static const int maxEvents = 10000;
  static const Duration sessionTimeout = Duration(minutes: 30);
  static const Duration insightsInterval = Duration(minutes: 5);

  // Getters
  List<UserEvent> get events => List.unmodifiable(_events);
  Map<String, dynamic> get userProfile => Map.unmodifiable(_userProfile);
  Map<String, int> get featureUsage => Map.unmodifiable(_featureUsage);
  Stream<UserEvent> get eventStream => _eventController.stream;
  Stream<Map<String, dynamic>> get insightsStream => _insightsController.stream;

  /// Initialize analytics service
  Future<void> initialize() async {
    await _initializeUserProfile();
    _startSession();
    _startInsightsGeneration();
    
    // Track app launch
    trackEvent(UserEventType.appLaunch, {
      'timestamp': DateTime.now().toIso8601String(),
      'platform': Platform.operatingSystem,
    });
  }

  /// Initialize user profile
  Future<void> _initializeUserProfile() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      final packageInfo = await PackageInfo.fromPlatform();

      String deviceId = 'unknown';
      String deviceModel = 'unknown';
      String osVersion = 'unknown';

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
        deviceModel = '${androidInfo.brand} ${androidInfo.model}';
        osVersion = 'Android ${androidInfo.version.release}';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? 'unknown';
        deviceModel = '${iosInfo.name} ${iosInfo.model}';
        osVersion = 'iOS ${iosInfo.systemVersion}';
      }

      _userProfile.addAll({
        'device_id': deviceId,
        'device_model': deviceModel,
        'os_version': osVersion,
        'app_version': packageInfo.version,
        'build_number': packageInfo.buildNumber,
        'first_launch': DateTime.now().toIso8601String(),
        'user_type': 'new_user', // Will be updated based on behavior
        'preferred_language': Platform.localeName,
        'timezone': DateTime.now().timeZoneName,
      });
    } catch (e) {
      debugPrint('Failed to initialize user profile: $e');
    }
  }

  /// Start user session
  void _startSession() {
    _sessionStartTime = DateTime.now();
    _screenViews = 0;
    _userInteractions = 0;
    
    trackEvent(UserEventType.sessionStart, {
      'session_id': _generateSessionId(),
      'timestamp': _sessionStartTime!.toIso8601String(),
    });
  }

  /// Start insights generation
  void _startInsightsGeneration() {
    Timer.periodic(insightsInterval, (_) {
      _generateInsights();
    });
  }

  /// Track user event
  void trackEvent(UserEventType type, Map<String, dynamic> properties) {
    final event = UserEvent(
      type: type,
      properties: properties,
      timestamp: DateTime.now(),
      sessionId: _getCurrentSessionId(),
    );

    _events.add(event);
    
    // Keep only last maxEvents
    if (_events.length > maxEvents) {
      _events.removeAt(0);
    }

    // Update feature usage
    _updateFeatureUsage(type);
    
    // Update user interactions
    if (type == UserEventType.userInteraction) {
      _userInteractions++;
    }

    // Emit event
    _eventController.add(event);
  }

  /// Track screen view
  void trackScreenView(String screenName, {Map<String, dynamic>? properties}) {
    _currentScreen = screenName;
    _screenViews++;
    
    trackEvent(UserEventType.screenView, {
      'screen_name': screenName,
      'screen_views': _screenViews,
      'previous_screen': _events.isNotEmpty ? _events.last.properties['screen_name'] : null,
      ...?properties,
    });
  }

  /// Track user interaction
  void trackUserInteraction(String interactionType, {
    String? elementId,
    String? elementType,
    Map<String, dynamic>? properties,
  }) {
    _userInteractions++;
    
    trackEvent(UserEventType.userInteraction, {
      'interaction_type': interactionType,
      'element_id': elementId,
      'element_type': elementType,
      'screen': _currentScreen,
      'interaction_count': _userInteractions,
      ...?properties,
    });
  }

  /// Track feature usage
  void trackFeatureUsage(String featureName, {
    String? action,
    Map<String, dynamic>? properties,
  }) {
    trackEvent(UserEventType.featureUsage, {
      'feature_name': featureName,
      'action': action ?? 'used',
      'screen': _currentScreen,
      ...?properties,
    });
  }

  /// Track AI interaction
  void trackAIInteraction(String aiType, String action, {
    Duration? responseTime,
    bool? success,
    Map<String, dynamic>? properties,
  }) {
    trackEvent(UserEventType.aiInteraction, {
      'ai_type': aiType,
      'action': action,
      'response_time_ms': responseTime?.inMilliseconds,
      'success': success,
      'screen': _currentScreen,
      ...?properties,
    });
  }

  /// Track error
  void trackError(String errorType, String errorMessage, {
    String? screen,
    Map<String, dynamic>? properties,
  }) {
    trackEvent(UserEventType.error, {
      'error_type': errorType,
      'error_message': errorMessage,
      'screen': screen ?? _currentScreen,
      ...?properties,
    });
  }

  /// Track performance
  void trackPerformance(String metricName, double value, {
    String? unit,
    Map<String, dynamic>? properties,
  }) {
    trackEvent(UserEventType.performance, {
      'metric_name': metricName,
      'value': value,
      'unit': unit,
      'screen': _currentScreen,
      ...?properties,
    });
  }

  /// Update feature usage statistics
  void _updateFeatureUsage(UserEventType type) {
    final featureKey = type.name;
    _featureUsage[featureKey] = (_featureUsage[featureKey] ?? 0) + 1;
  }

  /// Generate user insights
  void _generateInsights() {
    final insights = <String, dynamic>{};

    // Session insights
    if (_sessionStartTime != null) {
      final sessionDuration = DateTime.now().difference(_sessionStartTime!);
      insights['session_duration_minutes'] = sessionDuration.inMinutes;
      insights['screen_views'] = _screenViews;
      insights['user_interactions'] = _userInteractions;
    }

    // Feature usage insights
    insights['most_used_feature'] = _getMostUsedFeature();
    insights['feature_usage_distribution'] = Map.from(_featureUsage);

    // User behavior insights
    insights['user_engagement_level'] = _calculateEngagementLevel();
    insights['preferred_screens'] = _getPreferredScreens();
    insights['interaction_patterns'] = _getInteractionPatterns();

    // AI usage insights
    insights['ai_usage_stats'] = _getAIUsageStats();

    // Performance insights
    insights['performance_metrics'] = _getPerformanceMetrics();

    // User type classification
    insights['user_type'] = _classifyUserType();

    _insightsController.add(insights);
  }

  /// Get most used feature
  String _getMostUsedFeature() {
    if (_featureUsage.isEmpty) return 'none';
    
    return _featureUsage.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  /// Calculate user engagement level
  String _calculateEngagementLevel() {
    final sessionDuration = _sessionStartTime != null 
        ? DateTime.now().difference(_sessionStartTime!).inMinutes 
        : 0;
    
    final interactionRate = _screenViews > 0 ? _userInteractions / _screenViews : 0;
    
    if (sessionDuration > 30 && interactionRate > 2) {
      return 'high';
    } else if (sessionDuration > 10 && interactionRate > 1) {
      return 'medium';
    } else {
      return 'low';
    }
  }

  /// Get preferred screens
  List<Map<String, dynamic>> _getPreferredScreens() {
    final screenCounts = <String, int>{};
    
    for (final event in _events) {
      if (event.type == UserEventType.screenView) {
        final screenName = event.properties['screen_name'] as String?;
        if (screenName != null) {
          screenCounts[screenName] = (screenCounts[screenName] ?? 0) + 1;
        }
      }
    }
    
    return screenCounts.entries
        .map((e) => {'screen': e.key, 'views': e.value})
        .toList()
      ..sort((a, b) => (b['views'] as int).compareTo(a['views'] as int));
  }

  /// Get interaction patterns
  Map<String, dynamic> _getInteractionPatterns() {
    final patterns = <String, int>{};
    
    for (final event in _events) {
      if (event.type == UserEventType.userInteraction) {
        final interactionType = event.properties['interaction_type'] as String?;
        if (interactionType != null) {
          patterns[interactionType] = (patterns[interactionType] ?? 0) + 1;
        }
      }
    }
    
    return patterns;
  }

  /// Get AI usage statistics
  Map<String, dynamic> _getAIUsageStats() {
    final aiEvents = _events.where((e) => e.type == UserEventType.aiInteraction).toList();
    
    if (aiEvents.isEmpty) {
      return {'total_interactions': 0, 'success_rate': 0.0, 'avg_response_time': 0.0};
    }
    
    final totalInteractions = aiEvents.length;
    final successfulInteractions = aiEvents.where((e) => e.properties['success'] == true).length;
    final successRate = totalInteractions > 0 ? successfulInteractions / totalInteractions : 0.0;
    
    final responseTimes = aiEvents
        .where((e) => e.properties['response_time_ms'] != null)
        .map((e) => e.properties['response_time_ms'] as double)
        .toList();
    
    final avgResponseTime = responseTimes.isNotEmpty 
        ? responseTimes.reduce((a, b) => a + b) / responseTimes.length 
        : 0.0;
    
    return {
      'total_interactions': totalInteractions,
      'success_rate': successRate,
      'avg_response_time_ms': avgResponseTime,
    };
  }

  /// Get performance metrics
  Map<String, dynamic> _getPerformanceMetrics() {
    final performanceEvents = _events.where((e) => e.type == UserEventType.performance).toList();
    
    if (performanceEvents.isEmpty) {
      return {};
    }
    
    final metrics = <String, List<double>>{};
    
    for (final event in performanceEvents) {
      final metricName = event.properties['metric_name'] as String?;
      final value = event.properties['value'] as double?;
      
      if (metricName != null && value != null) {
        metrics[metricName] = (metrics[metricName] ?? [])..add(value);
      }
    }
    
    final result = <String, dynamic>{};
    for (final entry in metrics.entries) {
      final values = entry.value;
      result[entry.key] = {
        'min': values.reduce((a, b) => a < b ? a : b),
        'max': values.reduce((a, b) => a > b ? a : b),
        'avg': values.reduce((a, b) => a + b) / values.length,
        'count': values.length,
      };
    }
    
    return result;
  }

  /// Classify user type
  String _classifyUserType() {
    final sessionDuration = _sessionStartTime != null 
        ? DateTime.now().difference(_sessionStartTime!).inMinutes 
        : 0;
    
    final totalEvents = _events.length;
    final aiInteractions = _events.where((e) => e.type == UserEventType.aiInteraction).length;
    
    if (sessionDuration > 60 && totalEvents > 100 && aiInteractions > 10) {
      return 'power_user';
    } else if (sessionDuration > 20 && totalEvents > 50) {
      return 'regular_user';
    } else if (totalEvents > 10) {
      return 'casual_user';
    } else {
      return 'new_user';
    }
  }

  /// Get current session ID
  String _getCurrentSessionId() {
    return _sessionStartTime?.millisecondsSinceEpoch.toString() ?? 'unknown';
  }

  /// Generate session ID
  String _generateSessionId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// Get user analytics summary
  Map<String, dynamic> getUserAnalyticsSummary() {
    return {
      'user_profile': _userProfile,
      'session_data': {
        'current_session_duration': _sessionStartTime != null 
            ? DateTime.now().difference(_sessionStartTime!).inMinutes 
            : 0,
        'screen_views': _screenViews,
        'user_interactions': _userInteractions,
        'current_screen': _currentScreen,
      },
      'feature_usage': _featureUsage,
      'total_events': _events.length,
      'user_type': _classifyUserType(),
      'engagement_level': _calculateEngagementLevel(),
      'most_used_feature': _getMostUsedFeature(),
    };
  }

  /// Export analytics data
  String exportAnalyticsData() {
    final data = {
      'user_profile': _userProfile,
      'events': _events.map((e) => e.toJson()).toList(),
      'feature_usage': _featureUsage,
      'session_data': _sessionData,
      'export_timestamp': DateTime.now().toIso8601String(),
    };
    
    return jsonEncode(data);
  }

  /// Clear analytics data
  void clearAnalyticsData() {
    _events.clear();
    _featureUsage.clear();
    _sessionData.clear();
  }

  /// Dispose resources
  void dispose() {
    _eventController.close();
    _insightsController.close();
  }
}

/// User event types
enum UserEventType {
  appLaunch,
  sessionStart,
  sessionEnd,
  screenView,
  userInteraction,
  featureUsage,
  aiInteraction,
  error,
  performance,
  custom,
}

/// User event data class
class UserEvent {
  final UserEventType type;
  final Map<String, dynamic> properties;
  final DateTime timestamp;
  final String sessionId;

  UserEvent({
    required this.type,
    required this.properties,
    required this.timestamp,
    required this.sessionId,
  });

  Map<String, dynamic> toJson() => {
    'type': type.name,
    'properties': properties,
    'timestamp': timestamp.toIso8601String(),
    'session_id': sessionId,
  };
}
