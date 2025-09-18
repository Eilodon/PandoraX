import '../entities/ai_response.dart';
import '../entities/chat_message.dart';

/// Abstract interface for AI services
abstract class AIRepository {
  /// Generate AI response for a given prompt
  Future<AIResponse> generateResponse(String prompt);

  /// Generate chat response with conversation context
  Future<AIResponse> generateChatResponse(String prompt, List<ChatMessage> conversationHistory);

  /// Summarize note content
  Future<AIResponse> summarizeNote(String content);

  /// Generate note title suggestions
  Future<List<String>> generateTitleSuggestions(String content);

  /// Enhance note content with AI suggestions
  Future<AIResponse> enhanceContent(String content);

  /// Generate tags for note content
  Future<List<String>> generateTags(String content);

  /// Check if AI service is available
  bool get isAvailable;

  /// Get AI service status
  String get status;

  /// Get current model being used
  String get currentModel;

  /// Check if using on-device model
  bool get isOnDevice;

  /// Dispose resources
  void dispose();
}
