import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora_ui/pandora_ui.dart';
import '../presentation/dashboard_screen.dart';

/// 🎯 Quest Panel Widget
/// 
/// Panel có thể kéo lên/xuống hiển thị nhiệm vụ trong ngày
/// Khi thu gọn: hiển thị nhiệm vụ quan trọng nhất
/// Khi mở rộng: hiển thị toàn bộ danh sách nhiệm vụ
class QuestPanel extends ConsumerStatefulWidget {
  final bool isExpanded;
  final VoidCallback onToggle;
  final Function(Quest) onQuestTap;

  const QuestPanel({
    super.key,
    required this.isExpanded,
    required this.onToggle,
    required this.onQuestTap,
  });

  @override
  ConsumerState<QuestPanel> createState() => _QuestPanelState();
}

class _QuestPanelState extends ConsumerState<QuestPanel>
    with TickerProviderStateMixin {
  late AnimationController _panelAnimationController;
  late AnimationController _questAnimationController;
  
  late Animation<double> _panelAnimation;
  late Animation<double> _questAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Panel animation - smooth expand/collapse
    _panelAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    // Quest animation - staggered entrance
    _questAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _panelAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _panelAnimationController,
      curve: Curves.easeInOut,
    ));

    _questAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _questAnimationController,
      curve: Curves.easeOutBack,
    ));

    if (widget.isExpanded) {
      _panelAnimationController.value = 1.0;
      _questAnimationController.forward();
    }
  }

  @override
  void didUpdateWidget(QuestPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _panelAnimationController.forward();
        _questAnimationController.forward();
      } else {
        _panelAnimationController.reverse();
        _questAnimationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _panelAnimationController.dispose();
    _questAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _panelAnimation,
      builder: (context, child) {
        return Container(
          height: MediaQuery.of(context).size.height * 
                 (0.4 + (0.2 * _panelAnimation.value)),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.95),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              // Handle bar
              _buildHandleBar(),
              
              // Panel content
              Expanded(
                child: _buildPanelContent(),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Build handle bar for dragging
  Widget _buildHandleBar() {
    return GestureDetector(
      onTap: widget.onToggle,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: PandoraColors.neutral300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Panel title
            Text(
              widget.isExpanded ? '📋 Today\'s Quests' : '🎯 Quick Quest',
              style: PTokens.typography.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: PandoraColors.neutral700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build panel content
  Widget _buildPanelContent() {
    if (widget.isExpanded) {
      return _buildExpandedContent();
    } else {
      return _buildCollapsedContent();
    }
  }

  /// Build collapsed content - show only priority quest
  Widget _buildCollapsedContent() {
    final priorityQuest = _getPriorityQuest();
    
    return Padding(
      padding: const EdgeInsets.all(PTokens.spacingMd),
      child: Column(
        children: [
          // Priority quest card
          _buildQuestCard(priorityQuest, isPriority: true),
          
          const SizedBox(height: PTokens.spacingMd),
          
          // Expand hint
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.keyboard_arrow_up,
                color: PandoraColors.neutral500,
                size: 20,
              ),
              const SizedBox(width: PTokens.spacingXs),
              Text(
                'Tap to see all quests',
                style: PTokens.typography.bodySmall.copyWith(
                  color: PandoraColors.neutral500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build expanded content - show all quests
  Widget _buildExpandedContent() {
    final allQuests = _getAllQuests();
    
    return Padding(
      padding: const EdgeInsets.all(PTokens.spacingMd),
      child: Column(
        children: [
          // Quest stats
          _buildQuestStats(allQuests),
          
          const SizedBox(height: PTokens.spacingMd),
          
          // Quest list
          Expanded(
            child: AnimatedBuilder(
              animation: _questAnimation,
              builder: (context, child) {
                return ListView.builder(
                  itemCount: allQuests.length,
                  itemBuilder: (context, index) {
                    final quest = allQuests[index];
                    final animationDelay = index * 0.1;
                    final animationValue = (_questAnimation.value - animationDelay).clamp(0.0, 1.0);
                    
                    return Transform.translate(
                      offset: Offset(0, 50 * (1 - animationValue)),
                      child: Opacity(
                        opacity: animationValue,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: PTokens.spacingSm),
                          child: _buildQuestCard(quest),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Build quest stats
  Widget _buildQuestStats(List<Quest> quests) {
    final completedQuests = quests.where((q) => q.status == QuestStatus.completed).length;
    final totalQuests = quests.length;
    final progress = totalQuests > 0 ? completedQuests / totalQuests : 0.0;
    
    return PandoraCard(
      variant: PandoraCardVariant.filled,
      child: Padding(
        padding: const EdgeInsets.all(PTokens.spacingMd),
        child: Row(
          children: [
            // Progress indicator
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PandoraColors.primary100,
              ),
              child: Stack(
                children: [
                  // Background circle
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: PandoraColors.primary200,
                        width: 4,
                      ),
                    ),
                  ),
                  // Progress circle
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 4,
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        PandoraColors.primary600,
                      ),
                    ),
                  ),
                  // Center text
                  Center(
                    child: Text(
                      '${(progress * 100).round()}%',
                      style: PTokens.typography.labelMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: PandoraColors.primary700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: PTokens.spacingMd),
            
            // Stats text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quest Progress',
                    style: PTokens.typography.labelLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: PandoraColors.neutral700,
                    ),
                  ),
                  const SizedBox(height: PTokens.spacingXs),
                  Text(
                    '$completedQuests of $totalQuests completed',
                    style: PTokens.typography.bodyMedium.copyWith(
                      color: PandoraColors.neutral600,
                    ),
                  ),
                  const SizedBox(height: PTokens.spacingXs),
                  Text(
                    '${_calculateTotalRewards(quests)} XP + ${_calculateTotalGold(quests)} Gold',
                    style: PTokens.typography.bodySmall.copyWith(
                      color: PandoraColors.primary600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build quest card
  Widget _buildQuestCard(Quest quest, {bool isPriority = false}) {
    return GestureDetector(
      onTap: () => widget.onQuestTap(quest),
      child: PandoraCard(
        variant: _getQuestCardVariant(quest.status),
        child: Padding(
          padding: const EdgeInsets.all(PTokens.spacingMd),
          child: Row(
            children: [
              // Quest icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _getQuestColor(quest.status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getQuestIcon(quest.type),
                  color: _getQuestColor(quest.status),
                  size: 24,
                ),
              ),
              
              const SizedBox(width: PTokens.spacingMd),
              
              // Quest content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quest title
                    Text(
                      quest.title,
                      style: PTokens.typography.labelLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: PandoraColors.neutral700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: PTokens.spacingXs),
                    
                    // Quest description
                    Text(
                      quest.description,
                      style: PTokens.typography.bodyMedium.copyWith(
                        color: PandoraColors.neutral600,
                      ),
                      maxLines: isPriority ? 2 : 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    if (!isPriority) ...[
                      const SizedBox(height: PTokens.spacingXs),
                      
                      // Quest rewards
                      Row(
                        children: [
                          if (quest.experienceReward > 0) ...[
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${quest.experienceReward} XP',
                              style: PTokens.typography.bodySmall.copyWith(
                                color: Colors.amber.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: PTokens.spacingSm),
                          ],
                          if (quest.goldReward > 0) ...[
                            Icon(
                              Icons.monetization_on,
                              color: Colors.yellow.shade600,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${quest.goldReward} Gold',
                              style: PTokens.typography.bodySmall.copyWith(
                                color: Colors.yellow.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              
              // Quest status indicator
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getQuestColor(quest.status),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Get priority quest
  Quest _getPriorityQuest() {
    final allQuests = _getAllQuests();
    // Return first available quest, or first in progress quest
    return allQuests.firstWhere(
      (q) => q.status == QuestStatus.available || q.status == QuestStatus.inProgress,
      orElse: () => allQuests.first,
    );
  }

  /// Get all quests
  List<Quest> _getAllQuests() {
    return [
      const Quest(
        id: 'daily_note',
        title: 'Write Daily Note',
        description: 'Create a note about your day',
        type: QuestType.daily,
        status: QuestStatus.available,
        experienceReward: 10,
        goldReward: 5,
      ),
      const Quest(
        id: 'voice_interaction',
        title: 'Use Voice Feature',
        description: 'Have a conversation with AI using voice',
        type: QuestType.daily,
        status: QuestStatus.inProgress,
        experienceReward: 15,
        goldReward: 8,
      ),
      const Quest(
        id: 'complete_streak',
        title: 'Maintain Streak',
        description: 'Use the app for 7 consecutive days',
        type: QuestType.weekly,
        status: QuestStatus.available,
        experienceReward: 50,
        goldReward: 25,
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
    ];
  }

  /// Get quest card variant based on status
  PandoraCardVariant _getQuestCardVariant(QuestStatus status) {
    switch (status) {
      case QuestStatus.completed:
        return PandoraCardVariant.filled;
      case QuestStatus.inProgress:
        return PandoraCardVariant.outlined;
      case QuestStatus.available:
        return PandoraCardVariant.elevated;
      case QuestStatus.expired:
        return PandoraCardVariant.outlined;
    }
  }

  /// Get quest color based on status
  Color _getQuestColor(QuestStatus status) {
    switch (status) {
      case QuestStatus.completed:
        return Colors.green;
      case QuestStatus.inProgress:
        return PandoraColors.primary600;
      case QuestStatus.available:
        return Colors.blue;
      case QuestStatus.expired:
        return Colors.grey;
    }
  }

  /// Get quest icon based on type
  IconData _getQuestIcon(QuestType type) {
    switch (type) {
      case QuestType.daily:
        return Icons.today;
      case QuestType.weekly:
        return Icons.date_range;
      case QuestType.story:
        return Icons.auto_stories;
      case QuestType.achievement:
        return Icons.emoji_events;
      case QuestType.social:
        return Icons.people;
    }
  }

  /// Calculate total experience rewards
  int _calculateTotalRewards(List<Quest> quests) {
    return quests
        .where((q) => q.status != QuestStatus.completed)
        .fold(0, (sum, q) => sum + q.experienceReward);
  }

  /// Calculate total gold rewards
  int _calculateTotalGold(List<Quest> quests) {
    return quests
        .where((q) => q.status != QuestStatus.completed)
        .fold(0, (sum, q) => sum + q.goldReward);
  }
}
