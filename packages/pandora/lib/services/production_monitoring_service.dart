import 'dart:async';
import 'dart:io';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Service for production monitoring, analytics, and error tracking
class ProductionMonitoringService {
  static final ProductionMonitoringService _instance = ProductionMonitoringService._internal();
  factory ProductionMonitoringService() => _instance;
  ProductionMonitoringService._internal();

  FirebaseAnalytics? _analytics;
  FirebaseCrashlytics? _crashlytics;
  PackageInfo? _packageInfo;
  SharedPreferences? _prefs;
  final Connectivity _connectivity = Connectivity();
  
  Timer? _heartbeatTimer;
  Timer? _performanceTimer;
  final Map<String, dynamic> _customMetrics = {};
  final List<MonitoringEvent> _eventQueue = [];
  bool _isInitialized = false;

  /// Initialize the production monitoring service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      _packageInfo = await PackageInfo.fromPlatform();
      _prefs = await SharedPreferences.getInstance();
      
      // Initialize Firebase services
      await _initializeFirebase();
      
      // Setup monitoring
      await _setupMonitoring();
      
      // Start background monitoring
      _startBackgroundMonitoring();
      
      _isInitialized = true;
      print('📊 Production monitoring initialized successfully');
    } catch (e) {
      print('❌ Failed to initialize production monitoring: $e');
      throw ProductionMonitoringException('Failed to initialize monitoring: $e');
    }
  }

  /// Initialize Firebase services
  Future<void> _initializeFirebase() async {
    try {
      _analytics = FirebaseAnalytics.instance;
      _crashlytics = FirebaseCrashlytics.instance;
      
      // Configure analytics
      await _analytics?.setAnalyticsCollectionEnabled(true);
      await _analytics?.setSessionTimeoutDuration(const Duration(minutes: 30));
      
      // Configure crashlytics
      await _crashlytics?.setCrashlyticsCollectionEnabled(true);
      
      print('🔥 Firebase monitoring services initialized');
    } catch (e) {
      print('⚠️ Firebase initialization failed: $e');
      // Continue without Firebase if it fails
    }
  }

  /// Setup monitoring configuration
  Future<void> _setupMonitoring() async {
    // Set user properties
    await _setUserProperties();
    
    // Setup error handling
    _setupErrorHandling();
    
    // Setup performance monitoring
    _setupPerformanceMonitoring();
  }

  /// Set user properties for analytics
  Future<void> _setUserProperties() async {
    if (_analytics == null || _packageInfo == null) return;

    try {
      await _analytics!.setUserProperty(
        name: 'app_version',
        value: _packageInfo!.version,
      );
      
      await _analytics!.setUserProperty(
        name: 'build_number',
        value: _packageInfo!.buildNumber,
      );
      
      await _analytics!.setUserProperty(
        name: 'platform',
        value: Platform.operatingSystem,
      );
      
      // Set custom user properties
      final userId = _prefs?.getString('user_id');
      if (userId != null) {
        await _analytics!.setUserId(userId);
      }
    } catch (e) {
      print('⚠️ Failed to set user properties: $e');
    }
  }

  /// Setup global error handling
  void _setupErrorHandling() {
    // Flutter error handling
    FlutterError.onError = (FlutterErrorDetails details) {
      _logError('Flutter Error', details.exception, details.stack);
    };

    // Platform error handling
    PlatformDispatcher.instance.onError = (error, stack) {
      _logError('Platform Error', error, stack);
      return true;
    };
  }

  /// Setup performance monitoring
  void _setupPerformanceMonitoring() {
    // Monitor app lifecycle
    _monitorAppLifecycle();
    
    // Monitor network connectivity
    _monitorConnectivity();
    
    // Monitor memory usage
    _monitorMemoryUsage();
  }

  /// Start background monitoring
  void _startBackgroundMonitoring() {
    // Heartbeat every 30 seconds
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _sendHeartbeat();
    });

    // Performance monitoring every 5 minutes
    _performanceTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      _collectPerformanceMetrics();
    });
  }

  /// Send heartbeat to monitoring service
  void _sendHeartbeat() {
    _trackEvent('heartbeat', {
      'timestamp': DateTime.now().toIso8601String(),
      'app_state': _getAppState(),
      'memory_usage': _getMemoryUsage(),
    });
  }

  /// Collect performance metrics
  void _collectPerformanceMetrics() {
    final metrics = PerformanceMetrics(
      timestamp: DateTime.now(),
      memoryUsage: _getMemoryUsage(),
      cpuUsage: _getCpuUsage(),
      networkStatus: _getNetworkStatus(),
      appUptime: _getAppUptime(),
      errorCount: _getErrorCount(),
    );

    _trackEvent('performance_metrics', metrics.toMap());
  }

  /// Track custom event
  Future<void> trackEvent(String eventName, Map<String, dynamic>? parameters) async {
    if (!_isInitialized) return;

    try {
      // Track with Firebase Analytics
      await _analytics?.logEvent(
        name: eventName,
        parameters: parameters,
      );

      // Track with custom monitoring
      final event = MonitoringEvent(
        name: eventName,
        parameters: parameters ?? {},
        timestamp: DateTime.now(),
      );
      
      _eventQueue.add(event);
      
      // Flush queue if it gets too large
      if (_eventQueue.length > 100) {
        await _flushEventQueue();
      }
    } catch (e) {
      print('⚠️ Failed to track event $eventName: $e');
    }
  }

  /// Track user action
  Future<void> trackUserAction(String action, {Map<String, dynamic>? parameters}) async {
    await trackEvent('user_action', {
      'action': action,
      ...?parameters,
    });
  }

  /// Track screen view
  Future<void> trackScreenView(String screenName, {Map<String, dynamic>? parameters}) async {
    await trackEvent('screen_view', {
      'screen_name': screenName,
      ...?parameters,
    });
  }

  /// Track error
  Future<void> trackError(String errorType, String errorMessage, {Map<String, dynamic>? parameters}) async {
    await trackEvent('error', {
      'error_type': errorType,
      'error_message': errorMessage,
      ...?parameters,
    });
  }

  /// Log error to crashlytics
  void _logError(String errorType, dynamic error, StackTrace? stackTrace) {
    try {
      _crashlytics?.recordError(
        error,
        stackTrace,
        reason: errorType,
        fatal: false,
      );
    } catch (e) {
      print('⚠️ Failed to log error to crashlytics: $e');
    }
  }

  /// Monitor app lifecycle
  void _monitorAppLifecycle() {
    // This would be implemented with WidgetsBindingObserver
    // For now, we'll simulate the monitoring
  }

  /// Monitor network connectivity
  void _monitorConnectivity() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _trackEvent('connectivity_change', {
        'status': result.toString(),
        'timestamp': DateTime.now().toIso8601String(),
      });
    });
  }

  /// Monitor memory usage
  void _monitorMemoryUsage() {
    // This would be implemented with platform-specific memory monitoring
    // For now, we'll simulate the monitoring
  }

  /// Get current app state
  String _getAppState() {
    // This would be implemented with actual app state monitoring
    return 'active';
  }

  /// Get memory usage
  double _getMemoryUsage() {
    // This would be implemented with actual memory monitoring
    return 0.0;
  }

  /// Get CPU usage
  double _getCpuUsage() {
    // This would be implemented with actual CPU monitoring
    return 0.0;
  }

  /// Get network status
  String _getNetworkStatus() {
    // This would be implemented with actual network monitoring
    return 'connected';
  }

  /// Get app uptime
  Duration _getAppUptime() {
    final startTime = _prefs?.getString('app_start_time');
    if (startTime != null) {
      return DateTime.now().difference(DateTime.parse(startTime));
    }
    return Duration.zero;
  }

  /// Get error count
  int _getErrorCount() {
    return _prefs?.getInt('error_count') ?? 0;
  }

  /// Set custom metric
  void setCustomMetric(String key, dynamic value) {
    _customMetrics[key] = value;
  }

  /// Get custom metric
  dynamic getCustomMetric(String key) {
    return _customMetrics[key];
  }

  /// Flush event queue
  Future<void> _flushEventQueue() async {
    if (_eventQueue.isEmpty) return;

    try {
      // In a real implementation, send events to your monitoring server
      print('📊 Flushing ${_eventQueue.length} monitoring events');
      _eventQueue.clear();
    } catch (e) {
      print('⚠️ Failed to flush event queue: $e');
    }
  }

  /// Get monitoring dashboard data
  Future<MonitoringDashboard> getDashboardData() async {
    return MonitoringDashboard(
      appVersion: _packageInfo?.version ?? 'Unknown',
      buildNumber: _packageInfo?.buildNumber ?? 'Unknown',
      platform: Platform.operatingSystem,
      uptime: _getAppUptime(),
      memoryUsage: _getMemoryUsage(),
      errorCount: _getErrorCount(),
      eventCount: _eventQueue.length,
      customMetrics: Map.from(_customMetrics),
    );
  }

  /// Dispose resources
  void dispose() {
    _heartbeatTimer?.cancel();
    _performanceTimer?.cancel();
    _flushEventQueue();
    _isInitialized = false;
  }
}

