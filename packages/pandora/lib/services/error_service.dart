import 'package:injectable/injectable.dart';

/// Centralized error handling service
@injectable
class ErrorService {
  /// Handle and format errors for display
  String handleError(dynamic error, {String? context}) {
    try {
      if (error is String) {
        return _formatErrorMessage(error, context);
      }
      
      if (error is Exception) {
        return _formatException(error, context);
      }
      
      if (error is Error) {
        return _formatError(error, context);
      }
      
      return _formatGenericError(error, context);
    } catch (e) {
      return 'An unexpected error occurred while handling the error: $e';
    }
  }
  
  /// Format string error message
  String _formatErrorMessage(String error, String? context) {
    final contextPrefix = context != null ? '[$context] ' : '';
    
    // Common error patterns
    if (error.contains('network') || error.contains('connection')) {
      return '${contextPrefix}Network connection error. Please check your internet connection.';
    }
    
    if (error.contains('permission') || error.contains('denied')) {
      return '${contextPrefix}Permission denied. Please check app permissions in settings.';
    }
    
    if (error.contains('timeout')) {
      return '${contextPrefix}Request timed out. Please try again.';
    }
    
    if (error.contains('not found') || error.contains('404')) {
      return '${contextPrefix}Resource not found.';
    }
    
    if (error.contains('unauthorized') || error.contains('401')) {
      return '${contextPrefix}Authentication failed. Please log in again.';
    }
    
    if (error.contains('forbidden') || error.contains('403')) {
      return '${contextPrefix}Access forbidden. You don\'t have permission to perform this action.';
    }
    
    if (error.contains('server') || error.contains('500')) {
      return '${contextPrefix}Server error. Please try again later.';
    }
    
    if (error.contains('API') || error.contains('api')) {
      return '${contextPrefix}API error: $error';
    }
    
    return '${contextPrefix}$error';
  }
  
  /// Format exception
  String _formatException(Exception exception, String? context) {
    final contextPrefix = context != null ? '[$context] ' : '';
    final message = exception.toString();
    
    if (message.contains('SocketException')) {
      return '${contextPrefix}Network connection failed. Please check your internet connection.';
    }
    
    if (message.contains('TimeoutException')) {
      return '${contextPrefix}Request timed out. Please try again.';
    }
    
    if (message.contains('FormatException')) {
      return '${contextPrefix}Invalid data format. Please check your input.';
    }
    
    if (message.contains('StateError')) {
      return '${contextPrefix}Application state error. Please restart the app.';
    }
    
    return '${contextPrefix}$message';
  }
  
  /// Format error
  String _formatError(Error error, String? context) {
    final contextPrefix = context != null ? '[$context] ' : '';
    final message = error.toString();
    
    if (message.contains('NoSuchMethodError')) {
      return '${contextPrefix}Method not found. This might be a version compatibility issue.';
    }
    
    if (message.contains('TypeError')) {
      return '${contextPrefix}Type error. Please check your data.';
    }
    
    if (message.contains('RangeError')) {
      return '${contextPrefix}Range error. Please check your input values.';
    }
    
    return '${contextPrefix}$message';
  }
  
  /// Format generic error
  String _formatGenericError(dynamic error, String? context) {
    final contextPrefix = context != null ? '[$context] ' : '';
    return '${contextPrefix}Unexpected error: $error';
  }
  
  /// Get user-friendly error message
  String getUserFriendlyMessage(String error) {
    switch (error.toLowerCase()) {
      case 'network_error':
        return 'Network connection failed. Please check your internet connection.';
      case 'permission_denied':
        return 'Permission denied. Please check app permissions in settings.';
      case 'timeout':
        return 'Request timed out. Please try again.';
      case 'not_found':
        return 'Resource not found.';
      case 'unauthorized':
        return 'Authentication failed. Please log in again.';
      case 'forbidden':
        return 'Access forbidden. You don\'t have permission to perform this action.';
      case 'server_error':
        return 'Server error. Please try again later.';
      case 'api_error':
        return 'API error. Please try again.';
      case 'validation_error':
        return 'Invalid input. Please check your data.';
      case 'storage_error':
        return 'Storage error. Please try again.';
      case 'sync_error':
        return 'Sync error. Please check your connection.';
      case 'ai_error':
        return 'AI service error. Please try again.';
      case 'voice_error':
        return 'Voice recognition error. Please try again.';
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }
  
  /// Get error category
  String getErrorCategory(dynamic error) {
    final errorString = error.toString().toLowerCase();
    
    if (errorString.contains('network') || errorString.contains('connection')) {
      return 'network';
    }
    
    if (errorString.contains('permission') || errorString.contains('denied')) {
      return 'permission';
    }
    
    if (errorString.contains('timeout')) {
      return 'timeout';
    }
    
    if (errorString.contains('api') || errorString.contains('server')) {
      return 'api';
    }
    
    if (errorString.contains('storage') || errorString.contains('database')) {
      return 'storage';
    }
    
    if (errorString.contains('ai') || errorString.contains('gemini')) {
      return 'ai';
    }
    
    if (errorString.contains('voice') || errorString.contains('speech')) {
      return 'voice';
    }
    
    if (errorString.contains('sync') || errorString.contains('firestore')) {
      return 'sync';
    }
    
    return 'unknown';
  }
  
  /// Get error severity
  String getErrorSeverity(dynamic error) {
    final errorString = error.toString().toLowerCase();
    
    if (errorString.contains('critical') || errorString.contains('fatal')) {
      return 'critical';
    }
    
    if (errorString.contains('error') || errorString.contains('exception')) {
      return 'error';
    }
    
    if (errorString.contains('warning') || errorString.contains('warn')) {
      return 'warning';
    }
    
    if (errorString.contains('info') || errorString.contains('information')) {
      return 'info';
    }
    
    return 'error';
  }
  
  /// Get error context
  Map<String, dynamic> getErrorContext(dynamic error, {String? context}) {
    return {
      'error': error.toString(),
      'context': context,
      'category': getErrorCategory(error),
      'severity': getErrorSeverity(error),
      'timestamp': DateTime.now().toIso8601String(),
      'user_friendly_message': getUserFriendlyMessage(getErrorCategory(error)),
    };
  }
}
