import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

enum ChatRole { user, assistant, system }

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required String content,
    required ChatRole role,
    required DateTime timestamp,
    String? modelUsed,
    bool? isOnDevice,
    Map<String, dynamic>? metadata,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);

  const ChatMessage._();

  factory ChatMessage.user(String content) => ChatMessage(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    content: content,
    role: ChatRole.user,
    timestamp: DateTime.now(),
  );

  factory ChatMessage.assistant(String content, {String? modelUsed, bool? isOnDevice}) => ChatMessage(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    content: content,
    role: ChatRole.assistant,
    timestamp: DateTime.now(),
    modelUsed: modelUsed,
    isOnDevice: isOnDevice,
  );

  factory ChatMessage.system(String content) => ChatMessage(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    content: content,
    role: ChatRole.system,
    timestamp: DateTime.now(),
  );

  bool get isUser => role == ChatRole.user;
  bool get isAssistant => role == ChatRole.assistant;
  bool get isSystem => role == ChatRole.system;
}
