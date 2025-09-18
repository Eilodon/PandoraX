import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_response.freezed.dart';
part 'ai_response.g.dart';

@freezed
class AIResponse with _$AIResponse {
  const factory AIResponse({
    required String content,
    required String modelUsed,
    required int processingTimeMs,
    required bool isOnDevice,
    required DateTime timestamp,
    String? error,
    Map<String, dynamic>? metadata,
  }) = _AIResponse;

  factory AIResponse.fromJson(Map<String, dynamic> json) => _$AIResponseFromJson(json);

  const AIResponse._();

  bool get isSuccess => error == null;
  
  String get processingTimeDisplay {
    if (processingTimeMs < 1000) {
      return '${processingTimeMs}ms';
    } else {
      return '${(processingTimeMs / 1000).toStringAsFixed(1)}s';
    }
  }
}
