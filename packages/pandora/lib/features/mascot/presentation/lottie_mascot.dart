import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/mascot_state.dart';

/// Lottie Mascot Widget
/// 
/// A widget that displays the mascot using Lottie animations
class LottieMascot extends ConsumerWidget {
  final MascotState mascotState;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const LottieMascot({
    super.key,
    required this.mascotState,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 200,
        height: height ?? 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue.withValues(alpha: 0.1),
        ),
        child: Center(
          child: Icon(
            _getMascotIcon(mascotState.mood),
            size: 100,
            color: _getMascotColor(mascotState.mood),
          ),
        ),
      ),
    );
  }

  IconData _getMascotIcon(MascotMood mood) {
    switch (mood) {
      case MascotMood.happy:
        return Icons.sentiment_very_satisfied;
      case MascotMood.sad:
        return Icons.sentiment_very_dissatisfied;
      case MascotMood.excited:
        return Icons.sentiment_satisfied_alt;
      case MascotMood.tired:
        return Icons.sentiment_dissatisfied;
      case MascotMood.neutral:
      default:
        return Icons.sentiment_neutral;
    }
  }

  Color _getMascotColor(MascotMood mood) {
    switch (mood) {
      case MascotMood.happy:
        return Colors.yellow;
      case MascotMood.sad:
        return Colors.blue;
      case MascotMood.excited:
        return Colors.orange;
      case MascotMood.tired:
        return Colors.grey;
      case MascotMood.neutral:
      default:
        return Colors.green;
    }
  }
}
