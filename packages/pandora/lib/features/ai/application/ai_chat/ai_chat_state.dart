import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_chat_state.freezed.dart';

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required String content,
    required bool isUser,
    required DateTime timestamp,
    @Default(false) bool isTyping,
  }) = _ChatMessage;
}

@freezed
class AiChatState with _$AiChatState {
  const factory AiChatState({
    @Default([]) List<ChatMessage> messages,
    @Default(false) bool isLoading,
    @Default(false) bool isTyping,
    String? errorMessage,
  }) = _AiChatState;
}
