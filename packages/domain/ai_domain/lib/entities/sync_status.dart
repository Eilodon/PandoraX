import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_status.freezed.dart';
part 'sync_status.g.dart';

/// Sync status for cloud synchronization
@freezed
class SyncStatus with _$SyncStatus {
  const factory SyncStatus({
    required String id,
    required SyncState state,
    required DateTime lastSync,
    DateTime? nextSync,
    int? pendingChanges,
    int? totalChanges,
    String? lastError,
    Map<String, dynamic>? metadata,
  }) = _SyncStatus;

  const SyncStatus._();

  factory SyncStatus.fromJson(Map<String, dynamic> json) =>
      _$SyncStatusFromJson(json);

  /// Check if sync is in progress
  bool get isSyncing => state == SyncState.syncing;

  /// Check if sync is successful
  bool get isSuccess => state == SyncState.success;

  /// Check if sync has errors
  bool get hasError => state == SyncState.error;

  /// Check if sync is idle
  bool get isIdle => state == SyncState.idle;

  /// Get progress percentage
  double get progress {
    if (totalChanges == null || totalChanges == 0) return 0.0;
    if (pendingChanges == null) return 0.0;
    return (totalChanges! - pendingChanges!) / totalChanges!;
  }

  /// Get status message
  String get statusMessage {
    switch (state) {
      case SyncState.idle:
        return 'Ready to sync';
      case SyncState.syncing:
        return 'Syncing... ${(progress * 100).toInt()}%';
      case SyncState.success:
        return 'Sync completed successfully';
      case SyncState.error:
        return 'Sync failed: ${lastError ?? 'Unknown error'}';
      case SyncState.paused:
        return 'Sync paused';
      case SyncState.offline:
        return 'Offline - sync when online';
    }
  }

  /// Get status icon
  String get statusIcon {
    switch (state) {
      case SyncState.idle:
        return '⏸️';
      case SyncState.syncing:
        return '🔄';
      case SyncState.success:
        return '✅';
      case SyncState.error:
        return '❌';
      case SyncState.paused:
        return '⏸️';
      case SyncState.offline:
        return '📡';
    }
  }
}

/// Sync state enumeration
enum SyncState {
  idle,
  syncing,
  success,
  error,
  paused,
  offline,
}

/// Sync conflict resolution strategy
enum ConflictResolutionStrategy {
  localWins,
  remoteWins,
  newestWins,
  manual,
  merge,
}

/// Sync configuration
@freezed
class SyncConfig with _$SyncConfig {
  const factory SyncConfig({
    @Default(true) bool autoSync,
    @Default(Duration(minutes: 5)) Duration syncInterval,
    @Default(ConflictResolutionStrategy.newestWins) ConflictResolutionStrategy conflictStrategy,
    @Default(true) bool syncOnWifiOnly,
    @Default(true) bool syncInBackground,
    @Default(100) int maxRetries,
    @Default(Duration(seconds: 30)) Duration timeout,
    @Default(true) bool enableCompression,
    @Default(true) bool enableEncryption,
    Map<String, dynamic>? customSettings,
  }) = _SyncConfig;

  const SyncConfig._();

  factory SyncConfig.fromJson(Map<String, dynamic> json) =>
      _$SyncConfigFromJson(json);

  /// Get default sync configuration
  static SyncConfig get defaultConfig => const SyncConfig();

  /// Get aggressive sync configuration (frequent syncing)
  static SyncConfig get aggressiveConfig => const SyncConfig(
    autoSync: true,
    syncInterval: Duration(minutes: 1),
    syncOnWifiOnly: false,
    maxRetries: 5,
  );

  /// Get conservative sync configuration (less frequent syncing)
  static SyncConfig get conservativeConfig => const SyncConfig(
    autoSync: true,
    syncInterval: Duration(minutes: 30),
    syncOnWifiOnly: true,
    maxRetries: 3,
  );

  /// Get offline-only configuration
  static SyncConfig get offlineConfig => const SyncConfig(
    autoSync: false,
    syncInterval: Duration(hours: 1),
    syncOnWifiOnly: true,
  );
}

