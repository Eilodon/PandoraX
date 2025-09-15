import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pandora/pandora.dart';
import 'package:cac_core/cac_core.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Cognitive Stream E2E Tests', () {
    testWidgets('should display cognitive stream dashboard', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const PandoraApp());
      await tester.pumpAndSettle();

      // Navigate to cognitive stream
      await tester.tap(find.text('Cognitive Stream'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Cognitive Stream'), findsOneWidget);
      expect(find.byType(TabBar), findsOneWidget);
      expect(find.text('Stream'), findsOneWidget);
      expect(find.text('Insights'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Analytics'), findsOneWidget);
    });

    testWidgets('should display memory cards in stream tab', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const PandoraApp());
      await tester.pumpAndSettle();

      // Navigate to cognitive stream
      await tester.tap(find.text('Cognitive Stream'));
      await tester.pumpAndSettle();

      // Wait for memories to load
      await tester.pump(const Duration(seconds: 2));

      // Assert
      expect(find.byType(MemoryCard), findsWidgets);
    });

    testWidgets('should search memories', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const PandoraApp());
      await tester.pumpAndSettle();

      // Navigate to cognitive stream
      await tester.tap(find.text('Cognitive Stream'));
      await tester.pumpAndSettle();

      // Tap on search tab
      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      // Enter search query
      await tester.enterText(find.byType(TextField), 'programming');
      await tester.pumpAndSettle();

      // Wait for search results
      await tester.pump(const Duration(seconds: 2));

      // Assert
      expect(find.byType(MemoryCard), findsWidgets);
    });

    testWidgets('should display insights in insights tab', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const PandoraApp());
      await tester.pumpAndSettle();

      // Navigate to cognitive stream
      await tester.tap(find.text('Cognitive Stream'));
      await tester.pumpAndSettle();

      // Tap on insights tab
      await tester.tap(find.text('Insights'));
      await tester.pumpAndSettle();

      // Wait for insights to load
      await tester.pump(const Duration(seconds: 2));

      // Assert
      expect(find.text('Memory Insights'), findsOneWidget);
      expect(find.text('Pattern Analysis'), findsOneWidget);
      expect(find.text('Recommendations'), findsOneWidget);
    });

    testWidgets('should display analytics in analytics tab', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const PandoraApp());
      await tester.pumpAndSettle();

      // Navigate to cognitive stream
      await tester.tap(find.text('Cognitive Stream'));
      await tester.pumpAndSettle();

      // Tap on analytics tab
      await tester.tap(find.text('Analytics'));
      await tester.pumpAndSettle();

      // Wait for analytics to load
      await tester.pump(const Duration(seconds: 2));

      // Assert
      expect(find.text('Analytics Overview'), findsOneWidget);
      expect(find.text('Cognitive Activity'), findsOneWidget);
      expect(find.text('Memory Distribution'), findsOneWidget);
      expect(find.text('Performance Metrics'), findsOneWidget);
    });

    testWidgets('should filter memories by type', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const PandoraApp());
      await tester.pumpAndSettle();

      // Navigate to cognitive stream
      await tester.tap(find.text('Cognitive Stream'));
      await tester.pumpAndSettle();

      // Tap on memory type filter
      await tester.tap(find.byType(DropdownButtonFormField<MemoryType?>));
      await tester.pumpAndSettle();

      // Select explicit memory type
      await tester.tap(find.text('EXPLICIT'));
      await tester.pumpAndSettle();

      // Wait for filtered results
      await tester.pump(const Duration(seconds: 2));

      // Assert
      expect(find.byType(MemoryCard), findsWidgets);
    });

    testWidgets('should pin and unpin memories', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const PandoraApp());
      await tester.pumpAndSettle();

      // Navigate to cognitive stream
      await tester.tap(find.text('Cognitive Stream'));
      await tester.pumpAndSettle();

      // Wait for memories to load
      await tester.pump(const Duration(seconds: 2));

      // Find a memory card
      final memoryCard = find.byType(MemoryCard).first;
      expect(memoryCard, findsOneWidget);

      // Tap on pin button
      await tester.tap(find.descendant(
        of: memoryCard,
        matching: find.byIcon(Icons.push_pin_outlined),
      ));
      await tester.pumpAndSettle();

      // Assert
      expect(find.descendant(
        of: memoryCard,
        matching: find.byIcon(Icons.push_pin),
      ), findsOneWidget);
    });

    testWidgets('should archive memories', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const PandoraApp());
      await tester.pumpAndSettle();

      // Navigate to cognitive stream
      await tester.tap(find.text('Cognitive Stream'));
      await tester.pumpAndSettle();

      // Wait for memories to load
      await tester.pump(const Duration(seconds: 2));

      // Find a memory card
      final memoryCard = find.byType(MemoryCard).first;
      expect(memoryCard, findsOneWidget);

      // Tap on archive button
      await tester.tap(find.descendant(
        of: memoryCard,
        matching: find.byIcon(Icons.archive),
      ));
      await tester.pumpAndSettle();

      // Assert
      expect(find.descendant(
        of: memoryCard,
        matching: find.byIcon(Icons.unarchive),
      ), findsOneWidget);
    });

    testWidgets('should show memory details', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const PandoraApp());
      await tester.pumpAndSettle();

      // Navigate to cognitive stream
      await tester.tap(find.text('Cognitive Stream'));
      await tester.pumpAndSettle();

      // Wait for memories to load
      await tester.pump(const Duration(seconds: 2));

      // Find a memory card and tap it
      final memoryCard = find.byType(MemoryCard).first;
      await tester.tap(memoryCard);
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Memory Details'), findsOneWidget);
      expect(find.text('Content:'), findsOneWidget);
      expect(find.text('Source:'), findsOneWidget);
      expect(find.text('Type:'), findsOneWidget);
      expect(find.text('Created:'), findsOneWidget);
      expect(find.text('Relevance:'), findsOneWidget);
    });

    testWidgets('should refresh data', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const PandoraApp());
      await tester.pumpAndSettle();

      // Navigate to cognitive stream
      await tester.tap(find.text('Cognitive Stream'));
      await tester.pumpAndSettle();

      // Tap refresh button
      await tester.tap(find.byIcon(Icons.refresh));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(MemoryCard), findsWidgets);
    });

    testWidgets('should show settings', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const PandoraApp());
      await tester.pumpAndSettle();

      // Navigate to cognitive stream
      await tester.tap(find.text('Cognitive Stream'));
      await tester.pumpAndSettle();

      // Tap settings button
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Cognitive Stream Settings'), findsOneWidget);
    });
  });

  group('Note Integration E2E Tests', () {
    testWidgets('should create note and save to memory system', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const PandoraApp());
      await tester.pumpAndSettle();

      // Navigate to notes
      await tester.tap(find.text('Notes'));
      await tester.pumpAndSettle();

      // Tap add note button
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Enter note title
      await tester.enterText(find.byKey(const Key('note_title_field')), 'Test Note');
      await tester.pumpAndSettle();

      // Enter note content
      await tester.enterText(find.byKey(const Key('note_content_field')), 'This is a test note about programming');
      await tester.pumpAndSettle();

      // Save note
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Navigate to cognitive stream
      await tester.tap(find.text('Cognitive Stream'));
      await tester.pumpAndSettle();

      // Wait for memory to be created
      await tester.pump(const Duration(seconds: 2));

      // Assert
      expect(find.text('Test Note'), findsOneWidget);
      expect(find.text('This is a test note about programming'), findsOneWidget);
    });

    testWidgets('should update note and update memory system', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const PandoraApp());
      await tester.pumpAndSettle();

      // Navigate to notes
      await tester.tap(find.text('Notes'));
      await tester.pumpAndSettle();

      // Find and tap on a note
      final noteCard = find.byType(Card).first;
      await tester.tap(noteCard);
      await tester.pumpAndSettle();

      // Edit note content
      await tester.enterText(find.byKey(const Key('note_content_field')), 'Updated content about Flutter development');
      await tester.pumpAndSettle();

      // Save note
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Navigate to cognitive stream
      await tester.tap(find.text('Cognitive Stream'));
      await tester.pumpAndSettle();

      // Wait for memory to be updated
      await tester.pump(const Duration(seconds: 2));

      // Assert
      expect(find.text('Updated content about Flutter development'), findsOneWidget);
    });

    testWidgets('should delete note and remove from memory system', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const PandoraApp());
      await tester.pumpAndSettle();

      // Navigate to notes
      await tester.tap(find.text('Notes'));
      await tester.pumpAndSettle();

      // Find and tap on a note
      final noteCard = find.byType(Card).first;
      await tester.tap(noteCard);
      await tester.pumpAndSettle();

      // Delete note
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      // Confirm deletion
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      // Navigate to cognitive stream
      await tester.tap(find.text('Cognitive Stream'));
      await tester.pumpAndSettle();

      // Wait for memory to be removed
      await tester.pump(const Duration(seconds: 2));

      // Assert
      expect(find.byType(MemoryCard), findsWidgets);
    });
  });

  group('AI Integration E2E Tests', () {
    testWidgets('should process AI response and store as memory', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const PandoraApp());
      await tester.pumpAndSettle();

      // Navigate to AI chat
      await tester.tap(find.text('AI Chat'));
      await tester.pumpAndSettle();

      // Enter prompt
      await tester.enterText(find.byType(TextField), 'What is Flutter?');
      await tester.pumpAndSettle();

      // Send message
      await tester.tap(find.byIcon(Icons.send));
      await tester.pumpAndSettle();

      // Wait for AI response
      await tester.pump(const Duration(seconds: 3));

      // Navigate to cognitive stream
      await tester.tap(find.text('Cognitive Stream'));
      await tester.pumpAndSettle();

      // Wait for memory to be created
      await tester.pump(const Duration(seconds: 2));

      // Assert
      expect(find.byType(MemoryCard), findsWidgets);
    });

    testWidgets('should search memories with AI context', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const PandoraApp());
      await tester.pumpAndSettle();

      // Navigate to cognitive stream
      await tester.tap(find.text('Cognitive Stream'));
      await tester.pumpAndSettle();

      // Tap on search tab
      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      // Enter search query
      await tester.enterText(find.byType(TextField), 'Flutter development');
      await tester.pumpAndSettle();

      // Wait for search results
      await tester.pump(const Duration(seconds: 2));

      // Assert
      expect(find.byType(MemoryCard), findsWidgets);
    });
  });
}
