# 🎨 Vùng tương tác Mascot - Hướng dẫn sử dụng

## Tổng quan

Hệ thống "Vùng tương tác" cho Mascot tạo ra một môi trường tương tác phong phú xung quanh Mascot trên DashboardScreen, cho phép người dùng trang trí không gian và tương tác với Mascot thông qua bong bóng thoại ngẫu nhiên.

## 🌟 Tính năng chính

### 1. Hệ thống Gold & Mua sắm

#### 💰 Gold System:
- **Kiếm Gold**: Hoàn thành nhiệm vụ, đăng nhập hàng ngày, thành tích
- **Mua sắm**: Sử dụng Gold để mua đồ trang trí
- **Lưu trữ**: Gold được lưu trong SharedPreferences

#### 🛍️ Decoration Shop:
- **8 loại đồ trang trí**: Cây, đèn, sách, đồ nội thất, tranh, đồ chơi, thức ăn, phụ kiện
- **Giá cả đa dạng**: Từ 30-600 Gold
- **Unlock system**: Mở khóa đồ trang trí sau khi mua

### 2. Môi trường tương tác

#### 🏠 MascotEnvironmentWidget:
- **Vùng tương tác**: Tap vào vùng trống để đặt đồ trang trí
- **Edit mode**: Chế độ chỉnh sửa để di chuyển/xóa đồ trang trí
- **Drag & Drop**: Kéo thả đồ trang trí (sẽ implement sau)
- **Visual feedback**: Hiệu ứng khi tương tác

#### 🎭 Bong bóng thoại ngẫu nhiên:
- **6 loại bong bóng**: Normal, excited, sad, thinking, celebration, reminder
- **Messages đa dạng**: 40+ thông điệp khác nhau
- **Auto-trigger**: Tự động hiện mỗi 2 phút
- **Mood-based**: Nội dung phụ thuộc vào tâm trạng Mascot

### 3. Hệ thống thưởng Gold

#### 🏆 Task Rewards:
```dart
// Easy task: 10 Gold
// Medium task: 25 Gold  
// Hard task: 50 Gold
// Expert task: 100 Gold

// Bonus:
// - On-time completion: +50%
// - Streak bonus: +5 Gold per day
// - Random bonus: 10% chance +50 Gold
```

#### 🎯 Achievement Rewards:
- **First Task**: 50 Gold
- **Week Streak**: 100 Gold
- **Month Streak**: 500 Gold
- **Perfect Week**: 200 Gold
- **Speed Demon**: 150 Gold
- **Night Owl**: 75 Gold
- **Early Bird**: 75 Gold
- **Social Butterfly**: 100 Gold
- **Perfectionist**: 300 Gold
- **Explorer**: 125 Gold

## 🚀 Cách sử dụng

### 1. Basic Environment Setup

```dart
MascotEnvironmentWidget(
  width: 400,
  height: 300,
  showThoughtBubbles: true,
  allowDecoration: true,
  onEnvironmentTap: () {
    // Handle environment tap
  },
)
```

### 2. Gold System Integration

```dart
// Initialize gold reward system
final goldSystem = ref.read(goldRewardSystemProvider);

// Reward task completion
await goldSystem.rewardTaskCompletion(
  taskId: 'task_123',
  difficulty: TaskDifficulty.medium,
  onTime: true,
  streakCount: 3,
);

// Reward daily login
await goldSystem.rewardDailyLogin();

// Reward achievements
await goldSystem.rewardSpecialAchievement(AchievementType.weekStreak);
```

### 3. Decoration System

```dart
// Get decoration service
final decorationService = ref.read(decorationSystemWithPrefsProvider.notifier);

// Purchase item
await decorationService.purchaseItem('plant_1');

// Place decoration
await decorationService.placeDecoration('plant_1', 100.0, 150.0);

// Remove decoration
await decorationService.removeDecoration('placed_decoration_id');
```

### 4. Thought Bubbles

```dart
// Get thought bubble service
final thoughtService = ref.read(thoughtBubbleProvider.notifier);

// Show custom bubble
thoughtService.showCustomBubble(
  "Custom message!",
  ThoughtBubbleType.normal,
);

// Show specific bubble types
thoughtService.showMotivationalBubble();
thoughtService.showCareBubble();
thoughtService.showCelebrationBubble();
```

## 🎨 Customization

### 1. Decoration Items

