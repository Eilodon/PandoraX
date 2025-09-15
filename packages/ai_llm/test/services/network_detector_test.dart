import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ai_llm/src/services/network_detector.dart';

import 'network_detector_test.mocks.dart';

@GenerateMocks([Connectivity])
void main() {
  group('NetworkDetector', () {
    late NetworkDetector detector;
    late MockConnectivity mockConnectivity;

    setUp(() {
      mockConnectivity = MockConnectivity();
      detector = NetworkDetector();
    });

    group('Connection Status', () {
      test('should return connection status', () async {
        // Act
        final isConnected = await detector.isConnected;

        // Assert
        expect(isConnected, isA<bool>());
      });

      test('should return network type', () {
        // Act
        final networkType = detector.networkType;

        // Assert
        expect(networkType, isA<NetworkType>());
      });

      test('should return signal strength', () {
        // Act
        final signalStrength = detector.signalStrength;

        // Assert
        expect(signalStrength, inInclusiveRange(0, 100));
      });
    });

    group('Network Quality', () {
      test('should calculate network quality score', () async {
        // Act
        final quality = await detector.getNetworkQuality();

        // Assert
        expect(quality, inInclusiveRange(0, 100));
      });

      test('should return 0 when not connected', () async {
        // Arrange
        when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.none);

        // Act
        final quality = await detector.getNetworkQuality();

        // Assert
        expect(quality, equals(0));
      });
    });

    group('AI Suitability', () {
      test('should check if network is suitable for AI', () async {
        // Act
        final isSuitable = await detector.isSuitableForAI();

        // Assert
        expect(isSuitable, isA<bool>());
      });

      test('should return false when not connected', () async {
        // Arrange
        when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.none);

        // Act
        final isSuitable = await detector.isSuitableForAI();

        // Assert
        expect(isSuitable, isFalse);
      });
    });

    group('Network Statistics', () {
      test('should provide network statistics', () {
        // Act
        final stats = detector.getStatistics();

        // Assert
        expect(stats, isA<NetworkStatistics>());
        expect(stats.isConnected, isA<bool>());
        expect(stats.networkType, isA<NetworkType>());
        expect(stats.signalStrength, inInclusiveRange(0, 100));
        expect(stats.lastCheck, isA<DateTime>());
      });
    });

    group('Connectivity Testing', () {
      test('should test connectivity to URL', () async {
        // Act
        final isConnected = await detector.testConnectivity('https://www.google.com');

        // Assert
        expect(isConnected, isA<bool>());
      });

      test('should return false for invalid URL', () async {
        // Act
        final isConnected = await detector.testConnectivity('invalid-url');

        // Assert
        expect(isConnected, isFalse);
      });

      test('should return false for unreachable URL', () async {
        // Act
        final isConnected = await detector.testConnectivity('https://unreachable-url-12345.com');

        // Assert
        expect(isConnected, isFalse);
      });
    });

    group('Network Type Detection', () {
      test('should detect WiFi connection', () async {
        // Arrange
        when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.wifi);

        // Act
        final isConnected = await detector.isConnected;

        // Assert
        expect(isConnected, isA<bool>());
        expect(detector.networkType, equals(NetworkType.wifi));
      });

      test('should detect mobile connection', () async {
        // Arrange
        when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.mobile);

        // Act
        final isConnected = await detector.isConnected;

        // Assert
        expect(isConnected, isA<bool>());
        expect(detector.networkType, equals(NetworkType.mobile));
      });

      test('should detect ethernet connection', () async {
        // Arrange
        when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.ethernet);

        // Act
        final isConnected = await detector.isConnected;

        // Assert
        expect(isConnected, isA<bool>());
        expect(detector.networkType, equals(NetworkType.ethernet));
      });

      test('should detect no connection', () async {
        // Arrange
        when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.none);

        // Act
        final isConnected = await detector.isConnected;

        // Assert
        expect(isConnected, isFalse);
        expect(detector.networkType, equals(NetworkType.none));
      });
    });

    group('Signal Strength', () {
      test('should return valid signal strength for WiFi', () async {
        // Arrange
        when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.wifi);

        // Act
        final signalStrength = detector.signalStrength;

        // Assert
        expect(signalStrength, inInclusiveRange(0, 100));
      });

      test('should return valid signal strength for mobile', () async {
        // Arrange
        when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.mobile);

        // Act
        final signalStrength = detector.signalStrength;

        // Assert
        expect(signalStrength, inInclusiveRange(0, 100));
      });

      test('should return 100 for ethernet', () async {
        // Arrange
        when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.ethernet);

        // Act
        final signalStrength = detector.signalStrength;

        // Assert
        expect(signalStrength, equals(100));
      });
    });

    group('Error Handling', () {
      test('should handle connectivity check errors', () async {
        // Arrange
        when(mockConnectivity.checkConnectivity()).thenThrow(Exception('Connectivity error'));

        // Act
        final isConnected = await detector.isConnected;

        // Assert
        expect(isConnected, isFalse);
      });

      test('should handle network quality measurement errors', () async {
        // Arrange
        when(mockConnectivity.checkConnectivity()).thenThrow(Exception('Connectivity error'));

        // Act
        final quality = await detector.getNetworkQuality();

        // Assert
        expect(quality, equals(0));
      });
    });

    group('Resource Management', () {
      test('should dispose resources properly', () {
        // Act & Assert
        expect(() => detector.dispose(), returnsNormally);
      });
    });

    group('Configuration', () {
      test('should use custom configuration', () {
        // Arrange
        final customDetector = NetworkDetector(
          checkInterval: Duration(seconds: 60),
          timeout: Duration(seconds: 5),
          testUrls: ['https://custom-test.com'],
        );

        // Act & Assert
        expect(customDetector, isA<NetworkDetector>());
        customDetector.dispose();
      });
    });
  });
}
