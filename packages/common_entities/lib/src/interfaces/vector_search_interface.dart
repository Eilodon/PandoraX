import '../entities/vector_search_result.dart';

abstract class VectorSearchInterface {
  Future<List<VectorSearchResult>> searchSimilar({
    required List<double> queryVector,
    required int limit,
    double? threshold,
  });

  Future<void> addEmbedding({
    required String id,
    required List<double> vector,
    required String content,
    Map<String, dynamic>? metadata,
  });

  Future<void> removeEmbedding(String id);
  Future<void> clearAll();
}
