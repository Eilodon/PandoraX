import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

class LoggerService {
  static final LoggerService _instance = LoggerService._internal();
  factory LoggerService() => _instance;
  LoggerService._internal();

  static void debug(String message, {String? tag}) {
    if (kDebugMode) {
      developer.log(message, name: tag ?? 'DEBUG');
    }
  }

  static void info(String message, {String? tag}) {
    if (kDebugMode) {
      developer.log(message, name: tag ?? 'INFO');
    }
  }

  static void warning(String message, {String? tag}) {
    if (kDebugMode) {
      developer.log(message, name: tag ?? 'WARNING');
    }
  }

  static void error(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      developer.log(
        message,
        name: tag ?? 'ERROR',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  static void production(String message, {String? tag}) {
    // Only log in production for critical issues
    developer.log(message, name: tag ?? 'PRODUCTION');
  }
}
