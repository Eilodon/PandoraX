import 'package:flutter_test/flutter_test.dart';
import 'package:ai_core/ai_core.dart';

void main() {
  group('AIResponse', () {
    test('should create AIResponse with required fields', () {
      final response = AIResponse(
        content: 'Hello, world!',
        modelUsed: 'phi-3-mini',
        processingTimeMs: 1500,
        isOnDevice: true,
        timestamp: DateTime.now(),
      );

      expect(response.content, 'Hello, world!');
      expect(response.modelUsed, 'phi-3-mini');
      expect(response.processingTimeMs, 1500);
      expect(response.isOnDevice, true);
      expect(response.isSuccess, true);
    });

    test('should indicate success when no error', () {
      final response = AIResponse(
        content: 'Test response',
        modelUsed: 'test-model',
        processingTimeMs: 1000,
        isOnDevice: false,
        timestamp: DateTime.now(),
      );

      expect(response.isSuccess, true);
    });

    test('should indicate failure when error is present', () {
      final response = AIResponse(
        content: 'Error response',
        modelUsed: 'test-model',
        processingTimeMs: 1000,
        isOnDevice: false,
        timestamp: DateTime.now(),
        error: 'Something went wrong',
      );

      expect(response.isSuccess, false);
    });

    test('should format processing time correctly', () {
      final response1 = AIResponse(
        content: 'Test',
        modelUsed: 'test',
        processingTimeMs: 500,
        isOnDevice: true,
        timestamp: DateTime.now(),
      );

      final response2 = AIResponse(
        content: 'Test',
        modelUsed: 'test',
        processingTimeMs: 1500,
        isOnDevice: true,
        timestamp: DateTime.now(),
      );

      expect(response1.processingTimeDisplay, '500ms');
      expect(response2.processingTimeDisplay, '1.5s');
    });
  });
}
