# 🎤 Voice Features Guide - PandoraX

## 📋 Overview

PandoraX features a comprehensive voice interaction system that allows users to interact with the app using natural Vietnamese speech. The system combines offline Speech-to-Text (STT) with high-quality Text-to-Speech (TTS) for a seamless voice experience.

## 🏗️ Architecture

### Core Components

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Voice Input   │───▶│   STT Service   │───▶│   AI Processor  │
│   (Microphone)  │    │   (Hybrid)      │    │   (Gemini AI)   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                │                       │
┌─────────────────┐    ┌─────────────────┐              │
│   Voice Output  │◀───│   TTS Service   │◀─────────────┘
│   (Speaker)     │    │   (FPT.AI API)  │
└─────────────────┘    └─────────────────┘
```

### Services

1. **VoiceInteractionService** - Main voice interaction coordinator
2. **VoiceCommandsService** - Intelligent voice command processing
3. **FptTtsService** - High-quality Vietnamese TTS
4. **PhoWhisperService** - Offline Vietnamese STT
5. **VoiceConfig** - Centralized configuration

## 🎯 Features

### ✅ Implemented Features

- **Speech Recognition**: Real-time voice input with Vietnamese support
- **Text-to-Speech**: Natural Vietnamese voice output with multiple voices
- **Voice Commands**: Intelligent command processing with AI
- **Offline Support**: PhoWhisper offline STT capability
- **Voice Settings**: Configurable voice preferences
- **Error Handling**: Comprehensive error management
- **Demo Interface**: Interactive demo screen for testing

### 🔄 Planned Features

- **Voice Training**: Personalized voice recognition
- **Advanced Commands**: Complex multi-step voice commands
- **Voice Profiles**: User-specific voice preferences
- **Offline TTS**: Local TTS fallback
- **Voice Analytics**: Usage tracking and optimization

## 🚀 Getting Started

### 1. Basic Voice Interaction

```dart
// Get voice interaction provider
final voiceNotifier = ref.read(voiceInteractionStateProvider.notifier);

// Start listening
await voiceNotifier.startListening();

// Stop listening
await voiceNotifier.stopListening();

// Speak response
await voiceNotifier.speakResponse("Xin chào! Tôi là AI assistant của PandoraX.");
```

### 2. Voice Commands

```dart
// Process voice command
final commandResult = await voiceNotifier.processCommand("Tạo ghi chú mới");

// Check result
if (commandResult.action == VoiceCommandAction.CREATE_NOTE) {
  // Handle note creation
  print("Creating note: ${commandResult.parameters?['content']}");
}
```

### 3. TTS Configuration

```dart
// Get TTS service
final ttsNotifier = ref.read(ttsStateProvider.notifier);

// Speak with specific voice
await ttsNotifier.speakText(
  "Hello world",
  voice: "linhsan", // Southern Vietnamese female voice
);
```

## 📱 Voice Commands

### Supported Commands

| Command Type | Example | Action |
|-------------|---------|--------|
| **CREATE_NOTE** | "Tạo ghi chú về cuộc họp" | Creates new note |
| **SEARCH_NOTES** | "Tìm ghi chú về dự án ABC" | Searches notes |
| **SET_REMINDER** | "Đặt nhắc nhở lúc 3 giờ chiều" | Sets reminder |
| **AI_CHAT** | "Trò chuyện với AI" | Starts AI conversation |
| **APP_CONTROL** | "Mở màn hình chính" | Controls app navigation |

### Command Patterns

```dart
// Create note patterns
"tạo ghi chú", "viết ghi chú", "ghi lại", "note lại", "tạo note"

// Search patterns
"tìm ghi chú", "tìm kiếm", "search", "tìm note", "kiếm ghi chú"

// Reminder patterns
"đặt nhắc nhở", "nhắc nhở", "reminder", "nhắc tôi", "đặt alarm"

// AI chat patterns
"trò chuyện", "chat", "hỏi ai", "tư vấn", "giúp tôi"
```

## 🔊 Voice Options

### Vietnamese Voices (FPT.AI)

| Voice ID | Name | Gender | Region | Description |
|----------|------|--------|--------|-------------|
| `banmai` | Bạn Mai | Female | North | Northern Vietnamese female |
| `linhsan` | Linh San | Female | South | Southern Vietnamese female |
| `minhquan` | Minh Quân | Male | North | Northern Vietnamese male |
| `thuminh` | Thu Minh | Female | Central | Central Vietnamese female |
| `lannhi` | Lan Nhi | Female | South | Southern Vietnamese female |

### Usage Example

```dart
// Configure voice preferences
final voiceConfig = VoiceConfig.getUserVoiceConfig(
  preferredVoice: 'linhsan',
  speed: 0.8,
  volume: 1.0,
  region: 'south',
);
```

## ⚙️ Configuration

### Voice Settings

```dart
class VoiceConfig {
  // API Configuration
  static const String fptApiKey = 'YOUR_FPT_API_KEY';
  static const String fptTtsUrl = 'https://api.fpt.ai/hmi/tts/v5';
  
  // Voice Settings
  static const String defaultVoice = 'banmai';
  static const double defaultSpeed = 0.8;
  static const double defaultVolume = 1.0;
  
