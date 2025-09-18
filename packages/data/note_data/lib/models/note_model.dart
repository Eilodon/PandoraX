import 'package:isar/isar.dart';
import 'package:common_entities/common_entities.dart';

part 'note_model.g.dart';

/// Isar model for Note entity
@collection
class NoteModel {
  Id id = Isar.autoIncrement;

  @Index()
  String title = '';

  @Index()
  String content = '';

  @Index()
  DateTime createdAt = DateTime.now();

  @Index()
  DateTime updatedAt = DateTime.now();

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

  @ignore
  Map<String, dynamic>? metadata;

  @Index()
  bool isArchived = false;

  /// Convert from Note entity
  static NoteModel fromNote(Note note) {
    return NoteModel()
      ..id = int.tryParse(note.id) ?? 0
      ..title = note.title
      ..content = note.content
      ..createdAt = note.createdAt
      ..updatedAt = note.updatedAt
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
      id: id.toString(),
      title: title,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
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
