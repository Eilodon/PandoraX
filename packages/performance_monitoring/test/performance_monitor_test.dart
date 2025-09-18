import 'package:flutter_test/flutter_test.dart';
import 'package:performance_monitoring/performance_monitoring.dart';

void main() {
  group('PerformanceMonitor', () {
    late PerformanceMonitor monitor;

    setUp(() {
      monitor = PerformanceMonitor();
    });

    tearDown(() {
      monitor.dispose();
    });

    test('should initialize successfully', () async {
      await monitor.initialize();
      expect(monitor.isInitialized, isTrue);
    });

    test('should track app startup time', () async {
      await monitor.initialize();
      
      final duration = Duration(milliseconds: 2500);
      await monitor.trackAppStartup(duration);
      
      // Verify metric was tracked
      final metrics = await monitor.getCurrentMetrics();
      expect(metrics.any((m) => m.name == 'App Startup'), isTrue);
    });

    test('should track AI response time', () async {
      await monitor.initialize();
      
      final duration = Duration(milliseconds: 1500);
      await monitor.trackAIResponse(duration, 'test-model');
      
      // Verify metric was tracked
      final metrics = await monitor.getCurrentMetrics();
      expect(metrics.any((m) => m.name == 'AI Response (test-model)'), isTrue);
    });

    test('should track memory usage', () async {
      await monitor.initialize();
      
      const bytes = 100 * 1024 * 1024; // 100MB
      await monitor.trackMemoryUsage(bytes);
      
      // Verify metric was tracked
      final metrics = await monitor.getCurrentMetrics();
      expect(metrics.any((m) => m.name == 'Memory Usage'), isTrue);
    });

    test('should emit metrics to stream', () async {
      await monitor.initialize();
      
      final metrics = <PerformanceMetric>[];
      monitor.metricStream.listen(metrics.add);
      
      const bytes = 50 * 1024 * 1024; // 50MB
      await monitor.trackMemoryUsage(bytes);
      
      // Wait for metric to be emitted
      await Future.delayed(Duration(milliseconds: 100));
      
      expect(metrics.isNotEmpty, isTrue);
      expect(metrics.any((m) => m.name == 'Memory Usage'), isTrue);
    });
  });
}
