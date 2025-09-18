import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_response.freezed.dart';
part 'ai_response.g.dart';

@freezed
class AIResponse with _$AIResponse {
  const factory AIResponse({
    required String id,
    required String query,
    required String response,
    required DateTime timestamp,
    @Default(0.0) double confidence,
    @Default({}) Map<String, dynamic> metadata,
  }) = _AIResponse;

  factory AIResponse.fromJson(Map<String, dynamic> json) => _$AIResponseFromJson(json);
}

extension AIResponseExtension on AIResponse {
  /// Check if response has high confidence
  bool get isHighConfidence => confidence > 0.8;

  /// Get formatted timestamp
  String get formattedTime {
    return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  /// Get content length
  int get contentLength => response.length;

  /// Check if response is empty
  bool get isEmpty => response.isEmpty;

  /// Get response preview (first 200 characters)
  String get preview {
    if (response.length <= 200) return response;
    return '${response.substring(0, 200)}...';
  }
}
