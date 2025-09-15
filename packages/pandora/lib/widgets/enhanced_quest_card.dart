import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/celebration_overlay_controller.dart';
import '../services/xp_level_system.dart';
import '../services/gold_reward_system.dart';
import '../services/mascot_service.dart';
import '../services/mascot_enums.dart';
import 'package:pandora_ui/pandora_ui.dart';

/// Enhanced Quest Card with completion animation
class EnhancedQuestCard extends ConsumerStatefulWidget {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final bool isLocked;
  final int difficulty;
  final int estimatedMinutes;
  final VoidCallback? onTap;
  final VoidCallback? onComplete;
  final VoidCallback? onLongPress;

  const EnhancedQuestCard({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.isLocked = false,
    this.difficulty = 1,
    this.estimatedMinutes = 30,
    this.onTap,
    this.onComplete,
    this.onLongPress,
  });

  @override
  ConsumerState<EnhancedQuestCard> createState() => _EnhancedQuestCardState();
}

class _EnhancedQuestCardState extends ConsumerState<EnhancedQuestCard>
    with TickerProviderStateMixin {
  late AnimationController _completionController;
  late AnimationController _pulseController;
  late Animation<double> _completionAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<Color?> _colorAnimation;

  bool _isCompleting = false;
  bool _isLongPressing = false;

  @override
  void initState() {
    super.initState();
    
    _completionController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _completionAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _completionController,
      curve: Curves.easeInOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _colorAnimation = ColorTween(
      begin: PandoraColors.primary500,
      end: PandoraColors.success500,
    ).animate(CurvedAnimation(
      parent: _completionController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _completionController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPressStart: (_) => _startLongPress(),
      onLongPressEnd: (_) => _endLongPress(),
      onLongPressCancel: () => _endLongPress(),
      child: AnimatedBuilder(
        animation: Listenable.merge([_completionAnimation, _pulseAnimation]),
        builder: (context, child) {
          return Transform.scale(
            scale: _isLongPressing ? _pulseAnimation.value : 1.0,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: widget.isCompleted 
                    ? PandoraColors.success50
                    : PandoraColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: widget.isCompleted 
                      ? PandoraColors.success500
                      : PandoraColors.neutral200,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: PandoraColors.shadowColor,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Main content
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            // Completion checkbox with animation
                            _buildCompletionCheckbox(),
                            
                            const SizedBox(width: 12),
                            
                            // Title
                            Expanded(
                              child: Text(
                                widget.title,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: widget.isCompleted 
                                      ? PandoraColors.success700
                                      : PandoraColors.neutral900,
                                  decoration: widget.isCompleted 
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                            ),
                            
                            // Difficulty indicator
                            _buildDifficultyIndicator(),
                          ],
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Description
                        Text(
                          widget.description,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: widget.isCompleted 
                                ? PandoraColors.success600
                                : PandoraColors.neutral600,
                          ),
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Footer
                        Row(
                          children: [
                            // Time estimate
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: PandoraColors.neutral500,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.estimatedMinutes} phút',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: PandoraColors.neutral500,
                              ),
                            ),
                            
                            const Spacer(),
                            
                            // XP reward
                            _buildXPReward(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Completion progress overlay
                  if (_isCompleting)
                    _buildCompletionOverlay(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCompletionCheckbox() {
    return GestureDetector(
      onTap: widget.isCompleted ? null : _startCompletion,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.isCompleted 
              ? PandoraColors.success500
              : PandoraColors.neutral200,
          border: Border.all(
            color: widget.isCompleted 
                ? PandoraColors.success500
                : PandoraColors.neutral400,
            width: 2,
          ),
        ),
        child: widget.isCompleted
            ? const Icon(
                Icons.check,
                color: PandoraColors.white,
                size: 16,
              )
            : _isCompleting
                ? _buildCompletionProgress()
                : null,
      ),
    );
  }

  Widget _buildCompletionProgress() {
    return AnimatedBuilder(
      animation: _completionAnimation,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(24, 24),
          painter: CompletionProgressPainter(
            progress: _completionAnimation.value,
            color: _colorAnimation.value ?? PandoraColors.primary500,
          ),
        );
      },
    );
  }

  Widget _buildDifficultyIndicator() {
    Color color;
    String label;
    
    switch (widget.difficulty) {
      case 1:
        color = PandoraColors.success500;
        label = 'Dễ';
        break;
      case 2:
        color = PandoraColors.warning500;
        label = 'Trung bình';
        break;
      case 3:
        color = PandoraColors.error500;
        label = 'Khó';
        break;
      default:
        color = PandoraColors.neutral500;
        label = 'Không xác định';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildXPReward() {
    final xpReward = _calculateXPReward();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: PandoraColors.primary50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PandoraColors.primary200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            color: PandoraColors.primary500,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            '+$xpReward XP',
            style: const TextStyle(
              color: PandoraColors.primary700,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: PandoraColors.success500.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _completionAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _completionAnimation.value,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: PandoraColors.success500,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: PandoraColors.success500.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check,
                    color: PandoraColors.white,
                    size: 32,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  int _calculateXPReward() {
    switch (widget.difficulty) {
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

  int _calculateGoldReward() {
    switch (widget.difficulty) {
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

  void _startLongPress() {
    if (widget.isCompleted || widget.isLocked) return;
    
    setState(() {
      _isLongPressing = true;
    });
    
    _pulseController.repeat(reverse: true);
  }

  void _endLongPress() {
    if (!_isLongPressing) return;
    
    setState(() {
      _isLongPressing = false;
    });
    
    _pulseController.stop();
    _pulseController.reset();
  }

  void _startCompletion() {
    if (widget.isCompleted || widget.isLocked || _isCompleting) return;
    
    setState(() {
      _isCompleting = true;
    });
    
    // Start completion animation
    _completionController.forward().then((_) {
      _completeTask();
    });
  }

  void _completeTask() {
    // Calculate rewards
    final xpReward = _calculateXPReward();
    final goldReward = _calculateGoldReward();
    
    // Add XP
    ref.read(xpLevelSystemProvider.notifier).addXP(xpReward, source: 'task_${widget.id}');
    
    // Add Gold
    ref.read(decorationSystemWithPrefsProvider.notifier).addGold(goldReward);
    
    // Show celebration overlay
    ref.read(celebrationOverlayProvider.notifier).showTaskCompletion(
      xpGained: xpReward,
      goldGained: goldReward,
      sourcePosition: _getCardPosition(),
    );
    
    // Trigger mascot celebration
    ref.read(mascotServiceProvider.notifier).handleUserAction(UserAction.completeTask);
    
    // Call completion callback
    widget.onComplete?.call();
    
    // Reset animation
    setState(() {
      _isCompleting = false;
    });
    
    _completionController.reset();
  }

  Offset _getCardPosition() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero);
      return Offset(
        position.dx + renderBox.size.width / 2,
        position.dy + renderBox.size.height / 2,
      );
    }
    return const Offset(200, 200); // Fallback position
  }
}

/// Completion Progress Painter
class CompletionProgressPainter extends CustomPainter {
  final double progress;
  final Color color;

  CompletionProgressPainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;
    
    // Background circle
    final backgroundPaint = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    canvas.drawCircle(center, radius, backgroundPaint);
    
    // Progress arc
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    
    final sweepAngle = 2 * 3.14159 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14159 / 2, // Start from top
      sweepAngle,
      false,
      progressPaint,
    );
    
    // Check mark when complete
    if (progress >= 1.0) {
      final checkPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round;
      
      final path = Path();
      path.moveTo(center.dx - 4, center.dy);
      path.lineTo(center.dx - 1, center.dy + 3);
      path.lineTo(center.dx + 4, center.dy - 2);
      
      canvas.drawPath(path, checkPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is CompletionProgressPainter &&
        (oldDelegate.progress != progress || oldDelegate.color != color);
  }
}

/// Quest List with Enhanced Cards
class EnhancedQuestList extends ConsumerWidget {
  final List<QuestItem> quests;
  final VoidCallback? onQuestTap;
  final VoidCallback? onQuestComplete;

  const EnhancedQuestList({
    super.key,
    required this.quests,
    this.onQuestTap,
    this.onQuestComplete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: quests.length,
      itemBuilder: (context, index) {
        final quest = quests[index];
        return EnhancedQuestCard(
          id: quest.id,
          title: quest.title,
          description: quest.description,
          isCompleted: quest.isCompleted,
          isLocked: quest.isLocked,
          difficulty: quest.difficulty,
          estimatedMinutes: quest.estimatedMinutes,
          onTap: () {
            onQuestTap?.call();
            // Handle quest tap
          },
          onComplete: () {
            onQuestComplete?.call();
            // Handle quest completion
          },
        );
      },
    );
  }
}

/// Quest Item Model
class QuestItem {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final bool isLocked;
  final int difficulty;
  final int estimatedMinutes;

  const QuestItem({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.isLocked = false,
    this.difficulty = 1,
    this.estimatedMinutes = 30,
  });
}
