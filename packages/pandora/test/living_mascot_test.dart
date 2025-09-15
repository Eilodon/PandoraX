import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora/services/mascot_service.dart';
import 'package:pandora/services/mascot_enums.dart';
import 'package:pandora/services/mascot_task_integration.dart';

void main() {
  group('Living Mascot System Tests', () {
    late ProviderContainer container;
    late MascotService mascotService;

    setUp(() {
      container = ProviderContainer();
      mascotService = container.read(mascotServiceProvider.notifier);
    });

    tearDown(() {
      container.dispose();
    });

    group('MascotService Tests', () {
      test('should initialize with neutral mood', () {
        final state = container.read(mascotServiceProvider);
        expect(state.mood, MascotMood.neutral);
        expect(state.currentAnimation, MascotAnimation.idle);
        expect(state.isVisible, true);
        expect(state.interactionCount, 0);
        expect(state.isSleeping, false);
        expect(state.missedDeadlines, 0);
      });

      test('should handle openApp action', () {
        mascotService.handleUserAction(UserAction.openApp);
        final state = container.read(mascotServiceProvider);
        
        expect(state.mood, MascotMood.welcoming);
        expect(state.currentAnimation, MascotAnimation.wave);
        expect(state.currentMessage, contains('Welcome back'));
        expect(state.interactionCount, 1);
      });

      test('should handle completeTask action', () {
        mascotService.handleUserAction(UserAction.completeTask);
        final state = container.read(mascotServiceProvider);
        
        expect(state.mood, MascotMood.celebrating);
        expect(state.currentAnimation, MascotAnimation.celebration);
        expect(state.currentMessage, contains('Amazing'));
        expect(state.interactionCount, 1);
      });

      test('should handle missDeadline action', () {
        mascotService.handleUserAction(UserAction.missDeadline);
        final state = container.read(mascotServiceProvider);
        
        expect(state.mood, MascotMood.disappointed);
        expect(state.currentAnimation, MascotAnimation.sad);
        expect(state.currentMessage, contains('missed the deadline'));
        expect(state.missedDeadlines, 1);
      });

      test('should handle directTouch action', () {
        mascotService.handleUserAction(UserAction.directTouch);
        final state = container.read(mascotServiceProvider);
        
        expect(state.mood, isIn([MascotMood.playful, MascotMood.happy, MascotMood.excited]));
        expect(state.interactionCount, 1);
      });

      test('should handle tap interaction', () {
        mascotService.handleInteraction(MascotInteraction.tap);
        final state = container.read(mascotServiceProvider);
        
        expect(state.mood, isIn([MascotMood.playful, MascotMood.happy, MascotMood.excited]));
        expect(state.interactionCount, 1);
      });

      test('should go to sleep after long idle time', () {
        // Simulate long idle time
        final now = DateTime.now();
        final longAgo = now.subtract(const Duration(minutes: 10));
        
        // Manually set last interaction to long ago
        mascotService.state = mascotService.state.copyWith(
          lastInteraction: longAgo,
        );
        
        // Trigger idle check
        mascotService.handleUserAction(UserAction.longIdle);
        final state = container.read(mascotServiceProvider);
        
        expect(state.mood, MascotMood.idle);
        expect(state.currentMessage, contains('Hey there'));
      });
    });

    group('MascotState Tests', () {
      test('should copy with new values', () {
        final originalState = MascotState(lastInteraction: DateTime.now());
        final newState = originalState.copyWith(
          mood: MascotMood.happy,
          currentAnimation: MascotAnimation.bounce,
          interactionCount: 5,
        );
        
        expect(newState.mood, MascotMood.happy);
        expect(newState.currentAnimation, MascotAnimation.bounce);
        expect(newState.interactionCount, 5);
        expect(newState.isVisible, originalState.isVisible);
        expect(newState.lastInteraction, originalState.lastInteraction);
      });
    });

    group('MascotTaskIntegrationService Tests', () {
      test('should handle task completion', () {
        final integrationService = container.read(mascotTaskIntegrationProvider);
        
        integrationService.onTaskCompleted();
        final state = container.read(mascotServiceProvider);
        
        expect(state.mood, MascotMood.celebrating);
        expect(state.currentAnimation, MascotAnimation.celebration);
      });

      test('should handle app opening', () {
        final integrationService = container.read(mascotTaskIntegrationProvider);
        
        integrationService.onAppOpened();
        final state = container.read(mascotServiceProvider);
        
        expect(state.mood, MascotMood.welcoming);
        expect(state.currentAnimation, MascotAnimation.wave);
      });

      test('should handle mascot touch', () {
        final integrationService = container.read(mascotTaskIntegrationProvider);
        
        integrationService.onMascotTouched();
        final state = container.read(mascotServiceProvider);
        
        expect(state.mood, isIn([MascotMood.playful, MascotMood.happy, MascotMood.excited]));
      });
    });

    group('MascotBehaviorController Tests', () {
      test('should handle task events', () {
        final controller = container.read(mascotBehaviorControllerProvider);
        
        controller.handleTaskEvent(TaskEvent.completed);
        final state = container.read(mascotServiceProvider);
        
        expect(state.mood, MascotMood.celebrating);
      });

      test('should handle AI events', () {
        final controller = container.read(mascotBehaviorControllerProvider);
        
        controller.handleAIEvent(AIEvent.processing);
        final state = container.read(mascotServiceProvider);
        
        expect(state.mood, MascotMood.thinking);
        expect(state.currentAnimation, MascotAnimation.spin);
      });

      test('should handle mascot interaction', () {
        final controller = container.read(mascotBehaviorControllerProvider);
        
        controller.handleMascotInteraction();
        final state = container.read(mascotServiceProvider);
        
        expect(state.mood, isIn([MascotMood.playful, MascotMood.happy, MascotMood.excited]));
      });
    });

    group('MascotMood Tests', () {
      test('should have all required moods', () {
        expect(MascotMood.values, contains(MascotMood.welcoming));
        expect(MascotMood.values, contains(MascotMood.celebrating));
        expect(MascotMood.values, contains(MascotMood.sleeping));
        expect(MascotMood.values, contains(MascotMood.idle));
        expect(MascotMood.values, contains(MascotMood.disappointed));
        expect(MascotMood.values, contains(MascotMood.playful));
      });
    });

    group('MascotAnimation Tests', () {
      test('should have all required animations', () {
        expect(MascotAnimation.values, contains(MascotAnimation.celebration));
        expect(MascotAnimation.values, contains(MascotAnimation.sleep));
        expect(MascotAnimation.values, contains(MascotAnimation.wake));
        expect(MascotAnimation.values, contains(MascotAnimation.sad));
        expect(MascotAnimation.values, contains(MascotAnimation.cloud));
        expect(MascotAnimation.values, contains(MascotAnimation.random));
      });
    });

    group('UserAction Tests', () {
      test('should have all required actions', () {
        expect(UserAction.values, contains(UserAction.missDeadline));
        expect(UserAction.values, contains(UserAction.longIdle));
        expect(UserAction.values, contains(UserAction.directTouch));
      });
    });
  });
}
