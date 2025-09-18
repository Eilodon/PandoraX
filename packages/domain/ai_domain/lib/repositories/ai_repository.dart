import 'package:common_entities/common_entities.dart';
import '../entities/ai_request.dart';

/// Abstract repository for AI operations
///
/// This repository defines the contract for AI-related operations
/// following Clean Architecture principles.
abstract class AiRepository {
  /// Generate AI response from a request
  Future<AiResponse> generateResponse(AiRequest request);

  /// Generate text response from prompt
  Future<AiResponse> generateText(String prompt, {
    String? context,
    double? temperature,
    int? maxTokens,
  });

  /// Summarize text content
  Future<AiResponse> summarizeText(String text, {
    int? maxLength,
    String? style,
  });

  /// Generate chat response
  Future<AiResponse> chat(String message, {
    String? conversationId,
    List<ChatMessage>? history,
  });

  /// Generate suggestions based on context
  Future<List<String>> generateSuggestions(String context, {
    int? count,
    String? type,
  });

  /// Translate text to target language
  Future<AiResponse> translateText(String text, String targetLanguage, {
    String? sourceLanguage,
  });

  /// Generate code based on description
  Future<AiResponse> generateCode(String description, {
    String? language,
    String? framework,
  });

  /// Check if AI service is available
  Future<bool> isAvailable();

  /// Get AI service status
  Future<AiServiceStatus> getStatus();

  /// Initialize AI service
  Future<bool> initialize();

  /// Dispose AI service
  Future<void> dispose();
}

/// AI service status
enum AiServiceStatus {
  initializing,
  ready,
  busy,
  error,
  unavailable,
}
