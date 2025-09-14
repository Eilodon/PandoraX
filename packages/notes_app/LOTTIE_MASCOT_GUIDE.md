# 🎭 Hướng dẫn sử dụng Lottie Mascot

## 📁 Cấu trúc thư mục

```
packages/notes_app/
├── assets/
│   ├── lottie/           # Thư mục chứa file Lottie animations
│   │   ├── welcome.json
│   │   ├── thinking.json
│   │   ├── success.json
│   │   ├── error.json
│   │   ├── loading.json
│   │   ├── celebration.json
│   │   ├── wave.json
│   │   ├── writing.json
│   │   ├── microphone.json
│   │   └── chat.json
│   └── images/           # Thư mục chứa hình ảnh
└── lib/
    └── widgets/
        └── lottie_mascot.dart  # Widget Lottie mascot
```

## 🎨 Cách thêm file Lottie

### 1. Tải file Lottie từ LottieFiles
- Truy cập [LottieFiles](https://lottiefiles.com/)
- Tìm animation phù hợp
- Tải file `.json`
- Đặt vào thư mục `assets/lottie/`

### 2. Đặt tên file theo quy ước
```bash
# Các file mascot cơ bản
welcome.json      # Chào mừng
thinking.json     # Suy nghĩ
success.json      # Thành công
error.json        # Lỗi
loading.json      # Đang tải
celebration.json  # Chúc mừng
wave.json         # Vẫy tay
writing.json      # Viết ghi chú
microphone.json   # Ghi âm
chat.json         # Trò chuyện
```

## 🚀 Cách sử dụng

### 1. Import widget
```dart
import 'package:notes_app/widgets/lottie_mascot.dart';
```

### 2. Sử dụng mascot cơ bản
```dart
// Mascot tùy chỉnh
LottieMascot(
  animationPath: 'assets/lottie/custom.json',
  width: 200,
  height: 200,
  repeat: true,
  onAnimationComplete: () {
    print('Animation completed!');
  },
)

// Mascot có sẵn
WelcomeMascot(
  size: 150,
  onAnimationComplete: () {
    // Xử lý khi animation hoàn thành
  },
)
```

### 3. Các mascot có sẵn

#### WelcomeMascot - Chào mừng
```dart
WelcomeMascot(
  size: 200,
  onAnimationComplete: () {
    // Chuyển sang màn hình chính
  },
)
```

#### ThinkingMascot - Suy nghĩ
```dart
ThinkingMascot(
  size: 100,
) // Lặp lại liên tục
```

#### SuccessMascot - Thành công
```dart
SuccessMascot(
  size: 150,
  onAnimationComplete: () {
    // Hiển thị thông báo thành công
  },
)
```

#### ErrorMascot - Lỗi
```dart
ErrorMascot(
  size: 120,
  onAnimationComplete: () {
    // Xử lý sau khi hiển thị lỗi
  },
)
```

#### LoadingMascot - Đang tải
```dart
LoadingMascot(
  size: 80,
) // Lặp lại liên tục
```

#### CelebrationMascot - Chúc mừng
```dart
CelebrationMascot(
  size: 180,
  onAnimationComplete: () {
    // Xử lý sau khi chúc mừng
  },
)
```

#### WaveMascot - Vẫy tay
```dart
WaveMascot(
  size: 100,
  onAnimationComplete: () {
    // Xử lý sau khi vẫy tay
  },
)
```

#### WritingMascot - Viết ghi chú
```dart
WritingMascot(
  size: 120,
) // Lặp lại liên tục
```

#### MicrophoneMascot - Ghi âm
```dart
MicrophoneMascot(
  size: 100,
) // Lặp lại liên tục
```

#### ChatMascot - Trò chuyện
```dart
ChatMascot(
  size: 100,
) // Lặp lại liên tục
```

## 🎯 Ví dụ sử dụng trong ứng dụng

### 1. Màn hình chào mừng
```dart
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WelcomeMascot(
              size: 200,
              onAnimationComplete: () {
                // Chuyển sang màn hình chính
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => NotesPage()),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              'Chào mừng đến với Notes App!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
```

### 2. Loading state
```dart
class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingMascot(size: 100),
          SizedBox(height: 16),
          Text('Đang tải...'),
        ],
      ),
    );
  }
}
```

### 3. Error state
```dart
class ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorWidget({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ErrorMascot(
            size: 120,
            onAnimationComplete: () {
              // Có thể thêm hiệu ứng sau khi hiển thị lỗi
            },
          ),
          SizedBox(height: 16),
          Text(message),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: Text('Thử lại'),
          ),
        ],
      ),
    );
  }
}
```

### 4. Success state
```dart
class SuccessWidget extends StatelessWidget {
  final String message;
  final VoidCallback onContinue;

  const SuccessWidget({
    required this.message,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SuccessMascot(
            size: 150,
            onAnimationComplete: () {
              // Tự động chuyển sau khi hiển thị thành công
              Future.delayed(Duration(seconds: 1), onContinue);
            },
          ),
          SizedBox(height: 16),
          Text(message),
        ],
      ),
    );
  }
}
```

## 🛠️ Tùy chỉnh nâng cao

### 1. Mascot với hiệu ứng đặc biệt
```dart
LottieMascot(
  animationPath: 'assets/lottie/special.json',
  width: 200,
  height: 200,
  repeat: true,
  reverse: true, // Chạy ngược
  duration: Duration(seconds: 3), // Thời gian animation
  onAnimationComplete: () {
    // Xử lý khi hoàn thành
  },
)
```

### 2. Mascot với fallback
```dart
// Nếu file Lottie không tồn tại, sẽ hiển thị icon mặc định
LottieMascot(
  animationPath: 'assets/lottie/non_existent.json',
  width: 100,
  height: 100,
)
```

## 📱 Tối ưu hóa

### 1. Kích thước file
- Giữ file Lottie < 500KB
- Sử dụng animation đơn giản
- Tối ưu hóa trên [LottieFiles](https://lottiefiles.com/tools/optimizer)

### 2. Performance
- Sử dụng `repeat: false` cho animation một lần
- Sử dụng `repeat: true` cho animation liên tục
- Dispose animation khi không cần thiết

### 3. Responsive design
```dart
LottieMascot(
  animationPath: MascotAnimations.welcome,
  width: MediaQuery.of(context).size.width * 0.6,
  height: MediaQuery.of(context).size.height * 0.3,
)
```

## 🎨 Nguồn Lottie animations

### 1. LottieFiles (Miễn phí)
- [LottieFiles](https://lottiefiles.com/)
- Tìm kiếm: "mascot", "character", "animation"

### 2. LottieFiles (Premium)
- [LottieFiles Pro](https://lottiefiles.com/pro)
- Chất lượng cao hơn
- Nhiều tùy chọn hơn

### 3. Tạo custom
- [After Effects](https://www.adobe.com/products/aftereffects.html)
- [Bodymovin plugin](https://github.com/airbnb/lottie-web)

## 🐛 Troubleshooting

### 1. Animation không hiển thị
- Kiểm tra đường dẫn file
- Kiểm tra file có tồn tại không
- Kiểm tra pubspec.yaml có cấu hình assets

### 2. Animation bị lỗi
- Kiểm tra format file JSON
- Kiểm tra version Lottie
- Sử dụng errorBuilder để debug

### 3. Performance kém
- Giảm kích thước file
- Sử dụng animation đơn giản hơn
- Kiểm tra memory usage

## 📚 Tài liệu tham khảo

- [Lottie Flutter Package](https://pub.dev/packages/lottie)
- [LottieFiles](https://lottiefiles.com/)
- [Lottie Web](https://lottie-web.github.io/lottie-web/)
- [After Effects](https://www.adobe.com/products/aftereffects.html)
