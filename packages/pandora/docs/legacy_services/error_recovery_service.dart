import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Enhanced Error Recovery Service
/// Provides intelligent error handling and recovery mechanisms
class ErrorRecoveryService {
  static final ErrorRecoveryService _instance = ErrorRecoveryService._internal();
  factory ErrorRecoveryService() => _instance;
  ErrorRecoveryService._internal();

  // Error tracking
  final List<ErrorEvent> _errorHistory = [];
  final Map<String, int> _errorCounts = {};
  final Map<String, DateTime> _lastErrorTimes = {};
  
  // Recovery strategies
  final Map<ErrorType, List<RecoveryStrategy>> _recoveryStrategies = {};
  
  // Stream controllers
  final StreamController<ErrorEvent> _errorController = 
      StreamController<ErrorEvent>.broadcast();
  final StreamController<RecoveryAction> _recoveryController = 
      StreamController<RecoveryAction>.broadcast();

  // Configuration
  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 2);
  static const Duration errorCooldown = Duration(minutes: 5);

  // Getters
  List<ErrorEvent> get errorHistory => List.unmodifiable(_errorHistory);
  Map<String, int> get errorCounts => Map.unmodifiable(_errorCounts);
  Stream<ErrorEvent> get errorStream => _errorController.stream;
  Stream<RecoveryAction> get recoveryStream => _recoveryController.stream;

  /// Initialize error recovery service
  Future<void> initialize() async {
    _setupRecoveryStrategies();
    _setupGlobalErrorHandlers();
    
    // Start error monitoring
    _startErrorMonitoring();
  }

  /// Setup recovery strategies for different error types
  void _setupRecoveryStrategies() {
    // Network errors
    _recoveryStrategies[ErrorType.network] = [
      RecoveryStrategy(
        name: 'Retry with exponential backoff',
        priority: 1,
        action: _retryWithBackoff,
      ),
      RecoveryStrategy(
        name: 'Switch to offline mode',
        priority: 2,
        action: _switchToOfflineMode,
      ),
      RecoveryStrategy(
        name: 'Show user notification',
        priority: 3,
        action: _showNetworkErrorNotification,
      ),
    ];

    // AI service errors
    _recoveryStrategies[ErrorType.aiService] = [
      RecoveryStrategy(
        name: 'Fallback to local AI',
        priority: 1,
        action: _fallbackToLocalAI,
      ),
      RecoveryStrategy(
        name: 'Retry with different model',
        priority: 2,
        action: _retryWithDifferentModel,
      ),
      RecoveryStrategy(
        name: 'Show AI error message',
        priority: 3,
        action: _showAIErrorMessage,
      ),
    ];

    // Database errors
    _recoveryStrategies[ErrorType.database] = [
      RecoveryStrategy(
        name: 'Reconnect to database',
        priority: 1,
        action: _reconnectDatabase,
      ),
      RecoveryStrategy(
        name: 'Clear corrupted data',
        priority: 2,
        action: _clearCorruptedData,
      ),
      RecoveryStrategy(
        name: 'Restore from backup',
        priority: 3,
        action: _restoreFromBackup,
      ),
    ];

    // Memory errors
    _recoveryStrategies[ErrorType.memory] = [
      RecoveryStrategy(
        name: 'Clear cache',
        priority: 1,
        action: _clearCache,
      ),
      RecoveryStrategy(
        name: 'Reduce memory usage',
        priority: 2,
        action: _reduceMemoryUsage,
      ),
      RecoveryStrategy(
        name: 'Restart app gracefully',
        priority: 3,
        action: _restartAppGracefully,
      ),
    ];

    // UI errors
    _recoveryStrategies[ErrorType.ui] = [
      RecoveryStrategy(
        name: 'Rebuild UI component',
        priority: 1,
        action: _rebuildUIComponent,
      ),
      RecoveryStrategy(
        name: 'Reset UI state',
        priority: 2,
        action: _resetUIState,
      ),
      RecoveryStrategy(
        name: 'Navigate to safe screen',
        priority: 3,
        action: _navigateToSafeScreen,
      ),
    ];
  }

  /// Setup global error handlers
  void _setupGlobalErrorHandlers() {
    // Flutter error handler
    FlutterError.onError = (FlutterErrorDetails details) {
      handleError(
        ErrorType.ui,
        'Flutter Error',
        details.exception.toString(),
        details.stack,
        context: {
          'library': details.library,
          'context': details.context?.toString(),
        },
      );
    };

    // Platform error handler
    PlatformDispatcher.instance.onError = (error, stack) {
      handleError(
        ErrorType.platform,
        'Platform Error',
        error.toString(),
        stack,
      );
      return true;
    };

    // Zone error handler
    runZonedGuarded(() {
      // App runs here
    }, (error, stack) {
      handleError(
        ErrorType.zone,
        'Zone Error',
        error.toString(),
        stack,
      );
    });
  }

  /// Start error monitoring
  void _startErrorMonitoring() {
    // Monitor for repeated errors
    Timer.periodic(const Duration(minutes: 1), (_) {
      _checkForRepeatedErrors();
    });
  }

  /// Handle error with recovery
  Future<void> handleError(
    ErrorType type,
    String message,
    dynamic exception,
    StackTrace? stackTrace, {
    Map<String, dynamic>? context,
    bool shouldRecover = true,
  }) async {
    final errorEvent = ErrorEvent(
      type: type,
      message: message,
      exception: exception.toString(),
      stackTrace: stackTrace?.toString(),
      timestamp: DateTime.now(),
      context: context ?? {},
    );

    // Record error
    _recordError(errorEvent);

    // Emit error event
    _errorController.add(errorEvent);

    // Attempt recovery if enabled
    if (shouldRecover) {
      await _attemptRecovery(errorEvent);
    }
  }

  /// Record error in history
  void _recordError(ErrorEvent errorEvent) {
    _errorHistory.add(errorEvent);
    
    // Keep only last 1000 errors
    if (_errorHistory.length > 1000) {
      _errorHistory.removeAt(0);
    }

    // Update error counts
    final errorKey = '${errorEvent.type.name}_${errorEvent.message}';
    _errorCounts[errorKey] = (_errorCounts[errorKey] ?? 0) + 1;
    _lastErrorTimes[errorKey] = errorEvent.timestamp;
  }

  /// Attempt recovery for error
  Future<void> _attemptRecovery(ErrorEvent errorEvent) async {
    final strategies = _recoveryStrategies[errorEvent.type] ?? [];
    
    for (final strategy in strategies) {
      try {
        final success = await strategy.action(errorEvent);
        if (success) {
          _recoveryController.add(RecoveryAction(
            errorEvent: errorEvent,
            strategy: strategy,
            success: true,
            timestamp: DateTime.now(),
          ));
          return;
        }
      } catch (e) {
        // Strategy failed, try next one
        continue;
      }
    }

    // All strategies failed
    _recoveryController.add(RecoveryAction(
      errorEvent: errorEvent,
      strategy: null,
      success: false,
      timestamp: DateTime.now(),
    ));
  }

  /// Check for repeated errors
  void _checkForRepeatedErrors() {
    final now = DateTime.now();
    
    for (final entry in _errorCounts.entries) {
      final lastErrorTime = _lastErrorTimes[entry.key];
      if (lastErrorTime != null) {
        final timeSinceLastError = now.difference(lastErrorTime);
        
        // If same error occurred multiple times recently
        if (entry.value > 3 && timeSinceLastError < errorCooldown) {
          _handleRepeatedError(entry.key, entry.value);
        }
      }
    }
  }

  /// Handle repeated errors
  void _handleRepeatedError(String errorKey, int count) {
    // Implement escalation logic
    if (count > 10) {
      // Critical error - escalate to admin
      _escalateToAdmin(errorKey, count);
    } else if (count > 5) {
      // High frequency error - show user notification
      _showRepeatedErrorNotification(errorKey, count);
    }
  }

  /// Escalate to admin
  void _escalateToAdmin(String errorKey, int count) {
    // In a real app, this would send to admin dashboard
    debugPrint('ESCALATION: Error $errorKey occurred $count times');
  }

  /// Show repeated error notification
  void _showRepeatedErrorNotification(String errorKey, int count) {
    // In a real app, this would show user notification
    debugPrint('NOTIFICATION: Error $errorKey occurred $count times');
  }

  // Recovery Strategy Implementations

  /// Retry with exponential backoff
  Future<bool> _retryWithBackoff(ErrorEvent errorEvent) async {
    // Implement retry logic with exponential backoff
    await Future.delayed(retryDelay);
    return true; // Simplified for demo
  }

  /// Switch to offline mode
  Future<bool> _switchToOfflineMode(ErrorEvent errorEvent) async {
    // Implement offline mode switch
    return true; // Simplified for demo
  }

  /// Show network error notification
  Future<bool> _showNetworkErrorNotification(ErrorEvent errorEvent) async {
    // Implement user notification
    return true; // Simplified for demo
  }

  /// Fallback to local AI
  Future<bool> _fallbackToLocalAI(ErrorEvent errorEvent) async {
    // Implement local AI fallback
    return true; // Simplified for demo
  }

  /// Retry with different model
  Future<bool> _retryWithDifferentModel(ErrorEvent errorEvent) async {
    // Implement model switching
    return true; // Simplified for demo
  }

  /// Show AI error message
  Future<bool> _showAIErrorMessage(ErrorEvent errorEvent) async {
    // Implement AI error message
    return true; // Simplified for demo
  }

  /// Reconnect to database
  Future<bool> _reconnectDatabase(ErrorEvent errorEvent) async {
    // Implement database reconnection
    return true; // Simplified for demo
  }

  /// Clear corrupted data
  Future<bool> _clearCorruptedData(ErrorEvent errorEvent) async {
    // Implement data clearing
    return true; // Simplified for demo
  }

  /// Restore from backup
  Future<bool> _restoreFromBackup(ErrorEvent errorEvent) async {
    // Implement backup restoration
    return true; // Simplified for demo
  }

  /// Clear cache
  Future<bool> _clearCache(ErrorEvent errorEvent) async {
    // Implement cache clearing
    return true; // Simplified for demo
  }

  /// Reduce memory usage
  Future<bool> _reduceMemoryUsage(ErrorEvent errorEvent) async {
    // Implement memory reduction
    return true; // Simplified for demo
  }

  /// Restart app gracefully
  Future<bool> _restartAppGracefully(ErrorEvent errorEvent) async {
    // Implement graceful restart
    return true; // Simplified for demo
  }

  /// Rebuild UI component
  Future<bool> _rebuildUIComponent(ErrorEvent errorEvent) async {
    // Implement UI rebuild
    return true; // Simplified for demo
  }

  /// Reset UI state
  Future<bool> _resetUIState(ErrorEvent errorEvent) async {
    // Implement UI state reset
    return true; // Simplified for demo
  }

  /// Navigate to safe screen
  Future<bool> _navigateToSafeScreen(ErrorEvent errorEvent) async {
    // Implement safe navigation
    return true; // Simplified for demo
  }

  /// Get error statistics
  Map<String, dynamic> getErrorStatistics() {
    return {
      'total_errors': _errorHistory.length,
      'error_counts': _errorCounts,
      'recent_errors': _errorHistory.take(10).map((e) => e.toJson()).toList(),
      'error_types': _errorCounts.keys.map((k) => k.split('_')[0]).toSet().length,
    };
  }

  /// Clear error history
  void clearErrorHistory() {
    _errorHistory.clear();
    _errorCounts.clear();
    _lastErrorTimes.clear();
  }

  /// Dispose resources
  void dispose() {
    _errorController.close();
    _recoveryController.close();
  }
}

/// Error types
enum ErrorType {
  network,
  aiService,
  database,
  memory,
  ui,
  platform,
  zone,
  unknown,
}

/// Error event data class
class ErrorEvent {
  final ErrorType type;
  final String message;
  final String exception;
  final String? stackTrace;
  final DateTime timestamp;
  final Map<String, dynamic> context;

  ErrorEvent({
    required this.type,
    required this.message,
    required this.exception,
    this.stackTrace,
    required this.timestamp,
    required this.context,
  });

  Map<String, dynamic> toJson() => {
    'type': type.name,
    'message': message,
    'exception': exception,
    'stackTrace': stackTrace,
    'timestamp': timestamp.toIso8601String(),
    'context': context,
  };
}

/// Recovery strategy data class
class RecoveryStrategy {
  final String name;
  final int priority;
  final Future<bool> Function(ErrorEvent) action;

  RecoveryStrategy({
    required this.name,
    required this.priority,
    required this.action,
  });
}

/// Recovery action data class
class RecoveryAction {
  final ErrorEvent errorEvent;
  final RecoveryStrategy? strategy;
  final bool success;
  final DateTime timestamp;

  RecoveryAction({
    required this.errorEvent,
    this.strategy,
    required this.success,
    required this.timestamp,
  });
}
