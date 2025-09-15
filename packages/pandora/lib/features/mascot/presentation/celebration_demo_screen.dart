import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/celebration_overlay_controller.dart';
import '../../../services/xp_level_system.dart';
import '../../../services/gold_reward_system.dart';
import '../../../services/sound_effects_service.dart';
import '../../../widgets/enhanced_quest_card.dart';
import 'package:pandora_ui/pandora_ui.dart';

/// Celebration Demo Screen
/// 
/// Demonstrates the complete "Nghi thức Bùng nổ" gamification system
class CelebrationDemoScreen extends ConsumerStatefulWidget {
  const CelebrationDemoScreen({super.key});

  @override
  ConsumerState<CelebrationDemoScreen> createState() => _CelebrationDemoScreenState();
}

class _CelebrationDemoScreenState extends ConsumerState<CelebrationDemoScreen> {
  final List<QuestItem> _demoQuests = [
    const QuestItem(
      id: 'quest_1',
      title: 'Hoàn thành bài tập toán',
      description: 'Giải 10 bài tập toán cơ bản',
      difficulty: 1,
      estimatedMinutes: 30,
    ),
    const QuestItem(
      id: 'quest_2',
      title: 'Đọc sách 30 phút',
      description: 'Đọc sách về lập trình trong 30 phút',
      difficulty: 2,
      estimatedMinutes: 30,
    ),
    const QuestItem(
      id: 'quest_3',
      title: 'Tập thể dục',
      description: 'Chạy bộ 5km hoặc tập gym 1 giờ',
      difficulty: 3,
      estimatedMinutes: 60,
    ),
    const QuestItem(
      id: 'quest_4',
      title: 'Học tiếng Anh',
      description: 'Học 20 từ vựng mới và làm bài tập',
      difficulty: 2,
      estimatedMinutes: 45,
    ),
    const QuestItem(
      id: 'quest_5',
      title: 'Viết blog post',
      description: 'Viết một bài blog về kinh nghiệm học tập',
      difficulty: 3,
      estimatedMinutes: 90,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final xpState = ref.watch(xpLevelSystemProvider);
    final celebrationState = ref.watch(celebrationOverlayProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nghi thức Bùng nổ Demo'),
        backgroundColor: PandoraColors.primary500,
        foregroundColor: PandoraColors.white,
        actions: [
          // XP Display
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: XPDisplayWidget(
              showLevel: true,
              showProgress: true,
              fontSize: 14,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Main content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Stats cards
                _buildStatsCards(xpState),
                
                const SizedBox(height: 20),
                
                // Demo quests
                Expanded(
                  child: _buildQuestList(),
                ),
                
                const SizedBox(height: 20),
                
                // Demo controls
                _buildDemoControls(),
              ],
            ),
          ),
          
          // Celebration overlay
          if (celebrationState.isVisible)
            const CelebrationOverlay(),
        ],
      ),
    );
  }

  Widget _buildStatsCards(XPLevelState xpState) {
    return Row(
      children: [
        // XP Card
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(
                    Icons.star,
                    color: PandoraColors.primary500,
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Level ${xpState.currentLevel}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${xpState.currentXP}/${xpState.xpToNextLevel} XP',
                    style: const TextStyle(
                      color: PandoraColors.neutral600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  LevelProgressWidget(
                    height: 6,
                    progressColor: PandoraColors.primary500,
                  ),
                ],
              ),
            ),
          ),
        ),
        
        const SizedBox(width: 16),
        
        // Achievements Card
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(
                    Icons.emoji_events,
                    color: PandoraColors.warning500,
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${xpState.achievements.where((a) => a.isUnlocked).length}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Achievements',
                    style: TextStyle(
                      color: PandoraColors.neutral600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestList() {
    return ListView.builder(
      itemCount: _demoQuests.length,
      itemBuilder: (context, index) {
        final quest = _demoQuests[index];
        return EnhancedQuestCard(
          id: quest.id,
          title: quest.title,
          description: quest.description,
          isCompleted: quest.isCompleted,
          isLocked: quest.isLocked,
          difficulty: quest.difficulty,
          estimatedMinutes: quest.estimatedMinutes,
          onComplete: () {
            _handleQuestCompletion(quest);
          },
        );
      },
    );
  }

  Widget _buildDemoControls() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Demo Controls',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            
            // Celebration buttons
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildActionButton(
                  'Task Completion',
                  Icons.check_circle,
                  PandoraColors.success500,
                  () => _simulateTaskCompletion(),
                ),
                _buildActionButton(
                  'Level Up',
                  Icons.star,
                  PandoraColors.primary500,
                  () => _simulateLevelUp(),
                ),
                _buildActionButton(
                  'Achievement',
                  Icons.emoji_events,
                  PandoraColors.warning500,
                  () => _simulateAchievement(),
                ),
                _buildActionButton(
                  'Streak',
                  Icons.local_fire_department,
                  PandoraColors.error500,
                  () => _simulateStreak(),
                ),
                _buildActionButton(
                  'Special Event',
                  Icons.celebration,
                  PandoraColors.purple500,
                  () => _simulateSpecialEvent(),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Sound controls
            _buildSoundControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: PandoraColors.white,
        minimumSize: const Size(120, 36),
      ),
    );
  }

  Widget _buildSoundControls() {
    final soundState = ref.watch(soundEffectsStateProvider);
    final soundNotifier = ref.read(soundEffectsStateProvider.notifier);
    final soundService = ref.read(soundEffectsServiceProvider);

    return Row(
      children: [
        const Icon(Icons.volume_up),
        const SizedBox(width: 8),
        const Text('Sound Effects'),
        const Spacer(),
        Switch(
          value: soundState.isEnabled,
          onChanged: (value) {
            soundNotifier.setEnabled(value);
            if (value) {
              soundService.playClick();
            }
          },
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: soundState.isEnabled
              ? () => soundService.playCelebrationSequence()
              : null,
          icon: const Icon(Icons.play_arrow),
          tooltip: 'Test Celebration Sound',
        ),
      ],
    );
  }

  void _handleQuestCompletion(QuestItem quest) {
    // Calculate rewards
    final xpReward = _calculateXPReward(quest.difficulty);
    final goldReward = _calculateGoldReward(quest.difficulty);
    
    // Add XP
    ref.read(xpLevelSystemProvider.notifier).addXP(xpReward, source: 'quest_${quest.id}');
    
    // Add Gold
    ref.read(decorationSystemWithPrefsProvider.notifier).addGold(goldReward);
    
    // Show celebration
    ref.read(celebrationOverlayProvider.notifier).showTaskCompletion(
      xpGained: xpReward,
      goldGained: goldReward,
    );
    
    // Play sound
    ref.read(soundEffectsServiceProvider).playTaskCompletionSequence();
    
    // Update quest as completed
    setState(() {
      final index = _demoQuests.indexWhere((q) => q.id == quest.id);
      if (index != -1) {
        _demoQuests[index] = quest.copyWith(isCompleted: true);
      }
    });
  }

  void _simulateTaskCompletion() {
    ref.read(celebrationOverlayProvider.notifier).showTaskCompletion(
      xpGained: 25,
      goldGained: 15,
    );
    ref.read(soundEffectsServiceProvider).playTaskCompletionSequence();
  }

  void _simulateLevelUp() {
    ref.read(celebrationOverlayProvider.notifier).showLevelUp(
      levelGained: 1,
      xpGained: 100,
    );
    ref.read(soundEffectsServiceProvider).playLevelUpSequence();
  }

  void _simulateAchievement() {
    ref.read(celebrationOverlayProvider.notifier).showAchievement(
      achievementName: 'First Steps',
      xpGained: 50,
    );
    ref.read(soundEffectsServiceProvider).playAchievementSequence();
  }

  void _simulateStreak() {
    ref.read(celebrationOverlayProvider.notifier).showStreak(
      streakDays: 7,
      xpGained: 75,
    );
    ref.read(soundEffectsServiceProvider).playStreakSequence();
  }

  void _simulateSpecialEvent() {
    ref.read(celebrationOverlayProvider.notifier).showSpecial(
      message: 'Sự kiện đặc biệt! 🎉',
      xpGained: 200,
      goldGained: 100,
    );
    ref.read(soundEffectsServiceProvider).playCelebrationSequence();
  }

  int _calculateXPReward(int difficulty) {
    switch (difficulty) {
      case 1:
        return 10;
      case 2:
        return 25;
      case 3:
        return 50;
      default:
        return 10;
    }
  }

  int _calculateGoldReward(int difficulty) {
    switch (difficulty) {
      case 1:
        return 5;
      case 2:
        return 15;
      case 3:
        return 30;
      default:
        return 5;
    }
  }
}

/// Quest Item Extension
extension QuestItemExtension on QuestItem {
  QuestItem copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    bool? isLocked,
    int? difficulty,
    int? estimatedMinutes,
  }) {
    return QuestItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      isLocked: isLocked ?? this.isLocked,
      difficulty: difficulty ?? this.difficulty,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
    );
  }
}
