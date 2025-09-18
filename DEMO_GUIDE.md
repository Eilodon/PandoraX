# 🎭 Hướng dẫn Demo & Testing cho Notes App

## 📋 Tổng quan

Hệ thống giả lập (Demo & Testing) cho phép bạn kiểm thử đầy đủ các tính năng của ứng dụng Notes mà không cần:
- API keys (Gemini AI, Firebase)
- Kết nối internet
- Quyền microphone
- Database setup thật
- Notification permissions

## 🚀 Cách sử dụng nhanh

### 1. Chạy Demo Mode bằng script
```bash
cd packages/pandora
./run_demo.sh web          # Chạy trên web browser
./run_demo.sh android      # Chạy trên Android
./run_demo.sh ios          # Chạy trên iOS
```

### 2. Chạy test scenarios
```bash
cd packages/pandora
dart test_runner.dart                    # Chạy tất cả scenarios
dart test_runner.dart -s "AI Chat"       # Chạy scenario cụ thể
dart test_runner.dart -v -r              # Verbose + HTML report
```

### 3. Trong ứng dụng
1. Mở ứng dụng Notes
2. Vào Settings hoặc tìm màn hình Demo
3. Bật "Demo Mode"
4. Chạy "Test Scenarios" để kiểm thử tự động

## 🛠️ Các thành phần chính

### 1. Mock Services (`lib/demo/mock_services.dart`)
- **MockAiService**: Giả lập Gemini AI với responses đa dạng
- **MockSpeechRecognitionService**: Giả lập speech-to-text
- **MockSyncService**: Giả lập cloud sync với Firestore
- **MockNotificationService**: Giả lập notifications

### 2. Demo Data (`lib/demo/demo_data.dart`)
- 7 demo notes với nội dung phong phú
- Demo conversations với AI
- Demo voice recordings
- Demo analytics data

### 3. Test Scenarios (`lib/demo/test_scenarios.dart`)
- **Note Management**: Test CRUD operations
- **AI Chat**: Test AI interactions
- **Speech Recognition**: Test voice features
- **Cloud Sync**: Test synchronization
- **Notifications**: Test reminder system
- **Error Handling**: Test error scenarios
- **Performance**: Test app performance

### 4. Demo Mode Manager (`lib/demo/demo_mode.dart`)
- Quản lý bật/tắt demo mode
- Provider cho state management
- UI components cho demo controls

### 5. Demo Screen (`lib/features/demo/demo_screen.dart`)
- UI để quản lý demo mode
- Chạy test scenarios
- Xem demo data và analytics

## 📊 Test Scenarios chi tiết

### 1. Note Management
```
✅ Tạo demo notes
✅ Test search functionality
✅ Test note editing operations
✅ Validate note properties
```

### 2. AI Chat
```
✅ Multiple AI interactions
✅ Text summarization
✅ Error handling (network issues)
✅ Response time validation
```

### 3. Speech Recognition
```
✅ Initialize speech service
✅ Start/stop listening cycle
✅ Real-time transcription
✅ Permission handling
```

### 4. Cloud Sync
```
✅ Connectivity testing
✅ Note upload simulation
✅ Full sync operations
✅ Offline/online states
```

### 5. Notifications
```
✅ Immediate notifications
✅ Scheduled notifications
✅ Notification cancellation
✅ Permission validation
```

### 6. Error Handling
```
✅ AI service errors
✅ Network failures
✅ Permission denials
✅ Sync failures
```

### 7. Performance
```
✅ Data generation speed
✅ Concurrent operations
✅ Search performance
✅ Memory usage
```

## 🎯 Các tính năng Demo Mode

### Trong ứng dụng
- 🎭 Banner "Demo Mode" hiển thị ở góc màn hình
- 📝 Pre-loaded với 7 demo notes đa dạng
- 🤖 AI Chat hoạt động với mock responses
- 🎤 Speech Recognition giả lập real-time transcription
- ☁️ Cloud Sync simulation với trạng thái online/offline
- 🔔 Mock notifications không cần permissions
- 📊 Demo analytics data

### Test Controls
- ▶️ Run All Test Scenarios button
- 🔍 View detailed test results
- 📈 Real-time progress tracking
- 📊 Success/failure statistics
- 📝 Detailed error reporting

## 📁 Cấu trúc files