  // Performance Settings
  static const int maxRecordingDuration = 30; // seconds
  static const int pauseForDuration = 3; // seconds
  static const Duration requestTimeout = Duration(seconds: 10);
}
```

### Environment Setup

1. **FPT.AI API Key**: Get from [FPT.AI Console](https://console.fpt.ai)
2. **Google AI API Key**: Get from [Google AI Studio](https://makersuite.google.com)
3. **Permissions**: Microphone access required

## 🧪 Testing

### Demo Screen

Access the voice demo screen to test all voice features:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const VoiceDemoScreen(),
  ),
);
```

### Unit Tests

```bash
# Run voice service tests
flutter test test/services/voice_interaction_service_test.dart
flutter test test/services/fpt_tts_service_test.dart

# Run all voice tests
flutter test test/services/ --reporter=expanded
```

### Integration Tests

```bash
# Run voice integration tests
flutter test integration_test/voice_integration_test.dart
```

## 📊 Performance

### Response Times

| Operation | Target | Typical |
|-----------|--------|---------|
| STT Processing | < 2s | 1.5s |
| AI Processing | < 3s | 2.5s |
| TTS Generation | < 1s | 0.8s |
| Total Interaction | < 6s | 5s |

### Resource Usage

| Resource | Usage |
|----------|-------|
| Memory | < 200MB |
| Storage | ~1.5GB (PhoWhisper) |
| Network | Minimal (TTS only) |
| Battery | Optimized |

## 🔒 Security & Privacy

### Privacy Protection

- **Offline STT**: Voice data stays on device
- **Encrypted Storage**: Audio files encrypted
- **No Voice Logging**: No persistent voice storage
- **Local Processing**: AI commands processed locally when possible

### Security Features

- **API Key Protection**: Secure storage
- **Request Validation**: All commands validated
- **Rate Limiting**: Request limits enforced
- **Error Handling**: Comprehensive error management

## 🐛 Troubleshooting

### Common Issues

#### 1. Microphone Permission Denied

```dart
// Check permission status
final status = await Permission.microphone.status;
if (status != PermissionStatus.granted) {
  await Permission.microphone.request();
}
```

#### 2. STT Not Working

```dart
// Check initialization
final voiceService = ref.read(voiceInteractionServiceProvider);
if (!voiceService.isInitialized) {
  await voiceService.initialize();
}
```

#### 3. TTS API Errors

```dart
// Check API configuration
if (!VoiceConfig.isValidConfig()) {
  // Update API keys
  print('Invalid API configuration');
}
```

#### 4. PhoWhisper Model Issues

```dart
// Check model status
final phoWhisperState = ref.read(phoWhisperStateProvider);
if (!phoWhisperState.isModelAvailable) {
  // Download model
  await ref.read(phoWhisperStateProvider.notifier).downloadModel();
}
```

### Debug Mode

Enable debug logging:

```dart
// Enable voice debug mode
VoiceConfig.enableAudioLogging = true;
VoiceConfig.enableCommandLogging = true;
```

## 📈 Analytics

### Voice Usage Tracking

```dart
// Track voice interactions
final analytics = FirebaseAnalytics.instance;
await analytics.logEvent(
  name: 'voice_command_processed',
  parameters: {
    'command_type': commandResult.action.name,
    'confidence': commandResult.confidence,
    'response_time': responseTime,
  },
);
```

### Performance Monitoring

```dart
// Monitor voice performance
final performance = FirebasePerformance.instance;
final trace = performance.newTrace('voice_interaction');
await trace.start();

// ... voice processing ...

await trace.stop();
```

## 🚀 Deployment

### Production Checklist

- [ ] API keys configured
- [ ] Permissions granted
- [ ] PhoWhisper model downloaded
- [ ] Voice settings optimized
- [ ] Error handling tested
- [ ] Performance validated
- [ ] Analytics configured

### Environment Variables

```bash
# .env file
FPT_AI_API_KEY=your_fpt_api_key
GOOGLE_AI_API_KEY=your_google_ai_key
VOICE_DEBUG_MODE=false
ENABLE_OFFLINE_STT=true
```

## 📚 API Reference

### VoiceInteractionService

```dart
class VoiceInteractionService {
  Future<bool> initialize();
  Future<void> startListening();
  Future<void> stopListening();
  Future<void> speakText(String text);
  Future<void> processVoiceCommand(String command);
  void dispose();
}
```

### VoiceCommandsService

```dart
class VoiceCommandsService {
  Future<VoiceCommandResult> processCommand(String command);
}
```

### FptTtsService

```dart
class FptTtsService {
  Future<Uint8List?> textToSpeech(String text, {String? voice});
  Future<String?> textToSpeechFile(String text, {String? fileName});
  Future<void> speakText(String text, {String? voice});
  List<Map<String, String>> getAvailableVoices();
  bool isValidVoice(String voiceId);
}
```

### PhoWhisperService

```dart
class PhoWhisperService {
  Future<bool> isModelAvailable();
  Future<bool> downloadModel();
  Future<bool> loadModel();
  Future<String> transcribeAudio(String audioFilePath);
  Map<String, dynamic> getModelInfo();
}
```

## 🤝 Contributing

### Development Setup

1. Clone repository
2. Install dependencies: `flutter pub get`
3. Configure API keys
4. Run tests: `flutter test`
5. Start development server: `flutter run`

### Code Style

- Follow Flutter/Dart conventions
- Use meaningful variable names
- Add comprehensive documentation
- Write unit tests for new features
- Update this guide for new features

## 📞 Support

For issues and questions:

1. Check troubleshooting section
2. Review API documentation
3. Test with demo screen
4. Check GitHub issues
5. Contact development team

---

**PandoraX Voice Features - Empowering Vietnamese voice interaction! 🎤✨**
