// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SyncConfigImpl _$$SyncConfigImplFromJson(Map<String, dynamic> json) =>
    _$SyncConfigImpl(
      autoSync: json['autoSync'] as bool? ?? true,
      syncInterval: (json['syncInterval'] as num?)?.toInt() ?? 300,
      syncOnWifiOnly: json['syncOnWifiOnly'] as bool? ?? false,
      enableConflictResolution:
          json['enableConflictResolution'] as bool? ?? true,
      maxRetries: (json['maxRetries'] as num?)?.toInt() ?? 1000,
    );

Map<String, dynamic> _$$SyncConfigImplToJson(_$SyncConfigImpl instance) =>
    <String, dynamic>{
      'autoSync': instance.autoSync,
      'syncInterval': instance.syncInterval,
      'syncOnWifiOnly': instance.syncOnWifiOnly,
      'enableConflictResolution': instance.enableConflictResolution,
      'maxRetries': instance.maxRetries,
    };
