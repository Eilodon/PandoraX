import 'package:freezed_annotation/freezed_annotation.dart';

part 'embedding.freezed.dart';
part 'embedding.g.dart';

@freezed
class Embedding with _$Embedding {
  const factory Embedding({
    required String id,
    required List<double> vector,
    required String content,
    required DateTime createdAt,
    @Default(0.0) double magnitude,
  }) = _Embedding;

  factory Embedding.fromJson(Map<String, dynamic> json) => _$EmbeddingFromJson(json);
}
