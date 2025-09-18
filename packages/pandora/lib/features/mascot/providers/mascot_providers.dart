import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'mascot_state.dart';

/// Mascot State Provider
final mascotStateProvider = StateNotifierProvider<MascotNotifier, MascotState>((ref) {
  return MascotNotifier();
});

/// Mascot Notifier
/// 
/// Manages mascot state including:
/// - Mood changes based on time of day
/// - Interaction states and animations
/// - Environment objects and decorations
/// - Greeting messages and personality
class MascotNotifier extends StateNotifier<MascotState> {
  MascotNotifier() : super(const MascotState()) {
    _initializeMascot();
  }

  /// Initialize mascot with current time-based mood
  void _initializeMascot() {
    _updateMoodBasedOnTime();
    _startMoodUpdates();
  }

  /// Update mood based on current time
  void _updateMoodBasedOnTime() {
    final hour = DateTime.now().hour;
    MascotMood newMood;
    
    if (hour >= 6 && hour < 10) {
      newMood = MascotMood.morning;
    } else if (hour >= 10 && hour < 14) {
      newMood = MascotMood.energetic;
    } else if (hour >= 14 && hour < 18) {
      newMood = MascotMood.happy;
    } else if (hour >= 18 && hour < 22) {
      newMood = MascotMood.relaxed;
    } else if (hour >= 22 || hour < 6) {
      newMood = MascotMood.sleepy;
    } else {
      newMood = MascotMood.neutral;
    }
    
    state = state.copyWith(mood: newMood);
  }

  /// Start mood updates based on time
  void _startMoodUpdates() {
    // Update mood every hour
    Timer.periodic(const Duration(hours: 1), (timer) {
      _updateMoodBasedOnTime();
    });
  }

  /// Trigger mascot interaction
  void triggerInteraction() {
    state = state.copyWith(
      isInteracting: true,
      lastInteractionTime: DateTime.now(),
    );
    
    // Reset interaction state after animation
    Timer(const Duration(seconds: 2), () {
      state = state.copyWith(isInteracting: false);
    });
  }

  /// Set mascot mood manually
  void setMood(MascotMood mood) {
    state = state.copyWith(mood: mood);
  }

  /// Unlock environment object
  void unlockObject(String objectId) {
    final currentUnlocked = List<String>.from(state.unlockedObjects);
    if (!currentUnlocked.contains(objectId)) {
      currentUnlocked.add(objectId);
      state = state.copyWith(unlockedObjects: currentUnlocked);
      
      // Trigger celebration animation
      _triggerCelebration();
    }
  }

  /// Lock environment object
  void lockObject(String objectId) {
    final currentUnlocked = List<String>.from(state.unlockedObjects);
    currentUnlocked.remove(objectId);
    state = state.copyWith(unlockedObjects: currentUnlocked);
  }

  /// Trigger celebration animation
  void _triggerCelebration() {
    state = state.copyWith(isCelebrating: true);
    
    // Reset celebration state after animation
    Timer(const Duration(seconds: 3), () {
      state = state.copyWith(isCelebrating: false);
    });
  }

  /// Feed mascot (affects happiness)
  void feedMascot() {
    final newHappiness = (state.happiness + 10).clamp(0, 100);
    state = state.copyWith(happiness: newHappiness);
    
    // Trigger feeding animation
    triggerInteraction();
  }

  /// Play with mascot (affects energy)
  void playWithMascot() {
    final newEnergy = (state.energy + 15).clamp(0, 100);
    state = state.copyWith(energy: newEnergy);
    
    // Trigger play animation
    triggerInteraction();
  }

  /// Pet mascot (affects affection)
  void petMascot() {
    final newAffection = (state.affection + 5).clamp(0, 100);
    state = state.copyWith(affection: newAffection);
    
    // Trigger petting animation
    triggerInteraction();
  }

