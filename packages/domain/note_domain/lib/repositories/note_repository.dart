import 'package:common_entities/common_entities.dart';

/// Abstract repository for note operations
///
/// This repository defines the contract for note-related operations
/// following Clean Architecture principles.
abstract class NoteRepository {
  /// Get all notes
  Future<List<Note>> getAllNotes();

  /// Get note by ID
  Future<Note?> getNoteById(String id);

  /// Create a new note
  Future<String> createNote(Note note);

  /// Update an existing note
  Future<void> updateNote(Note note);

  /// Delete a note
  Future<void> deleteNote(String id);

  /// Search notes by query
  Future<List<Note>> searchNotes(String query);

  /// Get notes by category
  Future<List<Note>> getNotesByCategory(String category);

  /// Get notes by tag
  Future<List<Note>> getNotesByTag(String tag);

  /// Get pinned notes
  Future<List<Note>> getPinnedNotes();

  /// Get recent notes
  Future<List<Note>> getRecentNotes({int? limit});

  /// Get notes by date range
  Future<List<Note>> getNotesByDateRange(DateTime start, DateTime end);

  /// Get all categories
  Future<List<String>> getAllCategories();

  /// Get all tags
  Future<List<String>> getAllTags();

  /// Pin/unpin a note
  Future<void> togglePin(String noteId);

  /// Archive/unarchive a note
  Future<void> toggleArchive(String noteId);

  /// Export notes
  Future<String> exportNotes(List<String> noteIds, String format);

  /// Import notes
  Future<List<String>> importNotes(String data, String format);

  /// Get note statistics
  Future<Map<String, dynamic>> getStatistics();

  /// Sync notes with remote
  Future<void> syncNotes();

  /// Check if notes are synced
  Future<bool> isSynced();
}

