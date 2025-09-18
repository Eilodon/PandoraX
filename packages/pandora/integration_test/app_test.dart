import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pandora/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Notes App Integration Tests', () {
    testWidgets('Complete note creation and management flow', (tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Verify app starts with notes list
      expect(find.text('Notes'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsNWidgets(3));

      // Test AI Chat functionality
      await tester.tap(find.byIcon(Icons.chat));
      await tester.pumpAndSettle();

      expect(find.text('Trò chuyện với AI'), findsOneWidget);
      expect(find.text('Chào mừng! Hãy bắt đầu cuộc trò chuyện với AI'), findsOneWidget);

      // Go back to notes list
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Test Voice Recording functionality
      await tester.tap(find.byIcon(Icons.mic));
      await tester.pumpAndSettle();

      expect(find.text('Ghi âm tạo ghi chú'), findsOneWidget);
      expect(find.text('Đang khởi tạo nhận dạng giọng nói...'), findsOneWidget);

      // Go back to notes list
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Test Add Note functionality (if implemented)
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Verify we can navigate back
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.text('Notes'), findsOneWidget);
    });

    testWidgets('Note detail screen navigation', (tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // If there are notes, test tapping on one
      final noteTiles = find.byType(ListTile);
      if (noteTiles.evaluate().isNotEmpty) {
        await tester.tap(noteTiles.first);
        await tester.pumpAndSettle();

        // Verify we're on note detail screen
        expect(find.byType(Scaffold), findsOneWidget);
        
        // Test AI Summary section
        expect(find.text('AI Summary'), findsOneWidget);
        expect(find.text('Click "Summarize" to generate an AI summary of this note.'), findsOneWidget);

        // Go back
        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();
      }
    });

    testWidgets('App state persistence', (tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Navigate to AI Chat
      await tester.tap(find.byIcon(Icons.chat));
      await tester.pumpAndSettle();

      // Send a test message (this will fail without API key, but we can test the UI)
      await tester.enterText(find.byType(TextField), 'Test message');
      await tester.tap(find.byIcon(Icons.send));
      await tester.pumpAndSettle();

      // Verify error handling
      expect(find.text('Lỗi khi gửi tin nhắn:'), findsOneWidget);

      // Go back to notes
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.text('Notes'), findsOneWidget);
    });

    testWidgets('Floating action buttons functionality', (tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Test all three floating action buttons
      final floatingButtons = find.byType(FloatingActionButton);
      expect(floatingButtons, findsNWidgets(3));

      // Test voice recording button
      await tester.tap(find.byIcon(Icons.mic));
      await tester.pumpAndSettle();
      expect(find.text('Ghi âm tạo ghi chú'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Test AI chat button
      await tester.tap(find.byIcon(Icons.chat));
      await tester.pumpAndSettle();
      expect(find.text('Trò chuyện với AI'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Test add note button
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      // Should navigate to note form or show some UI
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
    });
  });
}
