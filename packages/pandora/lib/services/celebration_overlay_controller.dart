import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mascot_service.dart';
import 'mascot_enums.dart';
import 'xp_level_system.dart';
import 'decoration_system.dart';
import 'mascot_thought_bubbles.dart';

/// Celebration Overlay State
class CelebrationOverlayState {
  final bool isVisible;
  final String? message;
  final int? xpGained;
  final int? goldGained;
  final int? levelGained;
  final Offset? sourcePosition;
  final CelebrationType type;
  final bool isAnimating;

  const CelebrationOverlayState({
    this.isVisible = false,
    this.message,
    this.xpGained,
    this.goldGained,
    this.levelGained,
    this.sourcePosition,
    this.type = CelebrationType.taskCompletion,
    this.isAnimating = false,
  });

  CelebrationOverlayState copyWith({
    bool? isVisible,
    String? message,
    int? xpGained,
    int? goldGained,
    int? levelGained,
    Offset? sourcePosition,
    CelebrationType? type,
    bool? isAnimating,
  }) {
    return CelebrationOverlayState(
      isVisible: isVisible ?? this.isVisible,
      message: message ?? this.message,
      xpGained: xpGained ?? this.xpGained,
      goldGained: goldGained ?? this.goldGained,
      levelGained: levelGained ?? this.levelGained,
      sourcePosition: sourcePosition ?? this.sourcePosition,
      type: type ?? this.type,
      isAnimating: isAnimating ?? this.isAnimating,
    );
  }
}

/// Celebration Types
enum CelebrationType {
  taskCompletion,
  levelUp,
  achievement,
  streak,
  special,
}

/// Celebration Overlay Controller
class CelebrationOverlayController extends StateNotifier<CelebrationOverlayState> {
  final Ref _ref;
  Timer? _celebrationTimer;
  final Random _random = Random();

  CelebrationOverlayController(this._ref) : super(const CelebrationOverlayState());

  /// Show celebration overlay
  void showCelebration({
    required CelebrationType type,
    String? message,
    int? xpGained,
    int? goldGained,
    int? levelGained,
    Offset? sourcePosition,
  }) {
    // Hide any existing celebration
    hideCelebration();

    // Set up new celebration
    state = state.copyWith(
      isVisible: true,
      message: message ?? _getDefaultMessage(type),
      xpGained: xpGained,
      goldGained: goldGained,
      levelGained: levelGained,
      sourcePosition: sourcePosition,
      type: type,
      isAnimating: true,
    );

    // Auto-hide after 3 seconds
    _celebrationTimer = Timer(const Duration(seconds: 3), () {
      hideCelebration();
    });

    // Trigger mascot celebration
    _triggerMascotCelebration(type);
  }

  /// Hide celebration overlay
  void hideCelebration() {
    _celebrationTimer?.cancel();
    state = state.copyWith(
      isVisible: false,
      isAnimating: false,
    );
  }

  /// Get default message for celebration type
  String _getDefaultMessage(CelebrationType type) {
    switch (type) {
      case CelebrationType.taskCompletion:
        return "Tuyệt vời! Nhiệm vụ hoàn thành! 🎉";
      case CelebrationType.levelUp:
        return "Chúc mừng! Bạn đã thăng cấp! ⭐";
      case CelebrationType.achievement:
        return "Thành tựu mới! 🏆";
      case CelebrationType.streak:
        return "Chuỗi ngày liên tiếp! 🔥";
      case CelebrationType.special:
        return "Sự kiện đặc biệt! ✨";
    }
  }

  /// Trigger mascot celebration
  void _triggerMascotCelebration(CelebrationType type) {
    final mascotService = _ref.read(mascotServiceProvider.notifier);
    
    switch (type) {
      case CelebrationType.taskCompletion:
        mascotService.handleUserAction(UserAction.completeTask);
        break;
      case CelebrationType.levelUp:
        mascotService.setMessage("Chúc mừng! Bạn đã thăng cấp! ⭐");
        break;
      case CelebrationType.achievement:
        mascotService.setMessage("Thành tựu mới! 🏆");
        break;
      case CelebrationType.streak:
        mascotService.setMessage("Chuỗi ngày liên tiếp! 🔥");
        break;
      case CelebrationType.special:
        mascotService.setMessage("Sự kiện đặc biệt! ✨");
        break;
    }
  }

  /// Show task completion celebration
  void showTaskCompletion({
    required int xpGained,
    required int goldGained,
    Offset? sourcePosition,
  }) {
    showCelebration(
      type: CelebrationType.taskCompletion,
      message: "Nhiệm vụ hoàn thành!",
      xpGained: xpGained,
      goldGained: goldGained,
      sourcePosition: sourcePosition,
    );
  }

  /// Show level up celebration
  void showLevelUp({
    required int levelGained,
    required int xpGained,
  }) {
    showCelebration(
      type: CelebrationType.levelUp,
      message: "Chúc mừng! Bạn đã thăng cấp!",
      levelGained: levelGained,
      xpGained: xpGained,
    );
  }

  /// Show achievement celebration
  void showAchievement({
    required String achievementName,
    required int xpGained,
  }) {
    showCelebration(
      type: CelebrationType.achievement,
      message: "Thành tựu: $achievementName",
      xpGained: xpGained,
    );
  }

  /// Show streak celebration
  void showStreak({
    required int streakDays,
    required int xpGained,
  }) {
    showCelebration(
      type: CelebrationType.streak,
      message: "Chuỗi $streakDays ngày liên tiếp!",
      xpGained: xpGained,
    );
  }

