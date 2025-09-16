import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora_ui/pandora_ui.dart';
import 'decoration_system.dart';
import 'mascot_service.dart';
import 'mascot_enums.dart';

/// Gold Reward System
/// 
/// Manages gold rewards for completing tasks and achievements
class GoldRewardSystem {
  final Ref _ref;
  final Random _random = Random();

  GoldRewardSystem(this._ref);

  /// Reward gold for completing a task
  Future<void> rewardTaskCompletion({
    required String taskId,
    required TaskDifficulty difficulty,
    required bool onTime,
    required int streakCount,
  }) async {
    int baseGold = _getBaseGoldForDifficulty(difficulty);
    
    // Bonus for completing on time
    if (onTime) {
      baseGold = (baseGold * 1.5).round();
    }
    
    // Streak bonus
    if (streakCount > 1) {
      baseGold += (streakCount * 5);
    }
    
    // Random bonus (10% chance)
    if (_random.nextInt(10) == 0) {
      baseGold += 50;
    }
    
    // Add gold to decoration system
    await _ref.read(decorationSystemWithPrefsProvider.notifier).addGold(baseGold);
    
    // Trigger mascot celebration
    _ref.read(mascotServiceProvider.notifier).handleUserAction(UserAction.completeTask);
    
    // Show special message for high rewards
    if (baseGold >= 100) {
      _ref.read(mascotServiceProvider.notifier).setMessage(
        "Wow! Bạn đã kiếm được $baseGold Gold! 🎉"
      );
    }
  }

  /// Reward gold for daily login
  Future<void> rewardDailyLogin() async {
    const int dailyGold = 20;
    await _ref.read(decorationSystemWithPrefsProvider.notifier).addGold(dailyGold);
    
    _ref.read(mascotServiceProvider.notifier).setMessage(
      "Chào mừng bạn trở lại! +$dailyGold Gold! 🌟"
    );
  }

  /// Reward gold for streak achievements
  Future<void> rewardStreakAchievement(int streakDays) async {
    int goldReward = streakDays * 10;
    await _ref.read(decorationSystemWithPrefsProvider.notifier).addGold(goldReward);
    
    _ref.read(mascotServiceProvider.notifier).setMessage(
      "Chúc mừng! $streakDays ngày liên tiếp! +$goldReward Gold! 🔥"
    );
  }

  /// Reward gold for special achievements
  Future<void> rewardSpecialAchievement(AchievementType achievement) async {
    int goldReward = _getGoldForAchievement(achievement);
    await _ref.read(decorationSystemWithPrefsProvider.notifier).addGold(goldReward);
    
    _ref.read(mascotServiceProvider.notifier).setMessage(
      "Thành tựu mới: ${_getAchievementName(achievement)}! +$goldReward Gold! 🏆"
    );
  }

  /// Reward gold for helping others (if you have social features)
  Future<void> rewardHelpingOthers() async {
    const int helpGold = 15;
    await _ref.read(decorationSystemWithPrefsProvider.notifier).addGold(helpGold);
    
    _ref.read(mascotServiceProvider.notifier).setMessage(
      "Cảm ơn bạn đã giúp đỡ! +$helpGold Gold! 💝"
    );
  }

  /// Reward gold for discovering new features
  Future<void> rewardFeatureDiscovery(String featureName) async {
    const int discoveryGold = 25;
    await _ref.read(decorationSystemWithPrefsProvider.notifier).addGold(discoveryGold);
    
    _ref.read(mascotServiceProvider.notifier).setMessage(
      "Tuyệt! Bạn đã khám phá $featureName! +$discoveryGold Gold! 🔍"
    );
  }

  /// Reward gold for completing challenges
  Future<void> rewardChallengeCompletion(ChallengeType challenge) async {
    int goldReward = _getGoldForChallenge(challenge);
    await _ref.read(decorationSystemWithPrefsProvider.notifier).addGold(goldReward);
    
    _ref.read(mascotServiceProvider.notifier).setMessage(
      "Thử thách hoàn thành! +$goldReward Gold! ⚡"
    );
  }

  /// Get base gold for task difficulty
  int _getBaseGoldForDifficulty(TaskDifficulty difficulty) {
    switch (difficulty) {
      case TaskDifficulty.easy:
        return 10;
      case TaskDifficulty.medium:
        return 25;
      case TaskDifficulty.hard:
        return 50;
      case TaskDifficulty.expert:
        return 100;
    }
  }

