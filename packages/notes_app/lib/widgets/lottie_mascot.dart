import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieMascot extends StatelessWidget {
  final String animationPath;
  final double? width;
  final double? height;
  final bool repeat;
  final bool reverse;
  final Duration? duration;
  final VoidCallback? onAnimationComplete;

  const LottieMascot({
    super.key,
    required this.animationPath,
    this.width,
    this.height,
    this.repeat = true,
    this.reverse = false,
    this.duration,
    this.onAnimationComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      animationPath,
      width: width,
      height: height,
      repeat: repeat,
      reverse: reverse,
      duration: duration,
      onLoaded: (composition) {
        // Animation loaded successfully
        debugPrint('Lottie animation loaded: $animationPath');
      },
      onAnimationComplete: onAnimationComplete,
      errorBuilder: (context, error, stackTrace) {
        // Fallback widget if animation fails to load
        return Container(
          width: width ?? 100,
          height: height ?? 100,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.pets,
            size: 50,
            color: Colors.grey,
          ),
        );
      },
    );
  }
}

// Predefined mascot animations
class MascotAnimations {
  static const String welcome = 'assets/lottie/welcome.json';
  static const String thinking = 'assets/lottie/thinking.json';
  static const String success = 'assets/lottie/success.json';
  static const String error = 'assets/lottie/error.json';
  static const String loading = 'assets/lottie/loading.json';
  static const String celebration = 'assets/lottie/celebration.json';
  static const String wave = 'assets/lottie/wave.json';
  static const String writing = 'assets/lottie/writing.json';
  static const String microphone = 'assets/lottie/microphone.json';
  static const String chat = 'assets/lottie/chat.json';
}

// Specialized mascot widgets for different use cases
class WelcomeMascot extends StatelessWidget {
  final double? size;
  final VoidCallback? onAnimationComplete;

  const WelcomeMascot({
    super.key,
    this.size,
    this.onAnimationComplete,
  });

  @override
  Widget build(BuildContext context) {
    return LottieMascot(
      animationPath: MascotAnimations.welcome,
      width: size,
      height: size,
      repeat: false,
      onAnimationComplete: onAnimationComplete,
    );
  }
}

class ThinkingMascot extends StatelessWidget {
  final double? size;

  const ThinkingMascot({
    super.key,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return LottieMascot(
      animationPath: MascotAnimations.thinking,
      width: size,
      height: size,
      repeat: true,
    );
  }
}

class SuccessMascot extends StatelessWidget {
  final double? size;
  final VoidCallback? onAnimationComplete;

  const SuccessMascot({
    super.key,
    this.size,
    this.onAnimationComplete,
  });

  @override
  Widget build(BuildContext context) {
    return LottieMascot(
      animationPath: MascotAnimations.success,
      width: size,
      height: size,
      repeat: false,
      onAnimationComplete: onAnimationComplete,
    );
  }
}

class ErrorMascot extends StatelessWidget {
  final double? size;
  final VoidCallback? onAnimationComplete;

  const ErrorMascot({
    super.key,
    this.size,
    this.onAnimationComplete,
  });

  @override
  Widget build(BuildContext context) {
    return LottieMascot(
      animationPath: MascotAnimations.error,
      width: size,
      height: size,
      repeat: false,
      onAnimationComplete: onAnimationComplete,
    );
  }
}

class LoadingMascot extends StatelessWidget {
  final double? size;

  const LoadingMascot({
    super.key,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return LottieMascot(
      animationPath: MascotAnimations.loading,
      width: size,
      height: size,
      repeat: true,
    );
  }
}

class CelebrationMascot extends StatelessWidget {
  final double? size;
  final VoidCallback? onAnimationComplete;

  const CelebrationMascot({
    super.key,
    this.size,
    this.onAnimationComplete,
  });

  @override
  Widget build(BuildContext context) {
    return LottieMascot(
      animationPath: MascotAnimations.celebration,
      width: size,
      height: size,
      repeat: false,
      onAnimationComplete: onAnimationComplete,
    );
  }
}

class WaveMascot extends StatelessWidget {
  final double? size;
  final VoidCallback? onAnimationComplete;

  const WaveMascot({
    super.key,
    this.size,
    this.onAnimationComplete,
  });

  @override
  Widget build(BuildContext context) {
    return LottieMascot(
      animationPath: MascotAnimations.wave,
      width: size,
      height: size,
      repeat: false,
      onAnimationComplete: onAnimationComplete,
    );
  }
}

class WritingMascot extends StatelessWidget {
  final double? size;

  const WritingMascot({
    super.key,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return LottieMascot(
      animationPath: MascotAnimations.writing,
      width: size,
      height: size,
      repeat: true,
    );
  }
}

class MicrophoneMascot extends StatelessWidget {
  final double? size;

  const MicrophoneMascot({
    super.key,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return LottieMascot(
      animationPath: MascotAnimations.microphone,
      width: size,
      height: size,
      repeat: true,
    );
  }
}

class ChatMascot extends StatelessWidget {
  final double? size;

  const ChatMascot({
    super.key,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return LottieMascot(
      animationPath: MascotAnimations.chat,
      width: size,
      height: size,
      repeat: true,
    );
  }
}
