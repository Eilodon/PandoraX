import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:cac_core/cac_core.dart';
import 'package:cac_data/cac_data.dart';

import 'nightly_analysis_service_test.mocks.dart';

@GenerateMocks([MemoryRepository, EventBusService])
void main() {
  group('NightlyAnalysisService', () {
    late NightlyAnalysisService service;
    late MockMemoryRepository mockMemoryRepository;
    late MockEventBusService mockEventBusService;

    setUp(() {
      mockMemoryRepository = MockMemoryRepository();
      mockEventBusService = MockEventBusService();
      service = NightlyAnalysisService(mockMemoryRepository, mockEventBusService);
    });

    tearDown(() {
      service.dispose();
    });

    group('_performAnalysis', () {
      test('should analyze recent memories and generate insights', () async {
        // Arrange
        final recentMemories = [
          MemoryEntry(
            id: 'memory1',
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
            source: 'notes',
            content: 'I love programming',
            causalLinks: [],
            type: MemoryType.explicit,
          ),
          MemoryEntry(
            id: 'memory2',
            timestamp: DateTime.now().subtract(const Duration(days: 2)),
            source: 'notes',
            content: 'Programming is fun',
            causalLinks: [],
            type: MemoryType.explicit,
          ),
          MemoryEntry(
            id: 'memory3',
            timestamp: DateTime.now().subtract(const Duration(days: 3)),
            source: 'notes',
            content: 'I enjoy coding',
            causalLinks: [],
            type: MemoryType.explicit,
          ),
        ];

        when(mockMemoryRepository.getMemories(
          from: anyNamed('from'),
          limit: anyNamed('limit'),
        )).thenAnswer((_) async => recentMemories);

        when(mockEventBusService.publishEvent(any)).thenReturn(null);

        // Act
        await service._performAnalysis();

        // Assert
        verify(mockMemoryRepository.getMemories(
          from: anyNamed('from'),
          limit: anyNamed('limit'),
        )).called(1);
        verify(mockEventBusService.publishEvent(any)).called(greaterThan(0));
      });

      test('should handle empty memories gracefully', () async {
        // Arrange
        when(mockMemoryRepository.getMemories(
          from: anyNamed('from'),
          limit: anyNamed('limit'),
        )).thenAnswer((_) async => []);

        // Act
        await service._performAnalysis();

        // Assert
        verify(mockMemoryRepository.getMemories(
          from: anyNamed('from'),
          limit: anyNamed('limit'),
        )).called(1);
        verifyNever(mockEventBusService.publishEvent(any));
      });
    });

    group('_analyzeTemporalPatterns', () {
      test('should detect most active hour', () {
        // Arrange
        final memories = List.generate(10, (i) => MemoryEntry(
          id: 'memory$i',
          timestamp: DateTime(2024, 1, 1, 14, 0), // 2 PM
          source: 'notes',
          content: 'content $i',
          causalLinks: [],
          type: MemoryType.explicit,
        ));

        // Act
        final result = service._analyzeTemporalPatterns(memories);

        // Assert
        expect(result, isNotNull);
        expect(result!['insight'], contains('Most active during hour 14:00'));
        expect(result['confidence'], equals(0.7));
      });

      test('should return null for insufficient data', () {
        // Arrange
        final memories = [
          MemoryEntry(
            id: 'memory1',
            timestamp: DateTime.now(),
            source: 'notes',
            content: 'content',
            causalLinks: [],
            type: MemoryType.explicit,
          ),
        ];

        // Act
        final result = service._analyzeTemporalPatterns(memories);

        // Assert
        expect(result, isNull);
      });
    });

    group('_analyzeContentPatterns', () {
      test('should detect frequently mentioned topics', () {
        // Arrange
        final memories = [
          MemoryEntry(
            id: 'memory1',
            timestamp: DateTime.now(),
            source: 'notes',
            content: 'I love programming and coding',
            causalLinks: [],
            type: MemoryType.explicit,
          ),
          MemoryEntry(
            id: 'memory2',
            timestamp: DateTime.now(),
            source: 'notes',
            content: 'Programming is amazing',
            causalLinks: [],
            type: MemoryType.explicit,
          ),
          MemoryEntry(
            id: 'memory3',
            timestamp: DateTime.now(),
            source: 'notes',
            content: 'Coding makes me happy',
            causalLinks: [],
            type: MemoryType.explicit,
          ),
        ];

        // Act
        final result = service._analyzeContentPatterns(memories);

        // Assert
        expect(result, isNotNull);
        expect(result!['insight'], contains('Frequently mentioned topics'));
        expect(result['confidence'], equals(0.6));
      });

      test('should return null for insufficient patterns', () {
        // Arrange
        final memories = [
          MemoryEntry(
            id: 'memory1',
            timestamp: DateTime.now(),
            source: 'notes',
            content: 'short',
            causalLinks: [],
            type: MemoryType.explicit,
          ),
        ];

        // Act
        final result = service._analyzeContentPatterns(memories);

        // Assert
        expect(result, isNull);
      });
    });

    group('_analyzeEmotionalPatterns', () {
      test('should detect emotional patterns', () {
        // Arrange
        final memories = [
          MemoryEntry(
            id: 'memory1',
            timestamp: DateTime.now(),
            source: 'notes',
            content: 'I feel happy',
            causalLinks: [],
            type: MemoryType.emotional,
          ),
          MemoryEntry(
            id: 'memory2',
            timestamp: DateTime.now(),
            source: 'notes',
            content: 'I feel sad',
            causalLinks: [],
            type: MemoryType.emotional,
          ),
          MemoryEntry(
            id: 'memory3',
            timestamp: DateTime.now(),
            source: 'notes',
            content: 'I feel excited',
            causalLinks: [],
            type: MemoryType.emotional,
          ),
          MemoryEntry(
            id: 'memory4',
            timestamp: DateTime.now(),
            source: 'notes',
            content: 'I feel anxious',
            causalLinks: [],
            type: MemoryType.emotional,
          ),
        ];

        // Act
        final result = service._analyzeEmotionalPatterns(memories);

        // Assert
        expect(result, isNotNull);
        expect(result!['insight'], contains('Emotional patterns detected'));
        expect(result['confidence'], equals(0.5));
      });

      test('should return null for insufficient emotional data', () {
        // Arrange
        final memories = [
          MemoryEntry(
            id: 'memory1',
            timestamp: DateTime.now(),
            source: 'notes',
            content: 'I feel happy',
            causalLinks: [],
            type: MemoryType.emotional,
          ),
        ];

        // Act
        final result = service._analyzeEmotionalPatterns(memories);

        // Assert
        expect(result, isNull);
      });
    });
  });
}
