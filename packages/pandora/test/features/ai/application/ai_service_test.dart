import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:pandora/features/ai/application/ai_service.dart';

class MockGenerativeModel extends Mock implements GenerativeModel {}

void main() {
  group('AiService', () {
    late AiService aiService;
    late MockGenerativeModel mockModel;

    setUp(() {
      mockModel = MockGenerativeModel();
      aiService = AiService('test-api-key');
    });

    test('should create instance with API key', () {
      const apiKey = 'test-api-key';
      final service = AiService(apiKey);
      expect(service, isA<AiService>());
    });

    group('summarizeText', () {
      test('should return summary when text is provided', () async {
        // Arrange
        const inputText = 'This is a test note with some content.';
        const expectedSummary = 'This is a summary of the test note.';
        
        when(() => mockModel.generateContent(any()))
            .thenAnswer((_) async => GenerateContentResponse(
                  candidates: [
                    Candidate(
                      content: Content(parts: [Part(text: expectedSummary)]),
                    )
                  ],
                ));

        // Act
        final result = await aiService.summarizeText(inputText);

        // Assert
        expect(result, equals(expectedSummary));
      });

      test('should throw exception when API call fails', () async {
        // Arrange
        const inputText = 'Test text';
        
        when(() => mockModel.generateContent(any()))
            .thenThrow(Exception('API Error'));

        // Act & Assert
        expect(
          () => aiService.summarizeText(inputText),
          throwsA(isA<Exception>()),
        );
      });

      test('should handle empty response', () async {
        // Arrange
        const inputText = 'Test text';
        
        when(() => mockModel.generateContent(any()))
            .thenAnswer((_) async => GenerateContentResponse(
                  candidates: [
                    Candidate(content: Content(parts: [Part(text: null)])),
                  ],
                ));

        // Act
        final result = await aiService.summarizeText(inputText);

        // Assert
        expect(result, equals('Could not summarize.'));
      });
    });

    group('chatWithAI', () {
      test('should return AI response when message is provided', () async {
        // Arrange
        const inputMessage = 'Hello AI';
        const expectedResponse = 'Hello! How can I help you?';
        
        when(() => mockModel.generateContent(any()))
            .thenAnswer((_) async => GenerateContentResponse(
                  candidates: [
                    Candidate(
                      content: Content(parts: [Part(text: expectedResponse)]),
                    )
                  ],
                ));

        // Act
        final result = await aiService.chatWithAI(inputMessage);

        // Assert
        expect(result, equals(expectedResponse));
      });

      test('should throw exception when API call fails', () async {
        // Arrange
        const inputMessage = 'Test message';
        
        when(() => mockModel.generateContent(any()))
            .thenThrow(Exception('API Error'));

        // Act & Assert
        expect(
          () => aiService.chatWithAI(inputMessage),
          throwsA(isA<Exception>()),
        );
      });

      test('should handle empty response', () async {
        // Arrange
        const inputMessage = 'Test message';
        
        when(() => mockModel.generateContent(any()))
            .thenAnswer((_) async => GenerateContentResponse(
                  candidates: [
                    Candidate(content: Content(parts: [Part(text: null)])),
                  ],
                ));

        // Act
        final result = await aiService.chatWithAI(inputMessage);

        // Assert
        expect(result, equals('Xin lỗi, tôi không thể trả lời tin nhắn này.'));
      });
    });
  });
}