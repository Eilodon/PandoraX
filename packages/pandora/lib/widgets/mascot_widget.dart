import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:pandora_ui/pandora_ui.dart';
import '../services/mascot_service.dart';

class MascotWidget extends ConsumerStatefulWidget {
  final double size;
  final bool showMessage;
  final bool enableInteraction;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;
  final Function(DragEndDetails)? onPanEnd;

  const MascotWidget({
    super.key,
    this.size = 120.0,
    this.showMessage = true,
    this.enableInteraction = true,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.onPanEnd,
  });

  @override
  ConsumerState<MascotWidget> createState() => _MascotWidgetState();
}

class _MascotWidgetState extends ConsumerState<MascotWidget>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _pulseController;
  late Animation<double> _bounceAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mascotState = ref.watch(mascotServiceProvider);

    if (!mascotState.isVisible) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: widget.enableInteraction ? _handleTap : widget.onTap,
      onLongPress: widget.enableInteraction ? _handleLongPress : widget.onLongPress,
      onDoubleTap: widget.enableInteraction ? _handleDoubleTap : widget.onDoubleTap,
      onPanEnd: widget.enableInteraction ? _handlePanEnd : widget.onPanEnd,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Mascot Animation
          AnimatedBuilder(
            animation: Listenable.merge([_bounceAnimation, _pulseAnimation]),
            builder: (context, child) {
              return Transform.scale(
                scale: _bounceAnimation.value * _pulseAnimation.value,
                child: _buildMascotAnimation(mascotState.animation),
              );
            },
          ),
          
          const SizedBox(height: PTokens.spacingSm),
          
          // Message Bubble
          if (widget.showMessage && mascotState.showMessage && mascotState.message.isNotEmpty)
            _buildMessageBubble(mascotState.message, mascotState.mood),
        ],
      ),
    );
  }

  Widget _buildMascotAnimation(MascotAnimation animation) {
    // TODO: Thay thế bằng đường dẫn đến file Lottie thực tế
    final animationPath = _getAnimationPath(animation);
    
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: PandoraColors.primary200.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Lottie.asset(
        animationPath,
        width: widget.size,
        height: widget.size,
        fit: BoxFit.contain,
        repeat: true,
        animate: true,
        errorBuilder: (context, error, stackTrace) {
          // Fallback nếu không có file Lottie
          return _buildFallbackMascot(animation);
        },
      ),
    );
  }

  Widget _buildFallbackMascot(MascotAnimation animation) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: PandoraColors.primary100,
        border: Border.all(
          color: PandoraColors.primary300,
          width: 2,
        ),
      ),
      child: Icon(
        _getFallbackIcon(animation),
        size: widget.size * 0.6,
        color: PandoraColors.primary500,
      ),
    );
  }

  Widget _buildMessageBubble(String message, MascotMood mood) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 200),
      padding: const EdgeInsets.symmetric(
        horizontal: PTokens.spacingMd,
        vertical: PTokens.spacingSm,
      ),
      decoration: BoxDecoration(
        color: _getMoodColor(mood).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _getMoodColor(mood).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        message,
        style: PTokens.typography.bodySmall.copyWith(
          color: _getMoodColor(mood),
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  String _getAnimationPath(MascotAnimation animation) {
    // TODO: Thay thế bằng đường dẫn thực tế đến các file Lottie
    switch (animation) {
      case MascotAnimation.idle:
        return 'assets/lottie/cat_idle.json';
      case MascotAnimation.happy:
        return 'assets/lottie/cat_happy.json';
      case MascotAnimation.thinking:
        return 'assets/lottie/cat_thinking.json';
      case MascotAnimation.celebrating:
        return 'assets/lottie/cat_celebrating.json';
      case MascotAnimation.sleeping:
        return 'assets/lottie/cat_sleeping.json';
      case MascotAnimation.waving:
        return 'assets/lottie/cat_waving.json';
      case MascotAnimation.excited:
        return 'assets/lottie/cat_excited.json';
      case MascotAnimation.confused:
        return 'assets/lottie/cat_confused.json';
      case MascotAnimation.working:
        return 'assets/lottie/cat_working.json';
      case MascotAnimation.eating:
        return 'assets/lottie/cat_eating.json';
    }
  }

  IconData _getFallbackIcon(MascotAnimation animation) {
    switch (animation) {
      case MascotAnimation.idle:
        return Icons.pets;
      case MascotAnimation.happy:
        return Icons.sentiment_very_satisfied;
      case MascotAnimation.thinking:
        return Icons.psychology;
      case MascotAnimation.celebrating:
        return Icons.celebration;
      case MascotAnimation.sleeping:
        return Icons.bedtime;
      case MascotAnimation.waving:
        return Icons.waving_hand;
      case MascotAnimation.excited:
        return Icons.sentiment_very_satisfied;
      case MascotAnimation.confused:
        return Icons.help_outline;
      case MascotAnimation.working:
        return Icons.work;
      case MascotAnimation.eating:
        return Icons.restaurant;
    }
  }

  Color _getMoodColor(MascotMood mood) {
    switch (mood) {
      case MascotMood.neutral:
        return PandoraColors.neutral600;
      case MascotMood.happy:
        return PandoraColors.success600;
      case MascotMood.excited:
        return PandoraColors.primary600;
      case MascotMood.tired:
        return PandoraColors.warning600;
      case MascotMood.confused:
        return PandoraColors.error600;
      case MascotMood.proud:
        return PandoraColors.secondary600;
    }
  }

  void _handleTap() {
    _bounceController.forward().then((_) {
      _bounceController.reverse();
    });
    
    ref.read(mascotServiceProvider.notifier).handleInteraction(
      MascotInteraction.tap,
    );
  }

  void _handleLongPress() {
    _bounceController.forward().then((_) {
      _bounceController.reverse();
    });
    
    ref.read(mascotServiceProvider.notifier).handleInteraction(
      MascotInteraction.longPress,
    );
  }

  void _handleDoubleTap() {
    _bounceController.forward().then((_) {
      _bounceController.reverse();
    });
    
    ref.read(mascotServiceProvider.notifier).handleInteraction(
      MascotInteraction.doubleTap,
    );
  }

  void _handlePanEnd(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.dx.abs() > 100 ||
        details.velocity.pixelsPerSecond.dy.abs() > 100) {
      _bounceController.forward().then((_) {
        _bounceController.reverse();
      });
      
      ref.read(mascotServiceProvider.notifier).handleInteraction(
        MascotInteraction.swipe,
      );
    }
  }
}

