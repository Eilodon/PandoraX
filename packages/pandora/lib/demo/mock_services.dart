
/// Mock AI Service
class MockAiService {
  static final MockAiService _instance = MockAiService._internal();
  factory MockAiService() => _instance;
  MockAiService._internal();

  Future<String> generateResponse(String prompt) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Mock AI response for: $prompt';
  }
}

/// Mock Speech Recognition Service
class MockSpeechRecognitionService {
  static final MockSpeechRecognitionService _instance = MockSpeechRecognitionService._internal();
  factory MockSpeechRecognitionService() => _instance;
  MockSpeechRecognitionService._internal();

  Future<String> recognizeSpeech() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'Mock speech recognition result';
  }
}

/// Mock Sync Service
class MockSyncService {
  static final MockSyncService _instance = MockSyncService._internal();
  factory MockSyncService() => _instance;
  MockSyncService._internal();

  Future<bool> syncData() async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}

/// Mock Notification Service
class MockNotificationService {
  static final MockNotificationService _instance = MockNotificationService._internal();
  factory MockNotificationService() => _instance;
  MockNotificationService._internal();

  Future<void> showNotification(String title, String body) async {
    // Mock notification
  }
}
