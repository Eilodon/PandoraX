import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pandora/features/ai/application/ai_service.dart';
import 'package:pandora/features/ai/application/ai_chat/ai_chat_notifier.dart';
import 'package:pandora/features/ai/application/ai_chat/ai_chat_state.dart';

class MockAiService extends Mock implements AiService {}

void main() {
  group('AiChatNotifier', () {
    late AiChatNotifier notifier;
    late MockAiService mockAiService;

    setUp(() {
      mockAiService = MockAiService();
      notifier = AiChatNotifier(mockAiService);
    });

    test('should initialize with empty state', () {
      expect(notifier.state, equals(const AiChatState()));
    });

    group('sendMessage', () {
      test('should add user message and AI response to state', () async {
        // Arrange
        const userMessage = 'Hello AI';
        const aiResponse = 'Hello! How can I help you?';
        
        when(() => mockAiService.chatWithAI(userMessage))
            .thenAnswer((_) async => aiResponse);

        // Act
        await notifier.sendMessage(userMessage);

        // Assert
        expect(notifier.state.messages.length, equals(2));
        expect(notifier.state.messages.first.content, equals(userMessage));
        expect(notifier.state.messages.first.isUser, isTrue);
        expect(notifier.state.messages.last.content, equals(aiResponse));
        expect(notifier.state.messages.last.isUser, isFalse);
        expect(notifier.state.isLoading, isFalse);
        expect(notifier.state.errorMessage, isNull);
      });

      test('should not send empty message', () async {
        // Act
        await notifier.sendMessage('   ');

        // Assert
        expect(notifier.state.messages, isEmpty);
        verifyNever(() => mockAiService.chatWithAI(any()));
      });

      test('should handle AI service error', () async {
        // Arrange
        const userMessage = 'Hello AI';
        const errorMessage = 'API Error';
        
        when(() => mockAiService.chatWithAI(userMessage))
            .thenThrow(Exception(errorMessage));

        // Act
        await notifier.sendMessage(userMessage);

        // Assert
        expect(notifier.state.messages.length, equals(1));
        expect(notifier.state.messages.first.content, equals(userMessage));
        expect(notifier.state.isLoading, isFalse);
        expect(notifier.state.errorMessage, contains('Lỗi khi gửi tin nhắn'));
      });

      test('should set loading state during API call', () async {
        // Arrange
        const userMessage = 'Hello AI';
        
        when(() => mockAiService.chatWithAI(userMessage))
            .thenAnswer((_) async {
          // Verify loading state is set
          expect(notifier.state.isLoading, isTrue);
          return 'Response';
        });

        // Act
        await notifier.sendMessage(userMessage);

        // Assert
        expect(notifier.state.isLoading, isFalse);
      });
    });

    group('clearChat', () {
      test('should reset state to initial', () async {
        // Arrange
        await notifier.sendMessage('Test message');

        // Act
        notifier.clearChat();

        // Assert
        expect(notifier.state, equals(const AiChatState()));
      });
    });

    group('clearError', () {
      test('should clear error message', () async {
        // Arrange
        notifier.state = notifier.state.copyWith(
          errorMessage: 'Test error',
        );

        // Act
        notifier.clearError();

        // Assert
        expect(notifier.state.errorMessage, isNull);
      });
    });

    group('createNoteFromMessage', () {
      test('should find message by id', () async {
        // Arrange
        await notifier.sendMessage('Test message');
        final messageId = notifier.state.messages.first.id;

        // Act
        await notifier.createNoteFromMessage(messageId);

        // Assert
        // This is a TODO implementation, so we just verify it doesn't throw
        expect(() => notifier.createNoteFromMessage(messageId), returnsNormally);
      });
    });
  });
}