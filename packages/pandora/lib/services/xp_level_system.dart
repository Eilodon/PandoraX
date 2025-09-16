import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pandora_ui/pandora_ui.dart';

/// XP Level System State
class XPLevelState {
  final int currentXP;
  final int currentLevel;
  final int xpToNextLevel;
  final int totalXP;
  final List<LevelReward> unlockedRewards;
  final List<Achievement> achievements;
  final bool isLoading;
  final String? error;

  const XPLevelState({
    this.currentXP = 0,
    this.currentLevel = 1,
    this.xpToNextLevel = 100,
    this.totalXP = 0,
    this.unlockedRewards = const [],
    this.achievements = const [],
    this.isLoading = false,
    this.error,
  });

  XPLevelState copyWith({
    int? currentXP,
    int? currentLevel,
    int? xpToNextLevel,
    int? totalXP,
    List<LevelReward>? unlockedRewards,
    List<Achievement>? achievements,
    bool? isLoading,
    String? error,
  }) {
    return XPLevelState(
      currentXP: currentXP ?? this.currentXP,
      currentLevel: currentLevel ?? this.currentLevel,
      xpToNextLevel: xpToNextLevel ?? this.xpToNextLevel,
      totalXP: totalXP ?? this.totalXP,
      unlockedRewards: unlockedRewards ?? this.unlockedRewards,
      achievements: achievements ?? this.achievements,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  /// Get progress percentage to next level
  double getProgressPercentage() {
    if (xpToNextLevel == 0) return 1.0;
    return currentXP / xpToNextLevel;
  }
}

/// Level Reward
class LevelReward {
  final String id;
  final String name;
  final String description;
  final RewardType type;
  final int value;
  final int requiredLevel;
  final bool isUnlocked;
  final DateTime? unlockedAt;

  const LevelReward({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.value,
    required this.requiredLevel,
    this.isUnlocked = false,
    this.unlockedAt,
  });

  LevelReward copyWith({
    String? id,
    String? name,
    String? description,
    RewardType? type,
    int? value,
    int? requiredLevel,
    bool? isUnlocked,
    DateTime? unlockedAt,
  }) {
    return LevelReward(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      value: value ?? this.value,
      requiredLevel: requiredLevel ?? this.requiredLevel,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type.name,
      'value': value,
      'requiredLevel': requiredLevel,
      'isUnlocked': isUnlocked,
      'unlockedAt': unlockedAt?.toIso8601String(),
    };
  }

  factory LevelReward.fromJson(Map<String, dynamic> json) {
    return LevelReward(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: RewardType.values.firstWhere((e) => e.name == json['type']),
      value: json['value'],
      requiredLevel: json['requiredLevel'],
      isUnlocked: json['isUnlocked'] ?? false,
      unlockedAt: json['unlockedAt'] != null 
          ? DateTime.parse(json['unlockedAt'])
          : null,
    );
  }
}

/// Achievement
class Achievement {
  final String id;
  final String name;
  final String description;
  final String iconPath;
  final AchievementType type;
  final int requiredValue;
  final int currentValue;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final int xpReward;

  const Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.iconPath,
    required this.type,
    required this.requiredValue,
    this.currentValue = 0,
    this.isUnlocked = false,
    this.unlockedAt,
    this.xpReward = 50,
  });

  Achievement copyWith({
    String? id,
    String? name,
    String? description,
    String? iconPath,
    AchievementType? type,
    int? requiredValue,
    int? currentValue,
    bool? isUnlocked,
    DateTime? unlockedAt,
    int? xpReward,
  }) {
    return Achievement(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconPath: iconPath ?? this.iconPath,
      type: type ?? this.type,
      requiredValue: requiredValue ?? this.requiredValue,
      currentValue: currentValue ?? this.currentValue,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      xpReward: xpReward ?? this.xpReward,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'iconPath': iconPath,
      'type': type.name,
      'requiredValue': requiredValue,
      'currentValue': currentValue,
      'isUnlocked': isUnlocked,
      'unlockedAt': unlockedAt?.toIso8601String(),
      'xpReward': xpReward,
    };
  }

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      iconPath: json['iconPath'],
      type: AchievementType.values.firstWhere((e) => e.name == json['type']),
      requiredValue: json['requiredValue'],
      currentValue: json['currentValue'] ?? 0,
      isUnlocked: json['isUnlocked'] ?? false,
      unlockedAt: json['unlockedAt'] != null 
          ? DateTime.parse(json['unlockedAt'])
          : null,
      xpReward: json['xpReward'] ?? 50,
    );
  }
}

/// Reward Types
enum RewardType {
  gold,
  decoration,
  feature,
  title,
  badge,
}

/// Achievement Types
enum AchievementType {
  tasksCompleted,
  streakDays,
  perfectDays,
  speedCompletions,
  earlyCompletions,
  nightCompletions,
  socialInteractions,
  decorationsPlaced,
  levelsReached,
  specialEvents,
}

