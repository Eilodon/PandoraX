import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_status.freezed.dart';
part 'sync_status.g.dart';

/// Sync status types
enum SyncState {
  idle,
  syncing,
  success,
  error,
  conflict,
}

/// Sync status entity
@freezed
class SyncStatus with _$SyncStatus {
  const factory SyncStatus({
    required SyncState state,
    required DateTime lastSync,
    String? error,
    int? itemsPending,
    int? itemsSynced,
  }) = _SyncStatus;

  factory SyncStatus.fromJson(Map<String, dynamic> json) =>
      _$SyncStatusFromJson(json);
}
