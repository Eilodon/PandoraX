import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Mascot Animation Types
enum MascotAnimation {
  idle,           // Trạng thái nghỉ ngơi
  happy,          // Vui vẻ khi user tạo ghi chú mới
  thinking,       // Suy nghĩ khi AI đang xử lý
  celebrating,    // Ăn mừng khi hoàn thành task
  sleeping,       // Ngủ khi không có hoạt động
  waving,         // Vẫy tay chào
  excited,        // Hào hứng khi có nhiều ghi chú
  confused,       // Bối rối khi có lỗi
  working,        // Làm việc khi sync
  eating,         // Ăn khi user tương tác nhiều
}

/// Mascot Mood States
enum MascotMood {
  neutral,        // Bình thường
  happy,          // Vui vẻ
  excited,        // Hào hứng
  tired,          // Mệt mỏi
  confused,       // Bối rối
  proud,          // Tự hào
}

/// Mascot Interaction Types
enum MascotInteraction {
  tap,            // Chạm vào mascot
  longPress,      // Nhấn giữ
  swipe,          // Vuốt
  doubleTap,      // Chạm đôi
  shake,          // Lắc thiết bị
}

/// Mascot Service - Quản lý trạng thái và tương tác của mascot
class MascotService extends StateNotifier<MascotState> {
  MascotService() : super(const MascotState());

  Timer? _idleTimer;
  Timer? _moodTimer;
  int _interactionCount = 0;
  DateTime _lastInteraction = DateTime.now();

  /// Khởi tạo mascot
  void initialize() {
    _startIdleTimer();
    _startMoodTimer();
  }

  /// Xử lý tương tác từ user
  void handleInteraction(MascotInteraction interaction) {
    _interactionCount++;
    _lastInteraction = DateTime.now();
    
    // Reset idle timer
    _idleTimer?.cancel();
    _startIdleTimer();

    // Xử lý tương tác cụ thể
    switch (interaction) {
      case MascotInteraction.tap:
        _handleTap();
        break;
      case MascotInteraction.longPress:
        _handleLongPress();
        break;
      case MascotInteraction.swipe:
        _handleSwipe();
        break;
      case MascotInteraction.doubleTap:
        _handleDoubleTap();
        break;
      case MascotInteraction.shake:
        _handleShake();
        break;
    }
  }

  /// Xử lý hành động của user
  void handleUserAction(UserAction action) {
    switch (action) {
      case UserAction.createNote:
        _celebrateNoteCreation();
        break;
      case UserAction.completeTask:
        _celebrateTaskCompletion();
        break;
      case UserAction.aiProcessing:
        _showThinking();
        break;
      case UserAction.error:
        _showConfusion();
        break;
      case UserAction.sync:
        _showWorking();
        break;
      case UserAction.idle:
        _showIdle();
        break;
    }
  }

  /// Cập nhật trạng thái dựa trên số lượng ghi chú
  void updateNoteCount(int noteCount) {
    if (noteCount == 0) {
      state = state.copyWith(
        animation: MascotAnimation.sleeping,
        mood: MascotMood.tired,
        message: 'Hãy tạo ghi chú đầu tiên của bạn!',
      );
    } else if (noteCount < 5) {
      state = state.copyWith(
        animation: MascotAnimation.idle,
        mood: MascotMood.neutral,
        message: 'Bạn đang làm rất tốt!',
      );
    } else if (noteCount < 20) {
      state = state.copyWith(
        animation: MascotAnimation.happy,
        mood: MascotMood.happy,
        message: 'Wow! Bạn đã tạo $noteCount ghi chú!',
      );
    } else {
      state = state.copyWith(
        animation: MascotAnimation.excited,
        mood: MascotMood.excited,
        message: 'Tuyệt vời! $noteCount ghi chú! Bạn là một người rất có tổ chức!',
      );
    }
  }

  /// Xử lý chạm vào mascot
  void _handleTap() {
    final random = Random();
    final messages = [
      'Meow! Bạn cần gì không?',
      'Chào bạn! Tôi đang ở đây để giúp đỡ!',
      'Hãy tạo ghi chú mới nhé!',
      'Tôi có thể giúp gì cho bạn?',
    ];
    
    state = state.copyWith(
      animation: MascotAnimation.waving,
      message: messages[random.nextInt(messages.length)],
      showMessage: true,
    );
    
    _hideMessageAfterDelay();
  }

  /// Xử lý nhấn giữ
  void _handleLongPress() {
    state = state.copyWith(
      animation: MascotAnimation.eating,
      message: 'Mmm... ngon quá! Cảm ơn bạn!',
      showMessage: true,
    );
    
    _hideMessageAfterDelay();
  }