/// XP Level System Service
class XPLevelSystemService extends StateNotifier<XPLevelState> {
  final SharedPreferences _prefs;
  final Random _random = Random();

  XPLevelSystemService(this._prefs) : super(const XPLevelState()) {
    _loadState();
    _initializeRewards();
    _initializeAchievements();
  }

  /// Load state from SharedPreferences
  Future<void> _loadState() async {
    try {
      final currentXP = _prefs.getInt('xp_current') ?? 0;
      final currentLevel = _prefs.getInt('xp_level') ?? 1;
      final totalXP = _prefs.getInt('xp_total') ?? 0;
      
      final rewardsJson = _prefs.getStringList('xp_rewards') ?? [];
      final achievementsJson = _prefs.getStringList('xp_achievements') ?? [];

      final unlockedRewards = rewardsJson
          .map((json) => LevelReward.fromJson(jsonDecode(json)))
          .toList();

      final achievements = achievementsJson
          .map((json) => Achievement.fromJson(jsonDecode(json)))
          .toList();

      final xpToNextLevel = _calculateXPToNextLevel(currentLevel);

      state = state.copyWith(
        currentXP: currentXP,
        currentLevel: currentLevel,
        xpToNextLevel: xpToNextLevel,
        totalXP: totalXP,
        unlockedRewards: unlockedRewards,
        achievements: achievements,
      );
    } catch (e) {
      state = state.copyWith(error: 'Failed to load XP state: $e');
    }
  }

  /// Save state to SharedPreferences
  Future<void> _saveState() async {
    try {
      await _prefs.setInt('xp_current', state.currentXP);
      await _prefs.setInt('xp_level', state.currentLevel);
      await _prefs.setInt('xp_total', state.totalXP);
      
      final rewardsJson = state.unlockedRewards
          .map((reward) => jsonEncode(reward.toJson()))
          .toList();
      await _prefs.setStringList('xp_rewards', rewardsJson);

      final achievementsJson = state.achievements
          .map((achievement) => jsonEncode(achievement.toJson()))
          .toList();
      await _prefs.setStringList('xp_achievements', achievementsJson);
    } catch (e) {
      state = state.copyWith(error: 'Failed to save XP state: $e');
    }
  }

  /// Initialize level rewards
  void _initializeRewards() {
    if (state.unlockedRewards.isNotEmpty) return;

    final rewards = [
      // Level 2 rewards
      LevelReward(
        id: 'level_2_gold',
        name: 'Gold Bonus',
        description: 'Unlock 50 bonus gold',
        type: RewardType.gold,
        value: 50,
        requiredLevel: 2,
      ),
      LevelReward(
        id: 'level_2_decoration',
        name: 'Special Plant',
        description: 'Unlock rare plant decoration',
        type: RewardType.decoration,
        value: 1,
        requiredLevel: 2,
      ),
      
      // Level 5 rewards
      LevelReward(
        id: 'level_5_feature',
        name: 'Advanced Analytics',
        description: 'Unlock detailed progress analytics',
        type: RewardType.feature,
        value: 1,
        requiredLevel: 5,
      ),
      LevelReward(
        id: 'level_5_title',
        name: 'Dedicated Learner',
        title: 'Dedicated Learner',
        description: 'Unlock new title',
        type: RewardType.title,
        value: 1,
        requiredLevel: 5,
      ),
      
      // Level 10 rewards
      LevelReward(
        id: 'level_10_badge',
        name: 'Expert Badge',
        description: 'Unlock expert badge',
        type: RewardType.badge,
        value: 1,
        requiredLevel: 10,
      ),
      LevelReward(
        id: 'level_10_decoration',
        name: 'Golden Mascot',
        description: 'Unlock golden mascot skin',
        type: RewardType.decoration,
        value: 1,
        requiredLevel: 10,
      ),
      
      // Level 20 rewards
      LevelReward(
        id: 'level_20_feature',
        name: 'AI Assistant',
        description: 'Unlock advanced AI features',
        type: RewardType.feature,
        value: 1,
        requiredLevel: 20,
      ),
      LevelReward(
        id: 'level_20_title',
        name: 'Master',
        title: 'Master',
        description: 'Unlock master title',
        type: RewardType.title,
        value: 1,
        requiredLevel: 20,
      ),
    ];

    state = state.copyWith(unlockedRewards: rewards);
    _saveState();
  }

