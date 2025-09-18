import 'package:common_entities/common_entities.dart';
import 'package:ai_domain/ai_domain.dart';
import 'package:core_utils/core_utils.dart';
import '../datasources/ai_remote_datasource.dart';
import '../datasources/ai_local_datasource.dart';

/// Implementation of AI repository
class AiRepositoryImpl implements AiRepository {
  final AiRemoteDataSource _remoteDataSource;
  final AiLocalDataSource _localDataSource;

  const AiRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<AiResponse> generateResponse(AiRequest request) async {
    try {
      AppLogger.info('🤖 Generating AI response for request: ${request.id}');

      // Try remote first
      try {
        final response = await _remoteDataSource.generateResponse(request);

        // Save to local storage
        await _localDataSource.saveResponse(response);

        AppLogger.success('AI response generated successfully');
        return response;
      } catch (e) {
        AppLogger.warning('Remote AI service failed, trying local fallback', e);

        // Fallback to local if available
        return await _generateLocalResponse(request);
      }
    } catch (e, stackTrace) {
      AppLogger.error('Failed to generate AI response', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<AiResponse> generateText(String prompt, {
    String? context,
    double? temperature,
    int? maxTokens,
  }) async {
    try {
      final request = AiRequest(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        prompt: prompt,
        type: AiRequestType.textGeneration,
        timestamp: DateTime.now(),
        context: context,
        temperature: temperature ?? 0.7,
        maxTokens: maxTokens ?? 2048,
      );

      return await generateResponse(request);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to generate text', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<AiResponse> summarizeText(String text, {
    int? maxLength,
    String? style,
  }) async {
    try {
      final request = AiRequest(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        prompt: _buildSummarizationPrompt(text, maxLength, style),
        type: AiRequestType.summarization,
        timestamp: DateTime.now(),
        context: text,
        maxTokens: maxLength ?? 200,
      );

      return await generateResponse(request);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to summarize text', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<AiResponse> chat(String message, {
    String? conversationId,
    List<ChatMessage>? history,
  }) async {
    try {
      final request = AiRequest(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        prompt: message,
        type: AiRequestType.chat,
        timestamp: DateTime.now(),
        conversationId: conversationId,
        temperature: 0.7,
        maxTokens: 1024,
      );

      return await generateResponse(request);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to chat', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<String>> generateSuggestions(String context, {
    int? count,
    String? type,
  }) async {
    try {
      return await _remoteDataSource.generateSuggestions(
        context,
        count: count,
        type: type,
      );
    } catch (e, stackTrace) {
      AppLogger.error('Failed to generate suggestions', e, stackTrace);
      return [];
    }
  }

  @override
  Future<AiResponse> translateText(String text, String targetLanguage, {
    String? sourceLanguage,
  }) async {
    try {
      final prompt = _buildTranslationPrompt(text, targetLanguage, sourceLanguage);

      final request = AiRequest(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        prompt: prompt,
        type: AiRequestType.translation,
        timestamp: DateTime.now(),
        context: text,
        temperature: 0.3,
        maxTokens: 1000,
      );

      return await generateResponse(request);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to translate text', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<AiResponse> generateCode(String description, {
    String? language,
    String? framework,
  }) async {
    try {
      final prompt = _buildCodeGenerationPrompt(description, language, framework);

      final request = AiRequest(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        prompt: prompt,
        type: AiRequestType.codeGeneration,
        timestamp: DateTime.now(),
        temperature: 0.2,
        maxTokens: 2000,
      );

      return await generateResponse(request);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to generate code', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<bool> isAvailable() async {
    try {
      return await _remoteDataSource.isAvailable();
    } catch (e) {
      AppLogger.warning('AI service not available', e);
      return false;
    }
  }

  @override
  Future<AiServiceStatus> getStatus() async {
    try {
      return await _remoteDataSource.getStatus();
    } catch (e) {
      AppLogger.warning('Failed to get AI service status', e);
      return AiServiceStatus.unavailable;
    }
  }

  @override
  Future<bool> initialize() async {
    try {
      AppLogger.info('🤖 Initializing AI repository...');

      // Initialize both data sources
      await _remoteDataSource.initialize();
      await _localDataSource.initialize();

      AppLogger.success('AI repository initialized successfully');
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to initialize AI repository', e, stackTrace);
      return false;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      await _remoteDataSource.dispose();
      await _localDataSource.dispose();

      AppLogger.info('AI repository disposed');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to dispose AI repository', e, stackTrace);
    }
  }

  /// Generate local response as fallback
  Future<AiResponse> _generateLocalResponse(AiRequest request) async {
    // Simple local fallback responses
    switch (request.type) {
      case AiRequestType.textGeneration:
        return AiResponse(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content: 'I apologize, but I\'m currently offline. Please check your internet connection and try again.',
          type: AiResponseType.text,
          timestamp: DateTime.now(),
          model: 'local-fallback',
          confidence: 0.5,
          metadata: {'fallback': true},
        );

      case AiRequestType.summarization:
        return AiResponse(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content: 'Summary: ${request.context?.substring(0, 100)}...',
          type: AiResponseType.summary,
          timestamp: DateTime.now(),
          model: 'local-fallback',
          confidence: 0.3,
          metadata: {'fallback': true},
        );

      case AiRequestType.chat:
        return AiResponse(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content: 'I\'m currently offline. Please check your internet connection and try again.',
          type: AiResponseType.text,
          timestamp: DateTime.now(),
          model: 'local-fallback',
          confidence: 0.5,
          metadata: {'fallback': true},
        );

      default:
        return AiResponse(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content: 'This feature is currently unavailable offline.',
          type: AiResponseType.text,
          timestamp: DateTime.now(),
          model: 'local-fallback',
          confidence: 0.5,
          metadata: {'fallback': true},
        );
    }
  }

  /// Build summarization prompt
  String _buildSummarizationPrompt(String text, int? maxLength, String? style) {
    final length = maxLength ?? 200;
    final styleText = style ?? 'concise';

    return '''
Summarize the following text in a $styleText style, keeping it under $length characters:

$text

Summary:
''';
  }

  /// Build translation prompt
  String _buildTranslationPrompt(String text, String targetLanguage, String? sourceLanguage) {
    final sourceText = sourceLanguage ?? 'auto-detect';

    return '''
Translate the following text from $sourceText to $targetLanguage:

$text

Translation:
''';
  }

  /// Build code generation prompt
  String _buildCodeGenerationPrompt(String description, String? language, String? framework) {
    final lang = language ?? 'Dart';
    final fw = framework != null ? ' using $framework' : '';

    return '''
Generate $lang code$fw for the following description:

$description

Code:
''';
  }
}
