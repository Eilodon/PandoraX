import '../entities/ai_response.dart';
import '../entities/chat_message.dart';
import '../repositories/ai_repository.dart';

/// Use case for getting chat response from AI
class GetChatResponse {
  final AIRepository _aiRepository;

  const GetChatResponse(this._aiRepository);

  /// Get chat response for a single message
  Future<AIResponse> call(String message) async {
    if (message.trim().isEmpty) {
      throw ArgumentError('Message cannot be empty');
    }

    if (!_aiRepository.isAvailable) {
      throw StateError('AI service is not available');
    }

    return await _aiRepository.generateResponse(message);
  }

  /// Get chat response with conversation history
  Future<AIResponse> callWithHistory(String message, List<ChatMessage> history) async {
    if (message.trim().isEmpty) {
      throw ArgumentError('Message cannot be empty');
    }

    if (!_aiRepository.isAvailable) {
      throw StateError('AI service is not available');
    }

    return await _aiRepository.generateChatResponse(message, history);
  }
}