  /// Show special celebration
  void showSpecial({
    required String message,
    int? xpGained,
    int? goldGained,
  }) {
    showCelebration(
      type: CelebrationType.special,
      message: message,
      xpGained: xpGained,
      goldGained: goldGained,
    );
  }

  @override
  void dispose() {
    _celebrationTimer?.cancel();
    super.dispose();
  }
}

/// Provider for Celebration Overlay Controller
final celebrationOverlayProvider = StateNotifierProvider<CelebrationOverlayController, CelebrationOverlayState>((ref) {
  return CelebrationOverlayController(ref);
});

/// Celebration Overlay Widget
class CelebrationOverlay extends ConsumerWidget {
  const CelebrationOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final celebrationState = ref.watch(celebrationOverlayProvider);
    
    if (!celebrationState.isVisible) {
      return const SizedBox.shrink();
    }

    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            // Background overlay
            Container(
              color: Colors.black.withOpacity(0.3),
            ),
            
            // Celebration content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Main celebration animation
                  _buildCelebrationAnimation(celebrationState),
                  
                  const SizedBox(height: 20),
                  
                  // Message
                  if (celebrationState.message != null)
                    _buildMessage(celebrationState.message!),
                  
                  const SizedBox(height: 20),
                  
                  // Rewards
                  _buildRewards(celebrationState),
                ],
              ),
            ),
            
            // Floating rewards
            if (celebrationState.sourcePosition != null)
              ..._buildFloatingRewards(celebrationState),
          ],
        ),
      ),
    );
  }

  Widget _buildCelebrationAnimation(CelebrationOverlayState state) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Fireworks effect
          _buildFireworksEffect(),
          
          // Central icon
          _buildCentralIcon(state.type),
        ],
      ),
    );
  }

  Widget _buildFireworksEffect() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.transparent,
            Colors.yellow.withOpacity(0.3),
            Colors.orange.withOpacity(0.2),
            Colors.red.withOpacity(0.1),
          ],
        ),
      ),
      child: CustomPaint(
        painter: FireworksPainter(),
      ),
    );
  }

  Widget _buildCentralIcon(CelebrationType type) {
    IconData iconData;
    Color color;
    
    switch (type) {
      case CelebrationType.taskCompletion:
        iconData = Icons.check_circle;
        color = Colors.green;
        break;
      case CelebrationType.levelUp:
        iconData = Icons.star;
        color = Colors.yellow;
        break;
      case CelebrationType.achievement:
        iconData = Icons.emoji_events;
        color = Colors.orange;
        break;
      case CelebrationType.streak:
        iconData = Icons.local_fire_department;
        color = Colors.red;
        break;
      case CelebrationType.special:
        iconData = Icons.celebration;
        color = Colors.purple;
        break;
    }

    return AnimatedScale(
      scale: 1.0,
      duration: const Duration(milliseconds: 300),
      child: Icon(
        iconData,
        size: 80,
        color: color,
      ),
    );
  }

  Widget _buildMessage(String message) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildRewards(CelebrationOverlayState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (state.xpGained != null) ...[
          _buildRewardItem(
            icon: Icons.star,
            label: '+${state.xpGained} XP',
            color: Colors.blue,
          ),
          const SizedBox(width: 16),
        ],
        if (state.goldGained != null) ...[
          _buildRewardItem(
            icon: Icons.monetization_on,
            label: '+${state.goldGained} Gold',
            color: Colors.amber,
          ),
          const SizedBox(width: 16),
        ],
        if (state.levelGained != null) ...[
          _buildRewardItem(
            icon: Icons.trending_up,
            label: 'Level ${state.levelGained}',
            color: Colors.purple,
          ),
        ],
      ],
    );
  }

  Widget _buildRewardItem({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFloatingRewards(CelebrationOverlayState state) {
    final rewards = <Widget>[];
    
    if (state.xpGained != null) {
      rewards.add(
        FloatingRewardWidget(
          icon: Icons.star,
          label: '+${state.xpGained} XP',
          color: Colors.blue,
          startPosition: state.sourcePosition!,
          endPosition: const Offset(100, 100),
        ),
      );
    }
    
    if (state.goldGained != null) {
      rewards.add(
        FloatingRewardWidget(
          icon: Icons.monetization_on,
          label: '+${state.goldGained} Gold',
          color: Colors.amber,
          startPosition: state.sourcePosition!,
          endPosition: const Offset(200, 100),
        ),
      );
    }
    
    return rewards;
  }
}

/// Floating Reward Widget
class FloatingRewardWidget extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Offset startPosition;
  final Offset endPosition;

  const FloatingRewardWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.startPosition,
    required this.endPosition,
  });

  @override
  State<FloatingRewardWidget> createState() => _FloatingRewardWidgetState();
}

class _FloatingRewardWidgetState extends State<FloatingRewardWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _positionAnimation = Tween<Offset>(
      begin: widget.startPosition,
      end: widget.endPosition,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.7, 1.0),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.3),
    ));

    _controller.forward();
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
          left: _positionAnimation.value.dx,
          top: _positionAnimation.value.dy,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: widget.color.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.icon,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Fireworks Painter
class FireworksPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.yellow.withOpacity(0.8);

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw fireworks particles
    for (int i = 0; i < 12; i++) {
      final angle = (i * 30) * (3.14159 / 180);
      final x = center.dx + cos(angle) * radius * 0.8;
      final y = center.dy + sin(angle) * radius * 0.8;
      
      canvas.drawCircle(
        Offset(x, y),
        3,
        paint..color = Colors.yellow.withOpacity(0.6),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
