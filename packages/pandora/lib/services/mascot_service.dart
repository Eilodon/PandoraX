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
  final bool isSleeping;
  final Duration idleTime;
  final int missedDeadlines;

  const MascotState({
    this.mood = MascotMood.neutral,
    this.currentAnimation = MascotAnimation.idle,
    this.isVisible = true,
    this.currentMessage,
    this.interactionCount = 0,
    required this.lastInteraction,
    this.isSleeping = false,
    this.idleTime = Duration.zero,
    this.missedDeadlines = 0,
  });

  MascotState copyWith({
    MascotMood? mood,
    MascotAnimation? currentAnimation,
    bool? isVisible,
    String? currentMessage,
    int? interactionCount,
    DateTime? lastInteraction,
    bool? isSleeping,
    Duration? idleTime,
    int? missedDeadlines,
  }) {
    return MascotState(
      mood: mood ?? this.mood,
      currentAnimation: currentAnimation ?? this.currentAnimation,
      isVisible: isVisible ?? this.isVisible,
      currentMessage: currentMessage ?? this.currentMessage,
      interactionCount: interactionCount ?? this.interactionCount,
      lastInteraction: lastInteraction ?? this.lastInteraction,
      isSleeping: isSleeping ?? this.isSleeping,
      idleTime: idleTime ?? this.idleTime,
      missedDeadlines: missedDeadlines ?? this.missedDeadlines,
    );
  }
}

/// Mascot Service
/// 
/// Manages mascot state, interactions, and animations
class MascotService extends StateNotifier<MascotState> {
  MascotService() : super(MascotState(lastInteraction: DateTime.now())) {
    _startIdleAnimation();
    _startIdleTimer();
  }

  Timer? _idleTimer;
  Timer? _sleepTimer;
  final Random _random = Random();

  void _startIdleAnimation() {
    _idleTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      if (mounted) {
        _performIdleAction();
      }
    });
  }

  void _startIdleTimer() {
    _sleepTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        _updateIdleTime();
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

  void _updateIdleTime() {
    final now = DateTime.now();
    final idleDuration = now.difference(state.lastInteraction);
    
    state = state.copyWith(idleTime: idleDuration);
    
    // If idle for more than 5 minutes, go to sleep
    if (idleDuration.inMinutes > 5 && !state.isSleeping) {
      _goToSleep();
    }
  }

  void _goToSleep() {
    state = state.copyWith(
      mood: MascotMood.sleeping,
      currentAnimation: MascotAnimation.sleep,
      currentMessage: "Zzz... I'm taking a nap. Wake me up when you're ready!",
      isSleeping: true,
    );
  }

  void _wakeUp() {
    state = state.copyWith(
      mood: MascotMood.welcoming,
      currentAnimation: MascotAnimation.wake,
      currentMessage: "Good to see you again! Let's get back to work!",
      isSleeping: false,
      lastInteraction: DateTime.now(),
    );
  }

  /// Handle user actions
  void handleUserAction(UserAction action) {
    final now = DateTime.now();
    
    // Wake up if sleeping
    if (state.isSleeping) {
      _wakeUp();
    }
    
    switch (action) {
      case UserAction.openApp:
        state = state.copyWith(
          mood: MascotMood.welcoming,
          currentAnimation: MascotAnimation.wave,
          currentMessage: "Welcome back! I missed you! 👋",
          interactionCount: state.interactionCount + 1,
          lastInteraction: now,
        );
        break;
        
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
          mood: MascotMood.celebrating,
          currentAnimation: MascotAnimation.celebration,
          currentMessage: "🎉 Amazing! You did it! I'm so proud of you! 🎉",
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
        
      case UserAction.missDeadline:
        state = state.copyWith(
          mood: MascotMood.disappointed,
          currentAnimation: MascotAnimation.sad,
          currentMessage: "😔 Oh no... We missed the deadline. But don't worry, we can do better next time!",
          interactionCount: state.interactionCount + 1,
          lastInteraction: now,
          missedDeadlines: state.missedDeadlines + 1,
        );
        break;
        
      case UserAction.longIdle:
        state = state.copyWith(
          mood: MascotMood.idle,
          currentAnimation: MascotAnimation.idle,
          currentMessage: "Hey there! I'm here if you need me. What should we work on?",
          lastInteraction: now,
        );
        break;
        
      case UserAction.directTouch:
        _handleDirectTouch();
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

  void _handleDirectTouch() {
    final now = DateTime.now();
    final randomActions = [
      (MascotMood.playful, MascotAnimation.bounce, "That tickles! 😄"),
      (MascotMood.happy, MascotAnimation.jump, "Hi there! Nice to see you! 👋"),
      (MascotMood.excited, MascotAnimation.spin, "Wheee! You're so fun! 🎉"),
      (MascotMood.playful, MascotAnimation.wave, "Hello! Want to play? 🎮"),
      (MascotMood.happy, MascotAnimation.random, "You make me so happy! 😊"),
    ];
    
    final randomAction = randomActions[_random.nextInt(randomActions.length)];
    state = state.copyWith(
      mood: randomAction.$1,
      currentAnimation: randomAction.$2,
      currentMessage: randomAction.$3,
      interactionCount: state.interactionCount + 1,
      lastInteraction: now,
    );
  }

  /// Handle direct interactions
  void handleInteraction(MascotInteraction interaction) {
    final now = DateTime.now();
    
    // Wake up if sleeping
    if (state.isSleeping) {
      _wakeUp();
    }
    
    switch (interaction) {
      case MascotInteraction.tap:
        _handleDirectTouch();
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
    _sleepTimer?.cancel();
    super.dispose();
  }
}

/// Mascot Service Provider
final mascotServiceProvider = StateNotifierProvider<MascotService, MascotState>(
  (ref) => MascotService(),
);