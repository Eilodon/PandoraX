class AppConfig {
  // Set your Gemini API key here or use environment variable
  // For development, you can set it directly:
  // static const String geminiApiKey = 'your-api-key-here';
  
  // For production, use environment variable:
  static const String geminiApiKey = String.fromEnvironment('GEMINI_API_KEY');
  
  // Fallback for development if environment variable is not set
  static String get apiKey {
    if (geminiApiKey.isNotEmpty) {
      return geminiApiKey;
    }
    // TODO: Replace with your actual API key for development
    throw Exception('GEMINI_API_KEY environment variable is required. Please set it in your IDE or run with: flutter run --dart-define=GEMINI_API_KEY=your-key-here');
  }
}