Thêm đồ trang trí mới trong `DecorationSystemService`:

```dart
DecorationItem(
  id: 'custom_item',
  name: 'Custom Decoration',
  description: 'A custom decoration item',
  type: DecorationType.plant,
  price: 100,
  iconPath: 'assets/decorations/custom.png',
  animationPath: 'assets/lottie/custom.json',
  tags: ['custom', 'special'],
),
```

### 2. Thought Messages

Thêm thông điệp mới trong `ThoughtBubbleService`:

```dart
static const List<String> _customMessages = [
  "Custom message 1! 🎉",
  "Custom message 2! ✨",
  "Custom message 3! 🌟",
];
```

### 3. Gold Rewards

Tùy chỉnh phần thưởng Gold:

```dart
int _getBaseGoldForDifficulty(TaskDifficulty difficulty) {
  switch (difficulty) {
    case TaskDifficulty.easy:
      return 15; // Increased from 10
    case TaskDifficulty.medium:
      return 35; // Increased from 25
    // ...
  }
}
```

## 📱 Demo Screens

### 1. MascotEnvironmentDemoScreen
- Interactive environment với Mascot
- Demo controls cho tất cả tính năng
- Gold animation effects
- Shop integration

### 2. DecorationShopWidget
- Browse tất cả đồ trang trí
- Filter theo loại
- Purchase system
- Gold display

## 🎯 UX Flow

### 1. Vòng lặp tương tác:
```
Làm nhiệm vụ → Kiếm Gold → Mua đồ trang trí → Đặt vào môi trường → 
Không gian đẹp hơn → Có động lực làm nhiệm vụ tiếp
```

### 2. Mascot Interaction:
```
Mascot hiển thị bong bóng thoại → Người dùng tương tác → 
Mascot phản ứng → Tạo cảm giác gắn kết
```

### 3. Personalization:
```
Người dùng trang trí không gian → Tạo không gian riêng → 
Cảm giác sở hữu → Tăng engagement
```

## 🔧 Technical Implementation

### 1. State Management:
- **Riverpod**: State management
- **SharedPreferences**: Data persistence
- **StateNotifier**: Reactive updates

### 2. Architecture:
- **Service Layer**: Business logic
- **Widget Layer**: UI components
- **Integration Layer**: System integration

### 3. Performance:
- **Lazy loading**: Decoration items
- **Efficient rendering**: Optimized widgets
- **Memory management**: Proper disposal

## 🐛 Troubleshooting

### 1. Gold không hiển thị:
- Kiểm tra SharedPreferences setup
- Verify provider initialization
- Check error logs

### 2. Decorations không lưu:
- Kiểm tra JSON serialization
- Verify SharedPreferences permissions
- Check error handling

### 3. Thought bubbles không hiện:
- Kiểm tra timer setup
- Verify mascot state
- Check message configuration

## 🔮 Future Enhancements

- [ ] Drag & Drop decorations
- [ ] Decoration animations
- [ ] Multi-layer environment
- [ ] Weather effects
- [ ] Day/night cycle
- [ ] Sound effects
- [ ] Haptic feedback
- [ ] Social sharing
- [ ] Achievement gallery
- [ ] Custom themes

## 📄 Files Structure

```
lib/
├── services/
│   ├── decoration_system.dart          # Decoration & Gold system
│   ├── mascot_thought_bubbles.dart     # Thought bubble system
│   └── gold_reward_system.dart         # Gold reward system
├── widgets/
│   └── mascot_environment_widget.dart  # Main environment widget
└── features/mascot/presentation/
    └── mascot_environment_demo_screen.dart  # Demo screen
```

## ✨ Kết luận

Hệ thống "Vùng tương tác" đã được triển khai thành công với:

- ✅ **Gold System**: Kiếm và sử dụng Gold
- ✅ **Decoration Shop**: Mua sắm đồ trang trí
- ✅ **Interactive Environment**: Môi trường tương tác
- ✅ **Thought Bubbles**: Bong bóng thoại ngẫu nhiên
- ✅ **Personalization**: Cá nhân hóa không gian
- ✅ **Demo Screens**: Screens demo đầy đủ

Hệ thống tạo ra một vòng lặp tương tác hấp dẫn, khuyến khích người dùng hoàn thành nhiệm vụ để kiếm Gold, mua đồ trang trí, và tạo ra không gian riêng của mình! 🎨✨
