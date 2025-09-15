import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:ai_core/ai_core.dart';
import 'package:ai_llm/src/services/ai_router_service.dart';
import 'package:ai_llm/src/services/progressive_model_service.dart';
import 'package:ai_llm/src/services/device_capability_detector.dart';
import 'package:ai_llm/src/services/network_detector.dart';
import 'package:ai_llm/src/datasources/on_device_model_service.dart';
import 'package:ai_llm/src/datasources/adaptive_health_monitor.dart';
import 'package:ai_llm/src/repositories/model_storage_repository_impl.dart';

import 'ai_system_integration_test.mocks.dart';

@GenerateMocks([
  ModelStorageRepository,
  DownloadClient,
  AIService,
])
void main() {
  group('AI System Integration Tests', () {
    late AIRouterService aiRouter;
    late ProgressiveModelService progressiveModel;
    late DeviceCapabilityDetector deviceDetector;
    late NetworkDetector networkDetector;
    late OnDeviceModelService onDeviceService;
    late AdaptiveHealthMonitor healthMonitor;
    late MockModelStorageRepository mockStorage;
    late MockDownloadClient mockDownloadClient;
    late MockAIService mockCloudService;

    setUp(() {
      mockStorage = MockModelStorageRepository();
      mockDownloadClient = MockDownloadClient();
      mockCloudService = MockAIService();
      
      healthMonitor = AdaptiveHealthMonitor();
      onDeviceService = OnDeviceModelService(mockStorage, healthMonitor);
      deviceDetector = DeviceCapabilityDetector();
      networkDetector = NetworkDetector();
      
      aiRouter = AIRouterService(
        onDeviceService: onDeviceService,
        cloudService: mockCloudService,
        healthMonitor: healthMonitor,
        networkDetector: networkDetector,
        deviceDetector: deviceDetector,
      );
      
      progressiveModel = ProgressiveModelService(
        storage: mockStorage,
        downloadClient: mockDownloadClient,
        deviceDetector: deviceDetector,
        networkDetector: networkDetector,
      );
    });

    group('Complete AI Workflow', () {
      test('should handle complete AI workflow from initialization to response', () async {
        // Arrange
        final capability = DeviceCapability(
          ramGB: 6,
          storageGB: 10,
          cpuCores: 8,
          hasGpu: true,
          maxModelSize: 1000000000,
        );
        
        final mockSession = ModelSession(
          key: 'test-model',
          file: null,
          level: ModelLevel.mini,
          pinned: false,
        );
        
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => [mockSession]);
        when(mockStorage.pinModel(any)).thenAnswer((_) async {});
        when(mockCloudService.generateResponse(any)).thenAnswer((_) async => 'Cloud response');

        // Act
        // 1. Initialize on-device service
        final onDeviceInitialized = await onDeviceService.initialize();
        expect(onDeviceInitialized, isTrue);

        // 2. Get device capability
        final detectedCapability = await deviceDetector.getCapability();
        expect(detectedCapability.ramGB, greaterThan(0));

        // 3. Check network connectivity
        final isConnected = await networkDetector.isConnected;
        expect(isConnected, isA<bool>());

        // 4. Route AI request
        final response = await aiRouter.routeRequest('Test prompt', AITaskType.quickResponse);
        expect(response, isA<String>());
        expect(response.isNotEmpty, isTrue);

        // 5. Check health status
        final healthSnapshot = healthMonitor.snapshot();
        expect(healthSnapshot, isA<HealthSnapshot>());
        expect(healthSnapshot.totalSamples, greaterThan(0));

        // Verify interactions
        verify(mockStorage.getAvailableModels()).called(1);
        verify(mockStorage.pinModel(any)).called(1);
      });

      test('should handle model download workflow', () async {
        // Arrange
        final capability = DeviceCapability(
          ramGB: 6,
          storageGB: 10,
          cpuCores: 8,
          hasGpu: true,
          maxModelSize: 1000000000,
        );
        
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => []);
        when(mockStorage.pinModel(any)).thenAnswer((_) async {});
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => true);

        // Act
        // 1. Load optimal model (should trigger download)
        final optimalModel = await progressiveModel.loadOptimalModel();
        expect(optimalModel, isNotNull);

        // 2. Check download progress
        final progressStream = progressiveModel.getDownloadProgress(ModelLevel.mini);
        expect(progressStream, isNotNull);

        // 3. Get model recommendations
        final recommendations = progressiveModel.getModelRecommendations();
        expect(recommendations, isNotEmpty);

        // 4. Check if model is suitable
        final isSuitable = await progressiveModel.isModelSuitable(ModelLevel.mini);
        expect(isSuitable, isTrue);

        // Verify interactions
        verify(mockStorage.getAvailableModels()).called(1);
        verify(mockStorage.pinModel(any)).called(1);
      });

      test('should handle network-aware routing', () async {
        // Arrange
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => []);
        when(mockCloudService.generateResponse(any)).thenAnswer((_) async => 'Cloud response');

        // Act
        // 1. Test with network available
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => true);
        final responseWithNetwork = await aiRouter.routeRequest('Test prompt', AITaskType.quickResponse);
        expect(responseWithNetwork, isA<String>());

        // 2. Test with no network
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => false);
        final responseWithoutNetwork = await aiRouter.routeRequest('Test prompt', AITaskType.quickResponse);
        expect(responseWithoutNetwork, isA<String>());

        // 3. Test network quality
        final networkQuality = await networkDetector.getNetworkQuality();
        expect(networkQuality, inInclusiveRange(0, 100));

        // 4. Test AI suitability
        final isSuitableForAI = await networkDetector.isSuitableForAI();
        expect(isSuitableForAI, isA<bool>());

        // Verify interactions
        verify(mockCloudService.generateResponse(any)).called(2);
      });
    });

    group('Error Handling and Recovery', () {
      test('should handle on-device service failures gracefully', () async {
        // Arrange
        when(mockStorage.getAvailableModels()).thenThrow(Exception('Storage error'));
        when(mockCloudService.generateResponse(any)).thenAnswer((_) async => 'Cloud fallback');

        // Act
        final response = await aiRouter.routeRequest('Test prompt', AITaskType.quickResponse);
        
        // Assert
        expect(response, equals('Cloud fallback'));
        verify(mockCloudService.generateResponse(any)).called(1);
      });

      test('should handle network failures gracefully', () async {
        // Arrange
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => false);
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => []);
        when(mockCloudService.generateResponse(any)).thenAnswer((_) async => 'Cloud response');

        // Act
        final response = await aiRouter.routeRequest('Test prompt', AITaskType.quickResponse);
        
        // Assert
        expect(response, isA<String>());
        expect(response.isNotEmpty, isTrue);
      });

      test('should handle device capability limitations', () async {
        // Arrange
        final limitedCapability = DeviceCapability(
          ramGB: 1,
          storageGB: 1,
          cpuCores: 1,
          hasGpu: false,
          maxModelSize: 50000000, // 50MB limit
        );
        
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => []);
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => true);

        // Act & Assert
        expect(
          () => progressiveModel.downloadModel(ModelLevel.full),
          throwsA(isA<ProgressiveModelException>()),
        );
      });
    });

    group('Performance and Health Monitoring', () {
      test('should track performance metrics correctly', () async {
        // Arrange
        final mockSession = ModelSession(
          key: 'test-model',
          file: null,
          level: ModelLevel.mini,
          pinned: false,
        );
        
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => [mockSession]);
        when(mockStorage.pinModel(any)).thenAnswer((_) async {});

        // Act
        await onDeviceService.initialize();
        
        // Simulate multiple requests
        for (int i = 0; i < 10; i++) {
          try {
            await onDeviceService.generateResponse('Test prompt $i');
          } catch (e) {
            // Expected for simulation
          }
        }

        // Assert
        final healthSnapshot = healthMonitor.snapshot();
        expect(healthSnapshot.totalSamples, equals(10));
        expect(healthSnapshot.successRate, inInclusiveRange(0.0, 1.0));
        expect(healthSnapshot.p50LatencyMs, greaterThan(0));
        expect(healthSnapshot.p95LatencyMs, greaterThanOrEqualTo(healthSnapshot.p50LatencyMs));
      });

      test('should provide health recommendations', () async {
        // Arrange
        final mockSession = ModelSession(
          key: 'test-model',
          file: null,
          level: ModelLevel.mini,
          pinned: false,
        );
        
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => [mockSession]);
        when(mockStorage.pinModel(any)).thenAnswer((_) async {});

        // Act
        await onDeviceService.initialize();
        
        // Simulate poor performance
        for (int i = 0; i < 5; i++) {
          healthMonitor.record(false, 5000); // Failures with high latency
        }

        // Assert
        final healthReport = healthMonitor.getDetailedReport();
        expect(healthReport.recommendations, isNotEmpty);
        expect(healthReport.snapshot.isHealthy, isFalse);
      });
    });

    group('State Management and Persistence', () {
      test('should maintain state across operations', () async {
        // Arrange
        final mockSession = ModelSession(
          key: 'test-model',
          file: null,
          level: ModelLevel.mini,
          pinned: false,
        );
        
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => [mockSession]);
        when(mockStorage.pinModel(any)).thenAnswer((_) async {});

        // Act
        await onDeviceService.initialize();
        
        // Verify initial state
        expect(onDeviceService.isAvailable, isTrue);
        expect(onDeviceService.currentModel, isNotEmpty);
        
        // Perform operations
        await onDeviceService.generateResponse('Test prompt');
        
        // Verify state is maintained
        expect(onDeviceService.isAvailable, isTrue);
        expect(onDeviceService.currentModel, isNotEmpty);
      });

      test('should handle service disposal correctly', () async {
        // Arrange
        final mockSession = ModelSession(
          key: 'test-model',
          file: null,
          level: ModelLevel.mini,
          pinned: false,
        );
        
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => [mockSession]);
        when(mockStorage.pinModel(any)).thenAnswer((_) async {});

        // Act
        await onDeviceService.initialize();
        expect(onDeviceService.isAvailable, isTrue);
        
        onDeviceService.dispose();
        
        // Assert
        expect(onDeviceService.isAvailable, isFalse);
        expect(onDeviceService.status, equals('Disposed'));
      });
    });

    group('Concurrent Operations', () {
      test('should handle concurrent AI requests', () async {
        // Arrange
        final mockSession = ModelSession(
          key: 'test-model',
          file: null,
          level: ModelLevel.mini,
          pinned: false,
        );
        
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => [mockSession]);
        when(mockStorage.pinModel(any)).thenAnswer((_) async {});

        // Act
        await onDeviceService.initialize();
        
        // Start multiple concurrent requests
        final futures = List.generate(5, (index) => 
          onDeviceService.generateResponse('Concurrent test $index')
        );
        
        final results = await Future.wait(futures);
        
        // Assert
        expect(results, hasLength(5));
        expect(results.every((result) => result.isNotEmpty), isTrue);
      });

      test('should handle concurrent model downloads', () async {
        // Arrange
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => []);
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => true);
        when(mockStorage.pinModel(any)).thenAnswer((_) async {});

        // Act
        final futures = [
          progressiveModel.downloadModel(ModelLevel.tiny),
          progressiveModel.downloadModel(ModelLevel.mini),
        ];
        
        final results = await Future.wait(futures);
        
        // Assert
        expect(results, hasLength(2));
        expect(results.every((result) => result != null), isTrue);
      });
    });

    group('Resource Management', () {
      test('should manage memory efficiently', () async {
        // Arrange
        final mockSession = ModelSession(
          key: 'test-model',
          file: null,
          level: ModelLevel.mini,
          pinned: false,
        );
        
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => [mockSession]);
        when(mockStorage.pinModel(any)).thenAnswer((_) async {});

        // Act
        await onDeviceService.initialize();
        
        // Perform many operations
        for (int i = 0; i < 100; i++) {
          try {
            await onDeviceService.generateResponse('Memory test $i');
          } catch (e) {
            // Expected for simulation
          }
        }
        
        // Cleanup
        onDeviceService.dispose();
        
        // Assert - should not throw or crash
        expect(onDeviceService.isAvailable, isFalse);
      });

      test('should handle cleanup of completed downloads', () async {
        // Arrange
        when(mockStorage.getAvailableModels()).thenAnswer((_) async => []);
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => true);
        when(mockStorage.pinModel(any)).thenAnswer((_) async {});

        // Act
        await progressiveModel.downloadModel(ModelLevel.tiny);
        await progressiveModel.cleanupCompletedDownloads();
        
        // Assert
        final stats = progressiveModel.getDownloadStatistics();
        expect(stats.totalDownloads, equals(0));
      });
    });
  });
}
