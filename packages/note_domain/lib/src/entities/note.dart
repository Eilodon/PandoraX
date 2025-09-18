import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'sync_status.dart';

part 'note.g.dart';

@JsonSerializable()
class Note extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isPinned;
  final bool pinned;
  final bool isFavorite;
  final String? category;
  final Map<String, dynamic>? metadata;
  final SyncStatus syncStatus;
  final DateTime? reminderTime;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.isPinned = false,
    this.pinned = false,
    this.isFavorite = false,
    this.category,
    this.metadata,
    this.syncStatus = SyncStatus.pending,
    this.reminderTime,
  });

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);

  Note copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPinned,
    bool? pinned,
    bool? isFavorite,
    String? category,
    Map<String, dynamic>? metadata,
    SyncStatus? syncStatus,
    DateTime? reminderTime,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPinned: isPinned ?? this.isPinned,
      pinned: pinned ?? this.pinned,
      isFavorite: isFavorite ?? this.isFavorite,
      category: category ?? this.category,
      metadata: metadata ?? this.metadata,
      syncStatus: syncStatus ?? this.syncStatus,
      reminderTime: reminderTime ?? this.reminderTime,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        createdAt,
        updatedAt,
      isPinned,
      pinned,
      isFavorite,
      category,
        metadata,
        syncStatus,
        reminderTime,
      ];
}