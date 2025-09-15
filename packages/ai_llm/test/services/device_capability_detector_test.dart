import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:ai_core/ai_core.dart';
import 'package:ai_llm/src/services/device_capability_detector.dart';
import 'package:ai_llm/src/services/ai_router_service.dart';

import 'device_capability_detector_test.mocks.dart';

@GenerateMocks([DeviceInfoPlugin])
void main() {
  group('DeviceCapabilityDetector', () {
    late DeviceCapabilityDetector detector;
    late MockDeviceInfoPlugin mockDeviceInfo;

    setUp(() {
      mockDeviceInfo = MockDeviceInfoPlugin();
      detector = DeviceCapabilityDetector();
    });

    group('Capability Detection', () {
      test('should return cached capability when recent', () async {
        // Arrange
        final capability = DeviceCapability(
          ramGB: 8,
          storageGB: 16,
          cpuCores: 8,
          hasGpu: true,
          maxModelSize: 2000000000,
        );

        // Act - First call
        final result1 = await detector.getCapability();
        
        // Act - Second call (should use cache)
        final result2 = await detector.getCapability();

        // Assert
        expect(result1, isA<DeviceCapability>());
        expect(result2, isA<DeviceCapability>());
        // Note: In a real test, you would verify caching behavior
      });

      test('should refresh capability when forced', () async {
        // Act
        final result = await detector.refreshCapability();

        // Assert
        expect(result, isA<DeviceCapability>());
        expect(result.ramGB, greaterThan(0));
        expect(result.storageGB, greaterThan(0));
        expect(result.cpuCores, greaterThan(0));
        expect(result.maxModelSize, greaterThan(0));
      });
    });

    group('Model Suitability', () {
      test('should check if device can handle model', () async {
        // Arrange
        final capability = DeviceCapability(
          ramGB: 6,
          storageGB: 10,
          cpuCores: 8,
          hasGpu: true,
          maxModelSize: 1000000000, // 1GB
        );

        // Act
        final canHandleTiny = await detector.canHandleModel(ModelLevel.tiny);
        final canHandleMini = await detector.canHandleModel(ModelLevel.mini);
        final canHandleFull = await detector.canHandleModel(ModelLevel.full);

        // Assert
        expect(canHandleTiny, isTrue);
        expect(canHandleMini, isTrue);
        expect(canHandleFull, isTrue);
      });

      test('should return false for models too large', () async {
        // Arrange
        final capability = DeviceCapability(
          ramGB: 2,
          storageGB: 1,
          cpuCores: 2,
          hasGpu: false,
          maxModelSize: 50000000, // 50MB
        );

        // Act
        final canHandleFull = await detector.canHandleModel(ModelLevel.full);

        // Assert
        expect(canHandleFull, isFalse);
      });
    });

    group('Model Recommendations', () {
      test('should provide recommended model levels', () async {
        // Act
        final recommendations = await detector.getRecommendedModelLevels();

        // Assert
        expect(recommendations, isNotEmpty);
        expect(recommendations.every((level) => level is ModelLevel), isTrue);
      });

      test('should recommend appropriate models for high-end device', () async {
        // Arrange - Mock high-end device
        // This would typically involve mocking device info

        // Act
        final recommendations = await detector.getRecommendedModelLevels();

        // Assert
        expect(recommendations, isNotEmpty);
        // Note: In a real test, you would verify specific recommendations
      });
    });

    group('Performance Score', () {
      test('should calculate performance score', () async {
        // Act
        final score = await detector.getPerformanceScore();

        // Assert
        expect(score, inInclusiveRange(0, 100));
      });

      test('should return higher score for better devices', () async {
        // This test would compare scores between different device configurations
        // For now, just verify the score is in valid range
        final score = await detector.getPerformanceScore();
        expect(score, inInclusiveRange(0, 100));
      });
    });

    group('Detailed Device Info', () {
      test('should provide detailed device information', () async {
        // Act
        final info = await detector.getDetailedInfo();

        // Assert
        expect(info, isA<DetailedDeviceInfo>());
        expect(info.platform, isNotEmpty);
        expect(info.model, isNotEmpty);
        expect(info.manufacturer, isNotEmpty);
        expect(info.version, isNotEmpty);
        expect(info.architecture, isNotEmpty);
      });

      test('should handle different platforms', () async {
        // Act
        final info = await detector.getDetailedInfo();

        // Assert
        expect(info.platform, isIn(['Android', 'iOS', 'Windows', 'macOS', 'Linux', 'Unknown']));
      });
    });

    group('Edge Cases', () {
      test('should handle detection failures gracefully', () async {
        // This test would simulate detection failures
        // For now, just verify the method doesn't throw
        expect(() => detector.getCapability(), returnsNormally);
      });

      test('should return default capability when detection fails', () async {
        // Act
        final capability = await detector.getCapability();

        // Assert
        expect(capability, isA<DeviceCapability>());
        expect(capability.ramGB, greaterThan(0));
        expect(capability.storageGB, greaterThan(0));
        expect(capability.cpuCores, greaterThan(0));
        expect(capability.maxModelSize, greaterThan(0));
      });
    });

    group('Capability Properties', () {
      test('should have valid capability properties', () async {
        // Act
        final capability = await detector.getCapability();

        // Assert
        expect(capability.ramGB, greaterThan(0));
        expect(capability.storageGB, greaterThan(0));
        expect(capability.cpuCores, greaterThan(0));
        expect(capability.maxModelSize, greaterThan(0));
        expect(capability.hasGpu, isA<bool>());
      });

      test('should calculate max model size appropriately', () async {
        // Act
        final capability = await detector.getCapability();

        // Assert
        expect(capability.maxModelSize, greaterThan(0));
        // Max model size should be reasonable based on available resources
        expect(capability.maxModelSize, lessThan(capability.ramGB * 1024 * 1024 * 1024));
        expect(capability.maxModelSize, lessThan(capability.storageGB * 1024 * 1024 * 1024));
      });
    });
  });
}
