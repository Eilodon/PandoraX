import 'package:flutter/material.dart';

/// Mascot State Model
/// 
/// Represents the current state of the mascot including mood, stats, and interactions
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

  /// Get greeting messages based on current mood
  List<String> getGreetingMessages() {
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

  /// Get mascot animation file based on mood
  String getMascotAnimation() {
    switch (mood) {
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
    switch (mood) {
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
    return happiness < 30 || energy < 20 || affection < 25;
  }

  /// Get overall mascot health score
  double getHealthScore() {
    return (happiness + energy + affection) / 3.0;
  }

  /// Get mascot status description
  String getStatusDescription() {
    final score = getHealthScore();
    if (score >= 80) {
      return 'Excellent! I\'m feeling fantastic! 🌟';
    } else if (score >= 60) {
      return 'Good! I\'m doing well today! 😊';
    } else if (score >= 40) {
      return 'Okay, but I could use some care... 😐';
    } else if (score >= 20) {
      return 'I\'m not feeling too great... 😔';
    } else {
      return 'I really need your help... 🆘';
    }
  }

  /// Get attention message
  String getAttentionMessage() {
    if (happiness < 30) {
      return 'I\'m feeling a bit sad... could you cheer me up? 😢';
    } else if (energy < 20) {
      return 'I\'m so tired... maybe we should rest together? 😴';
    } else if (affection < 25) {
      return 'I miss you... could you spend some time with me? 💙';
    } else {
      return 'I\'m doing great! Thanks for taking care of me! 😊';
    }
  }

  /// Get personality-based responses
  List<String> getPersonalityResponses() {
    switch (personality) {
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MascotState &&
        other.mood == mood &&
        other.isInteracting == isInteracting &&
        other.isCelebrating == isCelebrating &&
        other.lastInteractionTime == lastInteractionTime &&
        other.lastStatsUpdate == lastStatsUpdate &&
        other.happiness == happiness &&
        other.energy == energy &&
        other.affection == affection &&
        other.personality == personality;
  }

  @override
  int get hashCode {
    return Object.hash(
      mood,
      isInteracting,
      isCelebrating,
      lastInteractionTime,
      lastStatsUpdate,
      happiness,
      energy,
      affection,
      personality,
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
