# 🎭 Living Mascot System - Hướng dẫn sử dụng

## Tổng quan

Hệ thống Mascot "Sinh vật sống" biến Pandora thành một người bạn đồng hành thực sự, phản ứng với hành động của người dùng và thúc đẩy họ một cách tinh tế. Hệ thống này được lấy cảm hứng từ Tamagotchi và Finch.

## 🌟 Tính năng chính

### 1. Hệ thống Cảm xúc & Phản ứng

#### Khi người dùng mở app:
- **Mood**: `MascotMood.welcoming`
- **Animation**: `MascotAnimation.wave`
- **Message**: "Welcome back! I missed you! 👋"

#### Khi người dùng hoàn thành nhiệm vụ:
- **Mood**: `MascotMood.celebrating`
- **Animation**: `MascotAnimation.celebration`
- **Message**: "🎉 Amazing! You did it! I'm so proud of you! 🎉"

#### Khi người dùng bỏ lỡ deadline:
- **Mood**: `MascotMood.disappointed`
- **Animation**: `MascotAnimation.sad`
- **Message**: "😔 Oh no... We missed the deadline. But don't worry, we can do better next time!"

#### Khi người dùng không tương tác:
- **Mood**: `MascotMood.idle` → `MascotMood.sleeping`
- **Animation**: `MascotAnimation.idle` → `MascotAnimation.sleep`
- **Message**: "Zzz... I'm taking a nap. Wake me up when you're ready!"

#### Khi người dùng tương tác trực tiếp:
- **Mood**: `MascotMood.playful`
- **Animation**: Random actions (bounce, jump, spin, wave)
- **Message**: Random playful messages

## 🚀 Cách sử dụng

### 1. Import package

```dart
import 'package:pandora/pandora.dart';
```

### 2. Sử dụng Living Mascot Widget

```dart
// Basic usage
LivingMascotWidget(
  size: MascotSize.large,
  position: MascotPosition.floating,
  showMessage: true,
)

// With cloud effect for sad state
LivingMascotWithCloudWidget(
  size: MascotSize.medium,
  position: MascotPosition.bottomRight,
  showMessage: true,
)
```

### 3. Tích hợp với Task System

```dart
// Initialize mascot behavior controller
final mascotController = ref.read(mascotBehaviorControllerProvider);

// Handle app opening
mascotController.initializeMascot();

// Handle task events
mascotController.handleTaskEvent(TaskEvent.completed);
mascotController.handleTaskEvent(TaskEvent.created);
mascotController.handleTaskEvent(TaskEvent.missedDeadline);

// Handle AI events
mascotController.handleAIEvent(AIEvent.processing);
mascotController.handleAIEvent(AIEvent.error);

// Handle sync events
mascotController.handleSyncEvent();

// Handle direct mascot interaction
mascotController.handleMascotInteraction();
```

### 4. Sử dụng Mascot Service trực tiếp

```dart
// Get mascot service
final mascotService = ref.read(mascotServiceProvider.notifier);

// Handle user actions
mascotService.handleUserAction(UserAction.openApp);
mascotService.handleUserAction(UserAction.completeTask);
mascotService.handleUserAction(UserAction.missDeadline);
mascotService.handleUserAction(UserAction.directTouch);

// Handle interactions
mascotService.handleInteraction(MascotInteraction.tap);
mascotService.handleInteraction(MascotInteraction.longPress);
mascotService.handleInteraction(MascotInteraction.doubleTap);
```

## 🎨 Customization

### 1. Mascot Moods

```dart
enum MascotMood {
  neutral,
  happy,
  excited,
  tired,
  confused,
  proud,
  sad,
  thinking,
  // New moods for "living creature" behavior
  welcoming,    // When user opens app
  celebrating,  // When user completes task
  sleeping,     // When user is idle for too long
  idle,         // When user is not interacting
  disappointed, // When user misses deadline
  playful,      // When user interacts directly
}
```

### 2. Mascot Animations

```dart
enum MascotAnimation {
  idle,
  wave,
  jump,
  spin,
  bounce,
  fade,
  scale,
  slide,
  // New animations for "living creature" behavior
  celebration,  // For task completion
  sleep,        // For idle state
  wake,         // For waking up from sleep
  sad,          // For missed deadlines
  cloud,        // For sad state with cloud
  random,       // For random playful actions
}
```

### 3. User Actions

```dart
enum UserAction {
  idle,
  createNote,
  completeTask,
  aiProcessing,
  error,
  sync,
  openApp,
  closeApp,
  search,
  filter,
  // New actions for "living creature" behavior
  missDeadline,   // When user misses a deadline
  longIdle,       // When user is idle for too long
  directTouch,    // When user touches mascot directly
}
```

## 🔧 Configuration

### 1. Idle Timer Settings

```dart
// In MascotService, you can adjust these timers:
_idleTimer = Timer.periodic(const Duration(seconds: 10), (_) {
  // Performs idle actions every 10 seconds
});

_sleepTimer = Timer.periodic(const Duration(seconds: 1), (_) {
  // Updates idle time every second
});

// Sleep after 5 minutes of inactivity
if (idleDuration.inMinutes > 5 && !state.isSleeping) {
  _goToSleep();
}
```

### 2. Message Customization

```dart
// Customize messages in MascotService
case UserAction.openApp:
  state = state.copyWith(
    mood: MascotMood.welcoming,
    currentAnimation: MascotAnimation.wave,
    currentMessage: "Your custom welcome message! 👋",
    // ...
  );
```

## 📱 Demo Screen

Sử dụng `LivingMascotDemoScreen` để test và demo các tính năng:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const LivingMascotDemoScreen(),
  ),
);
```

## 🎯 Best Practices

### 1. Performance
- Sử dụng `ConsumerWidget` để rebuild chỉ khi cần thiết
- Dispose timers khi không sử dụng
- Sử dụng `AnimatedSwitcher` cho smooth transitions

### 2. UX
- Không spam messages quá nhiều
- Sử dụng appropriate timing cho animations
- Provide feedback cho user interactions

### 3. Integration
- Tích hợp với existing task system
- Handle app lifecycle events
- Persist mascot state across sessions

## 🐛 Troubleshooting

### 1. Mascot không hiển thị
- Kiểm tra `isVisible` state
- Đảm bảo widget được wrap trong `ConsumerWidget`
- Check provider setup

### 2. Animations không chạy
- Kiểm tra Lottie files có tồn tại
- Verify animation paths
- Check error logs

### 3. Messages không hiển thị
- Kiểm tra `showMessage` parameter
- Verify message content
- Check container constraints

## 🔮 Future Enhancements

- [ ] Voice interactions
- [ ] Gesture recognition
- [ ] Machine learning for behavior prediction
- [ ] Custom animation editor
- [ ] Multi-mascot support
- [ ] Social features
- [ ] Achievement system

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
