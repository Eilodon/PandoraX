# 🔑 API Setup Guide - PandoraX

Để kích hoạt 100% chức năng AI trong PandoraX, bạn cần cấu hình API keys cho các dịch vụ bên ngoài.

## 🤖 Google Gemini AI (Bắt buộc)

### Bước 1: Lấy API Key miễn phí
1. Truy cập: https://makersuite.google.com/app/apikey
2. Đăng nhập bằng Google account
3. Click "Create API Key"
4. Copy API key được tạo

### Bước 2: Cấu hình API Key
Có 2 cách để cấu hình:

#### Cách 1: Cập nhật file config (Khuyến nghị)
1. Mở file: `packages/presentation/pandora_app/lib/config/api_config.dart`
2. Thay thế `YOUR_GEMINI_API_KEY_HERE` bằng API key thực tế
3. Lưu file

#### Cách 2: Sử dụng Environment Variable
1. Tạo file `.env` trong thư mục gốc của project
2. Thêm dòng: `GEMINI_API_KEY=your_actual_api_key_here`
3. Hoặc export trong terminal: `export GEMINI_API_KEY=your_actual_api_key_here`

### Bước 3: Test AI Features
1. Chạy app: `flutter run`
2. Mở tab "AI Assistant"
3. Gửi tin nhắn để test AI response

## 🔥 Firebase (Tùy chọn - cho Cloud Sync)

### Bước 1: Tạo Firebase Project
1. Truy cập: https://console.firebase.google.com/
2. Click "Create a project"
3. Đặt tên project: `pandora-rebuilt`
4. Enable Google Analytics (tùy chọn)

### Bước 2: Cấu hình Android App
1. Click "Add app" > Android
2. Package name: `com.pandora.rebuilt`
3. Download `google-services.json`
4. Đặt file vào: `packages/presentation/pandora_app/android/app/`

### Bước 3: Cấu hình iOS App (nếu cần)
1. Click "Add app" > iOS
2. Bundle ID: `com.pandora.rebuilt`
3. Download `GoogleService-Info.plist`
4. Đặt file vào: `packages/presentation/pandora_app/ios/Runner/`

## 🎤 Voice Features (Tùy chọn)

Voice features sẽ hoạt động tự động trên thiết bị thật mà không cần API key bổ sung.

## 📊 Kiểm tra cấu hình

Sau khi cấu hình xong, chạy app và kiểm tra:

1. **AI Features**: Mở tab AI, gửi tin nhắn
2. **Database**: Tạo, sửa, xóa notes
3. **Voice**: Ghi âm và chuyển đổi thành text
4. **Cloud Sync**: Đồng bộ notes (nếu đã cấu hình Firebase)

## 🚨 Troubleshooting

### AI không hoạt động
- Kiểm tra API key có đúng không
- Kiểm tra kết nối internet
- Xem logs trong console để debug

### Database lỗi
- Xóa app và cài lại
- Kiểm tra quyền storage

### Voice không hoạt động
- Kiểm tra quyền microphone
- Test trên thiết bị thật (không hoạt động trên emulator)

## 📞 Hỗ trợ

Nếu gặp vấn đề, hãy:
1. Kiểm tra logs trong console
2. Đảm bảo đã follow đúng hướng dẫn
3. Test trên thiết bị thật thay vì emulator