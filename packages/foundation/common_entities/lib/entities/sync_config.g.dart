// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SyncConfigImpl _$$SyncConfigImplFromJson(Map<String, dynamic> json) =>
    _$SyncConfigImpl(
      autoSync: json['autoSync'] as bool? ?? true,
      syncInterval: (json['syncInterval'] as num?)?.toInt() ?? 300,
      syncOnWifiOnly: json['syncOnWifiOnly'] as bool? ?? true,
      syncInBackground: json['syncInBackground'] as bool? ?? true,
      maxRetryAttempts: (json['maxRetryAttempts'] as num?)?.toInt() ?? 5,
      retryDelaySeconds: (json['retryDelaySeconds'] as num?)?.toInt() ?? 30,
      enableConflictResolution:
          json['enableConflictResolution'] as bool? ?? true,
      enableDataCompression: json['enableDataCompression'] as bool? ?? true,
      maxConcurrentSyncs: (json['maxConcurrentSyncs'] as num?)?.toInt() ?? 10,
      maxSyncBatchSize: (json['maxSyncBatchSize'] as num?)?.toInt() ?? 100,
      enableIncrementalSync: json['enableIncrementalSync'] as bool? ?? true,
      dataRetentionDays: (json['dataRetentionDays'] as num?)?.toInt() ?? 7,
    );

Map<String, dynamic> _$$SyncConfigImplToJson(_$SyncConfigImpl instance) =>
    <String, dynamic>{
      'autoSync': instance.autoSync,
      'syncInterval': instance.syncInterval,
      'syncOnWifiOnly': instance.syncOnWifiOnly,
      'syncInBackground': instance.syncInBackground,
      'maxRetryAttempts': instance.maxRetryAttempts,
      'retryDelaySeconds': instance.retryDelaySeconds,
      'enableConflictResolution': instance.enableConflictResolution,
      'enableDataCompression': instance.enableDataCompression,
      'maxConcurrentSyncs': instance.maxConcurrentSyncs,
      'maxSyncBatchSize': instance.maxSyncBatchSize,
      'enableIncrementalSync': instance.enableIncrementalSync,
      'dataRetentionDays': instance.dataRetentionDays,
    };

_$SyncStatusImpl _$$SyncStatusImplFromJson(Map<String, dynamic> json) =>
    _$SyncStatusImpl(
      state: SyncState.fromJson(json['state'] as Map<String, dynamic>),
      lastSyncTime: DateTime.parse(json['lastSyncTime'] as String),
      itemsSynced: (json['itemsSynced'] as num).toInt(),
      itemsPending: (json['itemsPending'] as num).toInt(),
      itemsFailed: (json['itemsFailed'] as num).toInt(),
      lastError: json['lastError'] as String?,
      progress: (json['progress'] as num).toDouble(),
    );

Map<String, dynamic> _$$SyncStatusImplToJson(_$SyncStatusImpl instance) =>
    <String, dynamic>{
      'state': instance.state,
      'lastSyncTime': instance.lastSyncTime.toIso8601String(),
      'itemsSynced': instance.itemsSynced,
      'itemsPending': instance.itemsPending,
      'itemsFailed': instance.itemsFailed,
      'lastError': instance.lastError,
      'progress': instance.progress,
    };

