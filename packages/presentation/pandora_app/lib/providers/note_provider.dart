import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:common_entities/common_entities.dart';
import 'package:core_utils/core_utils.dart';

/// Note provider for managing notes state
class NoteNotifier extends StateNotifier<List<Note>> {
  NoteNotifier() : super([]);

  /// Add a new note
  void addNote(Note note) {
    state = [...state, note];
    AppLogger.info('➕ Added note: ${note.title}');
  }

  /// Update an existing note
  void updateNote(Note note) {
    state = state.map((n) => n.id == note.id ? note : n).toList();
    AppLogger.info('✏️ Updated note: ${note.title}');
  }

  /// Delete a note
  void deleteNote(String noteId) {
    state = state.where((n) => n.id != noteId).toList();
    AppLogger.info('🗑️ Deleted note: $noteId');
  }

  /// Get note by ID
  Note? getNoteById(String noteId) {
    try {
      return state.firstWhere((n) => n.id == noteId);
    } catch (e) {
      return null;
    }
  }

  /// Search notes
  List<Note> searchNotes(String query) {
    if (query.isEmpty) return state;
    
    return state.where((note) {
      return note.title.toLowerCase().contains(query.toLowerCase()) ||
             note.content.toLowerCase().contains(query.toLowerCase()) ||
             note.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase()));
    }).toList();
  }

  /// Filter notes by category
  List<Note> filterNotesByCategory(String category) {
    return state.where((note) => note.category == category).toList();
  }

  /// Filter notes by tags
  List<Note> filterNotesByTags(List<String> tags) {
    return state.where((note) => 
      tags.any((tag) => note.tags.contains(tag))
    ).toList();
  }

  /// Get notes statistics
  NoteStatistics getStatistics() {
    final totalNotes = state.length;
    final totalWords = state.fold(0, (sum, note) => sum + note.content.split(' ').length);
    final totalCharacters = state.fold(0, (sum, note) => sum + note.content.length);
    
    final categories = state.map((note) => note.category).toSet().toList();
    final tags = state.expand((note) => note.tags).toSet().toList();
    
    return NoteStatistics(
      totalNotes: totalNotes,
      pinnedNotes: state.where((note) => note.isPinned).length,
      archivedNotes: state.where((note) => note.isArchived).length,
      totalWords: totalWords,
      totalCharacters: totalCharacters,
      categoryCounts: categories.fold<Map<String, int>>({}, (map, category) {
        if (category != null) {
          map[category] = (map[category] ?? 0) + 1;
        }
        return map;
      }),
      tagCounts: tags.fold<Map<String, int>>({}, (map, tag) {
        map[tag] = (map[tag] ?? 0) + 1;
        return map;
      }),
      lastUpdated: DateTime.now(),
    );
  }

  /// Clear all notes
  void clearAllNotes() {
    state = [];
    AppLogger.info('🗑️ Cleared all notes');
  }
}

/// Note provider
final notesProvider = StateNotifierProvider<NoteNotifier, List<Note>>((ref) {
  return NoteNotifier();
});

/// Note statistics provider
final noteStatisticsProvider = Provider<NoteStatistics>((ref) {
  final notes = ref.watch(notesProvider);
  final notifier = ref.read(notesProvider.notifier);
  return notifier.getStatistics();
});

/// Search query provider
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Filtered notes provider
final filteredNotesProvider = Provider<List<Note>>((ref) {
  final notes = ref.watch(notesProvider);
  final searchQuery = ref.watch(searchQueryProvider);
  final notifier = ref.read(notesProvider.notifier);
  
  if (searchQuery.isEmpty) return notes;
  return notifier.searchNotes(searchQuery);
});