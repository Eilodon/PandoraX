# Hướng dẫn sử dụng các tính năng mới

## 🎯 Tổng quan

Ứng dụng Notes App đã được nâng cấp với các tính năng AI và nhận dạng giọng nói mạnh mẽ:

1. **Trò chuyện với AI** - Chat với AI để được hỗ trợ quản lý ghi chú
2. **Nhận dạng giọng nói** - Tạo ghi chú bằng giọng nói
3. **Tóm tắt AI** - Tóm tắt nội dung ghi chú bằng AI
4. **Nhắc nhở thông báo** - Thiết lập nhắc nhở cho ghi chú

## 🤖 1. Trò chuyện với AI

### Cách sử dụng:
1. Mở ứng dụng Notes
2. Nhấn nút **chat** (biểu tượng chat) ở góc dưới bên phải
3. Nhập câu hỏi hoặc yêu cầu của bạn
4. AI sẽ trả lời và hỗ trợ bạn quản lý ghi chú

### Tính năng:
- Giao diện chat đẹp mắt với bubble tin nhắn
- Hiển thị trạng thái "AI đang suy nghĩ..."
- Xóa toàn bộ cuộc trò chuyện
- Xử lý lỗi thông minh

## 🎤 2. Nhận dạng giọng nói

### Cách sử dụng:
1. Nhấn nút **microphone** (màu tím) ở góc dưới bên phải
2. Nhấn "Bắt đầu ghi âm"
3. Nói nội dung ghi chú của bạn
4. Nhấn "Dừng ghi âm" khi hoàn thành
5. Nhấn "Tạo ghi chú từ văn bản này" để tạo ghi chú mới

### Tính năng:
- Nhận dạng giọng nói theo thời gian thực
- Hiển thị văn bản đang được nhận dạng (partial text)
- Hỗ trợ tiếng Việt
- Tự động tạo ghi chú từ văn bản đã nhận dạng
- Xử lý lỗi và yêu cầu quyền microphone

## 📝 3. Tóm tắt AI

### Cách sử dụng:
1. Mở một ghi chú bất kỳ (nhấn vào ghi chú trong danh sách)
2. Cuộn xuống phần "AI Summary"
3. Nhấn nút "Summarize"
4. Chờ AI tạo tóm tắt

### Tính năng:
- Tóm tắt nội dung ghi chú bằng AI Gemini
- Hiển thị trạng thái loading
- Xử lý lỗi và cho phép thử lại
- Giao diện đẹp với các trạng thái khác nhau

## ⏰ 4. Nhắc nhở thông báo

### Cách sử dụng:
1. Tạo ghi chú mới hoặc chỉnh sửa ghi chú có sẵn
2. Cuộn xuống phần "Nhắc nhở"
3. Nhấn "Thiết lập nhắc nhở"
4. Chọn ngày và giờ nhắc nhở
5. Lưu ghi chú

### Tính năng:
- Chọn ngày và giờ nhắc nhở
- Hiển thị thông tin nhắc nhở trong chi tiết ghi chú
- Thông báo cục bộ khi đến giờ nhắc nhở
- Hủy nhắc nhở bằng cách xóa thời gian nhắc nhở

## ⚙️ Cài đặt

### 1. API Key cho AI
Để sử dụng tính năng AI, bạn cần thiết lập API key:

```bash
# Cách 1: Environment variable
export GEMINI_API_KEY="your-api-key-here"
flutter run

# Cách 2: Dart define
flutter run --dart-define=GEMINI_API_KEY=your-key-here
```

### 2. Quyền ứng dụng
Ứng dụng sẽ yêu cầu các quyền sau:
- **Microphone**: Để nhận dạng giọng nói
- **Notification**: Để gửi nhắc nhở

### 3. Chạy ứng dụng
```bash
cd packages/notes_app
flutter run
```

## 🎨 Giao diện

### Màn hình chính
- **3 nút floating action**:
  - 🎤 Ghi âm (màu tím)
  - 💬 Chat AI (màu xanh)
  - ➕ Thêm ghi chú (màu xanh)

### Màn hình chi tiết ghi chú
- Hiển thị thông tin nhắc nhở (nếu có)
- Nút tóm tắt AI
- Giao diện đẹp với card layout

### Màn hình tạo/chỉnh sửa ghi chú
- Phần thiết lập nhắc nhở
- Chọn ngày và giờ
- Hiển thị thông tin nhắc nhở đã chọn

## 🔧 Xử lý sự cố

### Lỗi API Key
- Đảm bảo đã thiết lập `GEMINI_API_KEY`
- Kiểm tra API key có hợp lệ

### Lỗi microphone
- Cấp quyền microphone cho ứng dụng
- Kiểm tra microphone có hoạt động

### Lỗi thông báo
- Cấp quyền thông báo cho ứng dụng
- Kiểm tra cài đặt thông báo của thiết bị

## 📱 Hỗ trợ nền tảng

- ✅ Android
- ✅ iOS
- ✅ Web (một số tính năng có thể hạn chế)
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🚀 Tính năng nâng cao

### Tối ưu hóa
- Sử dụng Riverpod cho state management
- Dependency injection với GetIt
- Clean Architecture pattern
- Error handling toàn diện

### Bảo mật
- API key được quản lý an toàn
- Quyền truy cập được kiểm tra kỹ lưỡng
- Dữ liệu được mã hóa khi cần thiết

---

**Lưu ý**: Một số tính năng có thể cần kết nối internet để hoạt động tối ưu (AI chat, tóm tắt). Tính năng nhận dạng giọng nói hoạt động offline sau khi khởi tạo.