/// Sync operation result
@freezed
class SyncResult with _$SyncResult {
  const factory SyncResult({
    required bool success,
    required String message,
    required DateTime timestamp,
    int? itemsSynced,
    int? itemsCreated,
    int? itemsUpdated,
    int? itemsDeleted,
    List<String>? conflicts,
    String? error,
    Map<String, dynamic>? metadata,
  }) = _SyncResult;

  const SyncResult._();

  factory SyncResult.fromJson(Map<String, dynamic> json) =>
      _$SyncResultFromJson(json);

  /// Create success result
  factory SyncResult.success({
    required String message,
    int? itemsSynced,
    int? itemsCreated,
    int? itemsUpdated,
    int? itemsDeleted,
    List<String>? conflicts,
    Map<String, dynamic>? metadata,
  }) {
    return SyncResult(
      success: true,
      message: message,
      timestamp: DateTime.now(),
      itemsSynced: itemsSynced,
      itemsCreated: itemsCreated,
      itemsUpdated: itemsUpdated,
      itemsDeleted: itemsDeleted,
      conflicts: conflicts,
      metadata: metadata,
    );
  }

  /// Create error result
  factory SyncResult.error({
    required String message,
    String? error,
    Map<String, dynamic>? metadata,
  }) {
    return SyncResult(
      success: false,
      message: message,
      timestamp: DateTime.now(),
      error: error,
      metadata: metadata,
    );
  }

  /// Get summary message
  String get summaryMessage {
    if (!success) {
      return 'Sync failed: $message';
    }

    final parts = <String>[];
    if (itemsSynced != null) parts.add('$itemsSynced synced');
    if (itemsCreated != null && itemsCreated! > 0) parts.add('$itemsCreated created');
    if (itemsUpdated != null && itemsUpdated! > 0) parts.add('$itemsUpdated updated');
    if (itemsDeleted != null && itemsDeleted! > 0) parts.add('$itemsDeleted deleted');
    if (conflicts != null && conflicts!.isNotEmpty) parts.add('${conflicts!.length} conflicts');

    if (parts.isEmpty) {
      return message;
    } else {
      return '${message}: ${parts.join(', ')}';
    }
  }
}

/// Sync conflict
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
    String? resolution,
    Map<String, dynamic>? metadata,
  }) = _SyncConflict;

  const SyncConflict._();

  factory SyncConflict.fromJson(Map<String, dynamic> json) =>
      _$SyncConflictFromJson(json);

  /// Get conflict description
  String get description {
    switch (type) {
      case ConflictType.contentModified:
        return 'Content modified in both local and remote versions';
      case ConflictType.deletedModified:
        return 'Item deleted locally but modified remotely';
      case ConflictType.modifiedDeleted:
        return 'Item modified locally but deleted remotely';
      case ConflictType.permissionDenied:
        return 'Permission denied for remote operation';
      case ConflictType.versionMismatch:
        return 'Version mismatch between local and remote';
      case ConflictType.networkError:
        return 'Network error during sync';
    }
  }

  /// Get conflict severity
  ConflictSeverity get severity {
    switch (type) {
      case ConflictType.contentModified:
        return ConflictSeverity.medium;
      case ConflictType.deletedModified:
        return ConflictSeverity.high;
      case ConflictType.modifiedDeleted:
        return ConflictSeverity.high;
      case ConflictType.permissionDenied:
        return ConflictSeverity.critical;
      case ConflictType.versionMismatch:
        return ConflictSeverity.medium;
      case ConflictType.networkError:
        return ConflictSeverity.low;
    }
  }

  /// Check if conflict is resolved
  bool get isResolved => resolution != null;
}

/// Conflict type enumeration
enum ConflictType {
  contentModified,
  deletedModified,
  modifiedDeleted,
  permissionDenied,
  versionMismatch,
  networkError,
}

/// Conflict severity enumeration
enum ConflictSeverity {
  low,
  medium,
  high,
  critical,
}
