import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/note.dart';
import '../entities/user.dart';
import '../repositories/note_repository.dart';
import 'app_state.dart';

/// App State Notifier
/// 
/// Manages the global application state
class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(const AppState());

  /// Set loading state
  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  /// Set error state
  void setError(String? error) {
    state = state.copyWith(error: error);
  }

  /// Clear error state
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Set user
  void setUser(User? user) {
    state = state.copyWith(user: user);
  }

  /// Add a note
  void addNote(Note note) {
    final notes = List<Note>.from(state.notes)..add(note);
    state = state.copyWith(notes: notes);
  }

  /// Update a note
  void updateNote(Note note) {
    final notes = List<Note>.from(state.notes);
    final index = notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      notes[index] = note;
      state = state.copyWith(notes: notes);
    }
  }

  /// Remove a note
  void removeNote(String noteId) {
    final notes = List<Note>.from(state.notes)
      ..removeWhere((note) => note.id == noteId);
    state = state.copyWith(notes: notes);
  }

  /// Set selected note
  void setSelectedNote(Note? note) {
    state = state.copyWith(selectedNote: note);
  }

  /// Set dark mode
  void setDarkMode(bool isDarkMode) {
    state = state.copyWith(isDarkMode: isDarkMode);
  }

  /// Set current screen
  void setCurrentScreen(String screen) {
    state = state.copyWith(currentScreen: screen);
  }

  /// Set preferences
  void setPreferences(Map<String, dynamic> preferences) {
    state = state.copyWith(preferences: preferences);
  }

  /// Load notes from repository
  Future<void> loadNotes(NoteRepository repository) async {
    try {
      setLoading(true);
      clearError();
      
      final notes = await repository.getAllNotes();
      state = state.copyWith(notes: notes);
    } catch (e) {
      setError('Failed to load notes: $e');
    } finally {
      setLoading(false);
    }
  }

  /// Save a note
  Future<void> saveNote(Note note, NoteRepository repository) async {
    try {
      setLoading(true);
      clearError();
      
      await repository.saveNote(note);
      addNote(note);
    } catch (e) {
      setError('Failed to save note: $e');
    } finally {
      setLoading(false);
    }
  }

  /// Delete a note
  Future<void> deleteNote(String noteId, NoteRepository repository) async {
    try {
      setLoading(true);
      clearError();
      
      await repository.deleteNote(noteId);
      removeNote(noteId);
    } catch (e) {
      setError('Failed to delete note: $e');
    } finally {
      setLoading(false);
    }
  }

  /// Sync notes with remote
  Future<void> syncNotes(NoteRepository repository) async {
    try {
      setLoading(true);
      clearError();
      
      await repository.syncNotes();
      final notes = await repository.getAllNotes();
      state = state.copyWith(notes: notes);
    } catch (e) {
      setError('Failed to sync notes: $e');
    } finally {
      setLoading(false);
    }
  }

  /// Reset state to initial
  void reset() {
    state = const AppState();
  }
}