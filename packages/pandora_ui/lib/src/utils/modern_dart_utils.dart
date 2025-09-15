/// Modern Dart utilities using Dart 3.9.2 features
/// 
/// This file demonstrates modern Dart patterns and features
/// for better code quality and performance

import 'dart:async';
import 'dart:math' as math;

/// Sealed class for performance states using Dart 3.0+ sealed classes
sealed class PerformanceState {
  const PerformanceState();
}

/// High performance state
final class HighPerformance extends PerformanceState {
  const HighPerformance();
}

/// Medium performance state
final class MediumPerformance extends PerformanceState {
  const MediumPerformance();
}

/// Low performance state
final class LowPerformance extends PerformanceState {
  const LowPerformance();
}

/// Critical performance state
final class CriticalPerformance extends PerformanceState {
  const CriticalPerformance();
}

/// Modern performance monitor using sealed classes and pattern matching
class ModernPerformanceMonitor {
  static PerformanceState _currentState = const HighPerformance();
  static final List<double> _frameRates = [];
  static const int maxSamples = 30;

  /// Get current performance state using pattern matching
  static PerformanceState get currentState => _currentState;

  /// Update performance state using modern pattern matching
  static void updatePerformanceState(double frameRate) {
    _frameRates.add(frameRate);
    if (_frameRates.length > maxSamples) {
      _frameRates.removeAt(0);
    }

    final averageFrameRate = _frameRates.reduce((a, b) => a + b) / _frameRates.length;
    
    // Use pattern matching for state updates
    _currentState = switch (averageFrameRate) {
      >= 55.0 => const HighPerformance(),
      >= 45.0 => const MediumPerformance(),
      >= 30.0 => const LowPerformance(),
      _ => const CriticalPerformance(),
    };
  }

  /// Get performance recommendations using pattern matching
  static String getPerformanceRecommendation() {
    return switch (_currentState) {
      HighPerformance() => 'Performance is excellent. No optimizations needed.',
      MediumPerformance() => 'Performance is good. Consider reducing animation complexity.',
      LowPerformance() => 'Performance is poor. Reduce widget count and optimize animations.',
      CriticalPerformance() => 'Performance is critical. Immediate optimization required.',
    };
  }

  /// Check if performance is acceptable using pattern matching
  static bool get isPerformanceAcceptable {
    return switch (_currentState) {
      HighPerformance() || MediumPerformance() => true,
      LowPerformance() || CriticalPerformance() => false,
    };
  }
}

/// Modern async utilities using Dart 3.0+ features
class ModernAsyncUtils {
  /// Debounce function with modern async patterns
  static Timer? _debounceTimer;
  
  static void debounce(
    Duration delay,
    void Function() callback,
  ) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(delay, callback);
  }

  /// Throttle function with modern async patterns
  static DateTime? _lastThrottleCall;
  
  static bool throttle(Duration delay) {
    final now = DateTime.now();
    if (_lastThrottleCall == null || 
        now.difference(_lastThrottleCall!) >= delay) {
      _lastThrottleCall = now;
      return true;
    }
    return false;
  }

  /// Retry with exponential backoff using modern async patterns
  static Future<T> retryWithBackoff<T>(
    Future<T> Function() operation, {
    int maxRetries = 3,
    Duration initialDelay = const Duration(milliseconds: 100),
    double backoffMultiplier = 2.0,
  }) async {
    int retries = 0;
    Duration delay = initialDelay;

    while (retries < maxRetries) {
      try {
        return await operation();
      } catch (e) {
        retries++;
        if (retries >= maxRetries) rethrow;
        
        await Future.delayed(delay);
        delay = Duration(
          milliseconds: (delay.inMilliseconds * backoffMultiplier).round(),
        );
      }
    }
    
    throw StateError('Max retries exceeded');
  }
}

/// Modern math utilities using Dart 3.0+ features
class ModernMathUtils {
  /// Clamp value with modern null safety
  static double clampValue(double value, double min, double max) {
    return math.max(min, math.min(max, value));
  }

  /// Lerp with modern null safety and type safety
  static double lerp(double a, double b, double t) {
    return a + (b - a) * t.clamp(0.0, 1.0);
  }

  /// Smooth step function for animations
  static double smoothStep(double edge0, double edge1, double x) {
    final t = ((x - edge0) / (edge1 - edge0)).clamp(0.0, 1.0);
    return t * t * (3.0 - 2.0 * t);
  }

  /// Ease in out cubic for smooth animations
  static double easeInOutCubic(double t) {
    return t < 0.5 
        ? 4 * t * t * t 
        : 1 - math.pow(-2 * t + 2, 3) / 2;
  }
}

/// Modern collection utilities using Dart 3.0+ features
class ModernCollectionUtils {
  /// Safe list access with default value
  static T safeGet<T>(List<T> list, int index, T defaultValue) {
    return (index >= 0 && index < list.length) ? list[index] : defaultValue;
  }

  /// Chunk list into smaller lists
  static List<List<T>> chunk<T>(List<T> list, int chunkSize) {
    final chunks = <List<T>>[];
    for (int i = 0; i < list.length; i += chunkSize) {
      chunks.add(list.sublist(
        i, 
        math.min(i + chunkSize, list.length),
      ));
    }
    return chunks;
  }

  /// Remove duplicates while preserving order
  static List<T> unique<T>(List<T> list) {
    final seen = <T>{};
    return list.where((element) => seen.add(element)).toList();
  }
}

/// Modern string utilities using Dart 3.0+ features
class ModernStringUtils {
  /// Check if string is null or empty
  static bool isNullOrEmpty(String? str) {
    return str == null || str.isEmpty;
  }

  /// Check if string is not null and not empty
  static bool isNotNullOrEmpty(String? str) {
    return str != null && str.isNotEmpty;
  }

  /// Capitalize first letter
  static String capitalize(String str) {
    if (str.isEmpty) return str;
    return str[0].toUpperCase() + str.substring(1).toLowerCase();
  }

  /// Convert to camelCase
  static String toCamelCase(String str) {
    final words = str.split(RegExp(r'[\s_-]+'));
    if (words.isEmpty) return str;
    
    return words.first.toLowerCase() + 
           words.skip(1).map((word) => capitalize(word)).join();
  }
}

/// Modern validation utilities using Dart 3.0+ features
class ModernValidationUtils {
  /// Validate email using modern regex
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Validate phone number
  static bool isValidPhone(String phone) {
    final phoneRegex = RegExp(r'^\+?[\d\s-()]+$');
    return phoneRegex.hasMatch(phone) && phone.replaceAll(RegExp(r'[\s-()]'), '').length >= 10;
  }

  /// Validate URL
  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }
}

