/// Voice Interaction Configuration
/// Centralized configuration for TTS and STT services
class VoiceConfig {
  // FPT.AI Configuration
  static const String fptApiKey = 'YOUR_FPT_API_KEY';
  static const String fptTtsUrl = 'https://api.fpt.ai/hmi/tts/v5';
  static const String fptSttUrl = 'https://api.fpt.ai/hmi/asr/v1';
  
  // Google AI Configuration
  static const String googleAiApiKey = 'YOUR_GOOGLE_AI_API_KEY';
  
  // Voice Settings
  static const String defaultVoice = 'banmai'; // Vietnamese female voice
  static const double defaultSpeed = 0.8;
  static const double defaultVolume = 1.0;
  
  // Supported Vietnamese voices from FPT.AI
  static const Map<String, String> vietnameseVoices = {
    'banmai': 'Bạn Mai - Giọng nữ miền Bắc',
    'linhsan': 'Linh San - Giọng nữ miền Nam',
    'minhquan': 'Minh Quân - Giọng nam miền Bắc',
    'thuminh': 'Thu Minh - Giọng nữ miền Trung',
    'lannhi': 'Lan Nhi - Giọng nữ miền Nam',
  };
  
  // Voice command patterns
  static const List<String> createNotePatterns = [
    'tạo ghi chú',
    'viết ghi chú',
    'ghi lại',
    'note lại',
    'tạo note',
  ];
  
  static const List<String> searchNotePatterns = [
    'tìm ghi chú',
    'tìm kiếm',
    'search',
    'tìm note',
    'kiếm ghi chú',
  ];
  
  static const List<String> reminderPatterns = [
    'đặt nhắc nhở',
    'nhắc nhở',
    'reminder',
    'nhắc tôi',
    'đặt alarm',
  ];
  
  static const List<String> aiChatPatterns = [
    'trò chuyện',
    'chat',
    'hỏi ai',
    'tư vấn',
    'giúp tôi',
  ];
  
  // Time expressions for Vietnamese
  static const Map<String, String> timeExpressions = {
    'hôm nay': 'today',
    'ngày mai': 'tomorrow',
    'tuần sau': 'next week',
    'tháng sau': 'next month',
    'năm sau': 'next year',
    'giờ sau': 'in 1 hour',
    'ngày sau': 'in 1 day',
  };
  
  // Audio settings
  static const int maxRecordingDuration = 30; // seconds
  static const int pauseForDuration = 3; // seconds
  static const String audioFormat = 'mp3';
  static const int audioQuality = 320; // kbps
  
  // Offline fallback settings
  static const bool enableOfflineMode = true;
  static const bool enableSystemTts = true;
  static const bool enablePhoWhisper = false; // Requires model download
  
  // Performance settings
  static const int maxConcurrentRequests = 3;
  static const Duration requestTimeout = Duration(seconds: 10);
  static const Duration cacheTimeout = Duration(hours: 1);
  
  // Error handling
  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 2);
  
  // Privacy settings
  static const bool enableAudioLogging = false;
  static const bool enableCommandLogging = true;
  static const Duration audioFileRetention = Duration(days: 7);
  
  /// Get voice configuration for specific user preference
  static Map<String, dynamic> getUserVoiceConfig({
    String? preferredVoice,
    double? speed,
    double? volume,
    String? region,
  }) {
    return {
      'voice': preferredVoice ?? defaultVoice,
      'speed': speed ?? defaultSpeed,
      'volume': volume ?? defaultVolume,
      'region': region ?? 'north', // north, central, south
      'language': 'vi-VN',
    };
  }
  
  /// Check if command matches any pattern
  static bool matchesPattern(String command, List<String> patterns) {
    final lowerCommand = command.toLowerCase();
    return patterns.any((pattern) => lowerCommand.contains(pattern));
  }
  
  /// Extract time from Vietnamese expression
  static String? extractTimeFromVietnamese(String expression) {
    final lowerExpr = expression.toLowerCase();
    return timeExpressions[lowerExpr];
  }
  
  /// Validate voice configuration
  static bool isValidConfig() {
    return fptApiKey.isNotEmpty && 
           fptApiKey != 'YOUR_FPT_API_KEY' &&
           googleAiApiKey.isNotEmpty &&
           googleAiApiKey != 'YOUR_GOOGLE_AI_API_KEY';
  }
  
  /// Get API usage limits
  static Map<String, int> getApiLimits() {
    return {
      'fpt_tts_daily': 1000, // requests per day
      'fpt_stt_daily': 1000, // requests per day
      'google_ai_daily': 100, // requests per day
      'max_file_size': 10 * 1024 * 1024, // 10MB
    };
  }
}
