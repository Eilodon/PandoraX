/// App State Notifier for Phase 4 Architecture
/// 
/// This file contains the StateNotifier that manages the application state
/// using a simplified approach with clear separation of concerns.
library app_state_notifier;

import 'package:note_domain/note_domain.dart';
import 'app_state.dart';

/// StateNotifier for managing application state
class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(const AppState());

  /// Set loading state
  void setLoading(bool loading) {
    state = state.setLoading(loading);
  }

  /// Set error state
  void setError(String error) {
    state = state.setError(error);
  }

  /// Clear error state
  void clearError() {
    state = state.clearError();
  }

  /// Set user
  void setUser(User? user) {
    state = state.copyWith(user: user);
  }

  /// Add a new note
  void addNote(Note note) {
    state = state.addNote(note);
  }

  /// Update an existing note
  void updateNote(Note note) {
    state = state.updateNote(note);
  }

  /// Remove a note
  void removeNote(String noteId) {
    state = state.removeNote(noteId);
  }

  /// Select a note
  void selectNote(Note? note) {
    state = state.selectNote(note);
  }

  /// Toggle dark mode
  void toggleDarkMode() {
    state = state.toggleDarkMode();
  }

  /// Navigate to a screen
  void navigateTo(String screen) {
    state = state.navigateTo(screen);
  }

  /// Update user preferences
  void updatePreferences(Map<String, dynamic> preferences) {
    state = state.updatePreferences(preferences);
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
