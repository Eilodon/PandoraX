import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mascot_service.dart';
import 'mascot_enums.dart';

/// Thought Bubble State
class ThoughtBubbleState {
  final String? message;
  final bool isVisible;
  final DateTime? lastShown;
  final int showCount;
  final ThoughtBubbleType type;

  const ThoughtBubbleState({
    this.message,
    this.isVisible = false,
    this.lastShown,
    this.showCount = 0,
    this.type = ThoughtBubbleType.normal,
  });

  ThoughtBubbleState copyWith({
    String? message,
    bool? isVisible,
    DateTime? lastShown,
    int? showCount,
    ThoughtBubbleType? type,
  }) {
    return ThoughtBubbleState(
      message: message ?? this.message,
      isVisible: isVisible ?? this.isVisible,
      lastShown: lastShown ?? this.lastShown,
      showCount: showCount ?? this.showCount,
      type: type ?? this.type,
    );
  }
}

/// Thought Bubble Types
enum ThoughtBubbleType {
  normal,     // Bong bóng thoại bình thường
  excited,    // Bong bóng phấn khích
  sad,        // Bong bóng buồn
  thinking,   // Bong bóng suy nghĩ
  celebration, // Bong bóng chúc mừng
  reminder,   // Bong bóng nhắc nhở
}

/// Thought Bubble Service
class ThoughtBubbleService extends StateNotifier<ThoughtBubbleState> {
  final Ref _ref;
  Timer? _bubbleTimer;
  Timer? _hideTimer;
  final Random _random = Random();

  // Predefined thought messages
  static const List<String> _motivationalMessages = [
    "Cùng hoàn thành nhiệm vụ hôm nay nhé! 💪",
    "Bạn làm tốt lắm! Tiếp tục phát huy! 🌟",
    "Mỗi ngày là một cơ hội mới! ✨",
    "Hãy tin vào bản thân mình! 💫",
    "Thành công sẽ đến với những ai kiên trì! 🎯",
    "Bạn đang tiến bộ rất nhiều! 🚀",
    "Hôm nay sẽ là một ngày tuyệt vời! 🌈",
    "Hãy làm việc với niềm vui! 😊",
  ];

  static const List<String> _careMessages = [
    "Đừng quên uống nước nha! 💧",
    "Hãy nghỉ ngơi một chút! 😌",
    "Đừng quên ăn uống đầy đủ! 🍎",
    "Hãy ngủ đủ giấc nhé! 😴",
    "Đừng quên tập thể dục! 🏃‍♀️",
    "Hãy chăm sóc bản thân! 💝",
    "Đừng quên gọi điện cho gia đình! 📞",
    "Hãy thư giãn một chút! 🧘‍♀️",
  ];

  static const List<String> _celebrationMessages = [
    "Tuyệt vời! Bạn đã hoàn thành! 🎉",
    "Chúc mừng! Bạn thật giỏi! 🏆",
    "Wow! Thật ấn tượng! ⭐",
    "Tuyệt vời! Tiếp tục như vậy! 🌟",
    "Bạn đã làm rất tốt! 👏",
    "Thật tự hào về bạn! 💖",
    "Chúc mừng thành tích! 🎊",
    "Bạn thật tuyệt vời! 🌈",
  ];

  static const List<String> _sadMessages = [
    "Đừng buồn, chúng ta sẽ làm tốt hơn! 😔",
    "Thất bại là mẹ thành công! 💪",
    "Hãy thử lại, tôi tin bạn! 🤗",
    "Mọi thứ sẽ ổn thôi! 💙",
    "Đừng bỏ cuộc! 🌟",
    "Tôi luôn ở bên bạn! 💕",
    "Hãy học hỏi từ sai lầm! 📚",
    "Ngày mai sẽ tốt hơn! 🌅",
  ];

  static const List<String> _thinkingMessages = [
    "Hmm, để tôi suy nghĩ... 🤔",
    "Có gì đó thú vị đây! 💭",
    "Tôi đang nghĩ về điều gì đó... 🧠",
    "Hãy để tôi suy nghĩ kỹ... 🤓",
    "Tôi có một ý tưởng! 💡",
    "Để tôi xem xét... 👀",
    "Có vẻ như có gì đó... 🔍",
    "Tôi đang phân tích... 📊",
  ];

