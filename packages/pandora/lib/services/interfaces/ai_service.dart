/// Abstract interface for AI services
abstract class AIService {
  /// Initialize the AI service
  Future<bool> initialize();

  /// Generate AI response for a given prompt
  Future<String> generateResponse(String prompt);

  /// Generate chat response with conversation context
  Future<String> generateChatResponse(String prompt, List<Map<String, String>> conversationHistory);

  /// Summarize note content
  Future<String> summarizeNote(String content);

  /// Generate note title suggestions
  Future<List<String>> generateTitleSuggestions(String content);

  /// Enhance note content with AI suggestions
  Future<String> enhanceContent(String content);

  /// Generate tags for note content
  Future<List<String>> generateTags(String content);

  /// Check if AI service is available
  bool get isAvailable;

  /// Get AI service status
  String get status;

  /// Dispose resources
  void dispose();
}
