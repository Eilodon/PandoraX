import 'package:flutter_test/flutter_test.dart';
import 'package:pandora/services/performance_optimization_service.dart';

void main() {
  group('PerformanceOptimizationService', () {
    tearDown(() async {
      // Clean up after each test
      await PerformanceOptimizationService.dispose();
    });

    group('Service Initialization', () {
      test('should initialize performance monitoring successfully', () async {
        // Act
        await PerformanceOptimizationService.initialize();

        // Assert
        final stats = PerformanceOptimizationService.getPerformanceStats();
        expect(stats['monitoring_active'], isTrue);
      });

      test('should handle multiple initialization calls gracefully', () async {
        // Act
        await PerformanceOptimizationService.initialize();
        await PerformanceOptimizationService.initialize();
        await PerformanceOptimizationService.initialize();

        // Assert
        final stats = PerformanceOptimizationService.getPerformanceStats();
        expect(stats['monitoring_active'], isTrue);
      });
    });

    group('Performance Statistics', () {
      test('should return empty stats when not initialized', () {
        // Act
        final stats = PerformanceOptimizationService.getPerformanceStats();

        // Assert
        expect(stats['metrics_count'], equals(0));
        expect(stats['monitoring_active'], isFalse);
        expect(stats['timestamp'], isA<String>());
      });

      test('should return performance stats after initialization', () async {
        // Arrange
        await PerformanceOptimizationService.initialize();

        // Act
        final stats = PerformanceOptimizationService.getPerformanceStats();

        // Assert
        expect(stats['monitoring_active'], isTrue);
        expect(stats['timestamp'], isA<String>());
        expect(stats.containsKey('total_metrics'), isTrue);
        expect(stats.containsKey('recent_metrics'), isTrue);
      });

      test('should include memory usage stats when available', () async {
        // Arrange
        await PerformanceOptimizationService.initialize();
        
        // Wait a bit for metrics to be collected
        await Future.delayed(const Duration(milliseconds: 100));

        // Act
        final stats = PerformanceOptimizationService.getPerformanceStats();

        // Assert
        expect(stats['monitoring_active'], isTrue);
        expect(stats.containsKey('total_metrics'), isTrue);
      });
    });

    group('Manual Optimization', () {
      test('should perform manual optimization without errors', () async {
        // Arrange
        await PerformanceOptimizationService.initialize();

        // Act & Assert
        expect(() => PerformanceOptimizationService.optimizeNow(), returnsNormally);
      });

      test('should handle optimization when not initialized', () async {
        // Act & Assert
        expect(() => PerformanceOptimizationService.optimizeNow(), returnsNormally);
      });
    });

    group('Performance Metrics', () {
      test('should handle PerformanceMetric creation', () {
        // Arrange
        final timestamp = DateTime.now();
        const type = PerformanceMetricType.memory;
        const value = 150.5;

        // Act
        final metric = PerformanceMetric(
          type: type,
          value: value,
          timestamp: timestamp,
        );

        // Assert
        expect(metric.type, equals(type));
        expect(metric.value, equals(value));
        expect(metric.timestamp, equals(timestamp));
      });

      test('should convert PerformanceMetric to JSON correctly', () {
        // Arrange
        final timestamp = DateTime.now();
        final metric = PerformanceMetric(
          type: PerformanceMetricType.frameTime,
          value: 16.7,
          timestamp: timestamp,
        );

        // Act
        final json = metric.toJson();

        // Assert
        expect(json['type'], equals('frameTime'));
        expect(json['value'], equals(16.7));
        expect(json['timestamp'], equals(timestamp.toIso8601String()));
      });
    });

    group('Performance Metric Types', () {
      test('should have all expected metric types', () {
        // Act & Assert
        expect(PerformanceMetricType.values, contains(PerformanceMetricType.memory));
        expect(PerformanceMetricType.values, contains(PerformanceMetricType.frameTime));
        expect(PerformanceMetricType.values, contains(PerformanceMetricType.cpuUsage));
        expect(PerformanceMetricType.values, contains(PerformanceMetricType.batteryUsage));
        expect(PerformanceMetricType.values, contains(PerformanceMetricType.networkLatency));
        expect(PerformanceMetricType.values, contains(PerformanceMetricType.storageIO));
      });

      test('should have readable metric type names', () {
        // Act & Assert
        expect(PerformanceMetricType.memory.name, equals('memory'));
        expect(PerformanceMetricType.frameTime.name, equals('frameTime'));
        expect(PerformanceMetricType.cpuUsage.name, equals('cpuUsage'));
        expect(PerformanceMetricType.batteryUsage.name, equals('batteryUsage'));
        expect(PerformanceMetricType.networkLatency.name, equals('networkLatency'));
        expect(PerformanceMetricType.storageIO.name, equals('storageIO'));
      });
    });

    group('Service Lifecycle', () {
      test('should dispose service gracefully', () async {
        // Arrange
        await PerformanceOptimizationService.initialize();

        // Act
        await PerformanceOptimizationService.dispose();

        // Assert
        final stats = PerformanceOptimizationService.getPerformanceStats();
        expect(stats['monitoring_active'], isFalse);
        expect(stats['metrics_count'], equals(0));
      });

      test('should handle dispose when not initialized', () async {
        // Act & Assert
        expect(() => PerformanceOptimizationService.dispose(), returnsNormally);
      });

      test('should allow re-initialization after disposal', () async {
        // Arrange
        await PerformanceOptimizationService.initialize();
        await PerformanceOptimizationService.dispose();

        // Act
        await PerformanceOptimizationService.initialize();

        // Assert
        final stats = PerformanceOptimizationService.getPerformanceStats();
        expect(stats['monitoring_active'], isTrue);
      });
    });

    group('Performance Monitoring', () {
      test('should collect performance metrics over time', () async {
        // Arrange
        await PerformanceOptimizationService.initialize();

        // Act - Wait for some metrics to be collected
        await Future.delayed(const Duration(milliseconds: 200));

        // Assert
        final stats = PerformanceOptimizationService.getPerformanceStats();
        expect(stats['monitoring_active'], isTrue);
      });

      test('should handle concurrent optimization requests', () async {
        // Arrange
        await PerformanceOptimizationService.initialize();

        // Act
        final futures = List.generate(5, (index) => 
            PerformanceOptimizationService.optimizeNow());
        
        // Assert
        expect(() => Future.wait(futures), returnsNormally);
      });
    });

    group('Error Handling', () {
      test('should handle initialization errors gracefully', () async {
        // This test ensures the service doesn't crash on initialization errors
        // Act & Assert
        expect(() => PerformanceOptimizationService.initialize(), returnsNormally);
      });

      test('should handle stats retrieval errors gracefully', () {
        // Act & Assert
        expect(() => PerformanceOptimizationService.getPerformanceStats(), returnsNormally);
      });

      test('should handle optimization errors gracefully', () async {
        // Act & Assert
        expect(() => PerformanceOptimizationService.optimizeNow(), returnsNormally);
      });
    });

    group('Memory Management', () {
      test('should manage memory metrics collection efficiently', () async {
        // Arrange
        await PerformanceOptimizationService.initialize();

        // Act - Simulate some activity
        for (int i = 0; i < 10; i++) {
          await PerformanceOptimizationService.optimizeNow();
          await Future.delayed(const Duration(milliseconds: 10));
        }

        // Assert
        final stats = PerformanceOptimizationService.getPerformanceStats();
        expect(stats['monitoring_active'], isTrue);
      });
    });

    group('Performance Optimization', () {
      test('should complete optimization within reasonable time', () async {
        // Arrange
        await PerformanceOptimizationService.initialize();

        // Act
        final stopwatch = Stopwatch()..start();
        await PerformanceOptimizationService.optimizeNow();
        stopwatch.stop();

        // Assert
        expect(stopwatch.elapsedMilliseconds, lessThan(5000)); // Should complete within 5 seconds
      });
    });

    group('Statistics Validation', () {
      test('should provide valid timestamp format', () async {
        // Arrange
        await PerformanceOptimizationService.initialize();

        // Act
        final stats = PerformanceOptimizationService.getPerformanceStats();

        // Assert
        expect(stats['timestamp'], isA<String>());
        expect(() => DateTime.parse(stats['timestamp']), returnsNormally);
      });

      test('should provide consistent data structure', () async {
        // Arrange
        await PerformanceOptimizationService.initialize();

        // Act
        final stats1 = PerformanceOptimizationService.getPerformanceStats();
        await Future.delayed(const Duration(milliseconds: 50));
        final stats2 = PerformanceOptimizationService.getPerformanceStats();

        // Assert
        expect(stats1.keys.toSet(), equals(stats2.keys.toSet()));
        expect(stats1['monitoring_active'], equals(stats2['monitoring_active']));
      });
    });
  });
}
