/// API configuration for external services
class ApiConfig {
  // Gemini AI API Key
  // To get your free API key:
  // 1. Go to https://makersuite.google.com/app/apikey
  // 2. Create a new API key
  // 3. Replace the value below with your actual API key
  // 4. For production, use environment variables or secure storage
  static const String geminiApiKey = 'YOUR_GEMINI_API_KEY_HERE';
  
  // OpenAI API Key (if needed in the future)
  static const String openAiApiKey = 'YOUR_OPENAI_API_KEY_HERE';
  
  // Other API configurations
  static const String firebaseProjectId = 'pandora-rebuilt';
  static const String firebaseAppId = '1:123456789:android:abcdef123456';
  
  /// Check if API keys are configured
  static bool get isGeminiConfigured => geminiApiKey != 'YOUR_GEMINI_API_KEY_HERE';
  static bool get isOpenAiConfigured => openAiApiKey != 'YOUR_OPENAI_API_KEY_HERE';
  
  /// Get API key with fallback
  static String getGeminiApiKey() {
    if (isGeminiConfigured) {
      return geminiApiKey;
    }
    
    // Try to get from environment variable
    const envKey = String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');
    if (envKey.isNotEmpty) {
      return envKey;
    }
    
    // Return empty string if not configured
    return '';
  }
}
