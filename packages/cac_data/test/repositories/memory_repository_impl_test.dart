import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:cac_core/cac_core.dart';
import 'package:cac_data/cac_data.dart';

import 'memory_repository_impl_test.mocks.dart';

@GenerateMocks([IsarMemoryDatasource, IsarWriteQueueService])
void main() {
  group('MemoryRepositoryImpl', () {
    late MemoryRepositoryImpl repository;
    late MockIsarMemoryDatasource mockDatasource;
    late MockIsarWriteQueueService mockWriteQueue;

    setUp(() {
      mockDatasource = MockIsarMemoryDatasource();
      mockWriteQueue = MockIsarWriteQueueService();
      repository = MemoryRepositoryImpl(mockDatasource, mockWriteQueue);
    });

    tearDown(() {
      repository.dispose();
    });

    group('saveMemory', () {
      test('should queue memory for save and emit to stream', () async {
        // Arrange
        final memory = MemoryEntry(
          id: 'test-id',
          timestamp: DateTime.now(),
          source: 'test',
          content: 'test content',
          causalLinks: [],
        );

        when(mockWriteQueue.add(any)).thenAnswer((_) async {});

        // Act
        await repository.saveMemory(memory);

        // Assert
        verify(mockWriteQueue.add(any)).called(1);
      });
    });

    group('getMemory', () {
      test('should return memory when found', () async {
        // Arrange
        final memoryId = 'test-id';
        final isarMemory = IsarMemoryEntry();
        isarMemory.memoryId = memoryId;
        isarMemory.timestamp = DateTime.now();
        isarMemory.source = 'test';
        isarMemory.content = 'test content';
        isarMemory.causalLinks = [];
        isarMemory.type = 'explicit';
        isarMemory.metadata = {};
        isarMemory.relevanceScore = 0.0;
        isarMemory.isPinned = false;
        isarMemory.isArchived = false;

        when(mockDatasource.getMemory(memoryId)).thenAnswer((_) async => isarMemory);

        // Act
        final result = await repository.getMemory(memoryId);

        // Assert
        expect(result, isNotNull);
        expect(result!.id, equals(memoryId));
        verify(mockDatasource.getMemory(memoryId)).called(1);
      });

      test('should return null when memory not found', () async {
        // Arrange
        final memoryId = 'non-existent-id';
        when(mockDatasource.getMemory(memoryId)).thenAnswer((_) async => null);

        // Act
        final result = await repository.getMemory(memoryId);

        // Assert
        expect(result, isNull);
        verify(mockDatasource.getMemory(memoryId)).called(1);
      });
    });

    group('searchMemories', () {
      test('should return search results', () async {
        // Arrange
        final query = 'test query';
        final isarMemories = [
          IsarMemoryEntry()
            ..memoryId = 'id1'
            ..timestamp = DateTime.now()
            ..source = 'test'
            ..content = 'test content 1'
            ..causalLinks = []
            ..type = 'explicit'
            ..metadata = {}
            ..relevanceScore = 0.0
            ..isPinned = false
            ..isArchived = false,
        ];

        when(mockDatasource.searchMemories(query)).thenAnswer((_) async => isarMemories);

        // Act
        final result = await repository.searchMemories(query);

        // Assert
        expect(result, hasLength(1));
        expect(result.first.content, equals('test content 1'));
        verify(mockDatasource.searchMemories(query)).called(1);
      });
    });

    group('deleteMemory', () {
      test('should queue memory for deletion', () async {
        // Arrange
        final memoryId = 'test-id';
        when(mockWriteQueue.add(any)).thenAnswer((_) async {});

        // Act
        await repository.deleteMemory(memoryId);

        // Assert
        verify(mockWriteQueue.add(any)).called(1);
      });
    });
  });
}
