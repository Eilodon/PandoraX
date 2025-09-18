import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AIRouterService {
  static final AIRouterService _instance = AIRouterService._internal();
  factory AIRouterService() => _instance;
  AIRouterService._internal();

  final StateController<AIMode> _currentMode = StateController<AIMode>(AIMode.balanced);
  final StateController<DateTime?> _lastActivity = StateController<DateTime?>(null);

  StateController<AIMode> get currentMode => _currentMode;
  StateController<DateTime?> get lastActivity => _lastActivity;

  Future<void> switchMode(AIMode mode) async {
    _currentMode.state = mode;
    _lastActivity.state = DateTime.now();
  }

  Future<AIMode> getOptimalMode() async {
    // Mock implementation - return balanced mode
    return AIMode.balanced;
  }

  Future<bool> isModeAvailable(AIMode mode) async {
    // Mock implementation - all modes available
    return true;
  }
}

enum AIMode {
  performance,
  balanced,
  quality,
  experimental,
}

extension AIModeExtension on AIMode {
  String get displayName {
    switch (this) {
      case AIMode.performance:
        return 'Performance';
      case AIMode.balanced:
        return 'Balanced';
      case AIMode.quality:
        return 'Quality';
      case AIMode.experimental:
        return 'Experimental';
    }
  }

  String get description {
    switch (this) {
      case AIMode.performance:
        return 'Fast responses, lower quality';
      case AIMode.balanced:
        return 'Good balance of speed and quality';
      case AIMode.quality:
        return 'High quality, slower responses';
      case AIMode.experimental:
        return 'Latest features, may be unstable';
    }
  }
}
