import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:injectable/injectable.dart';
import '../config/environment.dart' as app_env;
import 'state_persistence_service.dart';
import 'package:flutter/foundation.dart';

/// Production-grade error handling and monitoring service
@injectable
class ProductionErrorService {
  static final StreamController<ErrorEvent> _errorStreamController = 
      StreamController<ErrorEvent>.broadcast();
  
  static bool _isInitialized = false;
  static int _errorCount = 0;
  static DateTime? _lastErrorTime;
  
  /// Initialize the error service
  static Future<void> initialize() async {
    try {
      // Initialize Crashlytics
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      
      // Set up global error handlers
      _setupFlutterErrorHandlers();
      _setupZoneErrorHandlers();
      
      // Load error statistics from storage
      await _loadErrorStatistics();
      
      _isInitialized = true;
      
      if (app_env.Environment.enableLogging) {
        print('✅ Production error service initialized');
      }
    } catch (e) {
      if (app_env.Environment.enableLogging) {
        print('❌ Production error service initialization failed: $e');
      }
      rethrow;
    }
  }
  
  /// Setup Flutter framework error handlers
  static void _setupFlutterErrorHandlers() {
    // Handle Flutter framework errors
    FlutterError.onError = (FlutterErrorDetails details) {
      _handleFlutterError(details);
    };
  }
  
  /// Setup Dart Zone error handlers
  static void _setupZoneErrorHandlers() {
    // Handle uncaught Dart errors
    runZonedGuarded(() {
      // App initialization happens here in main.dart
    }, (error, stackTrace) {
      _handleUncaughtError(error, stackTrace);
    });
  }
  
  /// Handle Flutter framework errors
  static void _handleFlutterError(FlutterErrorDetails details) {
    try {
      final errorEvent = ErrorEvent(
        type: ErrorType.flutter,
        error: details.exception,
        stackTrace: details.stack,
        context: details.context?.toString(),
        timestamp: DateTime.now(),
        library: details.library,
      );
      
      _processError(errorEvent);
      
      // Report to Crashlytics
      FirebaseCrashlytics.instance.recordFlutterError(details);
      
    } catch (e) {
      if (app_env.Environment.enableLogging) {
        print('❌ Error while handling Flutter error: $e');
      }
    }
  }
  
  /// Handle uncaught Dart errors
  static void _handleUncaughtError(Object error, StackTrace stackTrace) {
    try {
      final errorEvent = ErrorEvent(
        type: ErrorType.uncaught,
        error: error,
        stackTrace: stackTrace,
        timestamp: DateTime.now(),
      );
      
      _processError(errorEvent);
      
      // Report to Crashlytics
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
      
    } catch (e) {
      if (app_env.Environment.enableLogging) {
        print('❌ Error while handling uncaught error: $e');
      }
    }
  }
  
  /// Handle application-level errors with context
  static Future<void> handleError({
    required Object error,
    StackTrace? stackTrace,
    String? context,
    ErrorSeverity severity = ErrorSeverity.error,
    Map<String, dynamic>? additionalData,
    bool reportToCrashlytics = true,
  }) async {
    try {
      final errorEvent = ErrorEvent(
        type: ErrorType.application,
        error: error,
        stackTrace: stackTrace ?? StackTrace.current,
        context: context,
        severity: severity,
        additionalData: additionalData,
        timestamp: DateTime.now(),
      );
      
      await _processError(errorEvent);
      
      // Report to Crashlytics if enabled
      if (reportToCrashlytics && severity.index >= ErrorSeverity.error.index) {
        await FirebaseCrashlytics.instance.recordError(
          error,
          stackTrace,
          information: [
            if (context != null) 'Context: $context',
            if (additionalData != null) 'Data: ${jsonEncode(additionalData)}',
          ],
        );
      }
      
    } catch (e) {
      if (app_env.Environment.enableLogging) {
        print('❌ Error while handling application error: $e');
      }
    }
  }
  