_$IdleSyncImpl _$$IdleSyncImplFromJson(Map<String, dynamic> json) =>
    _$IdleSyncImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$IdleSyncImplToJson(_$IdleSyncImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$SyncingSyncImpl _$$SyncingSyncImplFromJson(Map<String, dynamic> json) =>
    _$SyncingSyncImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SyncingSyncImplToJson(_$SyncingSyncImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$PausedSyncImpl _$$PausedSyncImplFromJson(Map<String, dynamic> json) =>
    _$PausedSyncImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$PausedSyncImplToJson(_$PausedSyncImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$ErrorSyncImpl _$$ErrorSyncImplFromJson(Map<String, dynamic> json) =>
    _$ErrorSyncImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ErrorSyncImplToJson(_$ErrorSyncImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$CompletedSyncImpl _$$CompletedSyncImplFromJson(Map<String, dynamic> json) =>
    _$CompletedSyncImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CompletedSyncImplToJson(_$CompletedSyncImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$SyncResultImpl _$$SyncResultImplFromJson(Map<String, dynamic> json) =>
    _$SyncResultImpl(
      success: json['success'] as bool,
      itemsSynced: (json['itemsSynced'] as num).toInt(),
      itemsCreated: (json['itemsCreated'] as num).toInt(),
      itemsUpdated: (json['itemsUpdated'] as num).toInt(),
      itemsDeleted: (json['itemsDeleted'] as num).toInt(),
      conflicts: (json['conflicts'] as List<dynamic>)
          .map((e) => SyncConflict.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      error: json['error'] as String?,
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
    );

Map<String, dynamic> _$$SyncResultImplToJson(_$SyncResultImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'itemsSynced': instance.itemsSynced,
      'itemsCreated': instance.itemsCreated,
      'itemsUpdated': instance.itemsUpdated,
      'itemsDeleted': instance.itemsDeleted,
      'conflicts': instance.conflicts,
      'timestamp': instance.timestamp.toIso8601String(),
      'error': instance.error,
      'duration': instance.duration.inMicroseconds,
    };

_$SyncConflictImpl _$$SyncConflictImplFromJson(Map<String, dynamic> json) =>
    _$SyncConflictImpl(
      id: json['id'] as String,
      entityType: json['entityType'] as String,
      localData: json['localData'] as Map<String, dynamic>,
      remoteData: json['remoteData'] as Map<String, dynamic>,
      localModified: DateTime.parse(json['localModified'] as String),
      remoteModified: DateTime.parse(json['remoteModified'] as String),
      type: ConflictType.fromJson(json['type'] as Map<String, dynamic>),
      resolution: ConflictResolution.fromJson(
          json['resolution'] as Map<String, dynamic>),
      resolutionNote: json['resolutionNote'] as String?,
    );

Map<String, dynamic> _$$SyncConflictImplToJson(_$SyncConflictImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'entityType': instance.entityType,
      'localData': instance.localData,
      'remoteData': instance.remoteData,
      'localModified': instance.localModified.toIso8601String(),
      'remoteModified': instance.remoteModified.toIso8601String(),
      'type': instance.type,
      'resolution': instance.resolution,
      'resolutionNote': instance.resolutionNote,
    };

_$DataMismatchConflictImpl _$$DataMismatchConflictImplFromJson(
        Map<String, dynamic> json) =>
    _$DataMismatchConflictImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DataMismatchConflictImplToJson(
        _$DataMismatchConflictImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$TimestampConflictImpl _$$TimestampConflictImplFromJson(
        Map<String, dynamic> json) =>
    _$TimestampConflictImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TimestampConflictImplToJson(
        _$TimestampConflictImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$DeletionConflictImpl _$$DeletionConflictImplFromJson(
        Map<String, dynamic> json) =>
    _$DeletionConflictImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DeletionConflictImplToJson(
        _$DeletionConflictImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$CreationConflictImpl _$$CreationConflictImplFromJson(
        Map<String, dynamic> json) =>
    _$CreationConflictImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CreationConflictImplToJson(
        _$CreationConflictImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$UseLocalResolutionImpl _$$UseLocalResolutionImplFromJson(
        Map<String, dynamic> json) =>
    _$UseLocalResolutionImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UseLocalResolutionImplToJson(
        _$UseLocalResolutionImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$UseRemoteResolutionImpl _$$UseRemoteResolutionImplFromJson(
        Map<String, dynamic> json) =>
    _$UseRemoteResolutionImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UseRemoteResolutionImplToJson(
        _$UseRemoteResolutionImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$MergeResolutionImpl _$$MergeResolutionImplFromJson(
        Map<String, dynamic> json) =>
    _$MergeResolutionImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$MergeResolutionImplToJson(
        _$MergeResolutionImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$ManualResolutionImpl _$$ManualResolutionImplFromJson(
        Map<String, dynamic> json) =>
    _$ManualResolutionImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ManualResolutionImplToJson(
        _$ManualResolutionImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };
