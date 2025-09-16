import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_request.freezed.dart';
part 'ai_request.g.dart';

@freezed
class AIRequest with _$AIRequest {
  const factory AIRequest({
    required String id,
    required AIRequestType type,
    required String prompt,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? metadata,
    DateTime? timestamp,
    String? modelId,
    InferenceConfig? config,
  }) = _AIRequest;

  factory AIRequest.fromJson(Map<String, dynamic> json) =>
      _$AIRequestFromJson(json);
}

@freezed
class AIResponse with _$AIResponse {
  const factory AIResponse({
    required String id,
    required String content,
    required double confidence,
    required String modelId,
    required AIRequestType type,
    Map<String, dynamic>? metadata,
    DateTime? timestamp,
    Duration? processingTime,
    String? error,
  }) = _AIResponse;

  factory AIResponse.fromJson(Map<String, dynamic> json) =>
      _$AIResponseFromJson(json);
}

@freezed
class InferenceConfig with _$InferenceConfig {
  const factory InferenceConfig({
    @Default(0.7) double temperature,
    @Default(100) int maxTokens,
    @Default(1) int topP,
    @Default(1) int topK,
    @Default(1) int repetitionPenalty,
    @Default(false) bool stream,
    @Default(false) bool useCache,
    Map<String, dynamic>? customParameters,
  }) = _InferenceConfig;

  factory InferenceConfig.fromJson(Map<String, dynamic> json) =>
      _$InferenceConfigFromJson(json);
}

enum AIRequestType {
  textGeneration,
  codeGeneration,
  imageAnalysis,
  speechRecognition,
  translation,
  summarization,
  questionAnswering,
  sentimentAnalysis,
  classification,
  embedding,
}

enum ModelType {
  onDevice,
  cloud,
  hybrid,
}

enum ModelStatus {
  available,
  downloading,
  downloaded,
  loading,
  loaded,
  error,
  outdated,
}