  /// Process error event
  static Future<void> _processError(ErrorEvent errorEvent) async {
    try {
      // Update statistics
      _errorCount++;
      _lastErrorTime = errorEvent.timestamp;
      
      // Save to persistent storage
      await _saveErrorToStorage(errorEvent);
      
      // Emit to stream for real-time monitoring
      if (!_errorStreamController.isClosed) {
        _errorStreamController.add(errorEvent);
      }
      
      // Log error if logging is enabled
      if (app_env.Environment.enableLogging) {
        _logError(errorEvent);
      }
      
      // Check for error rate limits
      _checkErrorRateLimit();
      
    } catch (e) {
      if (app_env.Environment.enableLogging) {
        print('❌ Error while processing error event: $e');
      }
    }
  }
  
  /// Save error to persistent storage
  static Future<void> _saveErrorToStorage(ErrorEvent errorEvent) async {
    try {
      // Save error details
      final errorData = errorEvent.toJson();
      final errorId = 'error_${errorEvent.timestamp.millisecondsSinceEpoch}';
      
      await StatePersistenceService.saveState(errorId, errorData);
      
      // Maintain error history (keep last 100 errors)
      final errorHistory = StatePersistenceService.loadState<List<dynamic>>('error_history', defaultValue: []) ?? [];
      errorHistory.add(errorId);
      
      // Keep only last 100 errors
      if (errorHistory.length > 100) {
        final oldErrorId = errorHistory.removeAt(0);
        await StatePersistenceService.removeState(oldErrorId);
      }
      
      await StatePersistenceService.saveState('error_history', errorHistory);
      
      // Update error statistics
      await _saveErrorStatistics();
      
    } catch (e) {
      if (app_env.Environment.enableLogging) {
        print('❌ Failed to save error to storage: $e');
      }
    }
  }
  
  /// Log error to console/debug output
  static void _logError(ErrorEvent errorEvent) {
    final severity = errorEvent.severity.name.toUpperCase();
    final type = errorEvent.type.name.toUpperCase();
    final timestamp = errorEvent.timestamp.toIso8601String();
    
    print('');
    print('🚨 [$severity] $type ERROR - $timestamp');
    print('📍 Context: ${errorEvent.context ?? 'Unknown'}');
    print('💥 Error: ${errorEvent.error}');
    
    if (errorEvent.stackTrace != null) {
      print('📚 Stack Trace:');
      final stackLines = errorEvent.stackTrace.toString().split('\n');
      for (int i = 0; i < stackLines.length && i < 10; i++) {
        print('   ${stackLines[i]}');
      }
      if (stackLines.length > 10) {
        print('   ... (${stackLines.length - 10} more lines)');
      }
    }
    
    if (errorEvent.additionalData != null) {
      print('📊 Additional Data: ${jsonEncode(errorEvent.additionalData)}');
    }
    
    print('─' * 80);
  }
  
  /// Check error rate and take action if too many errors
  static void _checkErrorRateLimit() {
    try {
      // Simple rate limiting: if more than 50 errors in last minute, log warning
      final now = DateTime.now();
      final oneMinuteAgo = now.subtract(const Duration(minutes: 1));
      
      // This is a simplified implementation
      // In production, you might want to track errors per time window
      if (_lastErrorTime != null && 
          _lastErrorTime!.isAfter(oneMinuteAgo) && 
          _errorCount > 50) {
        
        if (app_env.Environment.enableLogging) {
          print('⚠️ High error rate detected: $_errorCount errors');
        }
        
        // Could trigger additional actions like:
        // - Sending alerts
        // - Enabling debug mode
        // - Limiting functionality
      }
    } catch (e) {
      if (app_env.Environment.enableLogging) {
        print('❌ Error while checking rate limit: $e');
      }
    }
  }
  
  /// Load error statistics from storage
  static Future<void> _loadErrorStatistics() async {
    try {
      _errorCount = StatePersistenceService.loadState<int>('total_error_count', defaultValue: 0) ?? 0;
      final lastErrorTimeMs = StatePersistenceService.loadState<int>('last_error_time');
      if (lastErrorTimeMs != null) {
        _lastErrorTime = DateTime.fromMillisecondsSinceEpoch(lastErrorTimeMs);
      }
    } catch (e) {
      if (app_env.Environment.enableLogging) {
        print('❌ Failed to load error statistics: $e');
      }
    }
  }
  
