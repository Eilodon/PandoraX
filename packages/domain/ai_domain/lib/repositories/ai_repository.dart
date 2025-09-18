import 'package:common_entities/common_entities.dart';
import '../entities/ai_request.dart';
import '../entities/summarization_style.dart';
import '../entities/content_template.dart';
import '../entities/supported_language.dart';

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
    SummarizationStyle? summarizationStyle,
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
    bool preserveFormatting = true,
    Map<String, dynamic>? culturalContext,
  });

  /// Get all supported languages for translation
  Future<List<SupportedLanguage>> getSupportedLanguages();

  /// Detect language of text
  Future<SupportedLanguage?> detectLanguage(String text);

  /// Translate text with advanced options
  Future<AiResponse> translateTextAdvanced(
    String text,
    SupportedLanguage targetLanguage, {
    SupportedLanguage? sourceLanguage,
    bool preserveFormatting = true,
    Map<String, dynamic>? culturalContext,
    String? domain,
  });

  /// Generate code based on description
  Future<AiResponse> generateCode(String description, {
    String? language,
    String? framework,
  });

  /// Generate content using template
  Future<AiResponse> generateFromTemplate(
    ContentTemplate template, {
    Map<String, dynamic>? parameters,
    String? context,
  });

  /// Get all available content templates
  Future<List<ContentTemplate>> getContentTemplates();

  /// Get content templates by category
  Future<List<ContentTemplate>> getContentTemplatesByCategory(String category);

  /// Create custom content template
  Future<ContentTemplate> createContentTemplate(ContentTemplate template);

  /// Update content template
  Future<ContentTemplate> updateContentTemplate(ContentTemplate template);

  /// Delete content template
  Future<void> deleteContentTemplate(String templateId);

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
