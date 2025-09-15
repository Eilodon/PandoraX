import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:ai_core/ai_core.dart';
import 'package:ai_llm/src/services/ai_router_service.dart';
import 'package:ai_llm/src/datasources/on_device_model_service.dart';
import 'package:ai_llm/src/datasources/adaptive_health_monitor.dart';

import 'ai_router_service_test.mocks.dart';

@GenerateMocks([
  OnDeviceModelService,
  AIService,
  AdaptiveHealthMonitor,
  NetworkDetector,
  DeviceCapabilityDetector,
])
void main() {
  group('AIRouterService', () {
    late AIRouterService router;
    late MockOnDeviceModelService mockOnDeviceService;
    late MockAIService mockCloudService;
    late MockAdaptiveHealthMonitor mockHealthMonitor;
    late MockNetworkDetector mockNetworkDetector;
    late MockDeviceCapabilityDetector mockDeviceDetector;

    setUp(() {
      mockOnDeviceService = MockOnDeviceModelService();
      mockCloudService = MockAIService();
      mockHealthMonitor = MockAdaptiveHealthMonitor();
      mockNetworkDetector = MockNetworkDetector();
      mockDeviceDetector = MockDeviceCapabilityDetector();

      router = AIRouterService(
        onDeviceService: mockOnDeviceService,
        cloudService: mockCloudService,
        healthMonitor: mockHealthMonitor,
        networkDetector: mockNetworkDetector,
        deviceDetector: mockDeviceDetector,
      );
    });

    group('Routing Logic', () {
      test('should route to on-device when available and healthy', () async {
        // Arrange
        when(mockOnDeviceService.isAvailable).thenReturn(true);
        when(mockOnDeviceService.isHealthy).thenReturn(true);
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => true);
        when(mockDeviceDetector.getCapability()).thenAnswer((_) async => DeviceCapability(
          ramGB: 6,
          storageGB: 10,
          cpuCores: 8,
          hasGpu: true,
          maxModelSize: 1000000000,
        ));
        when(mockOnDeviceService.generateResponse(any)).thenAnswer((_) async => 'On-device response');
        when(mockHealthMonitor.snapshot()).thenReturn(HealthSnapshot(
          successRate: 0.9,
          p50LatencyMs: 100,
          p95LatencyMs: 200,
          totalSamples: 10,
          isHealthy: true,
        ));

        // Act
        final result = await router.routeRequest('Test prompt', AITaskType.quickResponse);

        // Assert
        expect(result, equals('On-device response'));
        verify(mockOnDeviceService.generateResponse('Test prompt')).called(1);
        verifyNever(mockCloudService.generateResponse(any));
      });

      test('should route to cloud when on-device is unhealthy', () async {
        // Arrange
        when(mockOnDeviceService.isAvailable).thenReturn(true);
        when(mockOnDeviceService.isHealthy).thenReturn(false);
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => true);
        when(mockCloudService.generateResponse(any)).thenAnswer((_) async => 'Cloud response');
        when(mockHealthMonitor.snapshot()).thenReturn(HealthSnapshot(
          successRate: 0.5,
          p50LatencyMs: 1000,
          p95LatencyMs: 2000,
          totalSamples: 10,
          isHealthy: false,
        ));

        // Act
        final result = await router.routeRequest('Test prompt', AITaskType.quickResponse);

        // Assert
        expect(result, equals('Cloud response'));
        verify(mockCloudService.generateResponse('Test prompt')).called(1);
        verifyNever(mockOnDeviceService.generateResponse(any));
      });

      test('should route to on-device when no network', () async {
        // Arrange
        when(mockOnDeviceService.isAvailable).thenReturn(true);
        when(mockOnDeviceService.isHealthy).thenReturn(true);
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => false);
        when(mockOnDeviceService.generateResponse(any)).thenAnswer((_) async => 'On-device response');

        // Act
        final result = await router.routeRequest('Test prompt', AITaskType.quickResponse);

        // Assert
        expect(result, equals('On-device response'));
        verify(mockOnDeviceService.generateResponse('Test prompt')).called(1);
        verifyNever(mockCloudService.generateResponse(any));
      });

      test('should route to cloud when on-device not available', () async {
        // Arrange
        when(mockOnDeviceService.isAvailable).thenReturn(false);
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => true);
        when(mockCloudService.generateResponse(any)).thenAnswer((_) async => 'Cloud response');

        // Act
        final result = await router.routeRequest('Test prompt', AITaskType.quickResponse);

        // Assert
        expect(result, equals('Cloud response'));
        verify(mockCloudService.generateResponse('Test prompt')).called(1);
        verifyNever(mockOnDeviceService.generateResponse(any));
      });
    });

    group('Chat Routing', () {
      test('should route chat to on-device when available', () async {
        // Arrange
        final history = [ChatMessage.user('Hello'), ChatMessage.assistant('Hi')];
        when(mockOnDeviceService.isAvailable).thenReturn(true);
        when(mockOnDeviceService.isHealthy).thenReturn(true);
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => true);
        when(mockDeviceDetector.getCapability()).thenAnswer((_) async => DeviceCapability(
          ramGB: 6,
          storageGB: 10,
          cpuCores: 8,
          hasGpu: true,
          maxModelSize: 1000000000,
        ));
        when(mockOnDeviceService.generateChatResponse(any, any)).thenAnswer((_) async => 'Chat response');
        when(mockHealthMonitor.snapshot()).thenReturn(HealthSnapshot(
          successRate: 0.9,
          p50LatencyMs: 100,
          p95LatencyMs: 200,
          totalSamples: 10,
          isHealthy: true,
        ));

        // Act
        final result = await router.routeChatRequest('Test prompt', history, AITaskType.realTimeChat);

        // Assert
        expect(result, equals('Chat response'));
        verify(mockOnDeviceService.generateChatResponse('Test prompt', history)).called(1);
        verifyNever(mockCloudService.generateChatResponse(any, any));
      });
    });

    group('Fallback Handling', () {
      test('should fallback to cloud when on-device fails', () async {
        // Arrange
        when(mockOnDeviceService.isAvailable).thenReturn(true);
        when(mockOnDeviceService.isHealthy).thenReturn(true);
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => true);
        when(mockDeviceDetector.getCapability()).thenAnswer((_) async => DeviceCapability(
          ramGB: 6,
          storageGB: 10,
          cpuCores: 8,
          hasGpu: true,
          maxModelSize: 1000000000,
        ));
        when(mockOnDeviceService.generateResponse(any)).thenThrow(Exception('On-device error'));
        when(mockCloudService.generateResponse(any)).thenAnswer((_) async => 'Cloud fallback response');

        // Act
        final result = await router.routeRequest('Test prompt', AITaskType.quickResponse);

        // Assert
        expect(result, equals('Cloud fallback response'));
        verify(mockOnDeviceService.generateResponse('Test prompt')).called(1);
        verify(mockCloudService.generateResponse('Test prompt')).called(1);
      });

      test('should throw exception when both services fail', () async {
        // Arrange
        when(mockOnDeviceService.isAvailable).thenReturn(true);
        when(mockOnDeviceService.isHealthy).thenReturn(true);
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => false); // No fallback
        when(mockOnDeviceService.generateResponse(any)).thenThrow(Exception('On-device error'));

        // Act & Assert
        expect(
          () => router.routeRequest('Test prompt', AITaskType.quickResponse),
          throwsA(isA<AIRoutingException>()),
        );
      });
    });

    group('Routing Status', () {
      test('should provide correct routing status', () async {
        // Arrange
        when(mockOnDeviceService.isAvailable).thenReturn(true);
        when(mockOnDeviceService.isHealthy).thenReturn(true);
        when(mockOnDeviceService.currentModel).thenReturn('phi-3-mini');
        when(mockNetworkDetector.isConnected).thenAnswer((_) async => true);
        when(mockHealthMonitor.snapshot()).thenReturn(HealthSnapshot(
          successRate: 0.9,
          p50LatencyMs: 100,
          p95LatencyMs: 200,
          totalSamples: 10,
          isHealthy: true,
        ));

        // Act
        final status = router.routingStatus;

        // Assert
        expect(status.isUsingOnDevice, isFalse); // Initially false
        expect(status.currentModel, equals('None'));
        expect(status.networkStatus, isTrue);
      });
    });

    group('Recommendations', () {
      test('should provide routing recommendations', () {
        // Arrange
        when(mockHealthMonitor.snapshot()).thenReturn(HealthSnapshot(
          successRate: 0.5, // Low success rate
          p50LatencyMs: 100,
          p95LatencyMs: 200,
          totalSamples: 10,
          isHealthy: false,
        ));
        when(mockOnDeviceService.isAvailable).thenReturn(true);

        // Act
        final recommendations = router.getRoutingRecommendations();

        // Assert
        expect(recommendations, isNotEmpty);
        expect(recommendations.any((r) => r.type == RecommendationType.switchToCloud), isTrue);
      });
    });

    group('Force Switching', () {
      test('should force switch to on-device', () async {
        // Arrange
        when(mockOnDeviceService.isAvailable).thenReturn(true);
        when(mockOnDeviceService.currentModel).thenReturn('phi-3-mini');

        // Act
        final result = await router.forceSwitchToOnDevice();

        // Assert
        expect(result, isTrue);
        expect(router.routingStatus.isUsingOnDevice, isTrue);
        expect(router.routingStatus.currentModel, equals('phi-3-mini'));
      });

      test('should force switch to cloud', () async {
        // Act
        final result = await router.forceSwitchToCloud();

        // Assert
        expect(result, isTrue);
        expect(router.routingStatus.isUsingOnDevice, isFalse);
        expect(router.routingStatus.currentModel, equals('Gemini'));
      });
    });

    group('Statistics', () {
      test('should provide routing statistics', () {
        // Arrange
        when(mockHealthMonitor.snapshot()).thenReturn(HealthSnapshot(
          successRate: 0.9,
          p50LatencyMs: 150,
          p95LatencyMs: 300,
          totalSamples: 100,
          isHealthy: true,
        ));

        // Act
        final stats = router.getStatistics();

        // Assert
        expect(stats.totalRequests, equals(100));
        expect(stats.successRate, equals(0.9));
        expect(stats.averageLatencyMs, equals(150));
      });
    });
  });
}
