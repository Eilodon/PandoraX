import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart';
import '../config/environment.dart' as app_env;

/// Unified Error Service
/// 
/// Consolidates error handling functionality from both error_service.dart and production_error_service.dart
/// Provides both development-friendly and production-grade error handling
@injectable
class UnifiedErrorService {
  static final StreamController<ErrorEvent> _errorStreamController = 
      StreamController<ErrorEvent>.broadcast();
  
  static bool _isInitialized = false;
  static int _errorCount = 0;
  static DateTime? _lastErrorTime;
  static bool _isProductionMode = false;

  /// Initialize the unified error service
  static Future<void> initialize({bool productionMode = false}) async {
    if (_isInitialized) return;
    
    _isProductionMode = productionMode;

    try {
      if (productionMode) {
        await _initializeProduction();
      }
      
      _setupFlutterErrorHandlers();
      
      if (productionMode) {
        _setupZoneErrorHandlers();
      }
      
      _isInitialized = true;
    } catch (e) {
      print('Failed to initialize error service: $e');
    }
  }

  /// Initialize production-specific features
  static Future<void> _initializeProduction() async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }

  /// Set up Flutter error handlers
  static void _setupFlutterErrorHandlers() {
    FlutterError.onError = (FlutterErrorDetails details) {
      final event = ErrorEvent(
        error: details.exception,
        stackTrace: details.stack,
        context: details.context?.toString(),
        timestamp: DateTime.now(),
        isFatal: false,
      );
      
      _handleErrorEvent(event);
    };
  }

  /// Set up zone error handlers (production only)
  static void _setupZoneErrorHandlers() {
    PlatformDispatcher.instance.onError = (error, stack) {
      final event = ErrorEvent(
        error: error,
        stackTrace: stack,
        context: 'PlatformDispatcher',
        timestamp: DateTime.now(),
        isFatal: true,
      );
      
      _handleErrorEvent(event);
      return true;
    };
  }

  /// Handle and format errors for display
  String handleError(dynamic error, {String? context}) {
    try {
      _errorCount++;
      _lastErrorTime = DateTime.now();

      String formattedError;
      
      if (error is String) {
        formattedError = _formatErrorMessage(error, context);
      } else if (error is Exception) {
        formattedError = _formatException(error, context);
      } else if (error is Error) {
        formattedError = _formatError(error, context);
      } else {
        formattedError = _formatGenericError(error, context);
      }

      // Log error
      final event = ErrorEvent(
        error: error,
        stackTrace: StackTrace.current,
        context: context,
        timestamp: DateTime.now(),
        isFatal: false,
      );
      
      _handleErrorEvent(event);
      
      return formattedError;
    } catch (e) {
      return 'An unexpected error occurred while handling the error: $e';
    }
  }

  /// Handle error event
  static void _handleErrorEvent(ErrorEvent event) {
    // Add to stream for listeners
    _errorStreamController.add(event);
    
    // Log to console in development
    if (!_isProductionMode || kDebugMode) {
      _logToConsole(event);
    }
    
    // Report to Crashlytics in production
    if (_isProductionMode && !kDebugMode) {
      _reportToCrashlytics(event);
    }
  }

  /// Log error to console
  static void _logToConsole(ErrorEvent event) {
    final timestamp = event.timestamp.toIso8601String();
    final contextInfo = event.context != null ? ' [${event.context}]' : '';
    final fatalInfo = event.isFatal ? ' [FATAL]' : '';
    
    print('ERROR$fatalInfo$contextInfo ($timestamp): ${event.error}');
    if (event.stackTrace != null) {
      print('Stack trace: ${event.stackTrace}');
    }
  }

  /// Report error to Crashlytics
  static void _reportToCrashlytics(ErrorEvent event) {
    try {
      if (event.isFatal) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(
          FlutterErrorDetails(
            exception: event.error,
            stack: event.stackTrace,
            context: event.context != null ? DiagnosticsNode.message(event.context!) : null,
          ),
        );
      } else {
        FirebaseCrashlytics.instance.recordFlutterError(
          FlutterErrorDetails(
            exception: event.error,
            stack: event.stackTrace,
            context: event.context != null ? DiagnosticsNode.message(event.context!) : null,
          ),
        );
      }
    } catch (e) {
      print('Failed to report error to Crashlytics: $e');
    }
  }

  /// Format string error message
  String _formatErrorMessage(String error, String? context) {
    final contextPrefix = context != null ? '[$context] ' : '';
    return '${contextPrefix}Error: $error';
  }

  /// Format exception
  String _formatException(Exception exception, String? context) {
    final contextPrefix = context != null ? '[$context] ' : '';
    return '${contextPrefix}Exception: ${exception.toString()}';
  }

  /// Format error
  String _formatError(Error error, String? context) {
    final contextPrefix = context != null ? '[$context] ' : '';
    return '${contextPrefix}Error: ${error.toString()}';
  }

  /// Format generic error
  String _formatGenericError(dynamic error, String? context) {
    final contextPrefix = context != null ? '[$context] ' : '';
    return '${contextPrefix}Unknown error: ${error.toString()}';
  }

  /// Get error stream
  static Stream<ErrorEvent> get errorStream => _errorStreamController.stream;

  /// Get error statistics
  static Map<String, dynamic> getErrorStats() {
    return {
      'errorCount': _errorCount,
      'lastErrorTime': _lastErrorTime?.toIso8601String(),
      'isInitialized': _isInitialized,
      'isProductionMode': _isProductionMode,
    };
  }

  /// Record custom error
  static void recordError(dynamic error, {StackTrace? stackTrace, String? context}) {
    final event = ErrorEvent(
      error: error,
      stackTrace: stackTrace ?? StackTrace.current,
      context: context,
      timestamp: DateTime.now(),
      isFatal: false,
    );
    
    _handleErrorEvent(event);
  }

  /// Clear error count
  static void clearErrorCount() {
    _errorCount = 0;
    _lastErrorTime = null;
  }

  /// Dispose resources
  static void dispose() {
    _errorStreamController.close();
    _isInitialized = false;
  }
}

/// Error event data class
class ErrorEvent {
  final dynamic error;
  final StackTrace? stackTrace;
  final String? context;
  final DateTime timestamp;
  final bool isFatal;

  const ErrorEvent({
    required this.error,
    this.stackTrace,
    this.context,
    required this.timestamp,
    this.isFatal = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'error': error.toString(),
      'stackTrace': stackTrace?.toString(),
      'context': context,
      'timestamp': timestamp.toIso8601String(),
      'isFatal': isFatal,
    };
  }
}