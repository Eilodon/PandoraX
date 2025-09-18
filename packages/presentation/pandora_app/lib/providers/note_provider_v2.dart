import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:common_entities/common_entities.dart';
// import 'package:note_domain/note_domain.dart'; // Temporarily disabled
import 'package:core_utils/core_utils.dart';
import '../services/simple_note_service.dart';
// import '../services/service_locator.dart'; // Temporarily disabled

/// Note provider for state management
class NoteNotifier extends StateNotifier<NoteState> {
  final SimpleNoteService _noteRepository;

  NoteNotifier(this._noteRepository) : super(const NoteState.initial());

  /// Load all notes
  Future<void> loadNotes() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      
      final notes = await _noteRepository.getAllNotes();
      
      state = state.copyWith(
        isLoading: false,
        notes: notes,
        filteredNotes: notes,
      );
    } catch (e, stackTrace) {
      AppLogger.error('Failed to load notes', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Create a new note
  Future<void> createNote(Note note) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      
      final id = await _noteRepository.createNote(note);
      final newNote = note.copyWith(id: id);
      
      final updatedNotes = [...state.notes, newNote];
      
      state = state.copyWith(
        isLoading: false,
        notes: updatedNotes,
        filteredNotes: _filterNotes(updatedNotes, state.searchQuery),
      );
    } catch (e, stackTrace) {
      AppLogger.error('Failed to create note', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Update an existing note
  Future<void> updateNote(Note note) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      
      await _noteRepository.updateNote(note);
      
      final updatedNotes = state.notes.map((n) => n.id == note.id ? note : n).toList();
      
      state = state.copyWith(
        isLoading: false,
        notes: updatedNotes,
        filteredNotes: _filterNotes(updatedNotes, state.searchQuery),
      );
    } catch (e, stackTrace) {
      AppLogger.error('Failed to update note', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Delete a note
  Future<void> deleteNote(String noteId) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      
      await _noteRepository.deleteNote(noteId);
      
      final updatedNotes = state.notes.where((n) => n.id != noteId).toList();
      
      state = state.copyWith(
        isLoading: false,
        notes: updatedNotes,
        filteredNotes: _filterNotes(updatedNotes, state.searchQuery),
      );
    } catch (e, stackTrace) {
      AppLogger.error('Failed to delete note', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Search notes
  Future<void> searchNotes(String query) async {
    try {
      state = state.copyWith(isLoading: true, error: null, searchQuery: query);
      
      if (query.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          filteredNotes: state.notes,
        );
        return;
      }
      
      final searchResults = await _noteRepository.searchNotes(query);
      
      state = state.copyWith(
        isLoading: false,
        filteredNotes: searchResults,
      );
    } catch (e, stackTrace) {
      AppLogger.error('Failed to search notes', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Filter notes by category
  Future<void> filterByCategory(String? category) async {
    try {
      state = state.copyWith(isLoading: true, error: null, selectedCategory: category);
      
      List<Note> filteredNotes;
      if (category == null) {
        filteredNotes = state.notes;
      } else {
        filteredNotes = await _noteRepository.getNotesByCategory(category);
      }
      
      state = state.copyWith(
        isLoading: false,
        filteredNotes: _filterNotes(filteredNotes, state.searchQuery),
      );
    } catch (e, stackTrace) {
      AppLogger.error('Failed to filter by category', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Filter notes by tag
  Future<void> filterByTag(String? tag) async {
    try {
      state = state.copyWith(isLoading: true, error: null, selectedTag: tag);
      
      List<Note> filteredNotes;
      if (tag == null) {
        filteredNotes = state.notes;
      } else {
        filteredNotes = await _noteRepository.getNotesByTag(tag);
      }
      
      state = state.copyWith(
        isLoading: false,
        filteredNotes: _filterNotes(filteredNotes, state.searchQuery),
      );
    } catch (e, stackTrace) {
      AppLogger.error('Failed to filter by tag', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Toggle pin status
  Future<void> togglePin(String noteId) async {
    try {
      await _noteRepository.togglePin(noteId);
      
      final updatedNotes = state.notes.map((note) {
        if (note.id == noteId) {
          return note.copyWith(isPinned: !note.isPinned);
        }
        return note;
      }).toList();
      
      state = state.copyWith(
        notes: updatedNotes,
        filteredNotes: _filterNotes(updatedNotes, state.searchQuery),
      );
    } catch (e, stackTrace) {
      AppLogger.error('Failed to toggle pin', e, stackTrace);
      state = state.copyWith(error: e.toString());
    }
  }

  /// Toggle archive status
  Future<void> toggleArchive(String noteId) async {
    try {
      await _noteRepository.toggleArchive(noteId);
      
      final updatedNotes = state.notes.map((note) {
        if (note.id == noteId) {
          return note.copyWith(isArchived: !note.isArchived);
        }
        return note;
      }).toList();
      
      state = state.copyWith(
        notes: updatedNotes,
        filteredNotes: _filterNotes(updatedNotes, state.searchQuery),
      );
    } catch (e, stackTrace) {
      AppLogger.error('Failed to toggle archive', e, stackTrace);
      state = state.copyWith(error: e.toString());
    }
  }

  /// Get all categories
  Future<List<String>> getCategories() async {
    try {
      return await _noteRepository.getAllCategories();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get categories', e, stackTrace);
      return [];
    }
  }

  /// Get all tags
  Future<List<String>> getTags() async {
    try {
      return await _noteRepository.getAllTags();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get tags', e, stackTrace);
      return [];
    }
  }

  /// Get note statistics
  Future<Map<String, dynamic>?> getStatistics() async {
    try {
      // Simple statistics calculation
      final notes = state.notes;
      final totalNotes = notes.length;
      final pinnedNotes = notes.where((note) => note.isPinned).length;
      final archivedNotes = notes.where((note) => note.isArchived).length;
      
      return {
        'totalNotes': totalNotes,
        'pinnedNotes': pinnedNotes,
        'archivedNotes': archivedNotes,
        'totalWords': notes.fold(0, (sum, note) => sum + (note.content.split(' ').length)),
        'totalCharacters': notes.fold(0, (sum, note) => sum + note.content.length),
        'lastUpdated': DateTime.now(),
      };
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get statistics', e, stackTrace);
      return null;
    }
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Filter notes based on search query
  List<Note> _filterNotes(List<Note> notes, String? query) {
    if (query == null || query.isEmpty) return notes;
    
    return notes.where((note) {
      return note.title.toLowerCase().contains(query.toLowerCase()) ||
             note.content.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}

/// Note state
class NoteState {
  final List<Note> notes;
  final List<Note> filteredNotes;
  final bool isLoading;
  final String? error;
  final String? searchQuery;
  final String? selectedCategory;
  final String? selectedTag;

  const NoteState({
    required this.notes,
    required this.filteredNotes,
    required this.isLoading,
    this.error,
    this.searchQuery,
    this.selectedCategory,
    this.selectedTag,
  });

  const NoteState.initial()
      : notes = const [],
        filteredNotes = const [],
        isLoading = false,
        error = null,
        searchQuery = null,
        selectedCategory = null,
        selectedTag = null;

  NoteState copyWith({
    List<Note>? notes,
    List<Note>? filteredNotes,
    bool? isLoading,
    String? error,
    String? searchQuery,
    String? selectedCategory,
    String? selectedTag,
  }) {
    return NoteState(
      notes: notes ?? this.notes,
      filteredNotes: filteredNotes ?? this.filteredNotes,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedTag: selectedTag ?? this.selectedTag,
    );
  }
}

/// Note provider
final noteProvider = StateNotifierProvider<NoteNotifier, NoteState>((ref) {
  return NoteNotifier(SimpleNoteService());
});

/// Mock note repository for development
class MockNoteRepository {
  final List<Note> _notes = [];
  
  // @override
  Future<List<Note>> getAllNotes() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_notes);
  }
  
  // @override
  Future<Note?> getNoteById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _notes.firstWhere((note) => note.id == id);
    } catch (e) {
      return null;
    }
  }
  
  // @override
  Future<String> createNote(Note note) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final newNote = note.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _notes.add(newNote);
    return newNote.id;
  }
  
  // @override
  Future<void> updateNote(Note note) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _notes[index] = note.copyWith(updatedAt: DateTime.now());
    }
  }
  
  // @override
  Future<void> deleteNote(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _notes.removeWhere((note) => note.id == id);
  }
  
  // @override
  Future<List<Note>> searchNotes(String query) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _notes.where((note) => 
      note.title.toLowerCase().contains(query.toLowerCase()) ||
      note.content.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
  
  // @override
  Future<List<Note>> getNotesByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _notes.where((note) => note.category == category).toList();
  }
  
  // @override
  Future<List<Note>> getNotesByTag(String tag) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _notes.where((note) => note.tags.contains(tag)).toList();
  }
  
  // @override
  Future<List<Note>> getPinnedNotes() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _notes.where((note) => note.isPinned).toList();
  }
  
  // @override
  Future<List<Note>> getRecentNotes({int? limit}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final sortedNotes = List<Note>.from(_notes);
    sortedNotes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return limit != null ? sortedNotes.take(limit).toList() : sortedNotes;
  }
  
  // @override
  Future<List<Note>> getNotesByDateRange(DateTime start, DateTime end) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _notes.where((note) => 
      note.createdAt.isAfter(start) && note.createdAt.isBefore(end)
    ).toList();
  }
  
  // @override
  Future<List<String>> getAllCategories() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _notes
        .map((note) => note.category)
        .where((category) => category != null)
        .cast<String>()
        .toSet()
        .toList();
  }
  
  // @override
  Future<List<String>> getAllTags() async {
    await Future.delayed(const Duration(milliseconds: 200));
    final tags = <String>{};
    for (final note in _notes) {
      tags.addAll(note.tags);
    }
    return tags.toList();
  }
  
  // @override
  Future<void> togglePin(String noteId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _notes.indexWhere((note) => note.id == noteId);
    if (index != -1) {
      _notes[index] = _notes[index].copyWith(isPinned: !_notes[index].isPinned);
    }
  }
  
  // @override
  Future<void> toggleArchive(String noteId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _notes.indexWhere((note) => note.id == noteId);
    if (index != -1) {
      _notes[index] = _notes[index].copyWith(isArchived: !_notes[index].isArchived);
    }
  }
  
  // @override
  Future<String> exportNotes(List<String> noteIds, String format) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return 'Mock export data';
  }
  
  // @override
  Future<List<String>> importNotes(String data, String format) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ['mock_id_1', 'mock_id_2'];
  }
  
  // @override
  Future<Map<String, dynamic>> getStatistics() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      'totalNotes': _notes.length,
      'pinnedNotes': _notes.where((n) => n.isPinned).length,
      'archivedNotes': _notes.where((n) => n.isArchived).length,
      'totalWords': _notes.fold(0, (sum, note) => sum + (note.content.split(' ').length)),
      'totalCharacters': _notes.fold(0, (sum, note) => sum + note.content.length),
      'categoryCounts': <String, int>{},
      'tagCounts': <String, int>{},
      'lastUpdated': DateTime.now(),
    };
  }
  
  // @override
  Future<void> syncNotes() async {
    await Future.delayed(const Duration(milliseconds: 1000));
  }
  
  // @override
  Future<bool> isSynced() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return true;
  }
}