  /// Save error statistics to storage
  static Future<void> _saveErrorStatistics() async {
    try {
      await StatePersistenceService.saveState('total_error_count', _errorCount);
      if (_lastErrorTime != null) {
        await StatePersistenceService.saveState('last_error_time', _lastErrorTime!.millisecondsSinceEpoch);
      }
    } catch (e) {
      if (app_env.Environment.enableLogging) {
        print('❌ Failed to save error statistics: $e');
      }
    }
  }
  
  /// Get user-friendly error message
  static String getUserFriendlyMessage(Object error, {String? context}) {
    try {
      final errorString = error.toString().toLowerCase();
      
      // Network errors
      if (errorString.contains('socket') || errorString.contains('network') || errorString.contains('connection')) {
        return 'Network connection problem. Please check your internet connection and try again.';
      }
      
      // Permission errors
      if (errorString.contains('permission') || errorString.contains('denied')) {
        return 'Permission required. Please check app permissions in your device settings.';
      }
      
      // Storage errors
      if (errorString.contains('storage') || errorString.contains('disk') || errorString.contains('file')) {
        return 'Storage problem. Please check available storage space and try again.';
      }
      
      // API errors
      if (errorString.contains('api') || errorString.contains('unauthorized') || errorString.contains('403')) {
        return 'API access problem. Please check your API configuration.';
      }
      
      // Timeout errors
      if (errorString.contains('timeout')) {
        return 'Request timed out. Please try again.';
      }
      
      // Validation errors
      if (errorString.contains('validation') || errorString.contains('invalid')) {
        return 'Invalid input. Please check your data and try again.';
      }
      
      // Generic fallback
      return 'Something went wrong. Please try again or contact support if the problem persists.';
      
    } catch (e) {
      return 'An unexpected error occurred. Please try again.';
    }
  }
  
  /// Get error category for analytics
  static String getErrorCategory(Object error) {
    final errorString = error.toString().toLowerCase();
    
    if (errorString.contains('socket') || errorString.contains('network')) {
      return 'network';
    } else if (errorString.contains('permission')) {
      return 'permission';
    } else if (errorString.contains('storage') || errorString.contains('file')) {
      return 'storage';
    } else if (errorString.contains('api') || errorString.contains('http')) {
      return 'api';
    } else if (errorString.contains('validation')) {
      return 'validation';
    } else if (errorString.contains('ui') || errorString.contains('widget')) {
      return 'ui';
    } else if (errorString.contains('database') || errorString.contains('sql')) {
      return 'database';
    } else if (errorString.contains('auth')) {
      return 'authentication';
    } else if (errorString.contains('timeout')) {
      return 'timeout';
    } else {
      return 'unknown';
    }
  }
  
  /// Get error stream for real-time monitoring
  static Stream<ErrorEvent> get errorStream => _errorStreamController.stream;
  
