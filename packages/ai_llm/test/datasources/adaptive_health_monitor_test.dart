import 'package:flutter_test/flutter_test.dart';
import 'package:ai_llm/src/datasources/adaptive_health_monitor.dart';
import 'package:ai_llm/src/models/health_sample.dart';

void main() {
  group('AdaptiveHealthMonitor', () {
    late AdaptiveHealthMonitor monitor;

    setUp(() {
      monitor = AdaptiveHealthMonitor(
        windowSize: 10,
        maxAge: const Duration(minutes: 1),
        successThreshold: 0.8,
        minSamples: 3,
      );
    });

    tearDown(() {
      monitor.reset();
    });

    group('Recording Samples', () {
      test('should record success samples', () {
        // Act
        monitor.record(true, 100);
        monitor.record(true, 150);
        monitor.record(true, 200);

        // Assert
        final snapshot = monitor.snapshot();
        expect(snapshot.successRate, equals(1.0));
        expect(snapshot.totalSamples, equals(3));
        expect(snapshot.isHealthy, isTrue);
      });

      test('should record failure samples', () {
        // Act
        monitor.record(false, 100);
        monitor.record(false, 150);
        monitor.record(false, 200);

        // Assert
        final snapshot = monitor.snapshot();
        expect(snapshot.successRate, equals(0.0));
        expect(snapshot.totalSamples, equals(3));
        expect(snapshot.isHealthy, isFalse);
      });

      test('should record mixed samples', () {
        // Act
        monitor.record(true, 100);
        monitor.record(false, 150);
        monitor.record(true, 200);
        monitor.record(true, 250);

        // Assert
        final snapshot = monitor.snapshot();
        expect(snapshot.successRate, equals(0.75));
        expect(snapshot.totalSamples, equals(4));
        expect(snapshot.isHealthy, isFalse); // Below 0.8 threshold
      });

      test('should maintain window size', () {
        // Act - Add more samples than window size
        for (int i = 0; i < 15; i++) {
          monitor.record(true, 100 + i);
        }

        // Assert
        final snapshot = monitor.snapshot();
        expect(snapshot.totalSamples, equals(10)); // Window size
      });
    });

    group('Health Snapshot', () {
      test('should calculate percentiles correctly', () {
        // Arrange
        final latencies = [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000];
        for (final latency in latencies) {
          monitor.record(true, latency);
        }

        // Act
        final snapshot = monitor.snapshot();

        // Assert
        expect(snapshot.p50LatencyMs, equals(550)); // Median
        expect(snapshot.p95LatencyMs, equals(950)); // 95th percentile
      });

      test('should handle empty samples', () {
        // Act
        final snapshot = monitor.snapshot();

        // Assert
        expect(snapshot.successRate, equals(1.0));
        expect(snapshot.p50LatencyMs, equals(0));
        expect(snapshot.p95LatencyMs, equals(0));
        expect(snapshot.totalSamples, equals(0));
        expect(snapshot.isHealthy, isTrue);
      });

      test('should determine health status correctly', () {
        // Test healthy case
        for (int i = 0; i < 5; i++) {
          monitor.record(true, 100);
        }
        expect(monitor.snapshot().isHealthy, isTrue);

        // Reset and test unhealthy case
        monitor.reset();
        for (int i = 0; i < 5; i++) {
          monitor.record(i < 2, 100); // 40% success rate
        }
        expect(monitor.snapshot().isHealthy, isFalse);
      });
    });

    group('Performance Trend', () {
      test('should detect improving trend', () {
        // Arrange - Start with failures, end with successes
        for (int i = 0; i < 10; i++) {
          monitor.record(i < 5, 100); // First 5 failures, last 5 successes
        }

        // Act
        final trend = monitor.getTrend();

        // Assert
        expect(trend, equals(PerformanceTrend.improving));
      });

      test('should detect declining trend', () {
        // Arrange - Start with successes, end with failures
        for (int i = 0; i < 10; i++) {
          monitor.record(i >= 5, 100); // First 5 successes, last 5 failures
        }

        // Act
        final trend = monitor.getTrend();

        // Assert
        expect(trend, equals(PerformanceTrend.declining));
      });

      test('should detect stable trend', () {
        // Arrange - Consistent performance
        for (int i = 0; i < 10; i++) {
          monitor.record(true, 100);
        }

        // Act
        final trend = monitor.getTrend();

        // Assert
        expect(trend, equals(PerformanceTrend.stable));
      });

      test('should detect slowing trend', () {
        // Arrange - Increasing latency
        for (int i = 0; i < 10; i++) {
          monitor.record(true, 100 + i * 50); // Increasing latency
        }

        // Act
        final trend = monitor.getTrend();

        // Assert
        expect(trend, equals(PerformanceTrend.slowing));
      });

      test('should detect speeding trend', () {
        // Arrange - Decreasing latency
        for (int i = 0; i < 10; i++) {
          monitor.record(true, 200 - i * 10); // Decreasing latency
        }

        // Act
        final trend = monitor.getTrend();

        // Assert
        expect(trend, equals(PerformanceTrend.speeding));
      });
    });

    group('Recent Errors', () {
      test('should return recent error samples', () {
        // Arrange
        monitor.record(true, 100);
        monitor.record(false, 150);
        monitor.record(true, 200);
        monitor.record(false, 250);
        monitor.record(false, 300);

        // Act
        final recentErrors = monitor.getRecentErrors(limit: 3);

        // Assert
        expect(recentErrors.length, equals(3));
        expect(recentErrors.every((sample) => !sample.success), isTrue);
        // Should be in reverse chronological order
        expect(recentErrors[0].latencyMs, equals(300));
        expect(recentErrors[1].latencyMs, equals(250));
        expect(recentErrors[2].latencyMs, equals(150));
      });

      test('should limit recent errors count', () {
        // Arrange
        for (int i = 0; i < 10; i++) {
          monitor.record(false, 100 + i);
        }

        // Act
        final recentErrors = monitor.getRecentErrors(limit: 3);

        // Assert
        expect(recentErrors.length, equals(3));
      });
    });

    group('Health Report', () {
      test('should generate detailed health report', () {
        // Arrange
        for (int i = 0; i < 5; i++) {
          monitor.record(i < 4, 100 + i * 10); // 80% success rate
        }

        // Act
        final report = monitor.getDetailedReport();

        // Assert
        expect(report.snapshot, isA<HealthSnapshot>());
        expect(report.trend, isA<PerformanceTrend>());
        expect(report.recentErrors, isA<List<HealthSample>>());
        expect(report.recommendations, isA<List<String>>());
        expect(report.recommendations.isNotEmpty, isTrue);
      });

      test('should provide appropriate recommendations', () {
        // Test low success rate
        for (int i = 0; i < 5; i++) {
          monitor.record(i < 2, 100); // 40% success rate
        }
        
        var report = monitor.getDetailedReport();
        expect(report.recommendations.any((r) => r.contains('reliability')), isTrue);

        // Reset and test high latency
        monitor.reset();
        for (int i = 0; i < 5; i++) {
          monitor.record(true, 6000); // High latency
        }
        
        report = monitor.getDetailedReport();
        expect(report.recommendations.any((r) => r.contains('slow')), isTrue);
      });
    });

    group('Cleanup', () {
      test('should reset all samples', () {
        // Arrange
        for (int i = 0; i < 5; i++) {
          monitor.record(true, 100);
        }

        // Act
        monitor.reset();

        // Assert
        final snapshot = monitor.snapshot();
        expect(snapshot.totalSamples, equals(0));
      });
    });

    group('Edge Cases', () {
      test('should handle single sample', () {
        // Act
        monitor.record(true, 100);

        // Assert
        final snapshot = monitor.snapshot();
        expect(snapshot.successRate, equals(1.0));
        expect(snapshot.p50LatencyMs, equals(100));
        expect(snapshot.p95LatencyMs, equals(100));
      });

      test('should handle all same latency values', () {
        // Arrange
        for (int i = 0; i < 10; i++) {
          monitor.record(true, 100);
        }

        // Act
        final snapshot = monitor.snapshot();

        // Assert
        expect(snapshot.p50LatencyMs, equals(100));
        expect(snapshot.p95LatencyMs, equals(100));
      });

      test('should handle very small window size', () {
        // Arrange
        final smallMonitor = AdaptiveHealthMonitor(windowSize: 2);
        smallMonitor.record(true, 100);
        smallMonitor.record(true, 200);
        smallMonitor.record(true, 300); // Should be trimmed

        // Act
        final snapshot = smallMonitor.snapshot();

        // Assert
        expect(snapshot.totalSamples, equals(2));
      });
    });
  });
}
