import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_config.freezed.dart';
part 'sync_config.g.dart';

/// Sync configuration for data synchronization
@freezed
class SyncConfig with _$SyncConfig {
  const factory SyncConfig({
    @Default(true) bool autoSync,
    @Default(300) int syncInterval,
    @Default(true) bool syncOnWifiOnly,
    @Default(true) bool syncInBackground,
    @Default(5) int maxRetryAttempts,
    @Default(30) int retryDelaySeconds,
    @Default(true) bool enableConflictResolution,
    @Default(true) bool enableDataCompression,
    @Default(10) int maxConcurrentSyncs,
    @Default(100) int maxSyncBatchSize,
    @Default(true) bool enableIncrementalSync,
    @Default(7) int dataRetentionDays,
  }) = _SyncConfig;

  factory SyncConfig.fromJson(Map<String, dynamic> json) =>
      _$SyncConfigFromJson(json);
}

/// Sync status for tracking synchronization state
@freezed
class SyncStatus with _$SyncStatus {
  const factory SyncStatus({
    required SyncState state,
    required DateTime lastSyncTime,
    required int itemsSynced,
    required int itemsPending,
    required int itemsFailed,
    String? lastError,
    required double progress,
  }) = _SyncStatus;

  factory SyncStatus.fromJson(Map<String, dynamic> json) =>
      _$SyncStatusFromJson(json);
}

/// Sync states
@freezed
class SyncState with _$SyncState {
  const factory SyncState.idle() = IdleSync;
  const factory SyncState.syncing() = SyncingSync;
  const factory SyncState.paused() = PausedSync;
  const factory SyncState.error() = ErrorSync;
  const factory SyncState.completed() = CompletedSync;

  factory SyncState.fromJson(Map<String, dynamic> json) =>
      _$SyncStateFromJson(json);
}

/// Sync result for tracking sync operations
@freezed
class SyncResult with _$SyncResult {
  const factory SyncResult({
    required bool success,
    required int itemsSynced,
    required int itemsCreated,
    required int itemsUpdated,
    required int itemsDeleted,
    required List<SyncConflict> conflicts,
    required DateTime timestamp,
    String? error,
    required Duration duration,
  }) = _SyncResult;

  factory SyncResult.fromJson(Map<String, dynamic> json) =>
      _$SyncResultFromJson(json);
}

/// Sync conflict for handling data conflicts
@freezed
class SyncConflict with _$SyncConflict {
  const factory SyncConflict({
    required String id,
    required String entityType,
    required Map<String, dynamic> localData,
    required Map<String, dynamic> remoteData,
    required DateTime localModified,
    required DateTime remoteModified,
    required ConflictType type,
    required ConflictResolution resolution,
    String? resolutionNote,
  }) = _SyncConflict;

  factory SyncConflict.fromJson(Map<String, dynamic> json) =>
      _$SyncConflictFromJson(json);
}

/// Conflict types
@freezed
class ConflictType with _$ConflictType {
  const factory ConflictType.dataMismatch() = DataMismatchConflict;
  const factory ConflictType.timestampConflict() = TimestampConflict;
  const factory ConflictType.deletionConflict() = DeletionConflict;
  const factory ConflictType.creationConflict() = CreationConflict;

  factory ConflictType.fromJson(Map<String, dynamic> json) =>
      _$ConflictTypeFromJson(json);
}

/// Conflict resolution strategies
@freezed
class ConflictResolution with _$ConflictResolution {
  const factory ConflictResolution.useLocal() = UseLocalResolution;
  const factory ConflictResolution.useRemote() = UseRemoteResolution;
  const factory ConflictResolution.merge() = MergeResolution;
  const factory ConflictResolution.manual() = ManualResolution;

  factory ConflictResolution.fromJson(Map<String, dynamic> json) =>
      _$ConflictResolutionFromJson(json);
}