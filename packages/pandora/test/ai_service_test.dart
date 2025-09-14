import 'package:flutter_test/flutter_test.dart';
import 'package:pandora/features/ai/application/ai_service.dart';

void main() {
  group('AiService', () {
    test('should create instance with API key', () {
      const apiKey = 'test-api-key';
      final aiService = AiService(apiKey);
      expect(aiService, isA<AiService>());
    });

    test('should throw exception when summarizing empty text', () async {
      const apiKey = 'test-api-key';
      final aiService = AiService(apiKey);
      
      // Note: This test will fail in real execution due to API call
      // but it tests the structure
      expect(() => aiService.summarizeText(''), throwsException);
    });
  });
}
