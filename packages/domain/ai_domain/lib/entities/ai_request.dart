import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:common_entities/common_entities.dart';

part 'ai_request.freezed.dart';
part 'ai_request.g.dart';

/// AI request entity
@freezed
class AiRequest with _$AiRequest {
  const factory AiRequest({
    required String id,
    required String prompt,
    required AiRequestType type,
    required DateTime timestamp,
    String? context,
    Map<String, dynamic>? parameters,
    String? conversationId,
    List<String>? attachments,
    @Default(false) bool isStreaming,
    @Default(0.7) double temperature,
    @Default(2048) int maxTokens,
  }) = _AiRequest;

  const AiRequest._();

  factory AiRequest.fromJson(Map<String, dynamic> json) => _$AiRequestFromJson(json);

  /// Check if request is for text generation
  bool get isTextGeneration => type == AiRequestType.textGeneration;

  /// Check if request is for summarization
  bool get isSummarization => type == AiRequestType.summarization;

  /// Check if request is for chat
  bool get isChat => type == AiRequestType.chat;

  /// Check if request has context
  bool get hasContext => context != null && context!.isNotEmpty;

  /// Check if request has attachments
  bool get hasAttachments => attachments != null && attachments!.isNotEmpty;
}

/// AI request types
enum AiRequestType {
  textGeneration,
  summarization,
  chat,
  translation,
  codeGeneration,
  imageGeneration,
  voiceToText,
  textToVoice,
}
