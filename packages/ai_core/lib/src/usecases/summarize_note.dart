import '../entities/ai_response.dart';
import '../repositories/ai_repository.dart';

/// Use case for summarizing note content
class SummarizeNote {
  final AIRepository _aiRepository;

  const SummarizeNote(this._aiRepository);

  /// Summarize note content
  Future<AIResponse> call(String content) async {
    if (content.trim().isEmpty) {
      throw ArgumentError('Content cannot be empty');
    }

    if (!_aiRepository.isAvailable) {
      throw StateError('AI service is not available');
    }

    return await _aiRepository.summarizeNote(content);
  }

  /// Summarize note content with custom prompt
  Future<AIResponse> callWithPrompt(String content, String customPrompt) async {
    if (content.trim().isEmpty) {
      throw ArgumentError('Content cannot be empty');
    }

    if (customPrompt.trim().isEmpty) {
      throw ArgumentError('Custom prompt cannot be empty');
    }

    if (!_aiRepository.isAvailable) {
      throw StateError('AI service is not available');
    }

    // Use custom prompt with content
    final fullPrompt = '$customPrompt\n\nContent:\n$content';
    return await _aiRepository.generateResponse(fullPrompt);
  }
}
