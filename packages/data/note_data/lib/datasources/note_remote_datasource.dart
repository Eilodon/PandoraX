import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common_entities/common_entities.dart';
import 'package:core_utils/core_utils.dart';

/// Remote data source for notes using Firestore
class NoteRemoteDataSource {
  late FirebaseFirestore _firestore;
  late String _userId;
  bool _isInitialized = false;

  /// Initialize remote data source
  Future<void> initialize(String userId) async {
    try {
      AppLogger.info('Initializing Note Remote DataSource for user: $userId');
      
      _firestore = FirebaseFirestore.instance;
      _userId = userId;
      _isInitialized = true;
      
      AppLogger.success('Note Remote DataSource initialized successfully');
    } catch (e) {
      AppLogger.error('Failed to initialize Note Remote DataSource', e);
      rethrow;
    }
  }

  /// Get all notes from Firestore
  Future<List<Note>> getAllNotes() async {
    if (!_isInitialized) {
      throw Exception('NoteRemoteDataSource not initialized');
    }

    try {
      AppLogger.info('Fetching all notes from Firestore');
      
      final snapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('notes')
          .orderBy('updatedAt', descending: true)
          .get();

      final notes = snapshot.docs
          .map((doc) => Note.fromJson({
                'id': doc.id,
                ...doc.data(),
              }))
          .toList();

      AppLogger.success('Fetched ${notes.length} notes from Firestore');
      return notes;
    } catch (e) {
      AppLogger.error('Failed to fetch notes from Firestore', e);
      rethrow;
    }
  }

  /// Get note by ID
  Future<Note?> getNoteById(String id) async {
    if (!_isInitialized) {
      throw Exception('NoteRemoteDataSource not initialized');
    }

    try {
      AppLogger.info('Fetching note by ID: $id');
      
      final doc = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('notes')
          .doc(id)
          .get();

      if (!doc.exists) {
        AppLogger.warning('Note not found: $id');
        return null;
      }

      final note = Note.fromJson({
        'id': doc.id,
        ...doc.data()!,
      });

      AppLogger.success('Note fetched successfully: $id');
      return note;
    } catch (e) {
      AppLogger.error('Failed to fetch note by ID: $id', e);
      rethrow;
    }
  }

  /// Create note in Firestore
  Future<String> createNote(Note note) async {
    if (!_isInitialized) {
      throw Exception('NoteRemoteDataSource not initialized');
    }

    try {
      AppLogger.info('Creating note in Firestore: ${note.title}');
      
      final docRef = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('notes')
          .add(note.toJson());

      AppLogger.success('Note created successfully: ${docRef.id}');
      return docRef.id;
    } catch (e) {
      AppLogger.error('Failed to create note in Firestore', e);
      rethrow;
    }
  }

  /// Update note in Firestore
  Future<void> updateNote(Note note) async {
    if (!_isInitialized) {
      throw Exception('NoteRemoteDataSource not initialized');
    }

    try {
      AppLogger.info('Updating note in Firestore: ${note.id}');
      
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('notes')
          .doc(note.id)
          .update(note.toJson());

      AppLogger.success('Note updated successfully: ${note.id}');
    } catch (e) {
      AppLogger.error('Failed to update note in Firestore: ${note.id}', e);
      rethrow;
    }
  }

  /// Delete note from Firestore
  Future<void> deleteNote(String id) async {
    if (!_isInitialized) {
      throw Exception('NoteRemoteDataSource not initialized');
    }

    try {
      AppLogger.info('Deleting note from Firestore: $id');
      
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('notes')
          .doc(id)
          .delete();

      AppLogger.success('Note deleted successfully: $id');
    } catch (e) {
      AppLogger.error('Failed to delete note from Firestore: $id', e);
      rethrow;
    }
  }

  /// Search notes in Firestore
  Future<List<Note>> searchNotes(String query) async {
    if (!_isInitialized) {
      throw Exception('NoteRemoteDataSource not initialized');
    }

    try {
      AppLogger.info('Searching notes in Firestore: $query');
      
      final snapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('notes')
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThan: query + 'z')
          .get();

      final notes = snapshot.docs
          .map((doc) => Note.fromJson({
                'id': doc.id,
                ...doc.data(),
              }))
          .toList();

      AppLogger.success('Found ${notes.length} notes matching query: $query');
      return notes;
    } catch (e) {
      AppLogger.error('Failed to search notes in Firestore', e);
      rethrow;
    }
  }

  /// Get notes by category
  Future<List<Note>> getNotesByCategory(String category) async {
    if (!_isInitialized) {
      throw Exception('NoteRemoteDataSource not initialized');
    }

    try {
      AppLogger.info('Fetching notes by category: $category');
      
      final snapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('notes')
          .where('category', isEqualTo: category)
          .orderBy('updatedAt', descending: true)
          .get();

      final notes = snapshot.docs
          .map((doc) => Note.fromJson({
                'id': doc.id,
                ...doc.data(),
              }))
          .toList();

      AppLogger.success('Fetched ${notes.length} notes for category: $category');
      return notes;
    } catch (e) {
      AppLogger.error('Failed to fetch notes by category: $category', e);
      rethrow;
    }
  }

  /// Get notes by tags
  Future<List<Note>> getNotesByTags(List<String> tags) async {
    if (!_isInitialized) {
      throw Exception('NoteRemoteDataSource not initialized');
    }

    try {
      AppLogger.info('Fetching notes by tags: $tags');
      
      final snapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('notes')
          .where('tags', arrayContainsAny: tags)
          .orderBy('updatedAt', descending: true)
          .get();

      final notes = snapshot.docs
          .map((doc) => Note.fromJson({
                'id': doc.id,
                ...doc.data(),
              }))
          .toList();

      AppLogger.success('Fetched ${notes.length} notes for tags: $tags');
      return notes;
    } catch (e) {
      AppLogger.error('Failed to fetch notes by tags: $tags', e);
      rethrow;
    }
  }

  /// Sync notes with local data
  Future<void> syncNotes(List<Note> localNotes) async {
    if (!_isInitialized) {
      throw Exception('NoteRemoteDataSource not initialized');
    }

    try {
      AppLogger.info('Syncing ${localNotes.length} notes with Firestore');
      
      final batch = _firestore.batch();
      
      for (final note in localNotes) {
        final docRef = _firestore
            .collection('users')
            .doc(_userId)
            .collection('notes')
            .doc(note.id);
        
        batch.set(docRef, note.toJson(), SetOptions(merge: true));
      }
      
      await batch.commit();
      
      AppLogger.success('Notes synced successfully with Firestore');
    } catch (e) {
      AppLogger.error('Failed to sync notes with Firestore', e);
      rethrow;
    }
  }

  /// Listen to notes changes
  Stream<List<Note>> listenToNotes() {
    if (!_isInitialized) {
      throw Exception('NoteRemoteDataSource not initialized');
    }

    return _firestore
        .collection('users')
        .doc(_userId)
        .collection('notes')
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Note.fromJson({
                  'id': doc.id,
                  ...doc.data(),
                }))
            .toList());
  }

  /// Check if service is initialized
  bool get isInitialized => _isInitialized;
}
