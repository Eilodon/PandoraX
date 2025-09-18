import 'package:flutter_test/flutter_test.dart';
import 'package:cac_core/cac_core.dart';
import 'package:cac_data/cac_data.dart';

void main() {
  group('IsarMemoryEntry', () {
    group('fromMemoryEntry', () {
      test('should convert MemoryEntry to IsarMemoryEntry correctly', () {
        // Arrange
        final memory = MemoryEntry(
          id: 'test-id',
          timestamp: DateTime(2024, 1, 1, 12, 0),
          source: 'notes',
          content: 'test content',
          embedding: [1.0, 2.0, 3.0],
          causalLinks: ['link1', 'link2'],
          type: MemoryType.emotional,
          metadata: {'key': 'value'},
          relevanceScore: 0.8,
          isPinned: true,
          isArchived: false,
        );

        // Act
        final isarMemory = IsarMemoryEntry.fromMemoryEntry(memory);

        // Assert
        expect(isarMemory.memoryId, equals('test-id'));
        expect(isarMemory.timestamp, equals(DateTime(2024, 1, 1, 12, 0)));
        expect(isarMemory.source, equals('notes'));
        expect(isarMemory.content, equals('test content'));
        expect(isarMemory.embedding, equals([1.0, 2.0, 3.0]));
        expect(isarMemory.causalLinks, equals(['link1', 'link2']));
        expect(isarMemory.type, equals('emotional'));
        expect(isarMemory.metadata, equals({'key': 'value'}));
        expect(isarMemory.relevanceScore, equals(0.8));
        expect(isarMemory.isPinned, isTrue);
        expect(isarMemory.isArchived, isFalse);
      });

      test('should handle null embedding correctly', () {
        // Arrange
        final memory = MemoryEntry(
          id: 'test-id',
          timestamp: DateTime.now(),
          source: 'notes',
          content: 'test content',
          embedding: null,
          causalLinks: [],
          type: MemoryType.explicit,
        );

        // Act
        final isarMemory = IsarMemoryEntry.fromMemoryEntry(memory);

        // Assert
        expect(isarMemory.embedding, isNull);
      });
    });

    group('toMemoryEntry', () {
      test('should convert IsarMemoryEntry to MemoryEntry correctly', () {
        // Arrange
        final isarMemory = IsarMemoryEntry()
          ..memoryId = 'test-id'
          ..timestamp = DateTime(2024, 1, 1, 12, 0)
          ..source = 'notes'
          ..content = 'test content'
          ..embedding = [1.0, 2.0, 3.0]
          ..causalLinks = ['link1', 'link2']
          ..type = 'emotional'
          ..metadata = {'key': 'value'}
          ..relevanceScore = 0.8
          ..isPinned = true
          ..isArchived = false;

        // Act
        final memory = isarMemory.toMemoryEntry();

        // Assert
        expect(memory.id, equals('test-id'));
        expect(memory.timestamp, equals(DateTime(2024, 1, 1, 12, 0)));
        expect(memory.source, equals('notes'));
        expect(memory.content, equals('test content'));
        expect(memory.embedding, equals([1.0, 2.0, 3.0]));
        expect(memory.causalLinks, equals(['link1', 'link2']));
        expect(memory.type, equals(MemoryType.emotional));
        expect(memory.metadata, equals({'key': 'value'}));
        expect(memory.relevanceScore, equals(0.8));
        expect(memory.isPinned, isTrue);
        expect(memory.isArchived, isFalse);
      });

      test('should handle null embedding correctly', () {
        // Arrange
        final isarMemory = IsarMemoryEntry()
          ..memoryId = 'test-id'
          ..timestamp = DateTime.now()
          ..source = 'notes'
          ..content = 'test content'
          ..embedding = null
          ..causalLinks = []
          ..type = 'explicit'
          ..metadata = {}
          ..relevanceScore = 0.0
          ..isPinned = false
          ..isArchived = false;

        // Act
        final memory = isarMemory.toMemoryEntry();

        // Assert
        expect(memory.embedding, isNull);
      });

      test('should handle all MemoryType values correctly', () {
        // Test all memory types
        for (final memoryType in MemoryType.values) {
          // Arrange
          final isarMemory = IsarMemoryEntry()
            ..memoryId = 'test-id'
            ..timestamp = DateTime.now()
            ..source = 'notes'
            ..content = 'test content'
            ..embedding = null
            ..causalLinks = []
            ..type = memoryType.name
            ..metadata = {}
            ..relevanceScore = 0.0
            ..isPinned = false
            ..isArchived = false;

          // Act
          final memory = isarMemory.toMemoryEntry();

          // Assert
          expect(memory.type, equals(memoryType));
        }
      });
    });

    group('round trip conversion', () {
      test('should maintain data integrity through conversion', () {
        // Arrange
        final originalMemory = MemoryEntry(
          id: 'test-id',
          timestamp: DateTime(2024, 1, 1, 12, 0),
          source: 'notes',
          content: 'test content',
          embedding: [1.0, 2.0, 3.0],
          causalLinks: ['link1', 'link2'],
          type: MemoryType.temporal,
          metadata: {'key': 'value', 'nested': {'data': 123}},
          relevanceScore: 0.8,
          isPinned: true,
          isArchived: false,
        );

        // Act
        final isarMemory = IsarMemoryEntry.fromMemoryEntry(originalMemory);
        final convertedMemory = isarMemory.toMemoryEntry();

        // Assert
        expect(convertedMemory.id, equals(originalMemory.id));
        expect(convertedMemory.timestamp, equals(originalMemory.timestamp));
        expect(convertedMemory.source, equals(originalMemory.source));
        expect(convertedMemory.content, equals(originalMemory.content));
        expect(convertedMemory.embedding, equals(originalMemory.embedding));
        expect(convertedMemory.causalLinks, equals(originalMemory.causalLinks));
        expect(convertedMemory.type, equals(originalMemory.type));
        expect(convertedMemory.metadata, equals(originalMemory.metadata));
        expect(convertedMemory.relevanceScore, equals(originalMemory.relevanceScore));
        expect(convertedMemory.isPinned, equals(originalMemory.isPinned));
        expect(convertedMemory.isArchived, equals(originalMemory.isArchived));
      });
    });
  });
}
