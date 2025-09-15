/// App Providers for Phase 4 Architecture
/// 
/// This file contains Riverpod providers for state management
/// using a simplified approach with clear separation of concerns.
library app_providers;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_domain/note_domain.dart';
import 'package:note_data/note_data.dart';
import 'app_state.dart';
import 'app_state_notifier.dart';
import 'service_locator.dart';

/// App state provider
final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>(
  (ref) => ServiceLocator.get<AppStateNotifier>(),
);

/// User provider
final userProvider = Provider<User?>((ref) {
  final appState = ref.watch(appStateProvider);
  return appState.user;
});

/// Notes provider
final notesProvider = Provider<List<Note>>((ref) {
  final appState = ref.watch(appStateProvider);
  return appState.notes;
});

/// Selected note provider
final selectedNoteProvider = Provider<Note?>((ref) {
  final appState = ref.watch(appStateProvider);
  return appState.selectedNote;
});

/// Loading state provider
final isLoadingProvider = Provider<bool>((ref) {
  final appState = ref.watch(appStateProvider);
  return appState.isLoading;
});

/// Error state provider
final errorProvider = Provider<String?>((ref) {
  final appState = ref.watch(appStateProvider);
  return appState.error;
});

/// Dark mode provider
final isDarkModeProvider = Provider<bool>((ref) {
  final appState = ref.watch(appStateProvider);
  return appState.isDarkMode;
});

/// Current screen provider
final currentScreenProvider = Provider<String>((ref) {
  final appState = ref.watch(appStateProvider);
  return appState.currentScreen;
});

/// User preferences provider
final preferencesProvider = Provider<Map<String, dynamic>>((ref) {
  final appState = ref.watch(appStateProvider);
  return appState.preferences;
});

/// Note repository provider
final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  return ServiceLocator.get<NoteRepository>();
});

/// Theme service provider
final themeServiceProvider = Provider<ThemeService>((ref) {
  return ServiceLocator.get<ThemeService>();
});

/// Navigation service provider
final navigationServiceProvider = Provider<NavigationService>((ref) {
  return ServiceLocator.get<NavigationService>();
});

/// AI service provider
final aiServiceProvider = Provider<AIService>((ref) {
  return ServiceLocator.get<AIService>();
});

/// Analytics service provider
final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return ServiceLocator.get<AnalyticsService>();
});

/// Async notes provider for loading notes
final asyncNotesProvider = FutureProvider<List<Note>>((ref) async {
  final repository = ref.read(noteRepositoryProvider);
  return await repository.getAllNotes();
});

/// Note by ID provider
final noteByIdProvider = Provider.family<Note?, String>((ref, noteId) {
  final notes = ref.watch(notesProvider);
  try {
    return notes.firstWhere((note) => note.id == noteId);
  } catch (e) {
    return null;
  }
});

/// Filtered notes provider
final filteredNotesProvider = Provider.family<List<Note>, String>((ref, query) {
  final notes = ref.watch(notesProvider);
  if (query.isEmpty) return notes;
  
  return notes.where((note) {
    return note.title.toLowerCase().contains(query.toLowerCase()) ||
           note.content.toLowerCase().contains(query.toLowerCase());
  }).toList();
});

/// Notes count provider
final notesCountProvider = Provider<int>((ref) {
  final notes = ref.watch(notesProvider);
  return notes.length;
});

/// Recent notes provider (last 5 notes)
final recentNotesProvider = Provider<List<Note>>((ref) {
  final notes = ref.watch(notesProvider);
  final sortedNotes = List<Note>.from(notes)
    ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  return sortedNotes.take(5).toList();
});

/// Favorite notes provider
final favoriteNotesProvider = Provider<List<Note>>((ref) {
  final notes = ref.watch(notesProvider);
  return notes.where((note) => note.isFavorite).toList();
});

/// Notes by category provider
final notesByCategoryProvider = Provider.family<List<Note>, String>((ref, category) {
  final notes = ref.watch(notesProvider);
  return notes.where((note) => note.category == category).toList();
});

/// Search suggestions provider
final searchSuggestionsProvider = Provider<List<String>>((ref) {
  final notes = ref.watch(notesProvider);
  final suggestions = <String>{};
  
  for (final note in notes) {
    // Add title words as suggestions
    final titleWords = note.title.toLowerCase().split(' ');
    suggestions.addAll(titleWords.where((word) => word.length > 2));
    
    // Add category as suggestion
    if (note.category.isNotEmpty) {
      suggestions.add(note.category.toLowerCase());
    }
  }
  
  return suggestions.take(10).toList();
});
