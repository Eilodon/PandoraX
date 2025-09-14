import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'ai_chat_state.dart';
import '../ai_service.dart';

@injectable
class AiChatNotifier extends StateNotifier<AiChatState> {
  final AiService _aiService;
  final _uuid = const Uuid();

  AiChatNotifier(this._aiService) : super(const AiChatState());

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    // Thêm tin nhắn của người dùng
    final userMessage = ChatMessage(
      id: _uuid.v4(),
      content: message.trim(),
      isUser: true,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
      errorMessage: null,
    );

    try {
      // Gửi tin nhắn đến AI
      final aiResponse = await _aiService.chatWithAI(message);
      
      // Thêm phản hồi từ AI
      final aiMessage = ChatMessage(
        id: _uuid.v4(),
        content: aiResponse,
        isUser: false,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        messages: [...state.messages, aiMessage],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Lỗi khi gửi tin nhắn: ${e.toString()}',
      );
    }
  }

  void clearChat() {
    state = const AiChatState();
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  Future<void> createNoteFromMessage(String messageId) async {
    final message = state.messages.firstWhere((msg) => msg.id == messageId);
    // TODO: Tích hợp với NoteFormNotifier để tạo ghi chú mới
    // Có thể mở màn hình tạo ghi chú với nội dung từ tin nhắn
  }
}