/// Monitoring event
class MonitoringEvent {
  final String name;
  final Map<String, dynamic> parameters;
  final DateTime timestamp;

  MonitoringEvent({
    required this.name,
    required this.parameters,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'parameters': parameters,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

/// Performance metrics
class PerformanceMetrics {
  final DateTime timestamp;
  final double memoryUsage;
  final double cpuUsage;
  final String networkStatus;
  final Duration appUptime;
  final int errorCount;

  PerformanceMetrics({
    required this.timestamp,
    required this.memoryUsage,
    required this.cpuUsage,
    required this.networkStatus,
    required this.appUptime,
    required this.errorCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'memory_usage': memoryUsage,
      'cpu_usage': cpuUsage,
      'network_status': networkStatus,
      'app_uptime': appUptime.inSeconds,
      'error_count': errorCount,
    };
  }
}

/// Monitoring dashboard data
class MonitoringDashboard {
  final String appVersion;
  final String buildNumber;
  final String platform;
  final Duration uptime;
  final double memoryUsage;
  final int errorCount;
  final int eventCount;
  final Map<String, dynamic> customMetrics;

  MonitoringDashboard({
    required this.appVersion,
    required this.buildNumber,
    required this.platform,
    required this.uptime,
    required this.memoryUsage,
    required this.errorCount,
    required this.eventCount,
    required this.customMetrics,
  });

  @override
  String toString() {
    return 'MonitoringDashboard(version: $appVersion, uptime: ${uptime.inMinutes}m, errors: $errorCount)';
  }
}

/// Production monitoring exception
class ProductionMonitoringException implements Exception {
  final String message;
  ProductionMonitoringException(this.message);

  @override
  String toString() => 'ProductionMonitoringException: $message';
}
