import 'package:common_entities/common_entities.dart';
import 'package:note_domain/note_domain.dart';
import 'package:core_utils/core_utils.dart';
import 'export_import_service.dart';

/// Real note service using actual database implementation
class RealNoteService implements NoteRepository {
  final NoteRepository _repository;
  final ExportImportService _exportImportService = ExportImportService();

  RealNoteService(this._repository);

  @override
  Future<List<Note>> getAllNotes() async {
    try {
      AppLogger.info('📝 Getting all notes from database...');
      final notes = await _repository.getAllNotes();
      AppLogger.success('Retrieved ${notes.length} notes from database');
      return notes;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get all notes', e, stackTrace);
      return [];
    }
  }

  @override
  Future<Note?> getNoteById(String id) async {
    try {
      AppLogger.info('📝 Getting note by ID: $id');
      final note = await _repository.getNoteById(id);
      if (note != null) {
        AppLogger.success('Note found: ${note.title}');
      } else {
        AppLogger.warning('Note not found with ID: $id');
      }
      return note;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get note by ID', e, stackTrace);
      return null;
    }
  }

  @override
  Future<String> createNote(Note note) async {
    try {
      AppLogger.info('📝 Creating new note: ${note.title}');
      final noteId = await _repository.createNote(note);
      AppLogger.success('Note created successfully with ID: $noteId');
      return noteId;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to create note', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> updateNote(Note note) async {
    try {
      AppLogger.info('📝 Updating note: ${note.title}');
      await _repository.updateNote(note);
      AppLogger.success('Note updated successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to update note', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    try {
      AppLogger.info('📝 Deleting note with ID: $id');
      await _repository.deleteNote(id);
      AppLogger.success('Note deleted successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to delete note', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<Note>> searchNotes(String query) async {
    try {
      AppLogger.info('🔍 Searching notes with query: $query');
      final notes = await _repository.searchNotes(query);
      AppLogger.success('Found ${notes.length} notes matching query');
      return notes;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to search notes', e, stackTrace);
      return [];
    }
  }

  @override
  Future<List<Note>> getNotesByCategory(String category) async {
    try {
      AppLogger.info('📁 Getting notes by category: $category');
      final notes = await _repository.getNotesByCategory(category);
      AppLogger.success('Found ${notes.length} notes in category: $category');
      return notes;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get notes by category', e, stackTrace);
      return [];
    }
  }

  @override
  Future<List<Note>> getNotesByTag(String tag) async {
    try {
      AppLogger.info('🏷️ Getting notes by tag: $tag');
      final notes = await _repository.getNotesByTag(tag);
      AppLogger.success('Found ${notes.length} notes with tag: $tag');
      return notes;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get notes by tag', e, stackTrace);
      return [];
    }
  }

  @override
  Future<List<Note>> getPinnedNotes() async {
    try {
      AppLogger.info('📌 Getting pinned notes');
      final notes = await _repository.getPinnedNotes();
      AppLogger.success('Found ${notes.length} pinned notes');
      return notes;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get pinned notes', e, stackTrace);
      return [];
    }
  }

  @override
  Future<List<Note>> getRecentNotes({int? limit}) async {
    try {
      AppLogger.info('🕒 Getting recent notes (limit: ${limit ?? 'none'})');
      final notes = await _repository.getRecentNotes(limit: limit);
      AppLogger.success('Found ${notes.length} recent notes');
      return notes;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get recent notes', e, stackTrace);
      return [];
    }
  }

  @override
  Future<List<Note>> getNotesByDateRange(DateTime start, DateTime end) async {
    try {
      AppLogger.info('📅 Getting notes by date range: $start to $end');
      final notes = await _repository.getNotesByDateRange(start, end);
      AppLogger.success('Found ${notes.length} notes in date range');
      return notes;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get notes by date range', e, stackTrace);
      return [];
    }
  }

  @override
  Future<List<String>> getAllCategories() async {
    try {
      AppLogger.info('📁 Getting all categories');
      final categories = await _repository.getAllCategories();
      AppLogger.success('Found ${categories.length} categories');
      return categories;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get all categories', e, stackTrace);
      return [];
    }
  }

  @override
  Future<List<String>> getAllTags() async {
    try {
      AppLogger.info('🏷️ Getting all tags');
      final tags = await _repository.getAllTags();
      AppLogger.success('Found ${tags.length} tags');
      return tags;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get all tags', e, stackTrace);
      return [];
    }
  }

  @override
  Future<void> togglePin(String noteId) async {
    try {
      AppLogger.info('📌 Toggling pin for note: $noteId');
      await _repository.togglePin(noteId);
      AppLogger.success('Pin toggled successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to toggle pin', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> toggleArchive(String noteId) async {
    try {
      AppLogger.info('📦 Toggling archive for note: $noteId');
      await _repository.toggleArchive(noteId);
      AppLogger.success('Archive toggled successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to toggle archive', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<String> exportNotes(List<String> noteIds, String format) async {
    try {
      AppLogger.info('📤 Exporting ${noteIds.length} notes in $format format');
      
      // Get notes by IDs
      final List<Note> notes = [];
      for (final id in noteIds) {
        final note = await _repository.getNoteById(id);
        if (note != null) {
          notes.add(note);
        }
      }
      
      // Export using real service
      String exportData;
      switch (format.toLowerCase()) {
        case 'json':
          exportData = await _exportImportService.exportNotesToJson(notes);
          break;
        case 'csv':
          exportData = await _exportImportService.exportNotesToCsv(notes);
          break;
        case 'txt':
          exportData = await _exportImportService.exportNotesToTxt(notes);
          break;
        default:
          throw Exception('Unsupported export format: $format');
      }
      
      AppLogger.success('Notes exported successfully');
      return exportData;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to export notes', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<String>> importNotes(String data, String format) async {
    try {
      AppLogger.info('📥 Importing notes in $format format');
      
      // Import using real service
      List<Note> notes;
      switch (format.toLowerCase()) {
        case 'json':
          notes = await _exportImportService.importNotesFromJson(data);
          break;
        case 'csv':
          notes = await _exportImportService.importNotesFromCsv(data);
          break;
        default:
          throw Exception('Unsupported import format: $format');
      }
      
      // Save notes to database
      final List<String> importedIds = [];
      for (final note in notes) {
        try {
          final id = await _repository.createNote(note);
          importedIds.add(id);
        } catch (e) {
          AppLogger.warning('Failed to import note: ${note.title}');
        }
      }
      
      AppLogger.success('Imported ${importedIds.length} notes successfully');
      return importedIds;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to import notes', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getStatistics() async {
    try {
      AppLogger.info('📊 Getting note statistics');
      final stats = await _repository.getStatistics();
      AppLogger.success('Statistics retrieved successfully');
      return stats;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get statistics', e, stackTrace);
      return {
        'totalNotes': 0,
        'pinnedNotes': 0,
        'archivedNotes': 0,
        'totalWords': 0,
        'totalCharacters': 0,
        'categoryCounts': <String, int>{},
        'tagCounts': <String, int>{},
        'lastUpdated': DateTime.now(),
      };
    }
  }

  @override
  Future<void> syncNotes() async {
    try {
      AppLogger.info('🔄 Syncing notes with cloud...');
      await _repository.syncNotes();
      AppLogger.success('Notes synced successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to sync notes', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<bool> isSynced() async {
    try {
      AppLogger.info('🔍 Checking sync status...');
      final isSynced = await _repository.isSynced();
      AppLogger.success('Sync status: $isSynced');
      return isSynced;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to check sync status', e, stackTrace);
      return false;
    }
  }
}
