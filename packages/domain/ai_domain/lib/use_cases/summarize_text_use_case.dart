import 'package:common_entities/common_entities.dart';
import '../entities/ai_request.dart';
import '../repositories/ai_repository.dart';

/// Use case for summarizing text using AI
class SummarizeTextUseCase {
  final AiRepository _aiRepository;

  const SummarizeTextUseCase(this._aiRepository);

  /// Summarize text content
  Future<AiResponse> call({
    required String text,
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

      return await _aiRepository.generateResponse(request);
    } catch (e) {
      rethrow;
    }
  }

  /// Build summarization prompt based on parameters
  String _buildSummarizationPrompt(String text, int? maxLength, String? style) {
    final length = maxLength ?? 200;
    final styleText = style ?? 'concise';

    return '''
Summarize the following text in a $styleText style, keeping it under $length characters:

$text

Summary:
''';
  }
}