```
packages/pandora/
├── lib/demo/
│   ├── mock_services.dart      # Mock implementations
│   ├── demo_data.dart          # Sample data generation
│   ├── test_scenarios.dart     # Automated test scenarios
│   └── demo_mode.dart          # Demo mode management
├── lib/features/demo/
│   └── demo_screen.dart        # Demo UI screen
├── test_runner.dart            # Command-line test runner
├── run_demo.sh                 # Demo startup script
└── .env.demo                   # Demo environment config
```

## 🔧 Cấu hình Demo

### Environment Variables
```bash
DEMO_MODE=true
USE_MOCK_SERVICES=true
LOAD_DEMO_NOTES=true
SHOW_DEMO_BANNER=true
MOCK_AI_RESPONSE_DELAY=1000
MOCK_SPEECH_ENABLED=true
```

### Dart Defines
```bash
flutter run --dart-define=DEMO_MODE=true
```

## 📝 Scenarios mẫu

### AI Chat Demo
```
User: "Chào AI, bạn có khỏe không?"
AI: "Chào bạn! Tôi rất vui được giúp bạn tạo và quản lý ghi chú..."

User: "Tóm tắt cho tôi về Flutter"
AI: "Tóm tắt AI: Flutter là framework UI của Google..."
```

### Speech Recognition Demo
```
🎤 "Họp team lúc 2 giờ chiều thứ Ba..."
📝 Real-time transcription: "Họp team lúc 2 giờ..."
✅ Final: "Họp team lúc 2 giờ chiều thứ Ba tại phòng họp tầng 3"
```

### Sync Demo
```
☁️ Online: Syncing notes to cloud...
📡 Offline: Working offline, will sync when online
🔄 Auto-sync: Every 10 minutes
```

## 🚨 Troubleshooting

### Demo Mode không hoạt động
1. Kiểm tra `DEMO_MODE=true` trong environment
2. Verify mock services đã được registered
3. Check console logs for errors

### Test Scenarios thất bại
1. Chạy `dart test_runner.dart -v` để xem chi tiết
2. Kiểm tra mock services initialization
3. Verify demo data generation

### Performance chậm
1. Giảm `MOCK_AI_RESPONSE_DELAY`
2. Disable verbose logging
3. Run on release mode: `flutter run --release`

## 📈 Metrics & Reporting

### Test Results
- Success rate percentage
- Individual scenario timings
- Error details và stack traces
- Performance metrics

### HTML Reports
```bash
dart test_runner.dart --report
# Generates: test_report.html
```

### Analytics Demo
- User activity patterns
- Feature usage statistics
- Performance monitoring
- Error tracking

## 🎉 Demo Scenarios examples

### Complete User Journey
1. 🎭 Bật Demo Mode
2. 📝 Xem pre-loaded notes
3. 🤖 Chat với AI về note ideas
4. 🎤 Tạo note bằng voice
5. ☁️ Sync notes to cloud
6. 🔔 Set reminders
7. 📊 View analytics

### Developer Testing
1. ▶️ Run all test scenarios
2. 📊 Check success rates
3. 🔍 Review detailed results
4. 🐛 Debug any failures
5. 📝 Generate reports

## 💡 Tips & Best Practices

### Cho Users
- Luôn bật Demo Mode khi testing mà không có API keys
- Sử dụng Test Scenarios để verify tất cả features
- Check HTML reports để hiểu performance

### Cho Developers
- Extend mock services cho features mới
- Add thêm test scenarios khi cần
- Update demo data để reflect app state
- Monitor test stability qua multiple runs

## 🔮 Tương lai

### Planned Features
- [ ] Visual test reports với screenshots
- [ ] Load testing scenarios
- [ ] User journey recordings
- [ ] Performance benchmarking
- [ ] A/B testing simulation
- [ ] Accessibility testing
- [ ] Cross-platform validation

### Possible Extensions
- Integration với CI/CD pipelines
- Automated regression testing
- User behavior simulation
- Real-time monitoring dashboard
- Performance profiling tools

---

## 📞 Hỗ trợ

Nếu gặp vấn đề với Demo Mode:
1. Check logs trong console
2. Run test scenarios để identify issues
3. Review mock service configurations
4. Tham khảo troubleshooting guide

**Happy Testing! 🎭✨**