  /// Update mascot stats based on time
  void updateStatsOverTime() {
    final now = DateTime.now();
    final lastUpdate = state.lastStatsUpdate;
    
    if (lastUpdate != null) {
      final hoursPassed = now.difference(lastUpdate).inHours;
      
      if (hoursPassed > 0) {
        // Decrease stats over time
        final newHappiness = (state.happiness - (hoursPassed * 2)).clamp(0, 100);
        final newEnergy = (state.energy - (hoursPassed * 1)).clamp(0, 100);
        final newAffection = (state.affection - (hoursPassed * 0.5)).clamp(0, 100);
        
        state = state.copyWith(
          happiness: newHappiness,
          energy: newEnergy,
          affection: newAffection,
          lastStatsUpdate: now,
        );
      }
    } else {
      state = state.copyWith(lastStatsUpdate: now);
    }
  }

  /// Get greeting message based on current mood
  String getGreetingMessage() {
    final mood = state.mood;
    final messages = _getGreetingMessagesForMood(mood);
    final randomIndex = DateTime.now().millisecond % messages.length;
    return messages[randomIndex];
  }

  /// Get greeting messages for specific mood
  List<String> _getGreetingMessagesForMood(MascotMood mood) {
    switch (mood) {
      case MascotMood.morning:
        return [
          'Good morning! Ready to start a new day? 🌅',
          'Morning! Let\'s make today amazing! ☀️',
          'Rise and shine! What should we do today? 🌸',
          'Good morning! I\'m so happy to see you! 💖',
        ];
      
      case MascotMood.energetic:
        return [
          'Let\'s go! I\'m full of energy today! ⚡',
          'I\'m so excited! What adventure awaits? 🚀',
          'Ready for action! Let\'s do something fun! 💪',
          'I feel amazing! Let\'s conquer the day! 🌟',
        ];
      
      case MascotMood.happy:
        return [
          'Hi there! I\'m so happy to see you! 😊',
          'You make me so happy! What should we do? 🎉',
          'I\'m in such a good mood today! 🌈',
          'Your smile makes my day brighter! ☺️',
        ];
      
      case MascotMood.relaxed:
        return [
          'Hey there! Feeling pretty chill today 🌿',
          'What a lovely day! Want to relax together? 🍃',
          'I\'m feeling so peaceful right now ☮️',
          'Let\'s take it easy and enjoy the moment 🌸',
        ];
      
      case MascotMood.sleepy:
        return [
          'I\'m getting a bit sleepy... 😴',
          'Time for some rest, don\'t you think? 🌙',
          'I\'m feeling cozy and warm... 🛌',
          'Maybe we should wind down together 🌃',
        ];
      
      case MascotMood.neutral:
        return [
          'Hello! How are you doing today? 👋',
          'Nice to see you! What\'s on your mind? 🤔',
          'Hey! Ready for whatever comes next? 😌',
          'Hi there! I\'m here whenever you need me 💙',
        ];
      
      case MascotMood.sad:
        return [
          'I\'m feeling a bit down today... 😔',
          'Could you cheer me up? I need some love 💔',
          'I\'m having a rough day... can you help? 🥺',
          'I miss you when you\'re not around... 💙',
        ];
      
      case MascotMood.excited:
        return [
          'I\'m SO excited! Something amazing is happening! 🎊',
          'This is incredible! I can\'t contain my joy! 🎈',
          'I\'m bursting with excitement! Let\'s celebrate! 🎉',
          'This is the best day ever! I love it! ✨',
        ];
    }
  }

  /// Get mascot animation based on mood
  String getMascotAnimation() {
    switch (state.mood) {
      case MascotMood.morning:
        return 'mascot_morning.json';
      case MascotMood.energetic:
        return 'mascot_energetic.json';
      case MascotMood.happy:
        return 'mascot_happy.json';
      case MascotMood.relaxed:
        return 'mascot_relaxed.json';
      case MascotMood.sleepy:
        return 'mascot_sleepy.json';
      case MascotMood.neutral:
        return 'mascot_neutral.json';
      case MascotMood.sad:
        return 'mascot_sad.json';
      case MascotMood.excited:
        return 'mascot_excited.json';
    }
  }

