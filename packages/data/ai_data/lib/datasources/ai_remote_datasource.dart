import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:common_entities/common_entities.dart';
import 'package:ai_domain/ai_domain.dart';
import 'package:core_utils/core_utils.dart';

/// Remote data source for AI operations using Google Generative AI
class AiRemoteDataSource {
  late GenerativeModel _model;
  late GenerationConfig _generationConfig;
  late List<SafetySetting> _safetySettings;

  /// Initialize the AI model with configuration
  Future<void> initialize() async {
    try {
      final apiKey = Platform.environment['GEMINI_API_KEY'];
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('GEMINI_API_KEY not found in environment variables');
      }

      _model = GenerativeModel(
        model: 'gemini-pro',
        apiKey: apiKey,
        generationConfig: _generationConfig,
        safetySettings: _safetySettings,
      );

      AppLogger.info('AI Remote DataSource initialized successfully');
    } catch (e) {
      AppLogger.error('Failed to initialize AI Remote DataSource', e);
      rethrow;
    }
  }

  /// Generate text using AI
  Future<AIResponse> generateText(AiRequest request) async {
    try {
      AppLogger.info('Generating text for request: ${request.query}');
      
      final content = [Content.text(request.query)];
      final response = await _model.generateContent(content);
      
      final aiResponse = AIResponse(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        query: request.query,
        response: response.text ?? '',
        timestamp: DateTime.now(),
        confidence: 0.9, // High confidence for text generation
        metadata: {
          'model': 'gemini-pro',
          'request_type': request.type.toString(),
        },
      );

      AppLogger.success('Text generated successfully');
      return aiResponse;
    } catch (e) {
      AppLogger.error('Failed to generate text', e);
      rethrow;
    }
  }

  /// Summarize text using AI
  Future<AIResponse> summarizeText(AiRequest request) async {
    try {
      AppLogger.info('Summarizing text: ${request.query.substring(0, 50)}...');
      
      final prompt = 'Please summarize the following text in Vietnamese:\n\n${request.query}';
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      
      final aiResponse = AIResponse(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        query: request.query,
        response: response.text ?? '',
        timestamp: DateTime.now(),
        confidence: 0.85,
        metadata: {
          'model': 'gemini-pro',
          'request_type': 'summarize',
        },
      );

      AppLogger.success('Text summarized successfully');
      return aiResponse;
    } catch (e) {
      AppLogger.error('Failed to summarize text', e);
      rethrow;
    }
  }

  /// Chat with AI
  Future<AIResponse> chat(List<ChatMessage> messages) async {
    try {
      AppLogger.info('Starting chat with ${messages.length} messages');
      
      final content = messages.map((msg) => Content.text(msg.content)).toList();
      final response = await _model.generateContent(content);
      
      final aiResponse = AIResponse(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        query: messages.last.content,
        response: response.text ?? '',
        timestamp: DateTime.now(),
        confidence: 0.8,
        metadata: {
          'model': 'gemini-pro',
          'request_type': 'chat',
          'message_count': messages.length,
        },
      );

      AppLogger.success('Chat response generated successfully');
      return aiResponse;
    } catch (e) {
      AppLogger.error('Failed to generate chat response', e);
      rethrow;
    }
  }

  /// Check AI service status
  Future<AiServiceStatus> checkServiceStatus() async {
    try {
      // Test with a simple request
      final testRequest = AiRequest(
        query: 'Hello',
        type: AiRequestType.text,
        context: 'test',
        attachments: [],
      );
      
      await generateText(testRequest);
      return AiServiceStatus.available;
    } catch (e) {
      AppLogger.error('AI service is not available', e);
      return AiServiceStatus.unavailable;
    }
  }

  /// Get supported AI request types
  Map<AiRequestType, AiResponseType> getSupportedTypes() {
    return {
      AiRequestType.text: AiResponseType.text,
      AiRequestType.summarize: AiResponseType.text,
      AiRequestType.chat: AiResponseType.text,
      AiRequestType.translate: AiResponseType.text,
      AiRequestType.analyze: AiResponseType.text,
      AiRequestType.generate: AiResponseType.text,
      AiRequestType.rewrite: AiResponseType.text,
      AiRequestType.explain: AiResponseType.text,
      AiRequestType.answer: AiResponseType.text,
      AiRequestType.help: AiResponseType.text,
    };
  }

  /// Convert chat messages to content format
  List<Content> _convertMessagesToContent(List<ChatMessage> messages) {
    return messages.map((message) {
      if (message.type == ChatMessageType.user) {
        return Content.text(message.content);
      } else {
        return Content.text('Assistant: ${message.content}');
      }
    }).toList();
  }

  /// Generate content with style
  Future<AIResponse> generateContentWithStyle(
    String prompt, 
    SummarizationStyle style,
    Map<String, dynamic>? customParameters,
  ) async {
    try {
      AppLogger.info('Generating content with style: ${style.displayName}');
      
      final stylePrompt = style.prompt + '\n\n' + prompt;
      
      final content = [Content.text(stylePrompt)];
      final response = await _model.generateContent(content);
      
      final aiResponse = AIResponse(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        query: prompt,
        response: response.text ?? '',
        timestamp: DateTime.now(),
        confidence: 0.9,
        metadata: {
          'model': 'gemini-pro',
          'style': style.displayName,
          'custom_parameters': customParameters,
        },
      );

      AppLogger.success('Content generated with style successfully');
      return aiResponse;
    } catch (e) {
      AppLogger.error('Failed to generate content with style', e);
      rethrow;
    }
  }

  /// Generate context-aware content
  Future<AIResponse> generateContextAwareContent(
    String prompt,
    String? context,
    Map<String, dynamic>? parameters,
  ) async {
    try {
      AppLogger.info('Generating context-aware content');
      
      String fullPrompt = prompt;
      if (context != null && context.isNotEmpty) {
        fullPrompt = 'Context: $context\n\nRequest: $prompt';
      }
      
      final content = [Content.text(fullPrompt)];
      final response = await _model.generateContent(content);
      
      final aiResponse = AIResponse(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        query: prompt,
        response: response.text ?? '',
        timestamp: DateTime.now(),
        confidence: 0.9,
        metadata: {
          'model': 'gemini-pro',
          'context_aware': true,
          'parameters': parameters,
        },
      );

      AppLogger.success('Context-aware content generated successfully');
      return aiResponse;
    } catch (e) {
      AppLogger.error('Failed to generate context-aware content', e);
      rethrow;
    }
  }

  /// Generate content from template
  Future<AIResponse> generateFromTemplate(
    ContentTemplate template,
    Map<String, dynamic>? parameters,
    String? context,
  ) async {
    try {
      AppLogger.info('Generating content from template: ${template.name}');
      
      final formattedPrompt = template.getFormattedPrompt(parameters);
      String fullPrompt = formattedPrompt;
      
      if (context != null && context.isNotEmpty) {
        fullPrompt = 'Context: $context\n\n$formattedPrompt';
      }
      
      final content = [Content.text(fullPrompt)];
      final response = await _model.generateContent(content);
      
      final aiResponse = AIResponse(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        query: formattedPrompt,
        response: response.text ?? '',
        timestamp: DateTime.now(),
        confidence: 0.9,
        metadata: {
          'model': 'gemini-pro',
          'template_id': template.id,
          'template_name': template.name,
          'parameters': parameters,
        },
      );

      AppLogger.success('Content generated from template successfully');
      return aiResponse;
    } catch (e) {
      AppLogger.error('Failed to generate content from template', e);
      rethrow;
    }
  }

  /// Translate text with advanced options
  Future<AIResponse> translateTextAdvanced(
    String text,
    SupportedLanguage targetLanguage, {
    SupportedLanguage? sourceLanguage,
    bool preserveFormatting = true,
    Map<String, dynamic>? culturalContext,
    String? domain,
  }) async {
    try {
      AppLogger.info('Translating text to ${targetLanguage.displayName}');
      
      String prompt = 'Translate the following text to ${targetLanguage.nativeName}';
      if (sourceLanguage != null) {
        prompt += ' from ${sourceLanguage.nativeName}';
      }
      if (preserveFormatting) {
        prompt += '. Please preserve the original formatting and structure.';
      }
      if (culturalContext != null) {
        prompt += ' Consider the cultural context: ${culturalContext.toString()}';
      }
      if (domain != null) {
        prompt += ' This is ${domain} content.';
      }
      prompt += '\n\nText: $text';
      
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      
      final aiResponse = AIResponse(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        query: text,
        response: response.text ?? '',
        timestamp: DateTime.now(),
        confidence: 0.9,
        metadata: {
          'model': 'gemini-pro',
          'translation': true,
          'target_language': targetLanguage.code,
          'source_language': sourceLanguage?.code,
          'preserve_formatting': preserveFormatting,
          'cultural_context': culturalContext,
          'domain': domain,
        },
      );

      AppLogger.success('Text translated successfully');
      return aiResponse;
    } catch (e) {
      AppLogger.error('Failed to translate text', e);
      rethrow;
    }
  }

  /// Get supported languages
  Future<List<SupportedLanguage>> getSupportedLanguages() async {
    try {
      AppLogger.info('Getting supported languages');
      return SupportedLanguages.all;
    } catch (e) {
      AppLogger.error('Failed to get supported languages', e);
      return [];
    }
  }

  /// Detect language of text
  Future<SupportedLanguage?> detectLanguage(String text) async {
    try {
      AppLogger.info('Detecting language of text');
      
      final prompt = 'Detect the language of the following text and return only the language code (e.g., en, vi, es, fr, de, ja, ko, zh, ar, hi):\n\n$text';
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      
      final detectedCode = response.text?.trim().toLowerCase();
      if (detectedCode != null) {
        return SupportedLanguages.getByCode(detectedCode);
      }
      
      return null;
    } catch (e) {
      AppLogger.error('Failed to detect language', e);
      return null;
    }
  }
}

/// AI Service Status enum
enum AiServiceStatus {
  available,
  unavailable,
  loading,
  error,
}