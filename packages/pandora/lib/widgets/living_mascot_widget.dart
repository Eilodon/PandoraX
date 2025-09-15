import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/mascot_service.dart';
import '../services/mascot_enums.dart';
import 'package:pandora_ui/pandora_ui.dart';
import 'package:notes_app/widgets/lottie_mascot.dart';

/// Living Mascot Widget
/// 
/// A mascot that behaves like a living creature with emotions and reactions
class LivingMascotWidget extends ConsumerWidget {
  final MascotSize size;
  final MascotPosition position;
  final bool showMessage;
  final Duration animationDuration;

  const LivingMascotWidget({
    super.key,
    this.size = MascotSize.medium,
    this.position = MascotPosition.floating,
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
        },
        onLongPress: () {
          ref.read(mascotServiceProvider.notifier).handleInteraction(MascotInteraction.longPress);
        },
        onDoubleTap: () {
          ref.read(mascotServiceProvider.notifier).handleInteraction(MascotInteraction.doubleTap);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showMessage && mascotState.currentMessage != null) ...[
              _buildMessageBubble(context, mascotState.currentMessage!),
            ],
            _buildMascotAnimation(mascotState),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context, String message) {
    return Container(
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
        message,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? PandoraColors.neutral100
              : PandoraColors.neutral900,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildMascotAnimation(MascotState state) {
    // Map mascot mood to Lottie animation
    String animationPath = _getAnimationPath(state);
    
    return AnimatedContainer(
      duration: animationDuration,
      width: _getSizeValue(),
      height: _getSizeValue(),
      child: LottieMascot(
        animationPath: animationPath,
        width: _getSizeValue(),
        height: _getSizeValue(),
        repeat: _shouldRepeat(state.mood),
        onAnimationComplete: () {
          // Handle animation completion
          _onAnimationComplete(state);
        },
      ),
    );
  }

  String _getAnimationPath(MascotState state) {
    // Map mascot mood and animation to Lottie files
    switch (state.mood) {
      case MascotMood.welcoming:
        return MascotAnimations.wave;
      case MascotMood.celebrating:
        return MascotAnimations.celebration;
      case MascotMood.sleeping:
        return MascotAnimations.loading; // Use loading as sleep animation
      case MascotMood.disappointed:
        return MascotAnimations.error;
      case MascotMood.playful:
        return MascotAnimations.success;
      case MascotMood.happy:
        return MascotAnimations.success;
      case MascotMood.excited:
        return MascotAnimations.celebration;
      case MascotMood.thinking:
        return MascotAnimations.thinking;
      case MascotMood.sad:
        return MascotAnimations.error;
      case MascotMood.idle:
        return MascotAnimations.welcome;
      default:
        return MascotAnimations.welcome;
    }
  }

  bool _shouldRepeat(MascotMood mood) {
    switch (mood) {
      case MascotMood.sleeping:
      case MascotMood.thinking:
      case MascotMood.idle:
        return true;
      default:
        return false;
    }
  }

  void _onAnimationComplete(MascotState state) {
    // Handle animation completion based on mood
    switch (state.mood) {
      case MascotMood.welcoming:
      case MascotMood.celebrating:
        // After welcoming or celebrating, go to happy state
        break;
      case MascotMood.playful:
        // After playful action, return to happy
        break;
      default:
        break;
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

/// Living Mascot with Cloud Effect (for sad/disappointed state)
class LivingMascotWithCloudWidget extends ConsumerWidget {
  final MascotSize size;
  final MascotPosition position;
  final bool showMessage;

  const LivingMascotWithCloudWidget({
    super.key,
    this.size = MascotSize.medium,
    this.position = MascotPosition.floating,
    this.showMessage = true,
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
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showMessage && mascotState.currentMessage != null) ...[
              _buildMessageBubble(context, mascotState.currentMessage!),
            ],
            Stack(
              alignment: Alignment.center,
              children: [
                // Cloud effect for sad state
                if (mascotState.mood == MascotMood.disappointed || 
                    mascotState.mood == MascotMood.sad) ...[
                  Positioned(
                    top: -10,
                    child: Icon(
                      Icons.cloud,
                      color: PandoraColors.neutral400,
                      size: 20,
                    ),
                  ),
                ],
                // Mascot animation
                LivingMascotWidget(
                  size: size,
                  position: MascotPosition.center,
                  showMessage: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context, String message) {
    return Container(
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
        message,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? PandoraColors.neutral100
              : PandoraColors.neutral900,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
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
