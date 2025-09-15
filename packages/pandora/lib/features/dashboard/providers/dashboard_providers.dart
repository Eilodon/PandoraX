import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import '../presentation/dashboard_screen.dart';
import '../../mascot/providers/mascot_providers.dart';

/// Dashboard State Provider
final dashboardStateProvider = StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  return DashboardNotifier();
});

/// Mascot State Provider (re-export for convenience)
final mascotStateProvider = StateNotifierProvider<MascotNotifier, MascotState>((ref) {
  return MascotNotifier();
});

/// Dashboard Notifier
/// 
/// Manages the state of the dashboard including:
/// - Time of day for background changes
/// - Quest panel expand/collapse state
/// - Current tab selection
/// - User stats and progression
/// - Today's quests
class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier() : super(_initialState()) {
    _initializeDashboard();
  }

  /// Initialize dashboard with current time and data
  void _initializeDashboard() {
    _updateTimeOfDay();
    _loadUserStats();
    _loadTodaysQuests();
    
    // Update time every minute
    _startTimeUpdates();
  }

  /// Get initial state
  static DashboardState _initialState() {
    return DashboardState(
      timeOfDay: TimeOfDay.now(),
      isQuestPanelExpanded: false,
      currentTabIndex: 0,
      userStats: const UserStats(),
      todaysQuests: [],
    );
  }

  /// Update time of day
  void _updateTimeOfDay() {
    state = state.copyWith(timeOfDay: TimeOfDay.now());
  }

  /// Load user stats
  void _loadUserStats() {
    // TODO: Load from storage/service
    final userStats = const UserStats(
      level: 5,
      experience: 750,
      maxExperience: 1000,
      healthPoints: 85,
      maxHealthPoints: 100,
      gold: 1250,
      gems: 45,
      streakDays: 7,
    );
    
    state = state.copyWith(userStats: userStats);
  }

  /// Load today's quests
  void _loadTodaysQuests() {
    // TODO: Load from service
    final quests = _generateSampleQuests();
    state = state.copyWith(todaysQuests: quests);
  }

  /// Generate sample quests
  List<Quest> _generateSampleQuests() {
    return [
      const Quest(
        id: 'daily_note',
        title: 'Write Daily Note',
        description: 'Create a note about your day',
        type: QuestType.daily,
        status: QuestStatus.available,
        experienceReward: 10,
        goldReward: 5,
        steps: [
          QuestStep(
            id: 'create_note',
            description: 'Open note editor',
            isCompleted: false,
          ),
          QuestStep(
            id: 'write_content',
            description: 'Write at least 50 words',
            isCompleted: false,
          ),
          QuestStep(
            id: 'save_note',
            description: 'Save the note',
            isCompleted: false,
          ),
        ],
      ),
      const Quest(
        id: 'voice_interaction',
        title: 'Voice Conversation',
        description: 'Have a conversation with AI using voice',
        type: QuestType.daily,
        status: QuestStatus.inProgress,
        experienceReward: 15,
        goldReward: 8,
        steps: [
          QuestStep(
            id: 'start_voice',
            description: 'Start voice interaction',
            isCompleted: true,
          ),
          QuestStep(
            id: 'speak_phrase',
            description: 'Say something to AI',
            isCompleted: false,
          ),
          QuestStep(
            id: 'get_response',
            description: 'Listen to AI response',
            isCompleted: false,
          ),
        ],
      ),
      const Quest(
        id: 'complete_streak',
        title: 'Maintain Streak',
        description: 'Use the app for 7 consecutive days',
        type: QuestType.weekly,
        status: QuestStatus.available,
        experienceReward: 50,
        goldReward: 25,
        deadline: null, // No deadline for streak
      ),
      const Quest(
        id: 'explore_features',
        title: 'Explore New Features',
        description: 'Try out the new dashboard and mascot',
        type: QuestType.story,
        status: QuestStatus.completed,
        experienceReward: 20,
        goldReward: 10,
      ),
      const Quest(
        id: 'social_interaction',
        title: 'Social Engagement',
        description: 'Share a note or interact with community',
        type: QuestType.social,
        status: QuestStatus.available,
        experienceReward: 12,
        goldReward: 6,
      ),
    ];
  }

  /// Start time updates
  void _startTimeUpdates() {
    // Update time every minute
    Timer.periodic(const Duration(minutes: 1), (timer) {
      _updateTimeOfDay();
    });
  }

  /// Toggle quest panel
  void toggleQuestPanel() {
    state = state.copyWith(
      isQuestPanelExpanded: !state.isQuestPanelExpanded,
    );
  }

  /// Set current tab
  void setCurrentTab(int index) {
    state = state.copyWith(currentTabIndex: index);
  }

  /// Update user stats
  void updateUserStats(UserStats newStats) {
    state = state.copyWith(userStats: newStats);
  }

  /// Add experience
  void addExperience(int amount) {
    final currentStats = state.userStats;
    var newExp = currentStats.experience + amount;
    var newLevel = currentStats.level;
    var newMaxExp = currentStats.maxExperience;
    
    // Check for level up
    while (newExp >= newMaxExp) {
      newExp -= newMaxExp;
      newLevel++;
      newMaxExp = (newMaxExp * 1.2).round(); // Increase max exp by 20%
    }
    
    final updatedStats = currentStats.copyWith(
      level: newLevel,
      experience: newExp,
      maxExperience: newMaxExp,
    );
    
    state = state.copyWith(userStats: updatedStats);
    
    // Show level up notification if leveled up
    if (newLevel > currentStats.level) {
      _showLevelUpNotification(newLevel);
    }
  }

  /// Add gold
  void addGold(int amount) {
    final currentStats = state.userStats;
    final updatedStats = currentStats.copyWith(
      gold: currentStats.gold + amount,
    );
    state = state.copyWith(userStats: updatedStats);
  }

  /// Add gems
  void addGems(int amount) {
    final currentStats = state.userStats;
    final updatedStats = currentStats.copyWith(
      gems: currentStats.gems + amount,
    );
    state = state.copyWith(userStats: updatedStats);
  }

  /// Update health points
  void updateHealthPoints(int newHP) {
    final currentStats = state.userStats;
    final updatedStats = currentStats.copyWith(
      healthPoints: newHP.clamp(0, currentStats.maxHealthPoints),
    );
    state = state.copyWith(userStats: updatedStats);
  }

  /// Update streak days
  void updateStreakDays(int days) {
    final currentStats = state.userStats;
    final updatedStats = currentStats.copyWith(streakDays: days);
    state = state.copyWith(userStats: updatedStats);
  }

  /// Complete quest
  void completeQuest(String questId) {
    final updatedQuests = state.todaysQuests.map((quest) {
      if (quest.id == questId) {
        final completedQuest = quest.copyWith(status: QuestStatus.completed);
        
        // Award rewards
        addExperience(quest.experienceReward);
        addGold(quest.goldReward);
        addGems(quest.gemsReward);
        
        return completedQuest;
      }
      return quest;
    }).toList();
    
    state = state.copyWith(todaysQuests: updatedQuests);
    
    // Show completion notification
    _showQuestCompletionNotification(questId);
  }

  /// Start quest
  void startQuest(String questId) {
    final updatedQuests = state.todaysQuests.map((quest) {
      if (quest.id == questId) {
        return quest.copyWith(status: QuestStatus.inProgress);
      }
      return quest;
    }).toList();
    
    state = state.copyWith(todaysQuests: updatedQuests);
  }

  /// Update quest step
  void updateQuestStep(String questId, String stepId, bool isCompleted) {
    final updatedQuests = state.todaysQuests.map((quest) {
      if (quest.id == questId) {
        final updatedSteps = quest.steps.map((step) {
          if (step.id == stepId) {
            return step.copyWith(isCompleted: isCompleted);
          }
          return step;
        }).toList();
        
        return quest.copyWith(steps: updatedSteps);
      }
      return quest;
    }).toList();
    
    state = state.copyWith(todaysQuests: updatedQuests);
    
    // Check if quest is completed
    _checkQuestCompletion(questId);
  }

  /// Check if quest is completed
  void _checkQuestCompletion(String questId) {
    final quest = state.todaysQuests.firstWhere(
      (q) => q.id == questId,
      orElse: () => throw StateError('Quest not found'),
    );
    
    if (quest.steps.every((step) => step.isCompleted)) {
      completeQuest(questId);
    }
  }

  /// Refresh dashboard data
  void refreshDashboard() {
    _updateTimeOfDay();
    _loadUserStats();
    _loadTodaysQuests();
  }

  /// Show level up notification
  void _showLevelUpNotification(int newLevel) {
    // TODO: Show level up notification
    print('🎉 Level Up! You are now level $newLevel!');
  }

  /// Show quest completion notification
  void _showQuestCompletionNotification(String questId) {
    // TODO: Show quest completion notification
    print('✅ Quest completed: $questId');
  }

  /// Get quest by ID
  Quest? getQuestById(String questId) {
    try {
      return state.todaysQuests.firstWhere((quest) => quest.id == questId);
    } catch (e) {
      return null;
    }
  }

  /// Get available quests
  List<Quest> getAvailableQuests() {
    return state.todaysQuests
        .where((quest) => quest.status == QuestStatus.available)
        .toList();
  }

  /// Get in-progress quests
  List<Quest> getInProgressQuests() {
    return state.todaysQuests
        .where((quest) => quest.status == QuestStatus.inProgress)
        .toList();
  }

  /// Get completed quests
  List<Quest> getCompletedQuests() {
    return state.todaysQuests
        .where((quest) => quest.status == QuestStatus.completed)
        .toList();
  }

  /// Get quest progress percentage
  double getQuestProgressPercentage() {
    if (state.todaysQuests.isEmpty) return 0.0;
    
    final completedCount = state.todaysQuests
        .where((quest) => quest.status == QuestStatus.completed)
        .length;
    
    return completedCount / state.todaysQuests.length;
  }

  /// Get total available rewards
  Map<String, int> getTotalAvailableRewards() {
    final availableQuests = getAvailableQuests();
    final inProgressQuests = getInProgressQuests();
    
    final totalExp = availableQuests.fold(0, (sum, quest) => sum + quest.experienceReward) +
                    inProgressQuests.fold(0, (sum, quest) => sum + quest.experienceReward);
    
    final totalGold = availableQuests.fold(0, (sum, quest) => sum + quest.goldReward) +
                     inProgressQuests.fold(0, (sum, quest) => sum + quest.goldReward);
    
    final totalGems = availableQuests.fold(0, (sum, quest) => sum + quest.gemsReward) +
                     inProgressQuests.fold(0, (sum, quest) => sum + quest.gemsReward);
    
    return {
      'experience': totalExp,
      'gold': totalGold,
      'gems': totalGems,
    };
  }
}

/// Quest copyWith extension
extension QuestCopyWith on Quest {
  Quest copyWith({
    String? id,
    String? title,
    String? description,
    QuestType? type,
    QuestStatus? status,
    int? experienceReward,
    int? goldReward,
    int? gemsReward,
    DateTime? deadline,
    List<QuestStep>? steps,
  }) {
    return Quest(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      status: status ?? this.status,
      experienceReward: experienceReward ?? this.experienceReward,
      goldReward: goldReward ?? this.goldReward,
      gemsReward: gemsReward ?? this.gemsReward,
      deadline: deadline ?? this.deadline,
      steps: steps ?? this.steps,
    );
  }
}

/// QuestStep copyWith extension
extension QuestStepCopyWith on QuestStep {
  QuestStep copyWith({
    String? id,
    String? description,
    bool? isCompleted,
  }) {
    return QuestStep(
      id: id ?? this.id,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

/// Timer import
import 'dart:async';