  /// Get mascot color based on mood
  Color getMascotColor() {
    switch (state.mood) {
      case MascotMood.morning:
        return Colors.orange.shade300;
      case MascotMood.energetic:
        return Colors.red.shade400;
      case MascotMood.happy:
        return Colors.yellow.shade400;
      case MascotMood.relaxed:
        return Colors.green.shade300;
      case MascotMood.sleepy:
        return Colors.purple.shade300;
      case MascotMood.neutral:
        return Colors.blue.shade300;
      case MascotMood.sad:
        return Colors.grey.shade400;
      case MascotMood.excited:
        return Colors.pink.shade400;
    }
  }

  /// Check if mascot needs attention
  bool needsAttention() {
    return state.happiness < 30 || state.energy < 20 || state.affection < 25;
  }

  /// Get attention message
  String getAttentionMessage() {
    if (state.happiness < 30) {
      return 'I\'m feeling a bit sad... could you cheer me up? 😢';
    } else if (state.energy < 20) {
      return 'I\'m so tired... maybe we should rest together? 😴';
    } else if (state.affection < 25) {
      return 'I miss you... could you spend some time with me? 💙';
    } else {
      return 'I\'m doing great! Thanks for taking care of me! 😊';
    }
  }

  /// Reset mascot to default state
  void resetMascot() {
    state = const MascotState();
    _initializeMascot();
  }

  /// Update mascot personality
  void updatePersonality(MascotPersonality personality) {
    state = state.copyWith(personality: personality);
  }

  /// Get personality-based responses
  List<String> getPersonalityResponses() {
    switch (state.personality) {
      case MascotPersonality.cute:
        return [
          'You\'re so sweet! I love spending time with you! 🥰',
          'You make my heart flutter! 💕',
          'I feel so special when you\'re around! ✨',
        ];
      
      case MascotPersonality.playful:
        return [
          'Let\'s play! I have so many fun ideas! 🎮',
          'Come on, let\'s have some fun together! 🎪',
          'I\'m always up for an adventure! 🏃‍♂️',
        ];
      
      case MascotPersonality.caring:
        return [
          'How are you feeling today? I\'m here for you! 🤗',
          'Don\'t worry, everything will be okay! 💙',
          'You\'re doing great! I\'m proud of you! 👏',
        ];
      
      case MascotPersonality.wise:
        return [
          'Let me share some wisdom with you today! 🧠',
          'Every challenge is an opportunity to grow! 🌱',
          'Remember, progress is more important than perfection! 📈',
        ];
    }
  }
}

/// Mascot State
class MascotState {
  final MascotMood mood;
  final bool isInteracting;
  final bool isCelebrating;
  final DateTime? lastInteractionTime;
  final DateTime? lastStatsUpdate;
  final List<String> unlockedObjects;
  final int happiness;
  final int energy;
  final int affection;
  final MascotPersonality personality;

  const MascotState({
    this.mood = MascotMood.neutral,
    this.isInteracting = false,
    this.isCelebrating = false,
    this.lastInteractionTime,
    this.lastStatsUpdate,
    this.unlockedObjects = const [],
    this.happiness = 80,
    this.energy = 70,
    this.affection = 75,
    this.personality = MascotPersonality.cute,
  });

  MascotState copyWith({
    MascotMood? mood,
    bool? isInteracting,
    bool? isCelebrating,
    DateTime? lastInteractionTime,
    DateTime? lastStatsUpdate,
    List<String>? unlockedObjects,
    int? happiness,
    int? energy,
    int? affection,
    MascotPersonality? personality,
  }) {
    return MascotState(
      mood: mood ?? this.mood,
      isInteracting: isInteracting ?? this.isInteracting,
      isCelebrating: isCelebrating ?? this.isCelebrating,
      lastInteractionTime: lastInteractionTime ?? this.lastInteractionTime,
      lastStatsUpdate: lastStatsUpdate ?? this.lastStatsUpdate,
      unlockedObjects: unlockedObjects ?? this.unlockedObjects,
      happiness: happiness ?? this.happiness,
      energy: energy ?? this.energy,
      affection: affection ?? this.affection,
      personality: personality ?? this.personality,
    );
  }
}

/// Mascot Mood Enum
enum MascotMood {
  morning,
  energetic,
  happy,
  relaxed,
  sleepy,
  neutral,
  sad,
  excited,
}

/// Mascot Personality Enum
enum MascotPersonality {
  cute,
  playful,
  caring,
  wise,
}

