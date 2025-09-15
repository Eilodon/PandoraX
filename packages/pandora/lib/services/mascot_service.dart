import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mascot_enums.dart';

/// Mascot Service State
class MascotState {
  final MascotMood mood;
  final MascotAnimation currentAnimation;
  final bool isVisible;
  final String? currentMessage;
  final int interactionCount;
  final DateTime lastInteraction;

  const MascotState({
    this.mood = MascotMood.neutral,
    this.currentAnimation = MascotAnimation.idle,
    this.isVisible = true,
    this.currentMessage,
    this.interactionCount = 0,
    required this.lastInteraction,
  });

  MascotState copyWith({
    MascotMood? mood,
    MascotAnimation? currentAnimation,
    bool? isVisible,
    String? currentMessage,
    int? interactionCount,
    DateTime? lastInteraction,
  }) {
    return MascotState(
      mood: mood ?? this.mood,
      currentAnimation: currentAnimation ?? this.currentAnimation,
      isVisible: isVisible ?? this.isVisible,
      currentMessage: currentMessage ?? this.currentMessage,
      interactionCount: interactionCount ?? this.interactionCount,
      lastInteraction: lastInteraction ?? this.lastInteraction,
    );
  }
}

/// Mascot Service
/// 
/// Manages mascot state, interactions, and animations
class MascotService extends StateNotifier<MascotState> {
  MascotService() : super(MascotState(lastInteraction: DateTime.now())) {
    _startIdleAnimation();
  }

  Timer? _idleTimer;
  final Random _random = Random();

  void _startIdleAnimation() {
    _idleTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      if (mounted) {
        _performIdleAction();
      }
    });
  }

  void _performIdleAction() {
    final actions = [
      MascotAnimation.wave,
      MascotAnimation.bounce,
      MascotAnimation.spin,
    ];
    
    final randomAction = actions[_random.nextInt(actions.length)];
    state = state.copyWith(
      currentAnimation: randomAction,
      lastInteraction: DateTime.now(),
    );
  }

  /// Handle user actions
  void handleUserAction(UserAction action) {
    final now = DateTime.now();
    
    switch (action) {
      case UserAction.createNote:
        state = state.copyWith(
          mood: MascotMood.happy,
          currentAnimation: MascotAnimation.jump,
          currentMessage: "Great! Let's create something amazing!",
          interactionCount: state.interactionCount + 1,
          lastInteraction: now,
        );
        break;
        
      case UserAction.completeTask:
        state = state.copyWith(
          mood: MascotMood.proud,
          currentAnimation: MascotAnimation.bounce,
          currentMessage: "Well done! You're doing great!",
          interactionCount: state.interactionCount + 1,
          lastInteraction: now,
        );
        break;
        
      case UserAction.aiProcessing:
        state = state.copyWith(
          mood: MascotMood.thinking,
          currentAnimation: MascotAnimation.spin,
          currentMessage: "Let me think about that...",
          interactionCount: state.interactionCount + 1,
          lastInteraction: now,
        );
        break;
        
      case UserAction.error:
        state = state.copyWith(
          mood: MascotMood.sad,
          currentAnimation: MascotAnimation.fade,
          currentMessage: "Oops! Let me help you fix that.",
          interactionCount: state.interactionCount + 1,
          lastInteraction: now,
        );
        break;
        
      case UserAction.sync:
        state = state.copyWith(
          mood: MascotMood.excited,
          currentAnimation: MascotAnimation.slide,
          currentMessage: "Syncing your data...",
          interactionCount: state.interactionCount + 1,
          lastInteraction: now,
        );
        break;
        
      case UserAction.idle:
      default:
        state = state.copyWith(
          mood: MascotMood.neutral,
          currentAnimation: MascotAnimation.idle,
          currentMessage: null,
          lastInteraction: now,
        );
        break;
    }
  }

  /// Handle direct interactions
  void handleInteraction(MascotInteraction interaction) {
    final now = DateTime.now();
    
    switch (interaction) {
      case MascotInteraction.tap:
        state = state.copyWith(
          mood: MascotMood.happy,
          currentAnimation: MascotAnimation.bounce,
          currentMessage: "Hello there!",
          interactionCount: state.interactionCount + 1,
          lastInteraction: now,
        );
        break;
        
      case MascotInteraction.longPress:
        state = state.copyWith(
          mood: MascotMood.excited,
          currentAnimation: MascotAnimation.jump,
          currentMessage: "That tickles!",
          interactionCount: state.interactionCount + 1,
          lastInteraction: now,
        );
        break;
        
      case MascotInteraction.doubleTap:
        state = state.copyWith(
          mood: MascotMood.proud,
          currentAnimation: MascotAnimation.spin,
          currentMessage: "Double the fun!",
          interactionCount: state.interactionCount + 1,
          lastInteraction: now,
        );
        break;
        
      case MascotInteraction.swipe:
        state = state.copyWith(
          mood: MascotMood.excited,
          currentAnimation: MascotAnimation.slide,
          currentMessage: "Wheee!",
          interactionCount: state.interactionCount + 1,
          lastInteraction: now,
        );
        break;
        
      case MascotInteraction.voiceCommand:
        state = state.copyWith(
          mood: MascotMood.thinking,
          currentAnimation: MascotAnimation.idle,
          currentMessage: "I'm listening...",
          interactionCount: state.interactionCount + 1,
          lastInteraction: now,
        );
        break;
        
      case MascotInteraction.gesture:
        state = state.copyWith(
          mood: MascotMood.happy,
          currentAnimation: MascotAnimation.wave,
          currentMessage: "Nice gesture!",
          interactionCount: state.interactionCount + 1,
          lastInteraction: now,
        );
        break;
    }
  }

  /// Set mascot visibility
  void setVisibility(bool visible) {
    state = state.copyWith(isVisible: visible);
  }

  /// Set custom message
  void setMessage(String? message) {
    state = state.copyWith(currentMessage: message);
  }

  /// Update note count for mascot behavior
  void updateNoteCount(int count) {
    final now = DateTime.now();
    
    if (count == 0) {
      state = state.copyWith(
        mood: MascotMood.sad,
        currentMessage: "No notes yet. Let's create one!",
        lastInteraction: now,
      );
    } else if (count < 5) {
      state = state.copyWith(
        mood: MascotMood.happy,
        currentMessage: "Great start! Keep going!",
        lastInteraction: now,
      );
    } else {
      state = state.copyWith(
        mood: MascotMood.proud,
        currentMessage: "Wow! You're a note-taking champion!",
        lastInteraction: now,
      );
    }
  }

  /// Reset mascot to neutral state
  void reset() {
    state = MascotState(lastInteraction: DateTime.now());
  }

  @override
  void dispose() {
    _idleTimer?.cancel();
    super.dispose();
  }
}

/// Mascot Service Provider
final mascotServiceProvider = StateNotifierProvider<MascotService, MascotState>(
  (ref) => MascotService(),
);