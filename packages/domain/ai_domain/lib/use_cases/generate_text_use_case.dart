import 'package:common_entities/common_entities.dart';
import '../entities/ai_request.dart';
import '../repositories/ai_repository.dart';

/// Use case for generating text using AI
class GenerateTextUseCase {
  final AiRepository _aiRepository;

  const GenerateTextUseCase(this._aiRepository);

  /// Generate text from a prompt
  Future<AiResponse> call({
    required String prompt,
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

      return await _aiRepository.generateResponse(request);
    } catch (e) {
      rethrow;
    }
  }
}
