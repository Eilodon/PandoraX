import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mascot_service.dart';
import 'mascot_enums.dart';

/// Mascot Task Integration Service
/// 
/// Integrates mascot behavior with task events like completion and deadlines
class MascotTaskIntegrationService {
  final Ref _ref;
  Timer? _deadlineCheckTimer;
  Timer? _idleCheckTimer;
  
  MascotTaskIntegrationService(this._ref) {
    _startDeadlineChecker();
    _startIdleChecker();
  }

  /// Start checking for missed deadlines
  void _startDeadlineChecker() {
    _deadlineCheckTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      _checkMissedDeadlines();
    });
  }

  /// Start checking for user idle time
  void _startIdleChecker() {
    _idleCheckTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      _checkIdleTime();
    });
  }

  /// Check for missed deadlines
  void _checkMissedDeadlines() {
    // This would integrate with your task system
    // For now, we'll simulate checking deadlines
    final now = DateTime.now();
    final mascotState = _ref.read(mascotServiceProvider);
    
    // Check if user has been idle for too long without completing tasks
    final idleTime = now.difference(mascotState.lastInteraction);
    if (idleTime.inMinutes > 30 && mascotState.missedDeadlines == 0) {
      // Simulate a missed deadline
      _ref.read(mascotServiceProvider.notifier).handleUserAction(UserAction.missDeadline);
    }
  }

  /// Check for user idle time
  void _checkIdleTime() {
    final mascotState = _ref.read(mascotServiceProvider);
    final now = DateTime.now();
    final idleTime = now.difference(mascotState.lastInteraction);
    
    if (idleTime.inMinutes > 10 && !mascotState.isSleeping) {
      _ref.read(mascotServiceProvider.notifier).handleUserAction(UserAction.longIdle);
    }
  }

  /// Handle task completion
  void onTaskCompleted() {
    _ref.read(mascotServiceProvider.notifier).handleUserAction(UserAction.completeTask);
  }

  /// Handle task creation
  void onTaskCreated() {
    _ref.read(mascotServiceProvider.notifier).handleUserAction(UserAction.createNote);
  }

  /// Handle app opening
  void onAppOpened() {
    _ref.read(mascotServiceProvider.notifier).handleUserAction(UserAction.openApp);
  }

  /// Handle direct mascot interaction
  void onMascotTouched() {
    _ref.read(mascotServiceProvider.notifier).handleUserAction(UserAction.directTouch);
  }

  /// Handle AI processing
  void onAIProcessing() {
    _ref.read(mascotServiceProvider.notifier).handleUserAction(UserAction.aiProcessing);
  }

  /// Handle error
  void onError() {
    _ref.read(mascotServiceProvider.notifier).handleUserAction(UserAction.error);
  }

  /// Handle sync
  void onSync() {
    _ref.read(mascotServiceProvider.notifier).handleUserAction(UserAction.sync);
  }

  /// Dispose resources
  void dispose() {
    _deadlineCheckTimer?.cancel();
    _idleCheckTimer?.cancel();
  }
}

/// Provider for Mascot Task Integration Service
final mascotTaskIntegrationProvider = Provider<MascotTaskIntegrationService>((ref) {
  final service = MascotTaskIntegrationService(ref);
  ref.onDispose(() => service.dispose());
  return service;
});

/// Mascot Behavior Controller
/// 
/// High-level controller for managing mascot behavior based on app state
class MascotBehaviorController {
  final Ref _ref;
  
  MascotBehaviorController(this._ref);

  /// Initialize mascot behavior when app starts
  void initializeMascot() {
    _ref.read(mascotTaskIntegrationProvider).onAppOpened();
  }

  /// Handle user interaction with mascot
  void handleMascotInteraction() {
    _ref.read(mascotTaskIntegrationProvider).onMascotTouched();
  }

  /// Handle task-related events
  void handleTaskEvent(TaskEvent event) {
    switch (event) {
      case TaskEvent.completed:
        _ref.read(mascotTaskIntegrationProvider).onTaskCompleted();
        break;
      case TaskEvent.created:
        _ref.read(mascotTaskIntegrationProvider).onTaskCreated();
        break;
      case TaskEvent.missedDeadline:
        _ref.read(mascotTaskIntegrationProvider).onTaskCompleted(); // This will trigger missDeadline
        break;
      case TaskEvent.updated:
        _ref.read(mascotTaskIntegrationProvider).onTaskUpdated();
        break;
    }
  }

  /// Handle AI-related events
  void handleAIEvent(AIEvent event) {
    switch (event) {
      case AIEvent.processing:
        _ref.read(mascotTaskIntegrationProvider).onAIProcessing();
        break;
      case AIEvent.error:
        _ref.read(mascotTaskIntegrationProvider).onError();
        break;
      case AIEvent.completed:
        _ref.read(mascotTaskIntegrationProvider).onAICompleted();
        break;
    }
  }

  /// Handle sync events
  void handleSyncEvent() {
    _ref.read(mascotTaskIntegrationProvider).onSync();
  }
}

/// Task events that can trigger mascot reactions
enum TaskEvent {
  completed,
  created,
  missedDeadline,
  updated,
  deleted,
}

/// AI events that can trigger mascot reactions
enum AIEvent {
  processing,
  completed,
  error,
  thinking,
}

/// Provider for Mascot Behavior Controller
final mascotBehaviorControllerProvider = Provider<MascotBehaviorController>((ref) {
  return MascotBehaviorController(ref);
});
