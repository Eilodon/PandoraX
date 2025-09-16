import 'dart:async';
import 'dart:math';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:common_entities/common_entities.dart';

@LazySingleton()
class VectorSearchDatasource implements VectorSearchInterface {
  final Logger _logger = Logger();
  final Map<String, List<double>> _vectors = {};
  final Map<String, String> _contents = {};
  final Map<String, Map<String, dynamic>> _metadata = {};

  @override
  Future<List<VectorSearchResult>> searchSimilar({
    required List<double> queryVector,
    required int limit,
    double? threshold,
  }) async {
    _logger.d('Searching for similar vectors with limit: $limit, threshold: $threshold');
    
    final results = <VectorSearchResult>[];
    
    for (final entry in _vectors.entries) {
      final similarity = _cosineSimilarity(queryVector, entry.value);
      
      if (threshold == null || similarity >= threshold) {
        results.add(VectorSearchResult(
          id: entry.key,
          content: _contents[entry.key] ?? '',
          similarity: similarity,
          createdAt: DateTime.now(), // This should be stored with the vector
          metadata: _metadata[entry.key] ?? {},
        ));
      }
    }

    // Sort by similarity (descending)
    results.sort((a, b) => b.similarity.compareTo(a.similarity));
    
    return results.take(limit).toList();
  }

  @override
  Future<void> addEmbedding({
    required String id,
    required List<double> vector,
    required String content,
    Map<String, dynamic>? metadata,
  }) async {
    _vectors[id] = vector;
    _contents[id] = content;
    _metadata[id] = metadata ?? {};
    _logger.d('Embedding added: $id');
  }

  @override
  Future<void> removeEmbedding(String id) async {
    _vectors.remove(id);
    _contents.remove(id);
    _metadata.remove(id);
    _logger.d('Embedding removed: $id');
  }

  @override
  Future<void> clearAll() async {
    _vectors.clear();
    _contents.clear();
    _metadata.clear();
    _logger.i('All embeddings cleared');
  }

  double _cosineSimilarity(List<double> a, List<double> b) {
    if (a.length != b.length) {
      throw ArgumentError('Vectors must have the same length');
    }

    double dotProduct = 0.0;
    double normA = 0.0;
    double normB = 0.0;

    for (int i = 0; i < a.length; i++) {
      dotProduct += a[i] * b[i];
      normA += a[i] * a[i];
      normB += b[i] * b[i];
    }

    if (normA == 0.0 || normB == 0.0) {
      return 0.0;
    }

    return dotProduct / (sqrt(normA) * sqrt(normB));
  }
}
