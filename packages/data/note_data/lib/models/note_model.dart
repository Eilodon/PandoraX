import 'package:isar/isar.dart';
import 'package:common_entities/common_entities.dart';

/// Isar model for Note entity
@collection
class NoteModel {
  @Id()
  String id = '';

  @Index()
  String title = '';

  @Index()
  String content = '';

  @Index()
  DateTime createdAt = DateTime.now();

  @Index()
  DateTime updatedAt = DateTime.now();

  @Index()
  bool isActive = true;

  String? category;

  @Index()
  List<String> tags = [];

  @Index()
  bool isEncrypted = false;

  @Index()
  bool isPinned = false;

  int priority = 0;

  String? color;

  String? icon;

  Map<String, dynamic>? metadata;

  @Index()
  bool isArchived = false;

  /// Convert from Note entity
  static NoteModel fromNote(Note note) {
    return NoteModel()
      ..id = note.id
      ..title = note.title
      ..content = note.content
      ..createdAt = note.createdAt
      ..updatedAt = note.updatedAt
      ..isActive = note.isActive
      ..category = note.category
      ..tags = note.tags ?? []
      ..isEncrypted = note.isEncrypted
      ..isPinned = note.isPinned
      ..priority = note.priority
      ..color = note.color
      ..icon = note.icon
      ..metadata = note.metadata;
  }

  /// Convert to Note entity
  Note toNote() {
    return Note(
      id: id,
      title: title,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isActive: isActive,
      category: category,
      tags: tags,
      isEncrypted: isEncrypted,
      isPinned: isPinned,
      priority: priority,
      color: color,
      icon: icon,
      metadata: metadata,
    );
  }
}
