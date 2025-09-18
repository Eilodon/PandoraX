import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_entity.freezed.dart';
part 'base_entity.g.dart';

@freezed
class BaseEntity with _$BaseEntity {
  const factory BaseEntity({
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(true) bool isActive,
  }) = _BaseEntity;

  factory BaseEntity.fromJson(Map<String, dynamic> json) => _$BaseEntityFromJson(json);
}

extension BaseEntityExtension on BaseEntity {
  /// Get formatted creation date
  String get formattedCreatedAt {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }

  /// Get formatted updated date
  String get formattedUpdatedAt {
    return '${updatedAt.day}/${updatedAt.month}/${updatedAt.year}';
  }

  /// Check if entity is recent (created within last 24 hours)
  bool get isRecent {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    return difference.inHours < 24;
  }

  /// Get age of entity in days
  int get ageInDays {
    final now = DateTime.now();
    return now.difference(createdAt).inDays;
  }
}
