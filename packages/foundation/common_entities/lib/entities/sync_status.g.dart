// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SyncStatusImpl _$$SyncStatusImplFromJson(Map<String, dynamic> json) =>
    _$SyncStatusImpl(
      state: $enumDecode(_$SyncStateEnumMap, json['state']),
      lastSync: DateTime.parse(json['lastSync'] as String),
      error: json['error'] as String?,
      itemsPending: (json['itemsPending'] as num?)?.toInt(),
      itemsSynced: (json['itemsSynced'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SyncStatusImplToJson(_$SyncStatusImpl instance) =>
    <String, dynamic>{
      'state': _$SyncStateEnumMap[instance.state]!,
      'lastSync': instance.lastSync.toIso8601String(),
      'error': instance.error,
      'itemsPending': instance.itemsPending,
      'itemsSynced': instance.itemsSynced,
    };

const _$SyncStateEnumMap = {
  SyncState.idle: 'idle',
  SyncState.syncing: 'syncing',
  SyncState.success: 'success',
  SyncState.error: 'error',
  SyncState.conflict: 'conflict',
};