  /// Initialize achievements
  void _initializeAchievements() {
    if (state.achievements.isNotEmpty) return;

    final achievements = [
      // Task completion achievements
      Achievement(
        id: 'first_task',
        name: 'First Steps',
        description: 'Complete your first task',
        iconPath: 'assets/achievements/first_task.png',
        type: AchievementType.tasksCompleted,
        requiredValue: 1,
        xpReward: 25,
      ),
      Achievement(
        id: 'task_master',
        name: 'Task Master',
        description: 'Complete 100 tasks',
        iconPath: 'assets/achievements/task_master.png',
        type: AchievementType.tasksCompleted,
        requiredValue: 100,
        xpReward: 200,
      ),
      Achievement(
        id: 'task_legend',
        name: 'Task Legend',
        description: 'Complete 500 tasks',
        iconPath: 'assets/achievements/task_legend.png',
        type: AchievementType.tasksCompleted,
        requiredValue: 500,
        xpReward: 500,
      ),
      
      // Streak achievements
      Achievement(
        id: 'week_warrior',
        name: 'Week Warrior',
        description: 'Maintain a 7-day streak',
        iconPath: 'assets/achievements/week_warrior.png',
        type: AchievementType.streakDays,
        requiredValue: 7,
        xpReward: 100,
      ),
      Achievement(
        id: 'month_master',
        name: 'Month Master',
        description: 'Maintain a 30-day streak',
        iconPath: 'assets/achievements/month_master.png',
        type: AchievementType.streakDays,
        requiredValue: 30,
        xpReward: 500,
      ),
      
      // Speed achievements
      Achievement(
        id: 'speed_demon',
        name: 'Speed Demon',
        description: 'Complete 10 tasks in under 5 minutes',
        iconPath: 'assets/achievements/speed_demon.png',
        type: AchievementType.speedCompletions,
        requiredValue: 10,
        xpReward: 150,
      ),
      
      // Time-based achievements
      Achievement(
        id: 'early_bird',
        name: 'Early Bird',
        description: 'Complete 20 tasks before 8 AM',
        iconPath: 'assets/achievements/early_bird.png',
        type: AchievementType.earlyCompletions,
        requiredValue: 20,
        xpReward: 100,
      ),
      Achievement(
        id: 'night_owl',
        name: 'Night Owl',
        description: 'Complete 20 tasks after 10 PM',
        iconPath: 'assets/achievements/night_owl.png',
        type: AchievementType.nightCompletions,
        requiredValue: 20,
        xpReward: 100,
      ),
      
      // Social achievements
      Achievement(
        id: 'social_butterfly',
        name: 'Social Butterfly',
        description: 'Interact with mascot 100 times',
        iconPath: 'assets/achievements/social_butterfly.png',
        type: AchievementType.socialInteractions,
        requiredValue: 100,
        xpReward: 150,
      ),
      
      // Decoration achievements
      Achievement(
        id: 'decorator',
        name: 'Decorator',
        description: 'Place 50 decorations',
        iconPath: 'assets/achievements/decorator.png',
        type: AchievementType.decorationsPlaced,
        requiredValue: 50,
        xpReward: 100,
      ),
      
      // Level achievements
      Achievement(
        id: 'level_10',
        name: 'Level 10',
        description: 'Reach level 10',
        iconPath: 'assets/achievements/level_10.png',
        type: AchievementType.levelsReached,
        requiredValue: 10,
        xpReward: 200,
      ),
      Achievement(
        id: 'level_25',
        name: 'Level 25',
        description: 'Reach level 25',
        iconPath: 'assets/achievements/level_25.png',
        type: AchievementType.levelsReached,
        requiredValue: 25,
        xpReward: 500,
      ),
    ];

    state = state.copyWith(achievements: achievements);
    _saveState();
  }

  /// Add XP and handle level up
  Future<void> addXP(int xpAmount, {String? source}) async {
    final newXP = state.currentXP + xpAmount;
    final newTotalXP = state.totalXP + xpAmount;
    
    // Check for level up
    int newLevel = state.currentLevel;
    int remainingXP = newXP;
    
    while (remainingXP >= _calculateXPToNextLevel(newLevel)) {
      remainingXP -= _calculateXPToNextLevel(newLevel);
      newLevel++;
    }
    
    final xpToNextLevel = _calculateXPToNextLevel(newLevel) - remainingXP;
    
    state = state.copyWith(
      currentXP: remainingXP,
      currentLevel: newLevel,
      xpToNextLevel: xpToNextLevel,
      totalXP: newTotalXP,
    );
    
    // Check for new rewards
    await _checkNewRewards();
    
    // Check for new achievements
    await _checkNewAchievements();
    
    await _saveState();
  }

  /// Calculate XP required for next level
  int _calculateXPToNextLevel(int level) {
    // Exponential growth: 100 * level^1.5
    return (100 * pow(level, 1.5)).round();
  }

