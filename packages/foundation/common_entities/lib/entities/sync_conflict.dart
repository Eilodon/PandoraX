import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_conflict.freezed.dart';
part 'sync_conflict.g.dart';

/// Sync conflict types
enum SyncConflictType {
  content,
  metadata,
  timestamp,
  deletion,
}

/// Sync conflict entity
@freezed
class SyncConflict with _$SyncConflict {
  const factory SyncConflict({
    required String id,
    required SyncConflictType type,
    required String entityType,
    required Map<String, dynamic> localData,
    required Map<String, dynamic> remoteData,
    required DateTime localModified,
    required DateTime remoteModified,
  }) = _SyncConflict;

  factory SyncConflict.fromJson(Map<String, dynamic> json) =>
      _$SyncConflictFromJson(json);
}
