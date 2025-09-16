import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/decoration_system.dart';
import '../../../services/gold_reward_system.dart';
import '../../../services/mascot_service.dart';
import '../../../services/mascot_thought_bubbles.dart';
import '../../../services/mascot_enums.dart';
import '../../../widgets/mascot_environment_widget.dart';
import 'package:pandora_ui/pandora_ui.dart';

/// Mascot Environment Demo Screen
/// 
/// Demonstrates the complete mascot environment with decorations and interactions
class MascotEnvironmentDemoScreen extends ConsumerStatefulWidget {
  const MascotEnvironmentDemoScreen({super.key});

  @override
  ConsumerState<MascotEnvironmentDemoScreen> createState() => _MascotEnvironmentDemoScreenState();
}

class _MascotEnvironmentDemoScreenState extends ConsumerState<MascotEnvironmentDemoScreen> {
  bool _showGoldAnimation = false;
  int _lastGoldAmount = 0;

  @override
  void initState() {
    super.initState();
    // Initialize gold reward system
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(goldRewardSystemProvider).rewardDailyLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    final decorationState = ref.watch(decorationSystemWithPrefsProvider);
    final mascotState = ref.watch(mascotServiceProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mascot Environment'),
        backgroundColor: PandoraColors.primary500,
        foregroundColor: PandoraColors.white,
        actions: [
          // Gold display
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GoldDisplayWidget(
              showIcon: true,
              fontSize: 16,
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
                // Environment widget
                Expanded(
                  flex: 3,
                  child: MascotEnvironmentWidget(
                    width: double.infinity,
                    height: 400,
                    showThoughtBubbles: true,
                    allowDecoration: true,
                    onEnvironmentTap: () {
                      _showEnvironmentInfo();
                    },
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Controls
                _buildControls(),
              ],
            ),
          ),
          
          // Gold animation overlay
          if (_showGoldAnimation)
            GoldAnimationWidget(
              goldAmount: _lastGoldAmount,
              onComplete: () {
                setState(() {
                  _showGoldAnimation = false;
                });
              },
            ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Shop button
          FloatingActionButton(
            onPressed: () => _openShop(),
            backgroundColor: PandoraColors.warning500,
            child: const Icon(Icons.shopping_cart),
          ),
          const SizedBox(height: 8),
          
          // Edit environment button
          FloatingActionButton(
            onPressed: () => _toggleEditMode(),
            backgroundColor: PandoraColors.primary500,
            child: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
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
            
            // Gold earning buttons
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildActionButton(
                  'Complete Easy Task',
                  Icons.check_circle,
                  PandoraColors.success500,
                  () => _simulateTaskCompletion(TaskDifficulty.easy),
                ),
                _buildActionButton(
                  'Complete Medium Task',
                  Icons.check_circle,
                  PandoraColors.info500,
                  () => _simulateTaskCompletion(TaskDifficulty.medium),
                ),
                _buildActionButton(
                  'Complete Hard Task',
                  Icons.check_circle,
                  PandoraColors.warning500,
                  () => _simulateTaskCompletion(TaskDifficulty.hard),
                ),
                _buildActionButton(
                  'Complete Expert Task',
                  Icons.check_circle,
                  PandoraColors.error500,
                  () => _simulateTaskCompletion(TaskDifficulty.expert),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Achievement buttons
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildActionButton(
                  'Week Streak',
                  Icons.local_fire_department,
                  PandoraColors.warning600,
                  () => _simulateAchievement(AchievementType.weekStreak),
                ),
                _buildActionButton(
                  'Perfect Week',
                  Icons.star,
                  PandoraColors.primary500,
                  () => _simulateAchievement(AchievementType.perfectWeek),
                ),
                _buildActionButton(
                  'Speed Demon',
                  Icons.speed,
                  PandoraColors.error500,
                  () => _simulateAchievement(AchievementType.speedDemon),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Mascot interaction buttons
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildActionButton(
                  'Touch Mascot',
                  Icons.touch_app,
                  PandoraColors.primary400,
                  () => _touchMascot(),
                ),
                _buildActionButton(
                  'Show Thought',
                  Icons.chat_bubble,
                  PandoraColors.info400,
                  () => _showRandomThought(),
                ),
                _buildActionButton(
                  'Celebrate',
                  Icons.celebration,
                  PandoraColors.warning400,
                  () => _celebrateMascot(),
                ),
              ],
            ),
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

  void _simulateTaskCompletion(TaskDifficulty difficulty) {
    final goldSystem = ref.read(goldRewardSystemProvider);
    final isOnTime = true; // Simulate on-time completion
    final streakCount = 3; // Simulate 3-day streak
    
    goldSystem.rewardTaskCompletion(
      taskId: 'demo_task_${DateTime.now().millisecondsSinceEpoch}',
      difficulty: difficulty,
      onTime: isOnTime,
      streakCount: streakCount,
    );
    
    _triggerGoldAnimation();
  }

  void _simulateAchievement(AchievementType achievement) {
    final goldSystem = ref.read(goldRewardSystemProvider);
    goldSystem.rewardSpecialAchievement(achievement);
    _triggerGoldAnimation();
  }

  void _touchMascot() {
    ref.read(mascotServiceProvider.notifier).handleInteraction(MascotInteraction.tap);
  }

  void _showRandomThought() {
    final thoughtService = ref.read(thoughtBubbleProvider.notifier);
    thoughtService.showCustomBubble(
      "Đây là một thông điệp demo! 😊",
      ThoughtBubbleType.normal,
    );
  }

  void _celebrateMascot() {
    ref.read(mascotServiceProvider.notifier).handleUserAction(UserAction.completeTask);
    final thoughtService = ref.read(thoughtBubbleProvider.notifier);
    thoughtService.showCelebrationBubble();
  }

  void _openShop() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DecorationShopWidget(),
      ),
    );
  }

  void _toggleEditMode() {
    // This would toggle edit mode in the environment widget
    // For now, just show a message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Edit mode toggled! Tap on empty areas to place decorations.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showEnvironmentInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mascot Environment'),
        content: const Text(
          'Đây là môi trường tương tác của Mascot Pandora!\n\n'
          '• Chạm vào Mascot để tương tác\n'
          '• Hoàn thành nhiệm vụ để kiếm Gold\n'
          '• Mua đồ trang trí từ shop\n'
          '• Đặt đồ trang trí vào môi trường\n'
          '• Xem bong bóng thoại ngẫu nhiên\n\n'
          'Hãy tạo ra không gian riêng của bạn!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _triggerGoldAnimation() {
    final currentGold = ref.read(decorationSystemWithPrefsProvider).gold;
    setState(() {
      _lastGoldAmount = currentGold - _lastGoldAmount;
      _showGoldAnimation = true;
    });
  }
}

/// Environment Statistics Widget
class EnvironmentStatsWidget extends ConsumerWidget {
  const EnvironmentStatsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decorationState = ref.watch(decorationSystemWithPrefsProvider);
    final mascotState = ref.watch(mascotServiceProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Environment Stats',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  'Gold',
                  '${decorationState.gold}',
                  Icons.monetization_on,
                  PandoraColors.warning500,
                ),
                _buildStatItem(
                  'Decorations',
                  '${decorationState.placedDecorations.length}',
                  Icons.home,
                  PandoraColors.primary500,
                ),
                _buildStatItem(
                  'Interactions',
                  '${mascotState.interactionCount}',
                  Icons.touch_app,
                  PandoraColors.info500,
                ),
                _buildStatItem(
                  'Mood',
                  _getMoodEmoji(mascotState.mood),
                  Icons.sentiment_satisfied,
                  _getMoodColor(mascotState.mood),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: PandoraColors.neutral600,
          ),
        ),
      ],
    );
  }

  String _getMoodEmoji(MascotMood mood) {
    switch (mood) {
      case MascotMood.welcoming:
        return '👋';
      case MascotMood.celebrating:
        return '🎉';
      case MascotMood.sleeping:
        return '😴';
      case MascotMood.disappointed:
        return '😔';
      case MascotMood.playful:
        return '😄';
      case MascotMood.happy:
        return '😊';
      case MascotMood.excited:
        return '🤩';
      case MascotMood.thinking:
        return '🤔';
      case MascotMood.sad:
        return '😢';
      case MascotMood.idle:
        return '😐';
      default:
        return '😊';
    }
  }

  Color _getMoodColor(MascotMood mood) {
    switch (mood) {
      case MascotMood.welcoming:
        return PandoraColors.success400;
      case MascotMood.celebrating:
        return PandoraColors.warning400;
      case MascotMood.sleeping:
        return PandoraColors.neutral600;
      case MascotMood.disappointed:
        return PandoraColors.error600;
      case MascotMood.playful:
        return PandoraColors.primary400;
      case MascotMood.happy:
        return PandoraColors.success500;
      case MascotMood.excited:
        return PandoraColors.warning500;
      case MascotMood.thinking:
        return PandoraColors.info500;
      case MascotMood.sad:
        return PandoraColors.error700;
      case MascotMood.idle:
        return PandoraColors.neutral400;
      default:
        return PandoraColors.primary400;
    }
  }
}
