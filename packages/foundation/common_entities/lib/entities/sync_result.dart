import 'package:freezed_annotation/freezed_annotation.dart';
import 'sync_conflict.dart';

part 'sync_result.freezed.dart';
part 'sync_result.g.dart';

/// Sync result entity
@freezed
class SyncResult with _$SyncResult {
  const factory SyncResult({
    required bool success,
    String? error,
    required int itemsSynced,
    required int itemsCreated,
    required int itemsUpdated,
    required int itemsDeleted,
    required List<SyncConflict> conflicts,
    required DateTime timestamp,
  }) = _SyncResult;

  factory SyncResult.fromJson(Map<String, dynamic> json) =>
      _$SyncResultFromJson(json);
}
