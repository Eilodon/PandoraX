import 'package:common_entities/common_entities.dart';
import '../entities/ai_request.dart';
import '../repositories/ai_repository.dart';

/// Use case for AI chat functionality
class ChatUseCase {
  final AiRepository _aiRepository;

  const ChatUseCase(this._aiRepository);

  /// Send a chat message and get AI response
  Future<AiResponse> call({
    required String message,
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

      return await _aiRepository.generateResponse(request);
    } catch (e) {
      rethrow;
    }
  }

  /// Generate suggestions for the next message
  Future<List<String>> generateSuggestions({
    required String context,
    String? conversationId,
    List<ChatMessage>? history,
  }) async {
    try {
      return await _aiRepository.generateSuggestions(
        context,
        count: 3,
        type: 'chat',
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Check if AI is ready for chat
  Future<bool> isReady() async {
    try {
      final status = await _aiRepository.getStatus();
      return status == AiServiceStatus.ready;
    } catch (e) {
      return false;
    }
  }
}
