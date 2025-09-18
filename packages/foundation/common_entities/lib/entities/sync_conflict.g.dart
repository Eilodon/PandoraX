// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_conflict.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SyncConflictImpl _$$SyncConflictImplFromJson(Map<String, dynamic> json) =>
    _$SyncConflictImpl(
      id: json['id'] as String,
      type: $enumDecode(_$SyncConflictTypeEnumMap, json['type']),
      entityType: json['entityType'] as String,
      localData: json['localData'] as Map<String, dynamic>,
      remoteData: json['remoteData'] as Map<String, dynamic>,
      localModified: DateTime.parse(json['localModified'] as String),
      remoteModified: DateTime.parse(json['remoteModified'] as String),
    );

Map<String, dynamic> _$$SyncConflictImplToJson(_$SyncConflictImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$SyncConflictTypeEnumMap[instance.type]!,
      'entityType': instance.entityType,
      'localData': instance.localData,
      'remoteData': instance.remoteData,
      'localModified': instance.localModified.toIso8601String(),
      'remoteModified': instance.remoteModified.toIso8601String(),
    };

const _$SyncConflictTypeEnumMap = {
  SyncConflictType.content: 'content',
  SyncConflictType.metadata: 'metadata',
  SyncConflictType.timestamp: 'timestamp',
  SyncConflictType.deletion: 'deletion',
};
