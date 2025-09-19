/// Unified AI Service Interface
/// 
/// Consolidates all AI functionality into a single, comprehensive interface
/// Combines note management, chat, and general AI capabilities
abstract class AIService {
  /// Initialize the AI service
  Future<bool> initialize();

  /// Generate AI response for a given prompt
  Future<String> generateResponse(String prompt);

  /// Generate chat response with conversation context
  Future<String> generateChatResponse(String prompt, List<Map<String, String>> conversationHistory);

  /// Chat with AI (legacy method for backward compatibility)
  Future<String> chatWithAI(String message) => generateResponse(message);

  /// Summarize note content
  Future<String> summarizeNote(String content);

  /// Summarize text (legacy method for backward compatibility) 
  Future<String> summarizeText(String text) => summarizeNote(text);

  /// Generate note title suggestions
  Future<List<String>> generateTitleSuggestions(String content);

  /// Enhance note content with AI suggestions
  Future<String> enhanceContent(String content);

  /// Generate tags for note content
  Future<List<String>> generateTags(String content);

  /// Get suggestions based on input
  Future<List<String>> getSuggestions(String input);

  /// Create embedding for text content
  Future<List<double>> createEmbedding(String content);

  /// Check if AI service is available
  bool get isAvailable;

  /// Check if AI service is available (async version)
  Future<bool> isAvailableAsync();

  /// Get AI service status
  String get status;

  /// Get AI model information
  Future<Map<String, dynamic>> getModelInfo();

  /// Dispose resources
  void dispose();
}
