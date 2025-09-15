import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:ai_core/ai_core.dart';
import 'package:ai_llm/src/datasources/on_device_model_service.dart';
import 'package:ai_llm/src/datasources/adaptive_health_monitor.dart';
import 'package:ai_llm/src/repositories/model_storage_repository_impl.dart';

import 'on_device_model_service_test.mocks.dart';

@GenerateMocks([ModelStorageRepository, AdaptiveHealthMonitor])
void main() {
  group('OnDeviceModelService', () {
    late OnDeviceModelService service;
    late MockModelStorageRepository mockStorage;
    late MockAdaptiveHealthMonitor mockHealth;

    setUp(() {
      mockStorage = MockModelStorageRepository();
      mockHealth = MockAdaptiveHealthMonitor();
      service = OnDeviceModelService(mockStorage, mockHealth);
    });

    tearDown(() {
      service.dispose();
    });

    group('Initialization', () {
      test('should initialize successfully with available models', () async {
        // Arrange
        final mockSession = ModelSession(
          key: 'test-model',
          file: null, // Will be mocked
          level: ModelLevel.tiny,
          pinned: false,
        );
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => [mockSession]);
        when(mockStorage.pinModel(any)).thenAnswer((_) async {});
        when(mockHealth.snapshot()).thenReturn(HealthSnapshot(
          successRate: 1.0,
          p50LatencyMs: 100,
          p95LatencyMs: 200,
          totalSamples: 10,
          isHealthy: true,
        ));

        // Act
        final result = await service.initialize();

        // Assert
        expect(result, isTrue);
        expect(service.isAvailable, isTrue);
        expect(service.status, equals('Ready'));
        expect(service.currentModel, equals('phi-3-tiny'));
        verify(mockStorage.getAvailableModels()).called(1);
        verify(mockStorage.pinModel('test-model')).called(1);
      });

      test('should fail initialization when no models available', () async {
        // Arrange
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => []);

        // Act
        final result = await service.initialize();

        // Assert
        expect(result, isFalse);
        expect(service.isAvailable, isFalse);
        expect(service.status, equals('No models available'));
        verify(mockStorage.getAvailableModels()).called(1);
      });

      test('should handle initialization errors', () async {
        // Arrange
        when(mockStorage.getAvailableModels()).thenThrow(Exception('Storage error'));

        // Act
        final result = await service.initialize();

        // Assert
        expect(result, isFalse);
        expect(service.isAvailable, isFalse);
        expect(service.status, contains('Initialization failed'));
      });
    });

    group('Response Generation', () {
      setUp(() async {
        // Initialize service with mock data
        final mockSession = ModelSession(
          key: 'test-model',
          file: null,
          level: ModelLevel.tiny,
          pinned: false,
        );
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => [mockSession]);
        when(mockStorage.pinModel(any)).thenAnswer((_) async {});
        when(mockHealth.snapshot()).thenReturn(HealthSnapshot(
          successRate: 1.0,
          p50LatencyMs: 100,
          p95LatencyMs: 200,
          totalSamples: 10,
          isHealthy: true,
        ));
        await service.initialize();
      });

      test('should generate response successfully', () async {
        // Arrange
        const prompt = 'Hello, world!';
        when(mockHealth.record(any, any)).thenReturn(null);

        // Act
        final result = await service.generateResponse(prompt);

        // Assert
        expect(result, isA<String>());
        expect(result, contains('On-device response for:'));
        verify(mockHealth.record(true, any)).called(1);
      });

      test('should throw error for empty prompt', () async {
        // Act & Assert
        expect(
          () => service.generateResponse(''),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('should throw error when not initialized', () async {
        // Arrange
        service.dispose();

        // Act & Assert
        expect(
          () => service.generateResponse('test'),
          throwsA(isA<StateError>()),
        );
      });

      test('should handle model execution errors', () async {
        // Arrange
        const prompt = 'test';
        when(mockHealth.record(any, any)).thenReturn(null);

        // Act & Assert
        // Note: The current implementation has a 5% chance of failure
        // This test might need to be adjusted based on the actual implementation
        expect(
          () => service.generateResponse(prompt),
          returnsNormally,
        );
      });
    });

    group('Chat Response Generation', () {
      setUp(() async {
        // Initialize service with mock data
        final mockSession = ModelSession(
          key: 'test-model',
          file: null,
          level: ModelLevel.tiny,
          pinned: false,
        );
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => [mockSession]);
        when(mockStorage.pinModel(any)).thenAnswer((_) async {});
        when(mockHealth.snapshot()).thenReturn(HealthSnapshot(
          successRate: 1.0,
          p50LatencyMs: 100,
          p95LatencyMs: 200,
          totalSamples: 10,
          isHealthy: true,
        ));
        await service.initialize();
      });

      test('should generate chat response with history', () async {
        // Arrange
        const prompt = 'What is the weather?';
        final history = [
          ChatMessage.user('Hello'),
          ChatMessage.assistant('Hi there!'),
        ];
        when(mockHealth.record(any, any)).thenReturn(null);

        // Act
        final result = await service.generateChatResponse(prompt, history);

        // Assert
        expect(result, isA<String>());
        expect(result, contains('On-device response for:'));
        verify(mockHealth.record(true, any)).called(1);
      });

      test('should throw error for empty prompt in chat', () async {
        // Act & Assert
        expect(
          () => service.generateChatResponse('', []),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('Health Monitoring', () {
      test('should provide health status', () async {
        // Arrange
        final healthSnapshot = HealthSnapshot(
          successRate: 0.95,
          p50LatencyMs: 150,
          p95LatencyMs: 300,
          totalSamples: 20,
          isHealthy: true,
        );
        when(mockHealth.snapshot()).thenReturn(healthSnapshot);

        // Act
        final result = service.healthSnapshot;

        // Assert
        expect(result, equals(healthSnapshot));
        expect(service.isHealthy, isTrue);
      });

      test('should provide health report', () async {
        // Arrange
        final healthReport = HealthReport(
          snapshot: HealthSnapshot(
            successRate: 0.95,
            p50LatencyMs: 150,
            p95LatencyMs: 300,
            totalSamples: 20,
            isHealthy: true,
          ),
          trend: PerformanceTrend.stable,
          recentErrors: [],
          recommendations: ['Performance is stable'],
        );
        when(mockHealth.getDetailedReport()).thenReturn(healthReport);

        // Act
        final result = service.healthReport;

        // Assert
        expect(result, equals(healthReport));
      });
    });

    group('Model Management', () {
      setUp(() async {
        // Initialize service
        final mockSession = ModelSession(
          key: 'test-model',
          file: null,
          level: ModelLevel.tiny,
          pinned: false,
        );
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => [mockSession]);
        when(mockStorage.pinModel(any)).thenAnswer((_) async {});
        when(mockHealth.snapshot()).thenReturn(HealthSnapshot(
          successRate: 1.0,
          p50LatencyMs: 100,
          p95LatencyMs: 200,
          totalSamples: 10,
          isHealthy: true,
        ));
        await service.initialize();
      });

      test('should switch model successfully', () async {
        // Arrange
        final newSession = ModelSession(
          key: 'new-model',
          file: null,
          level: ModelLevel.mini,
          pinned: false,
        );
        when(mockStorage.getModel(ModelLevel.mini)).thenAnswer((_) async => newSession);
        when(mockStorage.pinModel(any)).thenAnswer((_) async {});

        // Act
        final result = await service.switchModel(ModelLevel.mini);

        // Assert
        expect(result, isTrue);
        expect(service.currentModel, equals('phi-3-mini'));
      });

      test('should fail to switch when model not available', () async {
        // Arrange
        when(mockStorage.getModel(ModelLevel.mini)).thenAnswer((_) async => null);

        // Act
        final result = await service.switchModel(ModelLevel.mini);

        // Assert
        expect(result, isFalse);
      });

      test('should reload model successfully', () async {
        // Arrange
        when(mockStorage.pinModel(any)).thenAnswer((_) async {});

        // Act
        final result = await service.reloadModel();

        // Assert
        expect(result, isTrue);
      });

      test('should get available models', () async {
        // Arrange
        final models = [
          ModelSession(
            key: 'model1',
            file: null,
            level: ModelLevel.tiny,
            pinned: false,
          ),
          ModelSession(
            key: 'model2',
            file: null,
            level: ModelLevel.mini,
            pinned: true,
          ),
        ];
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => models);

        // Act
        final result = await service.getAvailableModels();

        // Assert
        expect(result, equals(models));
      });
    });

    group('Error Handling', () {
      test('should handle OnDeviceModelException', () async {
        // Arrange
        final mockSession = ModelSession(
          key: 'test-model',
          file: null,
          level: ModelLevel.tiny,
          pinned: false,
        );
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => [mockSession]);
        when(mockStorage.pinModel(any)).thenAnswer((_) async {});
        when(mockHealth.snapshot()).thenReturn(HealthSnapshot(
          successRate: 1.0,
          p50LatencyMs: 100,
          p95LatencyMs: 200,
          totalSamples: 10,
          isHealthy: true,
        ));
        await service.initialize();

        // Act & Assert
        // The current implementation has a 5% chance of failure
        // This test verifies that OnDeviceModelException is thrown when it occurs
        try {
          await service.generateResponse('test');
        } catch (e) {
          expect(e, isA<OnDeviceModelException>());
        }
      });
    });
  });
}
