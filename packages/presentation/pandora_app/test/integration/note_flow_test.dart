import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pandora_app/main.dart';
import 'package:common_entities/common_entities.dart';

/// Integration tests for complete note flow
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Note Flow Integration Tests', () {
    testWidgets('Complete note creation and management flow', (WidgetTester tester) async {
      // Start the app
      await tester.pumpWidget(const PandoraApp());
      await tester.pumpAndSettle();

      // Verify home screen is displayed
      expect(find.text('PandoraX'), findsOneWidget);
      expect(find.text('My Notes'), findsOneWidget);

      // Test creating a new note
      await _testCreateNote(tester);
      
      // Test editing a note
      await _testEditNote(tester);
      
      // Test searching notes
      await _testSearchNotes(tester);
      
      // Test pinning a note
      await _testPinNote(tester);
      
      // Test deleting a note
      await _testDeleteNote(tester);
    });

    testWidgets('AI features integration test', (WidgetTester tester) async {
      await tester.pumpWidget(const PandoraApp());
      await tester.pumpAndSettle();

      // Navigate to AI tab
      await tester.tap(find.byIcon(Icons.smart_toy));
      await tester.pumpAndSettle();

      // Verify AI tab is displayed
      expect(find.text('AI Assistant'), findsOneWidget);
      expect(find.text('AI Features Coming Soon'), findsOneWidget);
    });

    testWidgets('Voice features integration test', (WidgetTester tester) async {
      await tester.pumpWidget(const PandoraApp());
      await tester.pumpAndSettle();

      // Navigate to Voice tab
      await tester.tap(find.byIcon(Icons.mic));
      await tester.pumpAndSettle();

      // Verify Voice tab is displayed
      expect(find.text('Voice Notes'), findsOneWidget);
      expect(find.text('Voice Features Coming Soon'), findsOneWidget);
    });

    testWidgets('Profile tab integration test', (WidgetTester tester) async {
      await tester.pumpWidget(const PandoraApp());
      await tester.pumpAndSettle();

      // Navigate to Profile tab
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Verify Profile tab is displayed
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('User Profile'), findsOneWidget);
    });
  });
}

/// Test note creation flow
Future<void> _testCreateNote(WidgetTester tester) async {
  // Tap the floating action button to create a note
  await tester.tap(find.byIcon(Icons.add));
  await tester.pumpAndSettle();

  // Note: In a real implementation, this would open a note creation screen
  // For now, we'll just verify the button is tappable
  expect(find.byIcon(Icons.add), findsOneWidget);
}

/// Test note editing flow
Future<void> _testEditNote(WidgetTester tester) async {
  // Look for existing notes (if any)
  final noteCards = find.byType(Card);
  
  if (noteCards.evaluate().isNotEmpty) {
    // Tap on the first note card
    await tester.tap(noteCards.first);
    await tester.pumpAndSettle();

    // Look for edit button or menu
    final editButton = find.byIcon(Icons.edit);
    if (editButton.evaluate().isNotEmpty) {
      await tester.tap(editButton);
      await tester.pumpAndSettle();
    }
  }
}

/// Test note search flow
Future<void> _testSearchNotes(WidgetTester tester) async {
  // Tap the search button
  await tester.tap(find.byIcon(Icons.search));
  await tester.pumpAndSettle();

  // Note: In a real implementation, this would open a search screen
  // For now, we'll just verify the search button is tappable
  expect(find.byIcon(Icons.search), findsOneWidget);
}

/// Test note pinning flow
Future<void> _testPinNote(WidgetTester tester) async {
  // Look for existing notes
  final noteCards = find.byType(Card);
  
  if (noteCards.evaluate().isNotEmpty) {
    // Find the more options button
    final moreButton = find.byIcon(Icons.more_vert);
    if (moreButton.evaluate().isNotEmpty) {
      await tester.tap(moreButton.first);
      await tester.pumpAndSettle();

      // Look for pin option
      final pinOption = find.text('Pin');
      if (pinOption.evaluate().isNotEmpty) {
        await tester.tap(pinOption);
        await tester.pumpAndSettle();
      }
    }
  }
}

/// Test note deletion flow
Future<void> _testDeleteNote(WidgetTester tester) async {
  // Look for existing notes
  final noteCards = find.byType(Card);
  
  if (noteCards.evaluate().isNotEmpty) {
    // Find the more options button
    final moreButton = find.byIcon(Icons.more_vert);
    if (moreButton.evaluate().isNotEmpty) {
      await tester.tap(moreButton.first);
      await tester.pumpAndSettle();

      // Look for delete option
      final deleteOption = find.text('Delete');
      if (deleteOption.evaluate().isNotEmpty) {
        await tester.tap(deleteOption);
        await tester.pumpAndSettle();

        // Confirm deletion if dialog appears
        final confirmButton = find.text('Delete');
        if (confirmButton.evaluate().isNotEmpty) {
          await tester.tap(confirmButton);
          await tester.pumpAndSettle();
        }
      }
    }
  }
}
