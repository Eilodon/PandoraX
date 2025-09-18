// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SyncResultImpl _$$SyncResultImplFromJson(Map<String, dynamic> json) =>
    _$SyncResultImpl(
      success: json['success'] as bool,
      error: json['error'] as String?,
      itemsSynced: (json['itemsSynced'] as num).toInt(),
      itemsCreated: (json['itemsCreated'] as num).toInt(),
      itemsUpdated: (json['itemsUpdated'] as num).toInt(),
      itemsDeleted: (json['itemsDeleted'] as num).toInt(),
      conflicts: (json['conflicts'] as List<dynamic>)
          .map((e) => SyncConflict.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$SyncResultImplToJson(_$SyncResultImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'itemsSynced': instance.itemsSynced,
      'itemsCreated': instance.itemsCreated,
      'itemsUpdated': instance.itemsUpdated,
      'itemsDeleted': instance.itemsDeleted,
      'conflicts': instance.conflicts,
      'timestamp': instance.timestamp.toIso8601String(),
    };
