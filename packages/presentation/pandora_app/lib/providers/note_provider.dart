import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:common_entities/common_entities.dart';
import 'package:note_domain/note_domain.dart';
import 'package:core_utils/core_utils.dart';
import '../services/service_locator.dart';

/// Note provider for state management
final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  try {
    return serviceLocator<NoteRepository>();
  } catch (e) {
    AppLogger.error('Failed to get NoteRepository from service locator', e);
    throw Exception('NoteRepository not available. Please initialize services first.');
  }
});

/// Note list provider
final noteListProvider = FutureProvider<List<Note>>((ref) async {
  final repository = ref.read(noteRepositoryProvider);
  return await repository.getAllNotes();
});

/// Note search provider
final noteSearchProvider = StateProvider<String>((ref) => '');

/// Filtered notes provider
final filteredNotesProvider = Provider<List<Note>>((ref) {
  final notes = ref.watch(noteListProvider).value ?? [];
  final searchQuery = ref.watch(noteSearchProvider);

  if (searchQuery.isEmpty) {
    return notes;
  }

  return notes.where((note) {
    return note.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
           note.content.toLowerCase().contains(searchQuery.toLowerCase());
  }).toList();
});

/// Note statistics provider
final noteStatisticsProvider = FutureProvider<NoteStatistics>((ref) async {
  final repository = ref.read(noteRepositoryProvider);
  final statsMap = await repository.getStatistics();
  return NoteStatistics.fromJson(statsMap);
});

/// Note categories provider
final noteCategoriesProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.read(noteRepositoryProvider);
  return await repository.getAllCategories();
});

/// Note tags provider
final noteTagsProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.read(noteRepositoryProvider);
  return await repository.getAllTags();
});

/// Pinned notes provider
final pinnedNotesProvider = FutureProvider<List<Note>>((ref) async {
  final repository = ref.read(noteRepositoryProvider);
  return await repository.getPinnedNotes();
});

/// Recent notes provider
final recentNotesProvider = FutureProvider<List<Note>>((ref) async {
  final repository = ref.read(noteRepositoryProvider);
  return await repository.getRecentNotes(limit: 10);
});

/// Note notifier for CRUD operations
class NoteNotifier extends StateNotifier<AsyncValue<List<Note>>> {
  final NoteRepository _repository;

  NoteNotifier(this._repository) : super(const AsyncValue.loading()) {
    _loadNotes();
  }

  /// Load all notes
  Future<void> _loadNotes() async {
    try {
      state = const AsyncValue.loading();
      final notes = await _repository.getAllNotes();
      state = AsyncValue.data(notes);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Create a new note
  Future<void> createNote({
    required String title,
    required String content,
    String? category,
    List<String>? tags,
    bool isEncrypted = false,
    bool isPinned = false,
    int priority = 0,
    String? color,
    String? icon,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final note = Note(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        content: content,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        category: category,
        tags: tags ?? [],
        isEncrypted: isEncrypted,
        isPinned: isPinned,
        priority: priority,
        color: color,
        icon: icon,
        metadata: metadata,
      );

      await _repository.createNote(note);
      await _loadNotes();

      AppLogger.success('Note created: $title');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to create note', e, stackTrace);
      rethrow;
    }
  }

  /// Update an existing note
  Future<void> updateNote(Note note) async {
    try {
      final updatedNote = note.copyWith(updatedAt: DateTime.now());
      await _repository.updateNote(updatedNote);
      await _loadNotes();

      AppLogger.success('Note updated: ${note.title}');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to update note', e, stackTrace);
      rethrow;
    }
  }

  /// Delete a note
  Future<void> deleteNote(String noteId) async {
    try {
      await _repository.deleteNote(noteId);
      await _loadNotes();

      AppLogger.success('Note deleted: $noteId');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to delete note', e, stackTrace);
      rethrow;
    }
  }

  /// Toggle pin status
  Future<void> togglePin(String noteId) async {
    try {
      await _repository.togglePin(noteId);
      await _loadNotes();

      AppLogger.success('Pin toggled for note: $noteId');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to toggle pin', e, stackTrace);
      rethrow;
    }
  }

  /// Toggle archive status
  Future<void> toggleArchive(String noteId) async {
    try {
      await _repository.toggleArchive(noteId);
      await _loadNotes();

      AppLogger.success('Archive toggled for note: $noteId');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to toggle archive', e, stackTrace);
      rethrow;
    }
  }

  /// Search notes
  Future<List<Note>> searchNotes(String query) async {
    try {
      return await _repository.searchNotes(query);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to search notes', e, stackTrace);
      return [];
    }
  }

  /// Refresh notes
  Future<void> refresh() async {
    await _loadNotes();
  }
}

/// Note notifier provider
final noteNotifierProvider = StateNotifierProvider<NoteNotifier, AsyncValue<List<Note>>>((ref) {
  final repository = ref.read(noteRepositoryProvider);
  return NoteNotifier(repository);
});
