import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:cac_core/cac_core.dart';
import 'package:cac_data/cac_data.dart';

void main() {
  group('IsarMemoryDatasource', () {
    late IsarMemoryDatasource datasource;
    late Isar isar;

    setUp(() async {
      // Initialize in-memory Isar for testing
      isar = await Isar.open(
        [IsarMemoryEntrySchema],
        directory: '',
        name: 'test',
      );
      datasource = IsarMemoryDatasource();
      // We need to set the isar instance for testing
      // This would require modifying the datasource to accept isar in constructor
    });

    tearDown(() async {
      await isar.close();
    });

    group('saveMemory', () {
      test('should save memory successfully', () async {
        // Arrange
        final memory = IsarMemoryEntry()
          ..memoryId = 'test-id'
          ..timestamp = DateTime.now()
          ..source = 'test'
          ..content = 'test content'
          ..causalLinks = []
          ..type = 'explicit'
          ..metadata = {}
          ..relevanceScore = 0.0
          ..isPinned = false
          ..isArchived = false;

        // Act
        await datasource.saveMemory(memory);

        // Assert
        final savedMemory = await datasource.getMemory('test-id');
        expect(savedMemory, isNotNull);
        expect(savedMemory!.memoryId, equals('test-id'));
        expect(savedMemory.content, equals('test content'));
      });
    });

    group('getMemory', () {
      test('should return memory when found', () async {
        // Arrange
        final memory = IsarMemoryEntry()
          ..memoryId = 'test-id'
          ..timestamp = DateTime.now()
          ..source = 'test'
          ..content = 'test content'
          ..causalLinks = []
          ..type = 'explicit'
          ..metadata = {}
          ..relevanceScore = 0.0
          ..isPinned = false
          ..isArchived = false;

        await datasource.saveMemory(memory);

        // Act
        final result = await datasource.getMemory('test-id');

        // Assert
        expect(result, isNotNull);
        expect(result!.memoryId, equals('test-id'));
      });

      test('should return null when memory not found', () async {
        // Act
        final result = await datasource.getMemory('non-existent-id');

        // Assert
        expect(result, isNull);
      });
    });

    group('searchMemories', () {
      test('should return memories containing search query', () async {
        // Arrange
        final memories = [
          IsarMemoryEntry()
            ..memoryId = 'id1'
            ..timestamp = DateTime.now()
            ..source = 'test'
            ..content = 'programming is fun'
            ..causalLinks = []
            ..type = 'explicit'
            ..metadata = {}
            ..relevanceScore = 0.0
            ..isPinned = false
            ..isArchived = false,
          IsarMemoryEntry()
            ..memoryId = 'id2'
            ..timestamp = DateTime.now()
            ..source = 'test'
            ..content = 'coding is awesome'
            ..causalLinks = []
            ..type = 'explicit'
            ..metadata = {}
            ..relevanceScore = 0.0
            ..isPinned = false
            ..isArchived = false,
          IsarMemoryEntry()
            ..memoryId = 'id3'
            ..timestamp = DateTime.now()
            ..source = 'test'
            ..content = 'cooking is great'
            ..causalLinks = []
            ..type = 'explicit'
            ..metadata = {}
            ..relevanceScore = 0.0
            ..isPinned = false
            ..isArchived = false,
        ];

        for (final memory in memories) {
          await datasource.saveMemory(memory);
        }

        // Act
        final results = await datasource.searchMemories('programming');

        // Assert
        expect(results, hasLength(1));
        expect(results.first.memoryId, equals('id1'));
        expect(results.first.content, contains('programming'));
      });
    });

    group('getMemoriesByType', () {
      test('should return memories of specific type', () async {
        // Arrange
        final memories = [
          IsarMemoryEntry()
            ..memoryId = 'id1'
            ..timestamp = DateTime.now()
            ..source = 'test'
            ..content = 'explicit memory'
            ..causalLinks = []
            ..type = 'explicit'
            ..metadata = {}
            ..relevanceScore = 0.0
            ..isPinned = false
            ..isArchived = false,
          IsarMemoryEntry()
            ..memoryId = 'id2'
            ..timestamp = DateTime.now()
            ..source = 'test'
            ..content = 'emotional memory'
            ..causalLinks = []
            ..type = 'emotional'
            ..metadata = {}
            ..relevanceScore = 0.0
            ..isPinned = false
            ..isArchived = false,
        ];

        for (final memory in memories) {
          await datasource.saveMemory(memory);
        }

        // Act
        final results = await datasource.getMemoriesByType('explicit');

        // Assert
        expect(results, hasLength(1));
        expect(results.first.memoryId, equals('id1'));
        expect(results.first.type, equals('explicit'));
      });
    });

    group('deleteMemory', () {
      test('should delete memory successfully', () async {
        // Arrange
        final memory = IsarMemoryEntry()
          ..memoryId = 'test-id'
          ..timestamp = DateTime.now()
          ..source = 'test'
          ..content = 'test content'
          ..causalLinks = []
          ..type = 'explicit'
          ..metadata = {}
          ..relevanceScore = 0.0
          ..isPinned = false
          ..isArchived = false;

        await datasource.saveMemory(memory);

        // Act
        await datasource.deleteMemory('test-id');

        // Assert
        final result = await datasource.getMemory('test-id');
        expect(result, isNull);
      });
    });

    group('clearAllMemories', () {
      test('should clear all memories', () async {
        // Arrange
        final memories = [
          IsarMemoryEntry()
            ..memoryId = 'id1'
            ..timestamp = DateTime.now()
            ..source = 'test'
            ..content = 'memory 1'
            ..causalLinks = []
            ..type = 'explicit'
            ..metadata = {}
            ..relevanceScore = 0.0
            ..isPinned = false
            ..isArchived = false,
          IsarMemoryEntry()
            ..memoryId = 'id2'
            ..timestamp = DateTime.now()
            ..source = 'test'
            ..content = 'memory 2'
            ..causalLinks = []
            ..type = 'explicit'
            ..metadata = {}
            ..relevanceScore = 0.0
            ..isPinned = false
            ..isArchived = false,
        ];

        for (final memory in memories) {
          await datasource.saveMemory(memory);
        }

        // Act
        await datasource.clearAllMemories();

        // Assert
        final results = await datasource.getMemories();
        expect(results, isEmpty);
      });
    });
  });
}
