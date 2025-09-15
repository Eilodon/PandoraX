/// Simplified App State for Phase 4 Architecture
/// 
/// This file contains the core application state that serves as a single
/// source of truth for the entire application.
library app_state;

import 'package:note_domain/note_domain.dart';

/// Main application state containing all global state
class AppState {
  final User? user;
  final bool isLoading;
  final String? error;
  final List<Note> notes;
  final Note? selectedNote;
  final bool isDarkMode;
  final String currentScreen;
  final Map<String, dynamic> preferences;

  const AppState({
    this.user,
    this.isLoading = false,
    this.error,
    this.notes = const [],
    this.selectedNote,
    this.isDarkMode = false,
    this.currentScreen = 'welcome',
    this.preferences = const {},
  });

  /// Create a copy of the state with updated values
  AppState copyWith({
    User? user,
    bool? isLoading,
    String? error,
    List<Note>? notes,
    Note? selectedNote,
    bool? isDarkMode,
    String? currentScreen,
    Map<String, dynamic>? preferences,
  }) {
    return AppState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      notes: notes ?? this.notes,
      selectedNote: selectedNote ?? this.selectedNote,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      currentScreen: currentScreen ?? this.currentScreen,
      preferences: preferences ?? this.preferences,
    );
  }

  /// Clear error state
  AppState clearError() {
    return copyWith(error: null);
  }

  /// Clear loading state
  AppState clearLoading() {
    return copyWith(isLoading: false);
  }

  /// Set loading state
  AppState setLoading(bool loading) {
    return copyWith(isLoading: loading);
  }

  /// Set error state
  AppState setError(String error) {
    return copyWith(error: error, isLoading: false);
  }

  /// Add a new note
  AppState addNote(Note note) {
    return copyWith(notes: [...notes, note]);
  }

  /// Update an existing note
  AppState updateNote(Note updatedNote) {
    final updatedNotes = notes.map((note) {
      return note.id == updatedNote.id ? updatedNote : note;
    }).toList();
    return copyWith(notes: updatedNotes);
  }

  /// Remove a note
  AppState removeNote(String noteId) {
    final updatedNotes = notes.where((note) => note.id != noteId).toList();
    return copyWith(notes: updatedNotes);
  }

  /// Select a note
  AppState selectNote(Note? note) {
    return copyWith(selectedNote: note);
  }

  /// Toggle dark mode
  AppState toggleDarkMode() {
    return copyWith(isDarkMode: !isDarkMode);
  }

  /// Navigate to a screen
  AppState navigateTo(String screen) {
    return copyWith(currentScreen: screen);
  }

  /// Update user preferences
  AppState updatePreferences(Map<String, dynamic> newPreferences) {
    return copyWith(preferences: {...preferences, ...newPreferences});
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppState &&
        other.user == user &&
        other.isLoading == isLoading &&
        other.error == error &&
        other.notes == notes &&
        other.selectedNote == selectedNote &&
        other.isDarkMode == isDarkMode &&
        other.currentScreen == currentScreen &&
        other.preferences == preferences;
  }

  @override
  int get hashCode {
    return Object.hash(
      user,
      isLoading,
      error,
      notes,
      selectedNote,
      isDarkMode,
      currentScreen,
      preferences,
    );
  }

  @override
  String toString() {
    return 'AppState('
        'user: $user, '
        'isLoading: $isLoading, '
        'error: $error, '
        'notes: ${notes.length}, '
        'selectedNote: $selectedNote, '
        'isDarkMode: $isDarkMode, '
        'currentScreen: $currentScreen, '
        'preferences: $preferences'
        ')';
  }
}

/// User entity for the application
class User {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  final Map<String, dynamic> settings;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    required this.createdAt,
    this.lastLoginAt,
    this.settings = const {},
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    Map<String, dynamic>? settings,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      settings: settings ?? this.settings,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.avatar == avatar &&
        other.createdAt == createdAt &&
        other.lastLoginAt == lastLoginAt &&
        other.settings == settings;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      name,
      email,
      avatar,
      createdAt,
      lastLoginAt,
      settings,
    );
  }

  @override
  String toString() {
    return 'User('
        'id: $id, '
        'name: $name, '
        'email: $email, '
        'avatar: $avatar, '
        'createdAt: $createdAt, '
        'lastLoginAt: $lastLoginAt, '
        'settings: $settings'
        ')';
  }
}
