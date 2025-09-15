import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:ai_core/ai_core.dart';
import 'package:ai_llm/src/services/progressive_model_service.dart';
import 'package:ai_llm/src/repositories/model_storage_repository_impl.dart';
import 'package:ai_llm/src/datasources/download_client.dart';
import 'package:ai_llm/src/services/ai_router_service.dart';

import 'progressive_model_service_test.mocks.dart';

@GenerateMocks([
  ModelStorageRepository,
  DownloadClient,
  DeviceCapabilityDetector,
  NetworkDetector,
])
void main() {
  group('ProgressiveModelService', () {
    late ProgressiveModelService service;
    late MockModelStorageRepository mockStorage;
    late MockDownloadClient mockDownloadClient;
    late MockDeviceCapabilityDetector mockDeviceDetector;
    late MockNetworkDetector mockNetworkDetector;

    setUp(() {
      mockStorage = MockModelStorageRepository();
      mockDownloadClient = MockDownloadClient();
      mockDeviceDetector = MockDeviceCapabilityDetector();
      mockNetworkDetector = MockNetworkDetector();

      service = ProgressiveModelService(
        storage: mockStorage,
        downloadClient: mockDownloadClient,
        deviceDetector: mockDeviceDetector,
        networkDetector: mockNetworkDetector,
      );
    });

    group('Model Loading', () {
      test('should load optimal model when available', () async {
        // Arrange
        final mockSession = ModelSession(
          key: 'test-model',
          file: null,
          level: ModelLevel.mini,
          pinned: false,
        );
        final capability = DeviceCapability(
          ramGB: 6,
          storageGB: 10,
          cpuCores: 8,
          hasGpu: true,
          maxModelSize: 1000000000,
        );
        
        when(mockDeviceDetector.getCapability()).thenAnswer((_) async => capability);
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => [mockSession]);

        // Act
        final result = await service.loadOptimalModel();

        // Assert
        expect(result, equals(mockSession));
        verify(mockDeviceDetector.getCapability()).called(1);
        verify(mockStorage.getAvailableModels()).called(1);
      });

      test('should download recommended model when none available', () async {
        // Arrange
        final capability = DeviceCapability(
          ramGB: 6,
          storageGB: 10,
          cpuCores: 8,
          hasGpu: true,
          maxModelSize: 1000000000,
        );
        
        when(mockDeviceDetector.getCapability()).thenAnswer((_) async => capability);
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => []);
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => true);
        when(mockStorage.pinModel(any)).thenAnswer((_) async {});

        // Act
        final result = await service.loadOptimalModel();

        // Assert
        expect(result, isNotNull);
        verify(mockStorage.pinModel(any)).called(1);
      });

      test('should throw exception when device cannot handle model', () async {
        // Arrange
        final capability = DeviceCapability(
          ramGB: 2,
          storageGB: 1,
          cpuCores: 2,
          hasGpu: false,
          maxModelSize: 50000000, // 50MB limit
        );
        
        when(mockDeviceDetector.getCapability()).thenAnswer((_) async => capability);
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => []);
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => true);

        // Act & Assert
        expect(
          () => service.loadOptimalModel(),
          throwsA(isA<ProgressiveModelException>()),
        );
      });
    });

    group('Model Download', () {
      test('should download model successfully', () async {
        // Arrange
        final capability = DeviceCapability(
          ramGB: 6,
          storageGB: 10,
          cpuCores: 8,
          hasGpu: true,
          maxModelSize: 1000000000,
        );
        
        when(mockDeviceDetector.getCapability()).thenAnswer((_) async => capability);
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => true);
        when(mockStorage.pinModel(any)).thenAnswer((_) async {});

        // Act
        final result = await service.downloadModel(ModelLevel.mini);

        // Assert
        expect(result, isNotNull);
        verify(mockStorage.pinModel(any)).called(1);
      });

      test('should throw exception when no network', () async {
        // Arrange
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => false);

        // Act & Assert
        expect(
          () => service.downloadModel(ModelLevel.mini),
          throwsA(isA<ProgressiveModelException>()),
        );
      });

      test('should throw exception when insufficient storage', () async {
        // Arrange
        final capability = DeviceCapability(
          ramGB: 6,
          storageGB: 1, // Low storage
          cpuCores: 8,
          hasGpu: true,
          maxModelSize: 1000000000,
        );
        
        when(mockDeviceDetector.getCapability()).thenAnswer((_) async => capability);
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => true);

        // Act & Assert
        expect(
          () => service.downloadModel(ModelLevel.full),
          throwsA(isA<ProgressiveModelException>()),
        );
      });

      test('should throw exception when already downloading', () async {
        // Arrange
        final capability = DeviceCapability(
          ramGB: 6,
          storageGB: 10,
          cpuCores: 8,
          hasGpu: true,
          maxModelSize: 1000000000,
        );
        
        when(mockDeviceDetector.getCapability()).thenAnswer((_) async => capability);
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => true);
        when(mockStorage.pinModel(any)).thenAnswer((_) async {});

        // Start first download
        service.downloadModel(ModelLevel.mini);

        // Act & Assert
        expect(
          () => service.downloadModel(ModelLevel.mini),
          throwsA(isA<ProgressiveModelException>()),
        );
      });
    });

    group('Download Progress', () {
      test('should provide download progress stream', () async {
        // Arrange
        final capability = DeviceCapability(
          ramGB: 6,
          storageGB: 10,
          cpuCores: 8,
          hasGpu: true,
          maxModelSize: 1000000000,
        );
        
        when(mockDeviceDetector.getCapability()).thenAnswer((_) async => capability);
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => true);
        when(mockStorage.pinModel(any)).thenAnswer((_) async {});

        // Act
        final progressStream = service.getDownloadProgress(ModelLevel.mini);
        final downloadFuture = service.downloadModel(ModelLevel.mini);

        // Assert
        expect(progressStream, isNotNull);
        // Note: In a real test, you would listen to the stream and verify progress updates
        await downloadFuture;
      });
    });

    group('Model Recommendations', () {
      test('should provide model recommendations', () {
        // Act
        final recommendations = service.getModelRecommendations();

        // Assert
        expect(recommendations, isNotEmpty);
        expect(recommendations.length, equals(ModelLevel.values.length));
        
        // Check that each model level has a recommendation
        for (final level in ModelLevel.values) {
          expect(recommendations.any((r) => r.level == level), isTrue);
        }
      });

      test('should have correct recommendation priorities', () {
        // Act
        final recommendations = service.getModelRecommendations();

        // Assert
        final miniRecommendation = recommendations.firstWhere((r) => r.level == ModelLevel.mini);
        final tinyRecommendation = recommendations.firstWhere((r) => r.level == ModelLevel.tiny);
        final fullRecommendation = recommendations.firstWhere((r) => r.level == ModelLevel.full);

        expect(miniRecommendation.priority, lessThan(tinyRecommendation.priority));
        expect(tinyRecommendation.priority, lessThan(fullRecommendation.priority));
      });
    });

    group('Device Suitability', () {
      test('should check if model is suitable for device', () async {
        // Arrange
        final capability = DeviceCapability(
          ramGB: 6,
          storageGB: 10,
          cpuCores: 8,
          hasGpu: true,
          maxModelSize: 1000000000,
        );
        
        when(mockDeviceDetector.getCapability()).thenAnswer((_) async => capability);

        // Act
        final isTinySuitable = await service.isModelSuitable(ModelLevel.tiny);
        final isFullSuitable = await service.isModelSuitable(ModelLevel.full);

        // Assert
        expect(isTinySuitable, isTrue);
        expect(isFullSuitable, isTrue);
      });

      test('should return false for unsuitable models', () async {
        // Arrange
        final capability = DeviceCapability(
          ramGB: 2,
          storageGB: 1,
          cpuCores: 2,
          hasGpu: false,
          maxModelSize: 50000000, // 50MB limit
        );
        
        when(mockDeviceDetector.getCapability()).thenAnswer((_) async => capability);

        // Act
        final isFullSuitable = await service.isModelSuitable(ModelLevel.full);

        // Assert
        expect(isFullSuitable, isFalse);
      });
    });

    group('Download Statistics', () {
      test('should provide download statistics', () {
        // Act
        final stats = service.getDownloadStatistics();

        // Assert
        expect(stats.totalDownloads, equals(0));
        expect(stats.activeDownloads, equals(0));
        expect(stats.completedDownloads, equals(0));
        expect(stats.failedDownloads, equals(0));
      });
    });

    group('Cleanup', () {
      test('should cleanup completed downloads', () async {
        // Arrange
        final capability = DeviceCapability(
          ramGB: 6,
          storageGB: 10,
          cpuCores: 8,
          hasGpu: true,
          maxModelSize: 1000000000,
        );
        
        when(mockDeviceDetector.getCapability()).thenAnswer((_) async => capability);
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => true);
        when(mockStorage.pinModel(any)).thenAnswer((_) async {});

        // Start and complete a download
        await service.downloadModel(ModelLevel.tiny);

        // Act
        await service.cleanupCompletedDownloads();

        // Assert
        final stats = service.getDownloadStatistics();
        expect(stats.totalDownloads, equals(0));
      });
    });
  });
}
