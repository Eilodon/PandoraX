import 'package:flutter_test/flutter_test.dart';
import 'package:cac_data/cac_data.dart';

void main() {
  group('CAC Data Package', () {
    test('should export all necessary classes', () {
      // Test that all main classes are accessible
      expect(MemoryRepositoryImpl, isNotNull);
      expect(EventBusServiceImpl, isNotNull);
      expect(IsarWriteQueueService, isNotNull);
      expect(IsarMemoryDatasource, isNotNull);
      expect(VectorSearchDatasource, isNotNull);
      expect(NightlyAnalysisService, isNotNull);
    });

    test('should have proper dependency injection setup', () {
      // Test that configureDependencies function exists
      expect(configureDependencies, isNotNull);
    });
  });
}