  /// Check for new rewards
  Future<void> _checkNewRewards() async {
    final newRewards = state.unlockedRewards.where((reward) => 
        reward.requiredLevel <= state.currentLevel && !reward.isUnlocked).toList();
    
    if (newRewards.isNotEmpty) {
      final updatedRewards = state.unlockedRewards.map((reward) {
        if (newRewards.any((newReward) => newReward.id == reward.id)) {
          return reward.copyWith(
            isUnlocked: true,
            unlockedAt: DateTime.now(),
          );
        }
        return reward;
      }).toList();
      
      state = state.copyWith(unlockedRewards: updatedRewards);
    }
  }

  /// Check for new achievements
  Future<void> _checkNewAchievements() async {
    // This would be called from other services when specific actions occur
    // For now, just check level-based achievements
    final newAchievements = state.achievements.where((achievement) => 
        achievement.type == AchievementType.levelsReached &&
        achievement.requiredValue <= state.currentLevel &&
        !achievement.isUnlocked).toList();
    
    if (newAchievements.isNotEmpty) {
      final updatedAchievements = state.achievements.map((achievement) {
        if (newAchievements.any((newAchievement) => newAchievement.id == achievement.id)) {
          return achievement.copyWith(
            isUnlocked: true,
            unlockedAt: DateTime.now(),
          );
        }
        return achievement;
      }).toList();
      
      state = state.copyWith(achievements: updatedAchievements);
    }
  }

  /// Update achievement progress
  Future<void> updateAchievementProgress(AchievementType type, int value) async {
    final updatedAchievements = state.achievements.map((achievement) {
      if (achievement.type == type && !achievement.isUnlocked) {
        final newValue = achievement.currentValue + value;
        final isUnlocked = newValue >= achievement.requiredValue;
        
        return achievement.copyWith(
          currentValue: newValue,
          isUnlocked: isUnlocked,
          unlockedAt: isUnlocked ? DateTime.now() : null,
        );
      }
      return achievement;
    }).toList();
    
    state = state.copyWith(achievements: updatedAchievements);
    
    // Check for newly unlocked achievements
    final newlyUnlocked = updatedAchievements.where((achievement) => 
        achievement.isUnlocked && 
        achievement.unlockedAt?.isAfter(DateTime.now().subtract(const Duration(seconds: 1))) == true).toList();
    
    if (newlyUnlocked.isNotEmpty) {
      // Add XP for newly unlocked achievements
      for (final achievement in newlyUnlocked) {
        await addXP(achievement.xpReward, source: 'achievement_${achievement.id}');
      }
    }
    
    await _saveState();
  }


  /// Get unlocked rewards for current level
  List<LevelReward> getUnlockedRewardsForLevel(int level) {
    return state.unlockedRewards.where((reward) => 
        reward.requiredLevel == level && reward.isUnlocked).toList();
  }

  /// Get all unlocked achievements
  List<Achievement> getUnlockedAchievements() {
    return state.achievements.where((achievement) => achievement.isUnlocked).toList();
  }

  /// Get achievements by type
  List<Achievement> getAchievementsByType(AchievementType type) {
    return state.achievements.where((achievement) => achievement.type == type).toList();
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Provider for SharedPreferences
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

/// Provider for XP Level System Service
final xpLevelSystemProvider = StateNotifierProvider<XPLevelSystemService, XPLevelState>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider).value;
  if (prefs == null) {
    throw StateError('SharedPreferences not available');
  }
  return XPLevelSystemService(prefs);
});

/// XP Display Widget
class XPDisplayWidget extends ConsumerWidget {
  final bool showLevel;
  final bool showProgress;
  final double? fontSize;
  final Color? textColor;

  const XPDisplayWidget({
    super.key,
    this.showLevel = true,
    this.showProgress = true,
    this.fontSize,
    this.textColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final xpState = ref.watch(xpLevelSystemProvider);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: PandoraColors.primary500,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: PandoraColors.primary500.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            color: PandoraColors.white,
            size: 16,
          ),
          const SizedBox(width: 4),
          if (showLevel) ...[
            Text(
              'Lv.${xpState.currentLevel}',
              style: TextStyle(
                color: textColor ?? PandoraColors.white,
                fontSize: fontSize ?? 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
          ],
          if (showProgress) ...[
            Text(
              '${xpState.currentXP}/${xpState.xpToNextLevel} XP',
              style: TextStyle(
                color: textColor ?? PandoraColors.white,
                fontSize: (fontSize ?? 16) - 2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Level Progress Widget
class LevelProgressWidget extends ConsumerWidget {
  final double height;
  final Color? progressColor;
  final Color? backgroundColor;

  const LevelProgressWidget({
    super.key,
    this.height = 8,
    this.progressColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final xpState = ref.watch(xpLevelSystemProvider);
    final progress = xpState.getProgressPercentage();
    
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? PandoraColors.neutral200,
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(height / 2),
        child: LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(
            progressColor ?? PandoraColors.primary500,
          ),
        ),
      ),
    );
  }
}
