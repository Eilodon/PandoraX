import 'dart:async';
import '../entities/note.dart';

abstract class NoteRepository {
  Future<List<Note>> getAllNotes();
  Future<Note?> getNoteById(String id);
  Future<Note> createNote(Note note);
  Future<Note> updateNote(Note note);
  Future<void> saveNote(Note note);
  Future<void> deleteNote(String id);
  Future<List<Note>> searchNotes(String query);
  Future<List<Note>> getPinnedNotes();
  Future<List<Note>> getNotesByCategory(String category);
  Stream<List<Note>> watchAllNotes();
  Future<List<Note>> syncPendingNotes();
  Future<void> syncNotes();
}