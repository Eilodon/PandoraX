// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SyncConfig _$SyncConfigFromJson(Map<String, dynamic> json) {
  return _SyncConfig.fromJson(json);
}

/// @nodoc
mixin _$SyncConfig {
  bool get autoSync => throw _privateConstructorUsedError;
  int get syncInterval => throw _privateConstructorUsedError; // seconds
  bool get syncOnWifiOnly => throw _privateConstructorUsedError;
  bool get enableConflictResolution => throw _privateConstructorUsedError;
  int get maxRetries => throw _privateConstructorUsedError;

  /// Serializes this SyncConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SyncConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncConfigCopyWith<SyncConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncConfigCopyWith<$Res> {
  factory $SyncConfigCopyWith(
          SyncConfig value, $Res Function(SyncConfig) then) =
      _$SyncConfigCopyWithImpl<$Res, SyncConfig>;
  @useResult
  $Res call(
      {bool autoSync,
      int syncInterval,
      bool syncOnWifiOnly,
      bool enableConflictResolution,
      int maxRetries});
}

/// @nodoc
class _$SyncConfigCopyWithImpl<$Res, $Val extends SyncConfig>
    implements $SyncConfigCopyWith<$Res> {
  _$SyncConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? autoSync = null,
    Object? syncInterval = null,
    Object? syncOnWifiOnly = null,
    Object? enableConflictResolution = null,
    Object? maxRetries = null,
  }) {
    return _then(_value.copyWith(
      autoSync: null == autoSync
          ? _value.autoSync
          : autoSync // ignore: cast_nullable_to_non_nullable
              as bool,
      syncInterval: null == syncInterval
          ? _value.syncInterval
          : syncInterval // ignore: cast_nullable_to_non_nullable
              as int,
      syncOnWifiOnly: null == syncOnWifiOnly
          ? _value.syncOnWifiOnly
          : syncOnWifiOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      enableConflictResolution: null == enableConflictResolution
          ? _value.enableConflictResolution
          : enableConflictResolution // ignore: cast_nullable_to_non_nullable
              as bool,
      maxRetries: null == maxRetries
          ? _value.maxRetries
          : maxRetries // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncConfigImplCopyWith<$Res>
    implements $SyncConfigCopyWith<$Res> {
  factory _$$SyncConfigImplCopyWith(
          _$SyncConfigImpl value, $Res Function(_$SyncConfigImpl) then) =
      __$$SyncConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool autoSync,
      int syncInterval,
      bool syncOnWifiOnly,
      bool enableConflictResolution,
      int maxRetries});
}

/// @nodoc
class __$$SyncConfigImplCopyWithImpl<$Res>
    extends _$SyncConfigCopyWithImpl<$Res, _$SyncConfigImpl>
    implements _$$SyncConfigImplCopyWith<$Res> {
  __$$SyncConfigImplCopyWithImpl(
      _$SyncConfigImpl _value, $Res Function(_$SyncConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? autoSync = null,
    Object? syncInterval = null,
    Object? syncOnWifiOnly = null,
    Object? enableConflictResolution = null,
    Object? maxRetries = null,
  }) {
    return _then(_$SyncConfigImpl(
      autoSync: null == autoSync
          ? _value.autoSync
          : autoSync // ignore: cast_nullable_to_non_nullable
              as bool,
      syncInterval: null == syncInterval
          ? _value.syncInterval
          : syncInterval // ignore: cast_nullable_to_non_nullable
              as int,
      syncOnWifiOnly: null == syncOnWifiOnly
          ? _value.syncOnWifiOnly
          : syncOnWifiOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      enableConflictResolution: null == enableConflictResolution
          ? _value.enableConflictResolution
          : enableConflictResolution // ignore: cast_nullable_to_non_nullable
              as bool,
      maxRetries: null == maxRetries
          ? _value.maxRetries
          : maxRetries // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncConfigImpl implements _SyncConfig {
  const _$SyncConfigImpl(
      {this.autoSync = true,
      this.syncInterval = 300,
      this.syncOnWifiOnly = false,
      this.enableConflictResolution = true,
      this.maxRetries = 1000});

  factory _$SyncConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncConfigImplFromJson(json);

  @override
  @JsonKey()
  final bool autoSync;
  @override
  @JsonKey()
  final int syncInterval;
// seconds
  @override
  @JsonKey()
  final bool syncOnWifiOnly;
  @override
  @JsonKey()
  final bool enableConflictResolution;
  @override
  @JsonKey()
  final int maxRetries;

  @override
  String toString() {
    return 'SyncConfig(autoSync: $autoSync, syncInterval: $syncInterval, syncOnWifiOnly: $syncOnWifiOnly, enableConflictResolution: $enableConflictResolution, maxRetries: $maxRetries)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncConfigImpl &&
            (identical(other.autoSync, autoSync) ||
                other.autoSync == autoSync) &&
            (identical(other.syncInterval, syncInterval) ||
                other.syncInterval == syncInterval) &&
            (identical(other.syncOnWifiOnly, syncOnWifiOnly) ||
                other.syncOnWifiOnly == syncOnWifiOnly) &&
            (identical(
                    other.enableConflictResolution, enableConflictResolution) ||
                other.enableConflictResolution == enableConflictResolution) &&
            (identical(other.maxRetries, maxRetries) ||
                other.maxRetries == maxRetries));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, autoSync, syncInterval,
      syncOnWifiOnly, enableConflictResolution, maxRetries);

  /// Create a copy of SyncConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncConfigImplCopyWith<_$SyncConfigImpl> get copyWith =>
      __$$SyncConfigImplCopyWithImpl<_$SyncConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncConfigImplToJson(
      this,
    );
  }
}

abstract class _SyncConfig implements SyncConfig {
  const factory _SyncConfig(
      {final bool autoSync,
      final int syncInterval,
      final bool syncOnWifiOnly,
      final bool enableConflictResolution,
      final int maxRetries}) = _$SyncConfigImpl;

  factory _SyncConfig.fromJson(Map<String, dynamic> json) =
      _$SyncConfigImpl.fromJson;

  @override
  bool get autoSync;
  @override
  int get syncInterval; // seconds
  @override
  bool get syncOnWifiOnly;
  @override
  bool get enableConflictResolution;
  @override
  int get maxRetries;

  /// Create a copy of SyncConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncConfigImplCopyWith<_$SyncConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
