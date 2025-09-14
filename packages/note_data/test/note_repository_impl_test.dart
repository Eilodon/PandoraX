import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:isar/isar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alarm_domain/alarm_domain.dart';
import 'package:alarm_data/alarm_data.dart';

// Mock classes
class MockIsar extends Mock implements Isar {}
class MockIsarCollection extends Mock implements IsarCollection<NoteIsarModel> {}
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}
class MockQuerySnapshot extends Mock implements QuerySnapshot<Map<String, dynamic>> {}
class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot<Map<String, dynamic>> {}

void main() {
  late NoteRepositoryImpl repository;
  late MockIsar mockIsar;
  late MockIsarCollection mockIsarCollection;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockCollectionRef;
  late MockDocumentReference mockDocumentRef;

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(NoteIsarModel(
      id: 'test-id',
      title: 'Test Title',
      content: 'Test Content',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      pinned: false,
      syncStatus: SyncStatus.synced,
      reminderTime: null,
    ));
  });

  setUp(() {
    mockIsar = MockIsar();
    mockIsarCollection = MockIsarCollection();
    mockFirestore = MockFirebaseFirestore();
    mockCollectionRef = MockCollectionReference();
    mockDocumentRef = MockDocumentReference();

    // Setup mock behavior
    when(() => mockIsar.notes).thenReturn(mockIsarCollection);
    when(() => mockFirestore.collection('notes')).thenReturn(mockCollectionRef);
    when(() => mockCollectionRef.doc(any())).thenReturn(mockDocumentRef);

    repository = NoteRepositoryImpl(mockIsar, mockFirestore);
  });

  group('NoteRepositoryImpl', () {
    group('saveNote', () {
      test('should write to Isar with pending status when offline', () async {
        // Arrange
        final note = Note(
          id: 'test-id',
          title: 'Test Title',
          content: 'Test Content',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          pinned: false,
          syncStatus: SyncStatus.synced,
          reminderTime: null,
        );

        when(() => mockIsarCollection.putById(any())).thenAnswer((_) async => 1);

        // Act
        await repository.saveNote(note);

        // Assert
        verify(() => mockIsarCollection.putById(any(that: predicate((model) => 
          model is NoteIsarModel && 
          model.syncStatus == SyncStatus.pending
        )))).called(1);
      });

      test('should sync to Firestore when online', () async {
        // Arrange
        final note = Note(
          id: 'test-id',
          title: 'Test Title',
          content: 'Test Content',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          pinned: false,
          syncStatus: SyncStatus.synced,
          reminderTime: null,
        );

        when(() => mockIsarCollection.putById(any())).thenAnswer((_) async => 1);
        when(() => mockDocumentRef.set(any())).thenAnswer((_) async {});

        // Act
        await repository.saveNote(note);

        // Assert
        verify(() => mockDocumentRef.set(any())).called(1);
        verify(() => mockIsarCollection.putById(any(that: predicate((model) => 
          model is NoteIsarModel && 
          model.syncStatus == SyncStatus.synced
        )))).called(1);
      });

      test('should handle Firestore error gracefully', () async {
        // Arrange
        final note = Note(
          id: 'test-id',
          title: 'Test Title',
          content: 'Test Content',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          pinned: false,
          syncStatus: SyncStatus.synced,
          reminderTime: null,
        );

        when(() => mockIsarCollection.putById(any())).thenAnswer((_) async => 1);
        when(() => mockDocumentRef.set(any())).thenThrow(Exception('Firestore error'));

        // Act
        await repository.saveNote(note);

        // Assert
        verify(() => mockIsarCollection.putById(any(that: predicate((model) => 
          model is NoteIsarModel && 
          model.syncStatus == SyncStatus.pending
        )))).called(1);
      });
    });

    group('getAllNotes', () {
      test('should return notes from Isar', () async {
        // Arrange
        final now = DateTime.now();
        final note1 = NoteIsarModel(
          id: 'id1',
          title: 'Title 1',
          content: 'Content 1',
          createdAt: now,
          updatedAt: now,
          pinned: false,
          syncStatus: SyncStatus.synced,
          reminderTime: null,
        );
        final note2 = NoteIsarModel(
          id: 'id2',
          title: 'Title 2',
          content: 'Content 2',
          createdAt: now,
          updatedAt: now,
          pinned: true,
          syncStatus: SyncStatus.pending,
          reminderTime: now.add(Duration(hours: 1)),
        );

        when(() => mockIsarCollection.where()).thenReturn(mockIsarCollection);
        when(() => mockIsarCollection.findAll()).thenAnswer((_) async => [note1, note2]);

        // Act
        final result = await repository.getAllNotes();

        // Assert
        expect(result, hasLength(2));
        expect(result[0].id, equals('id1'));
        expect(result[0].title, equals('Title 1'));
        expect(result[1].id, equals('id2'));
        expect(result[1].pinned, isTrue);
        expect(result[1].reminderTime, isNotNull);
      });

      test('should return empty list when no notes exist', () async {
        // Arrange
        when(() => mockIsarCollection.where()).thenReturn(mockIsarCollection);
        when(() => mockIsarCollection.findAll()).thenAnswer((_) async => []);

        // Act
        final result = await repository.getAllNotes();

        // Assert
        expect(result, isEmpty);
      });
    });

    group('deleteNote', () {
      test('should delete note from Isar and Firestore', () async {
        // Arrange
        const noteId = 'test-id';
        when(() => mockIsarCollection.deleteById(noteId)).thenAnswer((_) async => true);
        when(() => mockDocumentRef.delete()).thenAnswer((_) async {});

        // Act
        await repository.deleteNote(noteId);

        // Assert
        verify(() => mockIsarCollection.deleteById(noteId)).called(1);
        verify(() => mockDocumentRef.delete()).called(1);
      });

      test('should handle Isar deletion failure', () async {
        // Arrange
        const noteId = 'test-id';
        when(() => mockIsarCollection.deleteById(noteId)).thenAnswer((_) async => false);

        // Act & Assert
        expect(() => repository.deleteNote(noteId), throwsException);
      });
    });

    group('syncNotes', () {
      test('should sync pending notes to Firestore', () async {
        // Arrange
        final now = DateTime.now();
        final pendingNote = NoteIsarModel(
          id: 'pending-id',
          title: 'Pending Title',
          content: 'Pending Content',
          createdAt: now,
          updatedAt: now,
          pinned: false,
          syncStatus: SyncStatus.pending,
          reminderTime: null,
        );

        when(() => mockIsarCollection.where()).thenReturn(mockIsarCollection);
        when(() => mockIsarCollection.filter()).thenReturn(mockIsarCollection);
        when(() => mockIsarCollection.findAll()).thenAnswer((_) async => [pendingNote]);
        when(() => mockDocumentRef.set(any())).thenAnswer((_) async {});
        when(() => mockIsarCollection.putById(any())).thenAnswer((_) async => 1);

        // Act
        await repository.syncNotes();

        // Assert
        verify(() => mockDocumentRef.set(any())).called(1);
        verify(() => mockIsarCollection.putById(any(that: predicate((model) => 
          model is NoteIsarModel && 
          model.syncStatus == SyncStatus.synced
        )))).called(1);
      });
    });
  });
}
