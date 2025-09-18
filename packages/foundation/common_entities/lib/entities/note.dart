import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';
part 'note.g.dart';

@freezed
class Note with _$Note {
  const factory Note({
    required String id,
    required String title,
    required String content,
    @Default([]) List<String> tags,
    @Default(false) bool isArchived,
    @Default(false) bool isPinned,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? aiSummary,
    String? aiCategory,
    String? category,
    @Default(false) bool isEncrypted,
    @Default(0) int priority,
    String? color,
    String? icon,
    Map<String, dynamic>? metadata,
  }) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
}

extension NoteExtension on Note {
  /// Get preview of note content (first 100 characters)
  String get preview {
    if (content.length <= 100) return content;
    return '${content.substring(0, 100)}...';
  }

  /// Check if note has tags
  bool get hasTags => tags.isNotEmpty;

  /// Get formatted creation date
  String get formattedCreatedAt {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }

  /// Get formatted updated date
  String get formattedUpdatedAt {
    return '${updatedAt.day}/${updatedAt.month}/${updatedAt.year}';
  }

  /// Get word count
  int get wordCount {
    return content.split(' ').where((word) => word.isNotEmpty).length;
  }

  /// Get character count
  int get characterCount => content.length;

  /// Check if note is empty
  bool get isEmpty => content.trim().isEmpty;

  /// Check if note has AI summary
  bool get hasAiSummary => aiSummary != null && aiSummary!.isNotEmpty;

  /// Check if note has category
  bool get hasCategory => category != null && category!.isNotEmpty;
}
