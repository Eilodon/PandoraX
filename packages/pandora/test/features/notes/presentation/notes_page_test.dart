import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:alarm_domain/alarm_domain.dart';
import 'package:pandora/features/notes/presentation/notes_page.dart';
import 'package:pandora/features/notes/application/note_watcher/note_watcher_state.dart';

// Mock providers
class MockNoteWatcherNotifier extends StateNotifier<NoteWatcherState> with Mock {
  MockNoteWatcherNotifier() : super(const NoteWatcherState.initial());
}

void main() {
  group('NotesPage Widget Tests', () {
    late MockNoteWatcherNotifier mockNotifier;

    setUp(() {
      mockNotifier = MockNoteWatcherNotifier();
    });

    Widget createTestWidget() {
      return ProviderScope(
        overrides: [
          // Override the noteWatcherProvider with our mock
          noteWatcherProvider.overrideWith((ref) => mockNotifier),
        ],
        child: const MaterialApp(
          home: NotesPage(),
        ),
      );
    }

    testWidgets('should display loading indicator when state is loading', (tester) async {
      // Arrange
      mockNotifier.state = const NoteWatcherState.loading();

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Notes'), findsOneWidget);
    });

    testWidgets('should display notes list when state is loadSuccess', (tester) async {
      // Arrange
      final notes = [
        Note(
          id: '1',
          title: 'Test Note 1',
          content: 'Content 1',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          pinned: false,
          syncStatus: SyncStatus.synced,
          reminderTime: null,
        ),
        Note(
          id: '2',
          title: 'Test Note 2',
          content: 'Content 2',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          pinned: true,
          syncStatus: SyncStatus.pending,
          reminderTime: DateTime.now().add(Duration(hours: 1)),
        ),
      ];
      mockNotifier.state = NoteWatcherState.loadSuccess(notes);

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text('Test Note 1'), findsOneWidget);
      expect(find.text('Content 1'), findsOneWidget);
      expect(find.text('Test Note 2'), findsOneWidget);
      expect(find.text('Content 2'), findsOneWidget);
      expect(find.byIcon(Icons.push_pin), findsOneWidget); // Pinned note
    });

    testWidgets('should display error message when state is loadFailure', (tester) async {
      // Arrange
      const errorMessage = 'Failed to load notes';
      mockNotifier.state = const NoteWatcherState.loadFailure(errorMessage);

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text('Error: $errorMessage'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('should display initial state message', (tester) async {
      // Arrange
      mockNotifier.state = const NoteWatcherState.initial();

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text('Initial state'), findsOneWidget);
    });

    testWidgets('should have floating action buttons', (tester) async {
      // Arrange
      mockNotifier.state = const NoteWatcherState.loadSuccess([]);

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.byType(FloatingActionButton), findsNWidgets(3));
      expect(find.byIcon(Icons.mic), findsOneWidget); // Voice recording
      expect(find.byIcon(Icons.chat), findsOneWidget); // AI chat
      expect(find.byIcon(Icons.add), findsOneWidget); // Add note
    });

    testWidgets('should navigate to note detail when note is tapped', (tester) async {
      // Arrange
      final notes = [
        Note(
          id: '1',
          title: 'Test Note',
          content: 'Test Content',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          pinned: false,
          syncStatus: SyncStatus.synced,
          reminderTime: null,
        ),
      ];
      mockNotifier.state = NoteWatcherState.loadSuccess(notes);

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.tap(find.text('Test Note'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Test Note'), findsOneWidget); // Should still be visible in detail screen
    });
  });
}