  /// Get gold for achievement type
  int _getGoldForAchievement(AchievementType achievement) {
    switch (achievement) {
      case AchievementType.firstTask:
        return 50;
      case AchievementType.weekStreak:
        return 100;
      case AchievementType.monthStreak:
        return 500;
      case AchievementType.perfectWeek:
        return 200;
      case AchievementType.speedDemon:
        return 150;
      case AchievementType.nightOwl:
        return 75;
      case AchievementType.earlyBird:
        return 75;
      case AchievementType.socialButterfly:
        return 100;
      case AchievementType.perfectionist:
        return 300;
      case AchievementType.explorer:
        return 125;
    }
  }

  /// Get gold for challenge type
  int _getGoldForChallenge(ChallengeType challenge) {
    switch (challenge) {
      case ChallengeType.daily:
        return 30;
      case ChallengeType.weekly:
        return 150;
      case ChallengeType.monthly:
        return 600;
      case ChallengeType.special:
        return 200;
    }
  }

  /// Get achievement name
  String _getAchievementName(AchievementType achievement) {
    switch (achievement) {
      case AchievementType.firstTask:
        return "Bước đầu tiên";
      case AchievementType.weekStreak:
        return "Tuần liên tiếp";
      case AchievementType.monthStreak:
        return "Tháng liên tiếp";
      case AchievementType.perfectWeek:
        return "Tuần hoàn hảo";
      case AchievementType.speedDemon:
        return "Tốc độ ánh sáng";
      case AchievementType.nightOwl:
        return "Cú đêm";
      case AchievementType.earlyBird:
        return "Chim sớm";
      case AchievementType.socialButterfly:
        return "Bướm xã hội";
      case AchievementType.perfectionist:
        return "Người hoàn hảo";
      case AchievementType.explorer:
        return "Nhà thám hiểm";
    }
  }
}

/// Task Difficulty Levels
enum TaskDifficulty {
  easy,
  medium,
  hard,
  expert,
}

/// Achievement Types
enum AchievementType {
  firstTask,
  weekStreak,
  monthStreak,
  perfectWeek,
  speedDemon,
  nightOwl,
  earlyBird,
  socialButterfly,
  perfectionist,
  explorer,
}

/// Challenge Types
enum ChallengeType {
  daily,
  weekly,
  monthly,
  special,
}

/// Gold Reward Service Provider
final goldRewardSystemProvider = Provider<GoldRewardSystem>((ref) {
  return GoldRewardSystem(ref);
});

/// Gold Display Widget
class GoldDisplayWidget extends ConsumerWidget {
  final bool showIcon;
  final double? fontSize;
  final Color? textColor;

  const GoldDisplayWidget({
    super.key,
    this.showIcon = true,
    this.fontSize,
    this.textColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decorationState = ref.watch(decorationSystemWithPrefsProvider);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: PandoraColors.warning500,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: PandoraColors.warning500.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            const Icon(
              Icons.monetization_on,
              color: PandoraColors.white,
              size: 16,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            '${decorationState.gold}',
            style: TextStyle(
              color: textColor ?? PandoraColors.white,
              fontSize: fontSize ?? 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

/// Gold Animation Widget
class GoldAnimationWidget extends StatefulWidget {
  final int goldAmount;
  final Duration duration;
  final VoidCallback? onComplete;

  const GoldAnimationWidget({
    super.key,
    required this.goldAmount,
    this.duration = const Duration(seconds: 2),
    this.onComplete,
  });

  @override
  State<GoldAnimationWidget> createState() => _GoldAnimationWidgetState();
}

class _GoldAnimationWidgetState extends State<GoldAnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.7, 1.0),
    ));

    _positionAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -1),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward().then((_) {
      widget.onComplete?.call();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: MediaQuery.of(context).size.width / 2 - 50,
          top: MediaQuery.of(context).size.height / 2 - 50,
          child: Transform.translate(
            offset: _positionAnimation.value * 100,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: PandoraColors.warning500,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: PandoraColors.warning500.withValues(alpha: 0.5),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.monetization_on,
                        color: PandoraColors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '+${widget.goldAmount}',
                        style: const TextStyle(
                          color: PandoraColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
