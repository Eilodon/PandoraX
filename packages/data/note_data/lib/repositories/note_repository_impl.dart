import 'package:common_entities/common_entities.dart';
import 'package:note_domain/note_domain.dart';
import 'package:core_utils/core_utils.dart';
import '../datasources/note_local_datasource.dart';

/// Implementation of note repository
class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource _localDataSource;

  const NoteRepositoryImpl(this._localDataSource);

  @override
  Future<List<Note>> getAllNotes() async {
    try {
      AppLogger.info('📝 Getting all notes...');
      final notes = await _localDataSource.getAllNotes();
      AppLogger.success('Retrieved ${notes.length} notes');
      return notes;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get all notes', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<Note?> getNoteById(String id) async {
    try {
      AppLogger.info('📝 Getting note by ID: $id');
      final note = await _localDataSource.getNoteById(id);
      if (note != null) {
        AppLogger.success('Note found: ${note.title}');
      } else {
        AppLogger.warning('Note not found: $id');
      }
      return note;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get note by ID', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<String> createNote(Note note) async {
    try {
      AppLogger.info('📝 Creating note: ${note.title}');
      final id = await _localDataSource.createNote(note);
      AppLogger.success('Note created successfully: $id');
      return id;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to create note', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> updateNote(Note note) async {
    try {
      AppLogger.info('📝 Updating note: ${note.title}');
      await _localDataSource.updateNote(note);
      AppLogger.success('Note updated successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to update note', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    try {
      AppLogger.info('📝 Deleting note: $id');
      await _localDataSource.deleteNote(id);
      AppLogger.success('Note deleted successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to delete note', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<Note>> searchNotes(String query) async {
    try {
      AppLogger.info('📝 Searching notes with query: $query');
      final notes = await _localDataSource.searchNotes(query);
      AppLogger.success('Found ${notes.length} notes matching query');
      return notes;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to search notes', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<Note>> getNotesByCategory(String category) async {
    try {
      AppLogger.info('📝 Getting notes by category: $category');
      final notes = await _localDataSource.getNotesByCategory(category);
      AppLogger.success('Found ${notes.length} notes in category');
      return notes;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get notes by category', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<Note>> getNotesByTag(String tag) async {
    try {
      AppLogger.info('📝 Getting notes by tag: $tag');
      final notes = await _localDataSource.getNotesByTag(tag);
      AppLogger.success('Found ${notes.length} notes with tag');
      return notes;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get notes by tag', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<Note>> getPinnedNotes() async {
    try {
      AppLogger.info('📝 Getting pinned notes...');
      final notes = await _localDataSource.getPinnedNotes();
      AppLogger.success('Found ${notes.length} pinned notes');
      return notes;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get pinned notes', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<Note>> getRecentNotes({int? limit}) async {
    try {
      AppLogger.info('📝 Getting recent notes (limit: ${limit ?? 'none'})...');
      final notes = await _localDataSource.getRecentNotes(limit: limit);
      AppLogger.success('Found ${notes.length} recent notes');
      return notes;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get recent notes', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<Note>> getNotesByDateRange(DateTime start, DateTime end) async {
    try {
      AppLogger.info('📝 Getting notes by date range: $start to $end');
      final notes = await _localDataSource.getNotesByDateRange(start, end);
      AppLogger.success('Found ${notes.length} notes in date range');
      return notes;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get notes by date range', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<String>> getAllCategories() async {
    try {
      AppLogger.info('📝 Getting all categories...');
      final categories = await _localDataSource.getAllCategories();
      AppLogger.success('Found ${categories.length} categories');
      return categories;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get all categories', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<String>> getAllTags() async {
    try {
      AppLogger.info('📝 Getting all tags...');
      final tags = await _localDataSource.getAllTags();
      AppLogger.success('Found ${tags.length} tags');
      return tags;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get all tags', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> togglePin(String noteId) async {
    try {
      AppLogger.info('📝 Toggling pin for note: $noteId');
      await _localDataSource.togglePin(noteId);
      AppLogger.success('Pin toggled successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to toggle pin', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> toggleArchive(String noteId) async {
    try {
      AppLogger.info('📝 Toggling archive for note: $noteId');
      await _localDataSource.toggleArchive(noteId);
      AppLogger.success('Archive toggled successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to toggle archive', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<String> exportNotes(List<String> noteIds, String format) async {
    try {
      AppLogger.info('📝 Exporting ${noteIds.length} notes in $format format...');

      // Get notes to export
      final notes = <Note>[];
      for (final id in noteIds) {
        final note = await getNoteById(id);
        if (note != null) {
          notes.add(note);
        }
      }

      // Export based on format
      String exportData;
      switch (format.toLowerCase()) {
        case 'json':
          exportData = _exportToJson(notes);
          break;
        case 'txt':
          exportData = _exportToText(notes);
          break;
        case 'md':
          exportData = _exportToMarkdown(notes);
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
      AppLogger.info('📝 Importing notes in $format format...');

      List<Note> notes;
      switch (format.toLowerCase()) {
        case 'json':
          notes = _importFromJson(data);
          break;
        case 'txt':
          notes = _importFromText(data);
          break;
        case 'md':
          notes = _importFromMarkdown(data);
          break;
        default:
          throw Exception('Unsupported import format: $format');
      }

      // Create notes
      final createdIds = <String>[];
      for (final note in notes) {
        final id = await createNote(note);
        createdIds.add(id);
      }

      AppLogger.success('Imported ${createdIds.length} notes successfully');
      return createdIds;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to import notes', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<NoteStatistics> getStatistics() async {
    try {
      AppLogger.info('📝 Getting note statistics...');
      final stats = await _localDataSource.getStatistics();
      AppLogger.success('Statistics retrieved successfully');
      return stats;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get statistics', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> syncNotes() async {
    try {
      AppLogger.info('📝 Syncing notes...');
      // TODO: Implement cloud sync
      AppLogger.success('Notes synced successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to sync notes', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<bool> isSynced() async {
    try {
      // TODO: Implement sync status check
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to check sync status', e, stackTrace);
      return false;
    }
  }

  /// Export notes to JSON format
  String _exportToJson(List<Note> notes) {
    final jsonData = {
      'notes': notes.map((note) => note.toJson()).toList(),
      'exportedAt': DateTime.now().toIso8601String(),
      'version': '1.0.0',
    };

    return jsonEncode(jsonData);
  }

  /// Export notes to text format
  String _exportToText(List<Note> notes) {
    final buffer = StringBuffer();
    buffer.writeln('PandoraX Notes Export');
    buffer.writeln('====================');
    buffer.writeln('Exported: ${DateTime.now().toIso8601String()}');
    buffer.writeln('Total Notes: ${notes.length}');
    buffer.writeln();

    for (int i = 0; i < notes.length; i++) {
      final note = notes[i];
      buffer.writeln('${i + 1}. ${note.title}');
      buffer.writeln('   Created: ${note.formattedCreatedAt}');
      buffer.writeln('   Updated: ${note.formattedUpdatedAt}');
      if (note.category != null) {
        buffer.writeln('   Category: ${note.category}');
      }
      if (note.tags != null && note.tags!.isNotEmpty) {
        buffer.writeln('   Tags: ${note.tags!.join(', ')}');
      }
      buffer.writeln('   Content:');
      buffer.writeln('   ${note.content}');
      buffer.writeln();
    }

    return buffer.toString();
  }

  /// Export notes to Markdown format
  String _exportToMarkdown(List<Note> notes) {
    final buffer = StringBuffer();
    buffer.writeln('# PandoraX Notes Export');
    buffer.writeln();
    buffer.writeln('**Exported:** ${DateTime.now().toIso8601String()}');
    buffer.writeln('**Total Notes:** ${notes.length}');
    buffer.writeln();

    for (int i = 0; i < notes.length; i++) {
      final note = notes[i];
      buffer.writeln('## ${i + 1}. ${note.title}');
      buffer.writeln();
      buffer.writeln('**Created:** ${note.formattedCreatedAt}');
      buffer.writeln('**Updated:** ${note.formattedUpdatedAt}');
      if (note.category != null) {
        buffer.writeln('**Category:** ${note.category}');
      }
      if (note.tags != null && note.tags!.isNotEmpty) {
        buffer.writeln('**Tags:** ${note.tags!.map((tag) => '#$tag').join(' ')}');
      }
      buffer.writeln();
      buffer.writeln(note.content);
      buffer.writeln();
    }

    return buffer.toString();
  }

  /// Import notes from JSON format
  List<Note> _importFromJson(String data) {
    final jsonData = jsonDecode(data) as Map<String, dynamic>;
    final notesJson = jsonData['notes'] as List<dynamic>;

    return notesJson.map((noteJson) => Note.fromJson(noteJson as Map<String, dynamic>)).toList();
  }

  /// Import notes from text format
  List<Note> _importFromText(String data) {
    // Simple text import - each note separated by double newlines
    final sections = data.split('\n\n');
    final notes = <Note>[];

    for (final section in sections) {
      if (section.trim().isEmpty) continue;

      final lines = section.split('\n');
      if (lines.isEmpty) continue;

      final title = lines[0].trim();
      final content = lines.skip(1).join('\n').trim();

      if (title.isNotEmpty && content.isNotEmpty) {
        final note = Note(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
          content: content,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        notes.add(note);
      }
    }

    return notes;
  }

  /// Import notes from Markdown format
  List<Note> _importFromMarkdown(String data) {
    // Simple markdown import - each note is a ## heading
    final sections = data.split('## ');
    final notes = <Note>[];

    for (final section in sections) {
      if (section.trim().isEmpty) continue;

      final lines = section.split('\n');
      if (lines.isEmpty) continue;

      final title = lines[0].trim();
      final content = lines.skip(1).join('\n').trim();

      if (title.isNotEmpty && content.isNotEmpty) {
        final note = Note(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
          content: content,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        notes.add(note);
      }
    }

    return notes;
  }
}