/// Mascot Floating Action Button
class MascotFloatingActionButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final String? tooltip;

  const MascotFloatingActionButton({
    super.key,
    this.onPressed,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mascotState = ref.watch(mascotServiceProvider);

    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: tooltip ?? 'Mascot',
      backgroundColor: PandoraColors.primary500,
      child: MascotWidget(
        size: 40,
        showMessage: false,
        enableInteraction: false,
      ),
    );
  }
}

/// Mascot Loading Widget
class MascotLoadingWidget extends ConsumerWidget {
  final String message;
  final double size;

  const MascotLoadingWidget({
    super.key,
    this.message = 'Đang xử lý...',
    this.size = 100.0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MascotWidget(
          size: size,
          showMessage: false,
          enableInteraction: false,
        ),
        const SizedBox(height: PTokens.spacingMd),
        Text(
          message,
          style: PTokens.typography.bodyMedium.copyWith(
            color: PandoraColors.neutral600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Mascot Empty State Widget
class MascotEmptyStateWidget extends ConsumerWidget {
  final String title;
  final String message;
  final String? actionText;
  final VoidCallback? onAction;

  const MascotEmptyStateWidget({
    super.key,
    required this.title,
    required this.message,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MascotWidget(
          size: 120,
          showMessage: false,
          enableInteraction: true,
        ),
        const SizedBox(height: PTokens.spacingLg),
        Text(
          title,
          style: PTokens.typography.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: PTokens.spacingSm),
        Text(
          message,
          style: PTokens.typography.bodyMedium.copyWith(
            color: PandoraColors.neutral600,
          ),
          textAlign: TextAlign.center,
        ),
        if (actionText != null && onAction != null) ...[
          const SizedBox(height: PTokens.spacingLg),
          PandoraButton(
            onPressed: onAction,
            variant: PandoraButtonVariant.primary,
            child: Text(actionText!),
          ),
        ],
      ],
    );
  }
}