  static const List<String> _reminderMessages = [
    "Đừng quên deadline sắp tới! ⏰",
    "Có nhiệm vụ mới đang chờ! 📋",
    "Hãy kiểm tra danh sách việc cần làm! ✅",
    "Đừng quên cập nhật tiến độ! 📈",
    "Có thông báo mới! 🔔",
    "Hãy xem lại mục tiêu! 🎯",
    "Đừng quên đồng bộ dữ liệu! 🔄",
    "Có cập nhật quan trọng! ⚡",
  ];

  ThoughtBubbleService(this._ref) : super(const ThoughtBubbleState()) {
    _startBubbleTimer();
  }

  /// Start the bubble timer
  void _startBubbleTimer() {
    _bubbleTimer = Timer.periodic(const Duration(minutes: 2), (_) {
      if (mounted) {
        _showRandomBubble();
      }
    });
  }

  /// Show a random thought bubble
  void _showRandomBubble() {
    final mascotState = _ref.read(mascotServiceProvider);
    
    // Don't show bubbles if mascot is sleeping
    if (mascotState.isSleeping) return;
    
    // Don't show bubbles too frequently
    if (state.lastShown != null) {
      final timeSinceLastShown = DateTime.now().difference(state.lastShown!);
      if (timeSinceLastShown.inMinutes < 1) return;
    }

    // Choose message based on mascot mood
    String message;
    ThoughtBubbleType type;
    
    switch (mascotState.mood) {
      case MascotMood.celebrating:
        message = _celebrationMessages[_random.nextInt(_celebrationMessages.length)];
        type = ThoughtBubbleType.celebration;
        break;
      case MascotMood.sad:
      case MascotMood.disappointed:
        message = _sadMessages[_random.nextInt(_sadMessages.length)];
        type = ThoughtBubbleType.sad;
        break;
      case MascotMood.thinking:
        message = _thinkingMessages[_random.nextInt(_thinkingMessages.length)];
        type = ThoughtBubbleType.thinking;
        break;
      case MascotMood.excited:
        message = _celebrationMessages[_random.nextInt(_celebrationMessages.length)];
        type = ThoughtBubbleType.excited;
        break;
      default:
        // Randomly choose between motivational and care messages
        final messageType = _random.nextInt(3);
        switch (messageType) {
          case 0:
            message = _motivationalMessages[_random.nextInt(_motivationalMessages.length)];
            type = ThoughtBubbleType.normal;
            break;
          case 1:
            message = _careMessages[_random.nextInt(_careMessages.length)];
            type = ThoughtBubbleType.reminder;
            break;
          case 2:
            message = _reminderMessages[_random.nextInt(_reminderMessages.length)];
            type = ThoughtBubbleType.reminder;
            break;
          default:
            message = _motivationalMessages[_random.nextInt(_motivationalMessages.length)];
            type = ThoughtBubbleType.normal;
        }
    }

    _showBubble(message, type);
  }

