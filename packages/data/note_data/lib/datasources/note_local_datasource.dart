import 'package:isar/isar.dart';
import 'package:common_entities/common_entities.dart';
import 'package:core_utils/core_utils.dart';
import '../models/note_model.dart';

/// Local data source for note operations using Isar database
class NoteLocalDataSource {
  Isar? _isar;

  /// Initialize the local database
  Future<void> initialize() async {
    try {
      AppLogger.info('📝 Initializing note local data source...');

      _isar = await Isar.open([
        NoteModelSchema,
      ]);

      AppLogger.success('Note local data source initialized successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to initialize note local data source', e, stackTrace);
      rethrow;
    }
  }

  /// Get all notes
  Future<List<Note>> getAllNotes() async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      final models = await _isar!.noteModels.where().findAll();
      return models.map((model) => model.toNote()).toList();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get all notes', e, stackTrace);
      return [];
    }
  }

  /// Get note by ID
  Future<Note?> getNoteById(String id) async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      final model = await _isar!.noteModels.get(id);
      return model?.toNote();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get note by ID', e, stackTrace);
      return null;
    }
  }

  /// Create a new note
  Future<String> createNote(Note note) async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      final model = NoteModel.fromNote(note);

      await _isar!.writeTxn(() async {
        await _isar!.noteModels.put(model);
      });

      AppLogger.info('Note created successfully: ${note.id}');
      return note.id;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to create note', e, stackTrace);
      rethrow;
    }
  }

  /// Update an existing note
  Future<void> updateNote(Note note) async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      final model = NoteModel.fromNote(note);

      await _isar!.writeTxn(() async {
        await _isar!.noteModels.put(model);
      });

      AppLogger.info('Note updated successfully: ${note.id}');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to update note', e, stackTrace);
      rethrow;
    }
  }

  /// Delete a note
  Future<void> deleteNote(String id) async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      await _isar!.writeTxn(() async {
        await _isar!.noteModels.delete(id);
      });

      AppLogger.info('Note deleted successfully: $id');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to delete note', e, stackTrace);
      rethrow;
    }
  }

  /// Search notes by query
  Future<List<Note>> searchNotes(String query) async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      final models = await _isar!.noteModels
          .filter()
          .or()
          .titleContains(query, caseSensitive: false)
          .or()
          .contentContains(query, caseSensitive: false)
          .findAll();

      return models.map((model) => model.toNote()).toList();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to search notes', e, stackTrace);
      return [];
    }
  }

  /// Get notes by category
  Future<List<Note>> getNotesByCategory(String category) async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      final models = await _isar!.noteModels
          .filter()
          .categoryEqualTo(category)
          .findAll();

      return models.map((model) => model.toNote()).toList();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get notes by category', e, stackTrace);
      return [];
    }
  }

  /// Get notes by tag
  Future<List<Note>> getNotesByTag(String tag) async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      final models = await _isar!.noteModels
          .filter()
          .tagsElementEqualTo(tag)
          .findAll();

      return models.map((model) => model.toNote()).toList();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get notes by tag', e, stackTrace);
      return [];
    }
  }

  /// Get pinned notes
  Future<List<Note>> getPinnedNotes() async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      final models = await _isar!.noteModels
          .filter()
          .isPinnedEqualTo(true)
          .findAll();

      return models.map((model) => model.toNote()).toList();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get pinned notes', e, stackTrace);
      return [];
    }
  }

  /// Get recent notes
  Future<List<Note>> getRecentNotes({int? limit}) async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      final query = _isar!.noteModels
          .where()
          .sortByUpdatedAtDesc();

      final models = limit != null
          ? await query.limit(limit).findAll()
          : await query.findAll();

      return models.map((model) => model.toNote()).toList();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get recent notes', e, stackTrace);
      return [];
    }
  }

  /// Get notes by date range
  Future<List<Note>> getNotesByDateRange(DateTime start, DateTime end) async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      final models = await _isar!.noteModels
          .filter()
          .createdAtBetween(start, end)
          .findAll();

      return models.map((model) => model.toNote()).toList();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get notes by date range', e, stackTrace);
      return [];
    }
  }

  /// Get all categories
  Future<List<String>> getAllCategories() async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      final models = await _isar!.noteModels
          .where()
          .categoryIsNotNull()
          .findAll();

      final categories = models
          .map((model) => model.category)
          .where((category) => category != null)
          .cast<String>()
          .toSet()
          .toList();

      return categories;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get all categories', e, stackTrace);
      return [];
    }
  }

  /// Get all tags
  Future<List<String>> getAllTags() async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      final models = await _isar!.noteModels
          .where()
          .tagsIsNotEmpty()
          .findAll();

      final tags = <String>{};
      for (final model in models) {
        tags.addAll(model.tags);
      }

      return tags.toList();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get all tags', e, stackTrace);
      return [];
    }
  }

  /// Toggle pin status
  Future<void> togglePin(String noteId) async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      final model = await _isar!.noteModels.get(noteId);
      if (model != null) {
        model.isPinned = !model.isPinned;
        await _isar!.writeTxn(() async {
          await _isar!.noteModels.put(model);
        });
      }
    } catch (e, stackTrace) {
      AppLogger.error('Failed to toggle pin', e, stackTrace);
      rethrow;
    }
  }

  /// Toggle archive status
  Future<void> toggleArchive(String noteId) async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      final model = await _isar!.noteModels.get(noteId);
      if (model != null) {
        model.isArchived = !model.isArchived;
        await _isar!.writeTxn(() async {
          await _isar!.noteModels.put(model);
        });
      }
    } catch (e, stackTrace) {
      AppLogger.error('Failed to toggle archive', e, stackTrace);
      rethrow;
    }
  }

  /// Get note statistics
  Future<NoteStatistics> getStatistics() async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      final allNotes = await _isar!.noteModels.where().findAll();

      final totalNotes = allNotes.length;
      final pinnedNotes = allNotes.where((note) => note.isPinned).length;
      final archivedNotes = allNotes.where((note) => note.isArchived).length;

      int totalWords = 0;
      int totalCharacters = 0;
      final categoryCounts = <String, int>{};
      final tagCounts = <String, int>{};

      for (final note in allNotes) {
        totalWords += note.content.split(' ').length;
        totalCharacters += note.content.length;

        if (note.category != null) {
          categoryCounts[note.category!] = (categoryCounts[note.category!] ?? 0) + 1;
        }

        for (final tag in note.tags) {
          tagCounts[tag] = (tagCounts[tag] ?? 0) + 1;
        }
      }

      return NoteStatistics(
        totalNotes: totalNotes,
        pinnedNotes: pinnedNotes,
        archivedNotes: archivedNotes,
        totalWords: totalWords,
        totalCharacters: totalCharacters,
        categoryCounts: categoryCounts,
        tagCounts: tagCounts,
        lastUpdated: DateTime.now(),
      );
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get statistics', e, stackTrace);
      rethrow;
    }
  }

  /// Clear all notes
  Future<void> clearAllNotes() async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      await _isar!.writeTxn(() async {
        await _isar!.noteModels.clear();
      });

      AppLogger.info('All notes cleared');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to clear all notes', e, stackTrace);
      rethrow;
    }
  }

  /// Dispose resources
  Future<void> dispose() async {
    await _isar?.close();
    _isar = null;
  }
}
