import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pandora/features/ai/presentation/ai_chat_screen.dart';
import 'package:pandora/features/ai/application/ai_chat/ai_chat_state.dart';
import 'package:pandora/features/ai/application/ai_chat/ai_chat_notifier.dart';

// Mock classes
class MockAiChatNotifier extends StateNotifier<AiChatState> with Mock {
  MockAiChatNotifier() : super(const AiChatState());
}

void main() {
  group('AiChatScreen Widget Tests', () {
    late MockAiChatNotifier mockNotifier;

    setUp(() {
      mockNotifier = MockAiChatNotifier();
    });

    Widget createTestWidget() {
      return ProviderScope(
        overrides: [
          aiChatProvider.overrideWith((ref) => mockNotifier),
        ],
        child: const MaterialApp(
          home: AiChatScreen(),
        ),
      );
    }

    testWidgets('should display initial empty state', (tester) async {
      // Arrange
      mockNotifier.state = const AiChatState();

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text('Trò chuyện với AI'), findsOneWidget);
      expect(find.text('Chào mừng! Hãy bắt đầu cuộc trò chuyện với AI'), findsOneWidget);
      expect(find.byIcon(Icons.chat_bubble_outline), findsOneWidget);
    });

    testWidgets('should display messages when available', (tester) async {
      // Arrange
      final messages = [
        ChatMessage(
          id: '1',
          content: 'Hello AI',
          isUser: true,
          timestamp: DateTime.now(),
        ),
        ChatMessage(
          id: '2',
          content: 'Hello! How can I help you?',
          isUser: false,
          timestamp: DateTime.now(),
        ),
      ];
      mockNotifier.state = AiChatState(messages: messages);

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text('Hello AI'), findsOneWidget);
      expect(find.text('Hello! How can I help you?'), findsOneWidget);
    });

    testWidgets('should show loading state when AI is responding', (tester) async {
      // Arrange
      mockNotifier.state = const AiChatState(isLoading: true);

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text('Summarizing...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show error message when error occurs', (tester) async {
      // Arrange
      const errorMessage = 'Failed to connect to AI';
      mockNotifier.state = const AiChatState(errorMessage: errorMessage);

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text(errorMessage), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
    });

    testWidgets('should have message input field and send button', (tester) async {
      // Arrange
      mockNotifier.state = const AiChatState();

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Nhập tin nhắn...'), findsOneWidget);
      expect(find.byIcon(Icons.send), findsOneWidget);
    });

    testWidgets('should call sendMessage when send button is pressed', (tester) async {
      // Arrange
      mockNotifier.state = const AiChatState();
      when(() => mockNotifier.sendMessage(any())).thenReturn(null);

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.enterText(find.byType(TextField), 'Test message');
      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();

      // Assert
      verify(() => mockNotifier.sendMessage('Test message')).called(1);
    });

    testWidgets('should show clear chat dialog when clear button is pressed', (tester) async {
      // Arrange
      mockNotifier.state = const AiChatState();

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.tap(find.byIcon(Icons.clear_all));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Xóa cuộc trò chuyện'), findsOneWidget);
      expect(find.text('Bạn có chắc muốn xóa toàn bộ cuộc trò chuyện?'), findsOneWidget);
    });

    testWidgets('should disable send button when loading', (tester) async {
      // Arrange
      mockNotifier.state = const AiChatState(isLoading: true);

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      final sendButton = find.byType(FloatingActionButton);
      expect(tester.widget<FloatingActionButton>(sendButton).onPressed, isNull);
    });
  });
}
