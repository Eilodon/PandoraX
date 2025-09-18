import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

enum ChatMessageType {
  user,
  ai,
  system,
  error,
}

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required String content,
    required ChatMessageType type,
    required DateTime timestamp,
    @Default([]) List<String> attachments,
    @Default({}) Map<String, dynamic> metadata,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);
}

extension ChatMessageExtension on ChatMessage {
  /// Check if message is from user
  bool get isUser => type == ChatMessageType.user;

  /// Check if message is from AI
  bool get isAi => type == ChatMessageType.ai;

  /// Check if message is system message
  bool get isSystem => type == ChatMessageType.system;

  /// Check if message is error
  bool get isError => type == ChatMessageType.error;

  /// Get formatted timestamp
  String get formattedTime {
    return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  /// Get content length
  int get contentLength => content.length;

  /// Check if message is empty
  bool get isEmpty => content.isEmpty;

  /// Check if message has attachments
  bool get hasAttachments => attachments.isNotEmpty;
}