  /// Get error statistics
  static Future<Map<String, dynamic>> getErrorStatistics() async {
    try {
      final errorHistory = StatePersistenceService.loadState<List<dynamic>>('error_history', defaultValue: []) ?? [];
      
      // Calculate error statistics
      final now = DateTime.now();
      final last24Hours = now.subtract(const Duration(hours: 24));
      final lastWeek = now.subtract(const Duration(days: 7));
      
      int errors24h = 0;
      int errorsWeek = 0;
      final errorsByCategory = <String, int>{};
      final errorsBySeverity = <String, int>{};
      
      for (final errorId in errorHistory) {
        try {
          final errorData = StatePersistenceService.loadState<Map<String, dynamic>>(errorId);
          if (errorData != null) {
            final timestampMs = errorData['timestamp'] as int?;
            if (timestampMs != null) {
              final errorTime = DateTime.fromMillisecondsSinceEpoch(timestampMs);
              
              if (errorTime.isAfter(last24Hours)) {
                errors24h++;
              }
              if (errorTime.isAfter(lastWeek)) {
                errorsWeek++;
              }
              
              // Count by category
              final category = errorData['category'] as String? ?? 'unknown';
              errorsByCategory[category] = (errorsByCategory[category] ?? 0) + 1;
              
              // Count by severity
              final severity = errorData['severity'] as String? ?? 'error';
              errorsBySeverity[severity] = (errorsBySeverity[severity] ?? 0) + 1;
            }
          }
        } catch (e) {
          // Skip corrupted error records
        }
      }
      
      return {
        'total_errors': _errorCount,
        'errors_24h': errors24h,
        'errors_week': errorsWeek,
        'last_error_time': _lastErrorTime?.toIso8601String(),
        'errors_by_category': errorsByCategory,
        'errors_by_severity': errorsBySeverity,
        'error_history_size': errorHistory.length,
        'is_initialized': _isInitialized,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      return {
        'error': 'Failed to get error statistics: $e',
        'timestamp': DateTime.now().toIso8601String(),
      };
    }
  }
  
  /// Clear error history
  static Future<void> clearErrorHistory() async {
    try {
      final errorHistory = StatePersistenceService.loadState<List<dynamic>>('error_history', defaultValue: []) ?? [];
      
      // Remove all error records
      for (final errorId in errorHistory) {
        await StatePersistenceService.removeState(errorId);
      }
      
      // Clear error history
      await StatePersistenceService.removeState('error_history');
      
      // Reset counters
      _errorCount = 0;
      _lastErrorTime = null;
      await _saveErrorStatistics();
      
      if (app_env.Environment.enableLogging) {
        print('✅ Error history cleared');
      }
    } catch (e) {
      if (app_env.Environment.enableLogging) {
        print('❌ Failed to clear error history: $e');
      }
    }
  }
  
  /// Set custom Crashlytics user information
  static Future<void> setUserInfo({
    String? userId,
    String? email,
    Map<String, String>? customKeys,
  }) async {
    try {
      if (userId != null) {
        await FirebaseCrashlytics.instance.setUserIdentifier(userId);
      }
      
      if (customKeys != null) {
        for (final entry in customKeys.entries) {
          await FirebaseCrashlytics.instance.setCustomKey(entry.key, entry.value);
        }
      }
      
      // Set app version and environment
      await FirebaseCrashlytics.instance.setCustomKey('app_version', app_env.Environment.appVersion);
      await FirebaseCrashlytics.instance.setCustomKey('environment', app_env.Environment.current.name);
      await FirebaseCrashlytics.instance.setCustomKey('platform', Platform.operatingSystem);
      
    } catch (e) {
      if (app_env.Environment.enableLogging) {
        print('❌ Failed to set user info: $e');
      }
    }
  }
  
  /// Dispose error service
  static Future<void> dispose() async {
    try {
      await _errorStreamController.close();
      _isInitialized = false;
    } catch (e) {
      if (app_env.Environment.enableLogging) {
        print('❌ Error while disposing error service: $e');
      }
    }
  }
}

/// Error event class
class ErrorEvent {
  final ErrorType type;
  final Object error;
  final StackTrace? stackTrace;
  final String? context;
  final ErrorSeverity severity;
  final Map<String, dynamic>? additionalData;
  final DateTime timestamp;
  final String? library;
  
  const ErrorEvent({
    required this.type,
    required this.error,
    this.stackTrace,
    this.context,
    this.severity = ErrorSeverity.error,
    this.additionalData,
    required this.timestamp,
    this.library,
  });
  
  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'error': error.toString(),
      'stackTrace': stackTrace?.toString(),
      'context': context,
      'severity': severity.name,
      'additionalData': additionalData,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'library': library,
      'category': ProductionErrorService.getErrorCategory(error),
    };
  }
  
  /// Create from JSON
  factory ErrorEvent.fromJson(Map<String, dynamic> json) {
    return ErrorEvent(
      type: ErrorType.values.firstWhere((e) => e.name == json['type']),
      error: json['error'] as String,
      stackTrace: json['stackTrace'] != null ? StackTrace.fromString(json['stackTrace']) : null,
      context: json['context'] as String?,
      severity: ErrorSeverity.values.firstWhere((e) => e.name == json['severity']),
      additionalData: json['additionalData'] as Map<String, dynamic>?,
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
      library: json['library'] as String?,
    );
  }
}

/// Error types
enum ErrorType {
  flutter,
  uncaught,
  application,
  network,
  storage,
  api,
  validation,
}

/// Error severity levels
enum ErrorSeverity {
  debug,
  info,
  warning,
  error,
  critical,
}
