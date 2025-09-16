import 'package:equatable/equatable.dart';
import '../entities/note.dart';
import '../entities/user.dart';

/// App State
/// 
/// Represents the global application state
class AppState extends Equatable {
  const AppState({
    this.user,
    this.notes = const [],
    this.selectedNote,
    this.isLoading = false,
    this.error,
    this.isDarkMode = false,
    this.currentScreen = 'home',
    this.preferences = const {},
  });

  final User? user;
  final List<Note> notes;
  final Note? selectedNote;
  final bool isLoading;
  final String? error;
  final bool isDarkMode;
  final String currentScreen;
  final Map<String, dynamic> preferences;

  AppState copyWith({
    User? user,
    List<Note>? notes,
    Note? selectedNote,
    bool? isLoading,
    String? error,
    bool? isDarkMode,
    String? currentScreen,
    Map<String, dynamic>? preferences,
  }) {
    return AppState(
      user: user ?? this.user,
      notes: notes ?? this.notes,
      selectedNote: selectedNote ?? this.selectedNote,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      currentScreen: currentScreen ?? this.currentScreen,
      preferences: preferences ?? this.preferences,
    );
  }

  @override
  List<Object?> get props => [
        user,
        notes,
        selectedNote,
        isLoading,
        error,
        isDarkMode,
        currentScreen,
        preferences,
      ];
}