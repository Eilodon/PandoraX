import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_config.freezed.dart';
part 'sync_config.g.dart';

/// Sync configuration entity
@freezed
class SyncConfig with _$SyncConfig {
  const factory SyncConfig({
    @Default(true) bool autoSync,
    @Default(300) int syncInterval, // seconds
    @Default(false) bool syncOnWifiOnly,
    @Default(true) bool enableConflictResolution,
    @Default(1000) int maxRetries,
  }) = _SyncConfig;

  factory SyncConfig.fromJson(Map<String, dynamic> json) =>
      _$SyncConfigFromJson(json);
}