  /// Show a specific thought bubble
  void _showBubble(String message, ThoughtBubbleType type) {
    state = state.copyWith(
      message: message,
      isVisible: true,
      lastShown: DateTime.now(),
      showCount: state.showCount + 1,
      type: type,
    );

    // Auto-hide after 5 seconds
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        _hideBubble();
      }
    });
  }

  /// Hide the current thought bubble
  void _hideBubble() {
    state = state.copyWith(isVisible: false);
  }

  /// Show a custom thought bubble
  void showCustomBubble(String message, ThoughtBubbleType type) {
    _hideTimer?.cancel();
    _showBubble(message, type);
  }

  /// Show a motivational bubble
  void showMotivationalBubble() {
    final message = _motivationalMessages[_random.nextInt(_motivationalMessages.length)];
    _showBubble(message, ThoughtBubbleType.normal);
  }

  /// Show a care reminder bubble
  void showCareBubble() {
    final message = _careMessages[_random.nextInt(_careMessages.length)];
    _showBubble(message, ThoughtBubbleType.reminder);
  }

  /// Show a celebration bubble
  void showCelebrationBubble() {
    final message = _celebrationMessages[_random.nextInt(_celebrationMessages.length)];
    _showBubble(message, ThoughtBubbleType.celebration);
  }

  /// Show a sad bubble
  void showSadBubble() {
    final message = _sadMessages[_random.nextInt(_sadMessages.length)];
    _showBubble(message, ThoughtBubbleType.sad);
  }

  /// Show a thinking bubble
  void showThinkingBubble() {
    final message = _thinkingMessages[_random.nextInt(_thinkingMessages.length)];
    _showBubble(message, ThoughtBubbleType.thinking);
  }

  /// Show a reminder bubble
  void showReminderBubble() {
    final message = _reminderMessages[_random.nextInt(_reminderMessages.length)];
    _showBubble(message, ThoughtBubbleType.reminder);
  }

  /// Force hide current bubble
  void forceHide() {
    _hideTimer?.cancel();
    _hideBubble();
  }

  /// Pause bubble showing
  void pause() {
    _bubbleTimer?.cancel();
    _hideTimer?.cancel();
  }

  /// Resume bubble showing
  void resume() {
    _startBubbleTimer();
  }

  @override
  void dispose() {
    _bubbleTimer?.cancel();
    _hideTimer?.cancel();
    super.dispose();
  }
}

/// Provider for Thought Bubble Service
final thoughtBubbleProvider = StateNotifierProvider<ThoughtBubbleService, ThoughtBubbleState>((ref) {
  return ThoughtBubbleService(ref);
});

/// Thought Bubble Widget
class ThoughtBubbleWidget extends ConsumerWidget {
  final double? width;
  final double? height;
  final Duration animationDuration;

  const ThoughtBubbleWidget({
    super.key,
    this.width,
    this.height,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bubbleState = ref.watch(thoughtBubbleProvider);
    
    if (!bubbleState.isVisible || bubbleState.message == null) {
      return const SizedBox.shrink();
    }

    return AnimatedOpacity(
      opacity: bubbleState.isVisible ? 1.0 : 0.0,
      duration: animationDuration,
      child: Container(
        width: width ?? 200,
        height: height ?? 60,
        margin: const EdgeInsets.only(bottom: 10),
        child: Stack(
          children: [
            // Bubble background
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _getBubbleColor(bubbleState.type),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  bubbleState.message!,
                  style: TextStyle(
                    color: _getTextColor(bubbleState.type),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Bubble tail
            Positioned(
              bottom: -5,
              left: 20,
              child: CustomPaint(
                size: const Size(20, 10),
                painter: BubbleTailPainter(_getBubbleColor(bubbleState.type)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBubbleColor(ThoughtBubbleType type) {
    switch (type) {
      case ThoughtBubbleType.excited:
        return const Color(0xFFFFD700); // Gold
      case ThoughtBubbleType.sad:
        return const Color(0xFFE0E0E0); // Light gray
      case ThoughtBubbleType.thinking:
        return const Color(0xFFE3F2FD); // Light blue
      case ThoughtBubbleType.celebration:
        return const Color(0xFFFF9800); // Orange
      case ThoughtBubbleType.reminder:
        return const Color(0xFF4CAF50); // Green
      case ThoughtBubbleType.normal:
      default:
        return const Color(0xFFFFFFFF); // White
    }
  }

  Color _getTextColor(ThoughtBubbleType type) {
    switch (type) {
      case ThoughtBubbleType.excited:
      case ThoughtBubbleType.celebration:
        return const Color(0xFF000000); // Black
      case ThoughtBubbleType.sad:
        return const Color(0xFF666666); // Dark gray
      case ThoughtBubbleType.thinking:
        return const Color(0xFF1976D2); // Blue
      case ThoughtBubbleType.reminder:
        return const Color(0xFFFFFFFF); // White
      case ThoughtBubbleType.normal:
      default:
        return const Color(0xFF333333); // Dark gray
    }
  }
}

/// Custom painter for bubble tail
class BubbleTailPainter extends CustomPainter {
  final Color color;

  BubbleTailPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
