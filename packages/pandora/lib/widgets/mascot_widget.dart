import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/mascot_service.dart';
import '../services/mascot_enums.dart';
import 'package:pandora_ui/pandora_ui.dart';

/// Mascot Widget
/// 
/// The main mascot character that users can interact with
class MascotWidget extends ConsumerWidget {
  final MascotSize size;
  final MascotPosition position;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;
  final bool showMessage;
  final Duration animationDuration;

  const MascotWidget({
    super.key,
    this.size = MascotSize.medium,
    this.position = MascotPosition.floating,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.showMessage = true,
    this.animationDuration = const Duration(milliseconds: 500),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mascotState = ref.watch(mascotServiceProvider);
    
    if (!mascotState.isVisible) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: _getTopPosition(context),
      right: _getRightPosition(context),
      child: GestureDetector(
        onTap: () {
          ref.read(mascotServiceProvider.notifier).handleInteraction(MascotInteraction.tap);
          onTap?.call();
        },
        onLongPress: () {
          ref.read(mascotServiceProvider.notifier).handleInteraction(MascotInteraction.longPress);
          onLongPress?.call();
        },
        onDoubleTap: () {
          ref.read(mascotServiceProvider.notifier).handleInteraction(MascotInteraction.doubleTap);
          onDoubleTap?.call();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showMessage && mascotState.currentMessage != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? PandoraColors.neutral800
                      : PandoraColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: PandoraColors.shadowColor,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  mascotState.currentMessage!,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? PandoraColors.neutral100
                        : PandoraColors.neutral900,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
            AnimatedContainer(
              duration: animationDuration,
              width: _getSizeValue(),
              height: _getSizeValue(),
              child: _buildMascotAvatar(mascotState),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMascotAvatar(MascotState state) {
    return AnimatedContainer(
      duration: animationDuration,
      decoration: BoxDecoration(
        color: _getMoodColor(state.mood),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: _getMoodColor(state.mood).withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: _buildMascotIcon(state),
      ),
    );
  }

  Widget _buildMascotIcon(MascotState state) {
    IconData iconData;
    
    switch (state.mood) {
      case MascotMood.happy:
        iconData = Icons.sentiment_very_satisfied;
        break;
      case MascotMood.excited:
        iconData = Icons.celebration;
        break;
      case MascotMood.thinking:
        iconData = Icons.psychology;
        break;
      case MascotMood.tired:
        iconData = Icons.bedtime;
        break;
      case MascotMood.confused:
        iconData = Icons.help_outline;
        break;
      case MascotMood.proud:
        iconData = Icons.emoji_events;
        break;
      case MascotMood.sad:
        iconData = Icons.sentiment_dissatisfied;
        break;
      case MascotMood.welcoming:
        iconData = Icons.waving_hand;
        break;
      case MascotMood.celebrating:
        iconData = Icons.celebration;
        break;
      case MascotMood.sleeping:
        iconData = Icons.bedtime;
        break;
      case MascotMood.idle:
        iconData = Icons.sentiment_neutral;
        break;
      case MascotMood.disappointed:
        iconData = Icons.sentiment_dissatisfied;
        break;
      case MascotMood.playful:
        iconData = Icons.sports_esports;
        break;
      case MascotMood.neutral:
      default:
        iconData = Icons.sentiment_neutral;
        break;
    }

    return AnimatedSwitcher(
      duration: animationDuration,
      child: Icon(
        iconData,
        key: ValueKey(state.mood),
        color: PandoraColors.white,
        size: _getSizeValue() * 0.6,
      ),
    );
  }

  Color _getMoodColor(MascotMood mood) {
    switch (mood) {
      case MascotMood.happy:
        return PandoraColors.success500;
      case MascotMood.excited:
        return PandoraColors.warning500;
      case MascotMood.thinking:
        return PandoraColors.info500;
      case MascotMood.tired:
        return PandoraColors.neutral500;
      case MascotMood.confused:
        return PandoraColors.error500;
      case MascotMood.proud:
        return PandoraColors.primary500;
      case MascotMood.sad:
        return PandoraColors.error700;
      case MascotMood.welcoming:
        return PandoraColors.success400;
      case MascotMood.celebrating:
        return PandoraColors.warning400;
      case MascotMood.sleeping:
        return PandoraColors.neutral600;
      case MascotMood.idle:
        return PandoraColors.neutral400;
      case MascotMood.disappointed:
        return PandoraColors.error600;
      case MascotMood.playful:
        return PandoraColors.primary400;
      case MascotMood.neutral:
      default:
        return PandoraColors.primary400;
    }
  }

  double _getSizeValue() {
    switch (size) {
      case MascotSize.small:
        return 40;
      case MascotSize.medium:
        return 60;
      case MascotSize.large:
        return 80;
      case MascotSize.extraLarge:
        return 100;
    }
  }

  double _getTopPosition(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    switch (position) {
      case MascotPosition.topLeft:
      case MascotPosition.topRight:
        return 50;
      case MascotPosition.center:
        return screenHeight / 2 - _getSizeValue() / 2;
      case MascotPosition.bottomLeft:
      case MascotPosition.bottomRight:
        return screenHeight - _getSizeValue() - 100;
      case MascotPosition.floating:
      default:
        return screenHeight - _getSizeValue() - 150;
    }
  }

  double _getRightPosition(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    switch (position) {
      case MascotPosition.topLeft:
      case MascotPosition.bottomLeft:
        return screenWidth - _getSizeValue() - 20;
      case MascotPosition.topRight:
      case MascotPosition.bottomRight:
      case MascotPosition.floating:
        return 20;
      case MascotPosition.center:
        return screenWidth / 2 - _getSizeValue() / 2;
      default:
        return 20;
    }
  }
}

/// Mascot Floating Action Button
class MascotFloatingActionButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final MascotSize size;

  const MascotFloatingActionButton({
    super.key,
    this.onPressed,
    this.size = MascotSize.medium,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        ref.read(mascotServiceProvider.notifier).handleInteraction(MascotInteraction.tap);
        onPressed?.call();
      },
      backgroundColor: PandoraColors.primary500,
      child: const Icon(
        Icons.sentiment_very_satisfied,
        color: PandoraColors.white,
      ),
    );
  }
}

/// Mascot Loading Widget
class MascotLoadingWidget extends ConsumerWidget {
  final String? message;

  const MascotLoadingWidget({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }
}

/// Mascot Empty State Widget
class MascotEmptyStateWidget extends ConsumerWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onAction;

  const MascotEmptyStateWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.onAction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MascotWidget(
            size: MascotSize.large,
            showMessage: false,
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          if (onAction != null) ...[
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onAction,
              child: const Text('Get Started'),
            ),
          ],
        ],
      ),
    );
  }
}