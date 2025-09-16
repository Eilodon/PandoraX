import 'package:freezed_annotation/freezed_annotation.dart';

part 'vector_search_result.freezed.dart';
part 'vector_search_result.g.dart';

@freezed
class VectorSearchResult with _$VectorSearchResult {
  const factory VectorSearchResult({
    required String id,
    required String content,
    required double similarity,
    required DateTime createdAt,
    @Default({}) Map<String, dynamic> metadata,
  }) = _VectorSearchResult;

  factory VectorSearchResult.fromJson(Map<String, dynamic> json) => _$VectorSearchResultFromJson(json);
}
