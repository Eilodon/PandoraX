import 'package:flutter_test/flutter_test.dart';
import 'package:common_entities/common_entities.dart';
import 'package:cac_data/cac_data.dart';

void main() {
  group('VectorSearchDatasource', () {
    late VectorSearchDatasource datasource;

    setUp(() {
      datasource = VectorSearchDatasource();
    });

    tearDown(() {
      datasource.clearAll();
    });

    group('addEmbedding', () {
      test('should add embedding successfully', () async {
        // Arrange
        final id = 'test-id';
        final vector = [1.0, 2.0, 3.0];
        final content = 'test content';
        final metadata = {'source': 'test'};

        // Act
        await datasource.addEmbedding(
          id: id,
          vector: vector,
          content: content,
          metadata: metadata,
        );

        // Assert
        final results = await datasource.searchSimilar(
          queryVector: vector,
          limit: 1,
        );
        expect(results, hasLength(1));
        expect(results.first.id, equals(id));
        expect(results.first.content, equals(content));
        expect(results.first.similarity, equals(1.0));
      });
    });

    group('searchSimilar', () {
      test('should return similar vectors sorted by similarity', () async {
        // Arrange
        final queryVector = [1.0, 0.0, 0.0];
        final vectors = [
          {'id': 'id1', 'vector': [1.0, 0.0, 0.0], 'content': 'exact match'},
          {'id': 'id2', 'vector': [0.5, 0.5, 0.0], 'content': 'partial match'},
          {'id': 'id3', 'vector': [0.0, 1.0, 0.0], 'content': 'different'},
        ];

        for (final vectorData in vectors) {
          await datasource.addEmbedding(
            id: vectorData['id'] as String,
            vector: vectorData['vector'] as List<double>,
            content: vectorData['content'] as String,
          );
        }

        // Act
        final results = await datasource.searchSimilar(
          queryVector: queryVector,
          limit: 3,
        );

        // Assert
        expect(results, hasLength(3));
        expect(results[0].id, equals('id1')); // Exact match should be first
        expect(results[0].similarity, equals(1.0));
        expect(results[1].id, equals('id2')); // Partial match should be second
        expect(results[2].id, equals('id3')); // Different should be last
      });

      test('should respect threshold parameter', () async {
        // Arrange
        final queryVector = [1.0, 0.0, 0.0];
        final vectors = [
          {'id': 'id1', 'vector': [1.0, 0.0, 0.0], 'content': 'exact match'},
          {'id': 'id2', 'vector': [0.5, 0.5, 0.0], 'content': 'partial match'},
          {'id': 'id3', 'vector': [0.0, 1.0, 0.0], 'content': 'different'},
        ];

        for (final vectorData in vectors) {
          await datasource.addEmbedding(
            id: vectorData['id'] as String,
            vector: vectorData['vector'] as List<double>,
            content: vectorData['content'] as String,
          );
        }

        // Act
        final results = await datasource.searchSimilar(
          queryVector: queryVector,
          limit: 10,
          threshold: 0.8,
        );

        // Assert
        expect(results, hasLength(1));
        expect(results.first.id, equals('id1'));
        expect(results.first.similarity, greaterThanOrEqualTo(0.8));
      });

      test('should respect limit parameter', () async {
        // Arrange
        final queryVector = [1.0, 0.0, 0.0];
        final vectors = List.generate(5, (i) => {
          'id': 'id$i',
          'vector': [1.0, 0.0, 0.0],
          'content': 'content $i',
        });

        for (final vectorData in vectors) {
          await datasource.addEmbedding(
            id: vectorData['id'] as String,
            vector: vectorData['vector'] as List<double>,
            content: vectorData['content'] as String,
          );
        }

        // Act
        final results = await datasource.searchSimilar(
          queryVector: queryVector,
          limit: 3,
        );

        // Assert
        expect(results, hasLength(3));
      });
    });

    group('removeEmbedding', () {
      test('should remove embedding successfully', () async {
        // Arrange
        final id = 'test-id';
        final vector = [1.0, 2.0, 3.0];
        final content = 'test content';

        await datasource.addEmbedding(
          id: id,
          vector: vector,
          content: content,
        );

        // Act
        await datasource.removeEmbedding(id);

        // Assert
        final results = await datasource.searchSimilar(
          queryVector: vector,
          limit: 1,
        );
        expect(results, isEmpty);
      });
    });

    group('clearAll', () {
      test('should clear all embeddings', () async {
        // Arrange
        final vectors = [
          {'id': 'id1', 'vector': [1.0, 0.0, 0.0], 'content': 'content 1'},
          {'id': 'id2', 'vector': [0.0, 1.0, 0.0], 'content': 'content 2'},
        ];

        for (final vectorData in vectors) {
          await datasource.addEmbedding(
            id: vectorData['id'] as String,
            vector: vectorData['vector'] as List<double>,
            content: vectorData['content'] as String,
          );
        }

        // Act
        await datasource.clearAll();

        // Assert
        final results = await datasource.searchSimilar(
          queryVector: [1.0, 0.0, 0.0],
          limit: 10,
        );
        expect(results, isEmpty);
      });
    });
  });
}