  /// Xử lý vuốt
  void _handleSwipe() {
    state = state.copyWith(
      animation: MascotAnimation.excited,
      message: 'Wheee! Đó là một cú vuốt tuyệt vời!',
      showMessage: true,
    );
    
    _hideMessageAfterDelay();
  }

  /// Xử lý chạm đôi
  void _handleDoubleTap() {
    state = state.copyWith(
      animation: MascotAnimation.celebrating,
      message: 'Yay! Bạn đã chạm đôi! Tôi rất vui!',
      showMessage: true,
    );
    
    _hideMessageAfterDelay();
  }

  /// Xử lý lắc thiết bị
  void _handleShake() {
    state = state.copyWith(
      animation: MascotAnimation.confused,
      message: 'Whoa! Tôi cảm thấy hơi chóng mặt...',
      showMessage: true,
    );
    
    _hideMessageAfterDelay();
  }

  /// Ăn mừng tạo ghi chú mới
  void _celebrateNoteCreation() {
    state = state.copyWith(
      animation: MascotAnimation.celebrating,
      mood: MascotMood.happy,
      message: 'Tuyệt vời! Ghi chú mới đã được tạo!',
      showMessage: true,
    );
    
    _hideMessageAfterDelay();
  }

  /// Ăn mừng hoàn thành task
  void _celebrateTaskCompletion() {
    state = state.copyWith(
      animation: MascotAnimation.celebrating,
      mood: MascotMood.proud,
      message: 'Tuyệt vời! Bạn đã hoàn thành task!',
      showMessage: true,
    );
    
    _hideMessageAfterDelay();
  }

  /// Hiển thị suy nghĩ
  void _showThinking() {
    state = state.copyWith(
      animation: MascotAnimation.thinking,
      message: 'Hmm... AI đang suy nghĩ...',
      showMessage: true,
    );
  }

  /// Hiển thị bối rối
  void _showConfusion() {
    state = state.copyWith(
      animation: MascotAnimation.confused,
      mood: MascotMood.confused,
      message: 'Oops! Có vẻ như có lỗi gì đó...',
      showMessage: true,
    );
    
    _hideMessageAfterDelay();
  }

  /// Hiển thị làm việc
  void _showWorking() {
    state = state.copyWith(
      animation: MascotAnimation.working,
      message: 'Đang đồng bộ dữ liệu...',
      showMessage: true,
    );
  }

  /// Hiển thị nghỉ ngơi
  void _showIdle() {
    state = state.copyWith(
      animation: MascotAnimation.idle,
      message: 'Tôi đang nghỉ ngơi...',
      showMessage: false,
    );
  }

  /// Bắt đầu timer nghỉ ngơi
  void _startIdleTimer() {
    _idleTimer?.cancel();
    _idleTimer = Timer(const Duration(seconds: 30), () {
      if (DateTime.now().difference(_lastInteraction).inSeconds > 30) {
        _showIdle();
      }
    });
  }

  /// Bắt đầu timer thay đổi mood
  void _startMoodTimer() {
    _moodTimer?.cancel();
    _moodTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
      _updateRandomMood();
    });
  }

  /// Cập nhật mood ngẫu nhiên
  void _updateRandomMood() {
    if (DateTime.now().difference(_lastInteraction).inMinutes < 5) return;
    
    final random = Random();
    final moods = MascotMood.values;
    final currentMood = moods[random.nextInt(moods.length)];
    
    state = state.copyWith(mood: currentMood);
  }

  /// Ẩn message sau delay
  void _hideMessageAfterDelay() {
    Timer(const Duration(seconds: 3), () {
      state = state.copyWith(showMessage: false);
    });
  }

  @override
  void dispose() {
    _idleTimer?.cancel();
    _moodTimer?.cancel();
    super.dispose();
  }
}

/// User Action Types
enum UserAction {
  createNote,
  completeTask,
  aiProcessing,
  error,
  sync,
  idle,
}

/// Mascot State
class MascotState {
  final MascotAnimation animation;
  final MascotMood mood;
  final String message;
  final bool showMessage;
  final bool isVisible;

  const MascotState({
    this.animation = MascotAnimation.idle,
    this.mood = MascotMood.neutral,
    this.message = '',
    this.showMessage = false,
    this.isVisible = true,
  });

  MascotState copyWith({
    MascotAnimation? animation,
    MascotMood? mood,
    String? message,
    bool? showMessage,
    bool? isVisible,
  }) {
    return MascotState(
      animation: animation ?? this.animation,
      mood: mood ?? this.mood,
      message: message ?? this.message,
      showMessage: showMessage ?? this.showMessage,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

/// Mascot Service Provider
final mascotServiceProvider = StateNotifierProvider<MascotService, MascotState>((ref) {
  final service = MascotService();
  service.initialize();
  return service;
});
