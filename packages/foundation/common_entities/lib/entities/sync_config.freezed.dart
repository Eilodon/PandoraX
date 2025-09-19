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
  int get syncInterval => throw _privateConstructorUsedError;
  bool get syncOnWifiOnly => throw _privateConstructorUsedError;
  bool get syncInBackground => throw _privateConstructorUsedError;
  int get maxRetryAttempts => throw _privateConstructorUsedError;
  int get retryDelaySeconds => throw _privateConstructorUsedError;
  bool get enableConflictResolution => throw _privateConstructorUsedError;
  bool get enableDataCompression => throw _privateConstructorUsedError;
  int get maxConcurrentSyncs => throw _privateConstructorUsedError;
  int get maxSyncBatchSize => throw _privateConstructorUsedError;
  bool get enableIncrementalSync => throw _privateConstructorUsedError;
  int get dataRetentionDays => throw _privateConstructorUsedError;

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
      bool syncInBackground,
      int maxRetryAttempts,
      int retryDelaySeconds,
      bool enableConflictResolution,
      bool enableDataCompression,
      int maxConcurrentSyncs,
      int maxSyncBatchSize,
      bool enableIncrementalSync,
      int dataRetentionDays});
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
    Object? syncInBackground = null,
    Object? maxRetryAttempts = null,
    Object? retryDelaySeconds = null,
    Object? enableConflictResolution = null,
    Object? enableDataCompression = null,
    Object? maxConcurrentSyncs = null,
    Object? maxSyncBatchSize = null,
    Object? enableIncrementalSync = null,
    Object? dataRetentionDays = null,
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
      syncInBackground: null == syncInBackground
          ? _value.syncInBackground
          : syncInBackground // ignore: cast_nullable_to_non_nullable
              as bool,
      maxRetryAttempts: null == maxRetryAttempts
          ? _value.maxRetryAttempts
          : maxRetryAttempts // ignore: cast_nullable_to_non_nullable
              as int,
      retryDelaySeconds: null == retryDelaySeconds
          ? _value.retryDelaySeconds
          : retryDelaySeconds // ignore: cast_nullable_to_non_nullable
              as int,
      enableConflictResolution: null == enableConflictResolution
          ? _value.enableConflictResolution
          : enableConflictResolution // ignore: cast_nullable_to_non_nullable
              as bool,
      enableDataCompression: null == enableDataCompression
          ? _value.enableDataCompression
          : enableDataCompression // ignore: cast_nullable_to_non_nullable
              as bool,
      maxConcurrentSyncs: null == maxConcurrentSyncs
          ? _value.maxConcurrentSyncs
          : maxConcurrentSyncs // ignore: cast_nullable_to_non_nullable
              as int,
      maxSyncBatchSize: null == maxSyncBatchSize
          ? _value.maxSyncBatchSize
          : maxSyncBatchSize // ignore: cast_nullable_to_non_nullable
              as int,
      enableIncrementalSync: null == enableIncrementalSync
          ? _value.enableIncrementalSync
          : enableIncrementalSync // ignore: cast_nullable_to_non_nullable
              as bool,
      dataRetentionDays: null == dataRetentionDays
          ? _value.dataRetentionDays
          : dataRetentionDays // ignore: cast_nullable_to_non_nullable
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
      bool syncInBackground,
      int maxRetryAttempts,
      int retryDelaySeconds,
      bool enableConflictResolution,
      bool enableDataCompression,
      int maxConcurrentSyncs,
      int maxSyncBatchSize,
      bool enableIncrementalSync,
      int dataRetentionDays});
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
    Object? syncInBackground = null,
    Object? maxRetryAttempts = null,
    Object? retryDelaySeconds = null,
    Object? enableConflictResolution = null,
    Object? enableDataCompression = null,
    Object? maxConcurrentSyncs = null,
    Object? maxSyncBatchSize = null,
    Object? enableIncrementalSync = null,
    Object? dataRetentionDays = null,
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
      syncInBackground: null == syncInBackground
          ? _value.syncInBackground
          : syncInBackground // ignore: cast_nullable_to_non_nullable
              as bool,
      maxRetryAttempts: null == maxRetryAttempts
          ? _value.maxRetryAttempts
          : maxRetryAttempts // ignore: cast_nullable_to_non_nullable
              as int,
      retryDelaySeconds: null == retryDelaySeconds
          ? _value.retryDelaySeconds
          : retryDelaySeconds // ignore: cast_nullable_to_non_nullable
              as int,
      enableConflictResolution: null == enableConflictResolution
          ? _value.enableConflictResolution
          : enableConflictResolution // ignore: cast_nullable_to_non_nullable
              as bool,
      enableDataCompression: null == enableDataCompression
          ? _value.enableDataCompression
          : enableDataCompression // ignore: cast_nullable_to_non_nullable
              as bool,
      maxConcurrentSyncs: null == maxConcurrentSyncs
          ? _value.maxConcurrentSyncs
          : maxConcurrentSyncs // ignore: cast_nullable_to_non_nullable
              as int,
      maxSyncBatchSize: null == maxSyncBatchSize
          ? _value.maxSyncBatchSize
          : maxSyncBatchSize // ignore: cast_nullable_to_non_nullable
              as int,
      enableIncrementalSync: null == enableIncrementalSync
          ? _value.enableIncrementalSync
          : enableIncrementalSync // ignore: cast_nullable_to_non_nullable
              as bool,
      dataRetentionDays: null == dataRetentionDays
          ? _value.dataRetentionDays
          : dataRetentionDays // ignore: cast_nullable_to_non_nullable
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
      this.syncOnWifiOnly = true,
      this.syncInBackground = true,
      this.maxRetryAttempts = 5,
      this.retryDelaySeconds = 30,
      this.enableConflictResolution = true,
      this.enableDataCompression = true,
      this.maxConcurrentSyncs = 10,
      this.maxSyncBatchSize = 100,
      this.enableIncrementalSync = true,
      this.dataRetentionDays = 7});

  factory _$SyncConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncConfigImplFromJson(json);

  @override
  @JsonKey()
  final bool autoSync;
  @override
  @JsonKey()
  final int syncInterval;
  @override
  @JsonKey()
  final bool syncOnWifiOnly;
  @override
  @JsonKey()
  final bool syncInBackground;
  @override
  @JsonKey()
  final int maxRetryAttempts;
  @override
  @JsonKey()
  final int retryDelaySeconds;
  @override
  @JsonKey()
  final bool enableConflictResolution;
  @override
  @JsonKey()
  final bool enableDataCompression;
  @override
  @JsonKey()
  final int maxConcurrentSyncs;
  @override
  @JsonKey()
  final int maxSyncBatchSize;
  @override
  @JsonKey()
  final bool enableIncrementalSync;
  @override
  @JsonKey()
  final int dataRetentionDays;

  @override
  String toString() {
    return 'SyncConfig(autoSync: $autoSync, syncInterval: $syncInterval, syncOnWifiOnly: $syncOnWifiOnly, syncInBackground: $syncInBackground, maxRetryAttempts: $maxRetryAttempts, retryDelaySeconds: $retryDelaySeconds, enableConflictResolution: $enableConflictResolution, enableDataCompression: $enableDataCompression, maxConcurrentSyncs: $maxConcurrentSyncs, maxSyncBatchSize: $maxSyncBatchSize, enableIncrementalSync: $enableIncrementalSync, dataRetentionDays: $dataRetentionDays)';
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
            (identical(other.syncInBackground, syncInBackground) ||
                other.syncInBackground == syncInBackground) &&
            (identical(other.maxRetryAttempts, maxRetryAttempts) ||
                other.maxRetryAttempts == maxRetryAttempts) &&
            (identical(other.retryDelaySeconds, retryDelaySeconds) ||
                other.retryDelaySeconds == retryDelaySeconds) &&
            (identical(
                    other.enableConflictResolution, enableConflictResolution) ||
                other.enableConflictResolution == enableConflictResolution) &&
            (identical(other.enableDataCompression, enableDataCompression) ||
                other.enableDataCompression == enableDataCompression) &&
            (identical(other.maxConcurrentSyncs, maxConcurrentSyncs) ||
                other.maxConcurrentSyncs == maxConcurrentSyncs) &&
            (identical(other.maxSyncBatchSize, maxSyncBatchSize) ||
                other.maxSyncBatchSize == maxSyncBatchSize) &&
            (identical(other.enableIncrementalSync, enableIncrementalSync) ||
                other.enableIncrementalSync == enableIncrementalSync) &&
            (identical(other.dataRetentionDays, dataRetentionDays) ||
                other.dataRetentionDays == dataRetentionDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      autoSync,
      syncInterval,
      syncOnWifiOnly,
      syncInBackground,
      maxRetryAttempts,
      retryDelaySeconds,
      enableConflictResolution,
      enableDataCompression,
      maxConcurrentSyncs,
      maxSyncBatchSize,
      enableIncrementalSync,
      dataRetentionDays);

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
      final bool syncInBackground,
      final int maxRetryAttempts,
      final int retryDelaySeconds,
      final bool enableConflictResolution,
      final bool enableDataCompression,
      final int maxConcurrentSyncs,
      final int maxSyncBatchSize,
      final bool enableIncrementalSync,
      final int dataRetentionDays}) = _$SyncConfigImpl;

  factory _SyncConfig.fromJson(Map<String, dynamic> json) =
      _$SyncConfigImpl.fromJson;

  @override
  bool get autoSync;
  @override
  int get syncInterval;
  @override
  bool get syncOnWifiOnly;
  @override
  bool get syncInBackground;
  @override
  int get maxRetryAttempts;
  @override
  int get retryDelaySeconds;
  @override
  bool get enableConflictResolution;
  @override
  bool get enableDataCompression;
  @override
  int get maxConcurrentSyncs;
  @override
  int get maxSyncBatchSize;
  @override
  bool get enableIncrementalSync;
  @override
  int get dataRetentionDays;

  /// Create a copy of SyncConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncConfigImplCopyWith<_$SyncConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SyncStatus _$SyncStatusFromJson(Map<String, dynamic> json) {
  return _SyncStatus.fromJson(json);
}

/// @nodoc
mixin _$SyncStatus {
  SyncState get state => throw _privateConstructorUsedError;
  DateTime get lastSyncTime => throw _privateConstructorUsedError;
  int get itemsSynced => throw _privateConstructorUsedError;
  int get itemsPending => throw _privateConstructorUsedError;
  int get itemsFailed => throw _privateConstructorUsedError;
  String? get lastError => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;

  /// Serializes this SyncStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncStatusCopyWith<SyncStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncStatusCopyWith<$Res> {
  factory $SyncStatusCopyWith(
          SyncStatus value, $Res Function(SyncStatus) then) =
      _$SyncStatusCopyWithImpl<$Res, SyncStatus>;
  @useResult
  $Res call(
      {SyncState state,
      DateTime lastSyncTime,
      int itemsSynced,
      int itemsPending,
      int itemsFailed,
      String? lastError,
      double progress});

  $SyncStateCopyWith<$Res> get state;
}

/// @nodoc
class _$SyncStatusCopyWithImpl<$Res, $Val extends SyncStatus>
    implements $SyncStatusCopyWith<$Res> {
  _$SyncStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? lastSyncTime = null,
    Object? itemsSynced = null,
    Object? itemsPending = null,
    Object? itemsFailed = null,
    Object? lastError = freezed,
    Object? progress = null,
  }) {
    return _then(_value.copyWith(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as SyncState,
      lastSyncTime: null == lastSyncTime
          ? _value.lastSyncTime
          : lastSyncTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      itemsSynced: null == itemsSynced
          ? _value.itemsSynced
          : itemsSynced // ignore: cast_nullable_to_non_nullable
              as int,
      itemsPending: null == itemsPending
          ? _value.itemsPending
          : itemsPending // ignore: cast_nullable_to_non_nullable
              as int,
      itemsFailed: null == itemsFailed
          ? _value.itemsFailed
          : itemsFailed // ignore: cast_nullable_to_non_nullable
              as int,
      lastError: freezed == lastError
          ? _value.lastError
          : lastError // ignore: cast_nullable_to_non_nullable
              as String?,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SyncStateCopyWith<$Res> get state {
    return $SyncStateCopyWith<$Res>(_value.state, (value) {
      return _then(_value.copyWith(state: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SyncStatusImplCopyWith<$Res>
    implements $SyncStatusCopyWith<$Res> {
  factory _$$SyncStatusImplCopyWith(
          _$SyncStatusImpl value, $Res Function(_$SyncStatusImpl) then) =
      __$$SyncStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SyncState state,
      DateTime lastSyncTime,
      int itemsSynced,
      int itemsPending,
      int itemsFailed,
      String? lastError,
      double progress});

  @override
  $SyncStateCopyWith<$Res> get state;
}

/// @nodoc
class __$$SyncStatusImplCopyWithImpl<$Res>
    extends _$SyncStatusCopyWithImpl<$Res, _$SyncStatusImpl>
    implements _$$SyncStatusImplCopyWith<$Res> {
  __$$SyncStatusImplCopyWithImpl(
      _$SyncStatusImpl _value, $Res Function(_$SyncStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? lastSyncTime = null,
    Object? itemsSynced = null,
    Object? itemsPending = null,
    Object? itemsFailed = null,
    Object? lastError = freezed,
    Object? progress = null,
  }) {
    return _then(_$SyncStatusImpl(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as SyncState,
      lastSyncTime: null == lastSyncTime
          ? _value.lastSyncTime
          : lastSyncTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      itemsSynced: null == itemsSynced
          ? _value.itemsSynced
          : itemsSynced // ignore: cast_nullable_to_non_nullable
              as int,
      itemsPending: null == itemsPending
          ? _value.itemsPending
          : itemsPending // ignore: cast_nullable_to_non_nullable
              as int,
      itemsFailed: null == itemsFailed
          ? _value.itemsFailed
          : itemsFailed // ignore: cast_nullable_to_non_nullable
              as int,
      lastError: freezed == lastError
          ? _value.lastError
          : lastError // ignore: cast_nullable_to_non_nullable
              as String?,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncStatusImpl implements _SyncStatus {
  const _$SyncStatusImpl(
      {required this.state,
      required this.lastSyncTime,
      required this.itemsSynced,
      required this.itemsPending,
      required this.itemsFailed,
      this.lastError,
      required this.progress});

  factory _$SyncStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncStatusImplFromJson(json);

  @override
  final SyncState state;
  @override
  final DateTime lastSyncTime;
  @override
  final int itemsSynced;
  @override
  final int itemsPending;
  @override
  final int itemsFailed;
  @override
  final String? lastError;
  @override
  final double progress;

  @override
  String toString() {
    return 'SyncStatus(state: $state, lastSyncTime: $lastSyncTime, itemsSynced: $itemsSynced, itemsPending: $itemsPending, itemsFailed: $itemsFailed, lastError: $lastError, progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncStatusImpl &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.lastSyncTime, lastSyncTime) ||
                other.lastSyncTime == lastSyncTime) &&
            (identical(other.itemsSynced, itemsSynced) ||
                other.itemsSynced == itemsSynced) &&
            (identical(other.itemsPending, itemsPending) ||
                other.itemsPending == itemsPending) &&
            (identical(other.itemsFailed, itemsFailed) ||
                other.itemsFailed == itemsFailed) &&
            (identical(other.lastError, lastError) ||
                other.lastError == lastError) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, state, lastSyncTime, itemsSynced,
      itemsPending, itemsFailed, lastError, progress);

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncStatusImplCopyWith<_$SyncStatusImpl> get copyWith =>
      __$$SyncStatusImplCopyWithImpl<_$SyncStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncStatusImplToJson(
      this,
    );
  }
}

abstract class _SyncStatus implements SyncStatus {
  const factory _SyncStatus(
      {required final SyncState state,
      required final DateTime lastSyncTime,
      required final int itemsSynced,
      required final int itemsPending,
      required final int itemsFailed,
      final String? lastError,
      required final double progress}) = _$SyncStatusImpl;

  factory _SyncStatus.fromJson(Map<String, dynamic> json) =
      _$SyncStatusImpl.fromJson;

  @override
  SyncState get state;
  @override
  DateTime get lastSyncTime;
  @override
  int get itemsSynced;
  @override
  int get itemsPending;
  @override
  int get itemsFailed;
  @override
  String? get lastError;
  @override
  double get progress;

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncStatusImplCopyWith<_$SyncStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SyncState _$SyncStateFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'idle':
      return IdleSync.fromJson(json);
    case 'syncing':
      return SyncingSync.fromJson(json);
    case 'paused':
      return PausedSync.fromJson(json);
    case 'error':
      return ErrorSync.fromJson(json);
    case 'completed':
      return CompletedSync.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'SyncState',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SyncState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() syncing,
    required TResult Function() paused,
    required TResult Function() error,
    required TResult Function() completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? syncing,
    TResult? Function()? paused,
    TResult? Function()? error,
    TResult? Function()? completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? syncing,
    TResult Function()? paused,
    TResult Function()? error,
    TResult Function()? completed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IdleSync value) idle,
    required TResult Function(SyncingSync value) syncing,
    required TResult Function(PausedSync value) paused,
    required TResult Function(ErrorSync value) error,
    required TResult Function(CompletedSync value) completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(IdleSync value)? idle,
    TResult? Function(SyncingSync value)? syncing,
    TResult? Function(PausedSync value)? paused,
    TResult? Function(ErrorSync value)? error,
    TResult? Function(CompletedSync value)? completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(IdleSync value)? idle,
    TResult Function(SyncingSync value)? syncing,
    TResult Function(PausedSync value)? paused,
    TResult Function(ErrorSync value)? error,
    TResult Function(CompletedSync value)? completed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this SyncState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncStateCopyWith<$Res> {
  factory $SyncStateCopyWith(SyncState value, $Res Function(SyncState) then) =
      _$SyncStateCopyWithImpl<$Res, SyncState>;
}

/// @nodoc
class _$SyncStateCopyWithImpl<$Res, $Val extends SyncState>
    implements $SyncStateCopyWith<$Res> {
  _$SyncStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$IdleSyncImplCopyWith<$Res> {
  factory _$$IdleSyncImplCopyWith(
          _$IdleSyncImpl value, $Res Function(_$IdleSyncImpl) then) =
      __$$IdleSyncImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$IdleSyncImplCopyWithImpl<$Res>
    extends _$SyncStateCopyWithImpl<$Res, _$IdleSyncImpl>
    implements _$$IdleSyncImplCopyWith<$Res> {
  __$$IdleSyncImplCopyWithImpl(
      _$IdleSyncImpl _value, $Res Function(_$IdleSyncImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$IdleSyncImpl implements IdleSync {
  const _$IdleSyncImpl({final String? $type}) : $type = $type ?? 'idle';

  factory _$IdleSyncImpl.fromJson(Map<String, dynamic> json) =>
      _$$IdleSyncImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SyncState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$IdleSyncImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() syncing,
    required TResult Function() paused,
    required TResult Function() error,
    required TResult Function() completed,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? syncing,
    TResult? Function()? paused,
    TResult? Function()? error,
    TResult? Function()? completed,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? syncing,
    TResult Function()? paused,
    TResult Function()? error,
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IdleSync value) idle,
    required TResult Function(SyncingSync value) syncing,
    required TResult Function(PausedSync value) paused,
    required TResult Function(ErrorSync value) error,
    required TResult Function(CompletedSync value) completed,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(IdleSync value)? idle,
    TResult? Function(SyncingSync value)? syncing,
    TResult? Function(PausedSync value)? paused,
    TResult? Function(ErrorSync value)? error,
    TResult? Function(CompletedSync value)? completed,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(IdleSync value)? idle,
    TResult Function(SyncingSync value)? syncing,
    TResult Function(PausedSync value)? paused,
    TResult Function(ErrorSync value)? error,
    TResult Function(CompletedSync value)? completed,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$IdleSyncImplToJson(
      this,
    );
  }
}

abstract class IdleSync implements SyncState {
  const factory IdleSync() = _$IdleSyncImpl;

  factory IdleSync.fromJson(Map<String, dynamic> json) =
      _$IdleSyncImpl.fromJson;
}

/// @nodoc
abstract class _$$SyncingSyncImplCopyWith<$Res> {
  factory _$$SyncingSyncImplCopyWith(
          _$SyncingSyncImpl value, $Res Function(_$SyncingSyncImpl) then) =
      __$$SyncingSyncImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SyncingSyncImplCopyWithImpl<$Res>
    extends _$SyncStateCopyWithImpl<$Res, _$SyncingSyncImpl>
    implements _$$SyncingSyncImplCopyWith<$Res> {
  __$$SyncingSyncImplCopyWithImpl(
      _$SyncingSyncImpl _value, $Res Function(_$SyncingSyncImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$SyncingSyncImpl implements SyncingSync {
  const _$SyncingSyncImpl({final String? $type}) : $type = $type ?? 'syncing';

  factory _$SyncingSyncImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncingSyncImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SyncState.syncing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SyncingSyncImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() syncing,
    required TResult Function() paused,
    required TResult Function() error,
    required TResult Function() completed,
  }) {
    return syncing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? syncing,
    TResult? Function()? paused,
    TResult? Function()? error,
    TResult? Function()? completed,
  }) {
    return syncing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? syncing,
    TResult Function()? paused,
    TResult Function()? error,
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    if (syncing != null) {
      return syncing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IdleSync value) idle,
    required TResult Function(SyncingSync value) syncing,
    required TResult Function(PausedSync value) paused,
    required TResult Function(ErrorSync value) error,
    required TResult Function(CompletedSync value) completed,
  }) {
    return syncing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(IdleSync value)? idle,
    TResult? Function(SyncingSync value)? syncing,
    TResult? Function(PausedSync value)? paused,
    TResult? Function(ErrorSync value)? error,
    TResult? Function(CompletedSync value)? completed,
  }) {
    return syncing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(IdleSync value)? idle,
    TResult Function(SyncingSync value)? syncing,
    TResult Function(PausedSync value)? paused,
    TResult Function(ErrorSync value)? error,
    TResult Function(CompletedSync value)? completed,
    required TResult orElse(),
  }) {
    if (syncing != null) {
      return syncing(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncingSyncImplToJson(
      this,
    );
  }
}

abstract class SyncingSync implements SyncState {
  const factory SyncingSync() = _$SyncingSyncImpl;

  factory SyncingSync.fromJson(Map<String, dynamic> json) =
      _$SyncingSyncImpl.fromJson;
}

/// @nodoc
abstract class _$$PausedSyncImplCopyWith<$Res> {
  factory _$$PausedSyncImplCopyWith(
          _$PausedSyncImpl value, $Res Function(_$PausedSyncImpl) then) =
      __$$PausedSyncImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PausedSyncImplCopyWithImpl<$Res>
    extends _$SyncStateCopyWithImpl<$Res, _$PausedSyncImpl>
    implements _$$PausedSyncImplCopyWith<$Res> {
  __$$PausedSyncImplCopyWithImpl(
      _$PausedSyncImpl _value, $Res Function(_$PausedSyncImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$PausedSyncImpl implements PausedSync {
  const _$PausedSyncImpl({final String? $type}) : $type = $type ?? 'paused';

  factory _$PausedSyncImpl.fromJson(Map<String, dynamic> json) =>
      _$$PausedSyncImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SyncState.paused()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PausedSyncImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() syncing,
    required TResult Function() paused,
    required TResult Function() error,
    required TResult Function() completed,
  }) {
    return paused();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? syncing,
    TResult? Function()? paused,
    TResult? Function()? error,
    TResult? Function()? completed,
  }) {
    return paused?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? syncing,
    TResult Function()? paused,
    TResult Function()? error,
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    if (paused != null) {
      return paused();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IdleSync value) idle,
    required TResult Function(SyncingSync value) syncing,
    required TResult Function(PausedSync value) paused,
    required TResult Function(ErrorSync value) error,
    required TResult Function(CompletedSync value) completed,
  }) {
    return paused(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(IdleSync value)? idle,
    TResult? Function(SyncingSync value)? syncing,
    TResult? Function(PausedSync value)? paused,
    TResult? Function(ErrorSync value)? error,
    TResult? Function(CompletedSync value)? completed,
  }) {
    return paused?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(IdleSync value)? idle,
    TResult Function(SyncingSync value)? syncing,
    TResult Function(PausedSync value)? paused,
    TResult Function(ErrorSync value)? error,
    TResult Function(CompletedSync value)? completed,
    required TResult orElse(),
  }) {
    if (paused != null) {
      return paused(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PausedSyncImplToJson(
      this,
    );
  }
}

abstract class PausedSync implements SyncState {
  const factory PausedSync() = _$PausedSyncImpl;

  factory PausedSync.fromJson(Map<String, dynamic> json) =
      _$PausedSyncImpl.fromJson;
}

/// @nodoc
abstract class _$$ErrorSyncImplCopyWith<$Res> {
  factory _$$ErrorSyncImplCopyWith(
          _$ErrorSyncImpl value, $Res Function(_$ErrorSyncImpl) then) =
      __$$ErrorSyncImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ErrorSyncImplCopyWithImpl<$Res>
    extends _$SyncStateCopyWithImpl<$Res, _$ErrorSyncImpl>
    implements _$$ErrorSyncImplCopyWith<$Res> {
  __$$ErrorSyncImplCopyWithImpl(
      _$ErrorSyncImpl _value, $Res Function(_$ErrorSyncImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$ErrorSyncImpl implements ErrorSync {
  const _$ErrorSyncImpl({final String? $type}) : $type = $type ?? 'error';

  factory _$ErrorSyncImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorSyncImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SyncState.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ErrorSyncImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() syncing,
    required TResult Function() paused,
    required TResult Function() error,
    required TResult Function() completed,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? syncing,
    TResult? Function()? paused,
    TResult? Function()? error,
    TResult? Function()? completed,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? syncing,
    TResult Function()? paused,
    TResult Function()? error,
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IdleSync value) idle,
    required TResult Function(SyncingSync value) syncing,
    required TResult Function(PausedSync value) paused,
    required TResult Function(ErrorSync value) error,
    required TResult Function(CompletedSync value) completed,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(IdleSync value)? idle,
    TResult? Function(SyncingSync value)? syncing,
    TResult? Function(PausedSync value)? paused,
    TResult? Function(ErrorSync value)? error,
    TResult? Function(CompletedSync value)? completed,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(IdleSync value)? idle,
    TResult Function(SyncingSync value)? syncing,
    TResult Function(PausedSync value)? paused,
    TResult Function(ErrorSync value)? error,
    TResult Function(CompletedSync value)? completed,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorSyncImplToJson(
      this,
    );
  }
}

abstract class ErrorSync implements SyncState {
  const factory ErrorSync() = _$ErrorSyncImpl;

  factory ErrorSync.fromJson(Map<String, dynamic> json) =
      _$ErrorSyncImpl.fromJson;
}

/// @nodoc
abstract class _$$CompletedSyncImplCopyWith<$Res> {
  factory _$$CompletedSyncImplCopyWith(
          _$CompletedSyncImpl value, $Res Function(_$CompletedSyncImpl) then) =
      __$$CompletedSyncImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CompletedSyncImplCopyWithImpl<$Res>
    extends _$SyncStateCopyWithImpl<$Res, _$CompletedSyncImpl>
    implements _$$CompletedSyncImplCopyWith<$Res> {
  __$$CompletedSyncImplCopyWithImpl(
      _$CompletedSyncImpl _value, $Res Function(_$CompletedSyncImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$CompletedSyncImpl implements CompletedSync {
  const _$CompletedSyncImpl({final String? $type})
      : $type = $type ?? 'completed';

  factory _$CompletedSyncImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompletedSyncImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SyncState.completed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CompletedSyncImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() syncing,
    required TResult Function() paused,
    required TResult Function() error,
    required TResult Function() completed,
  }) {
    return completed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? syncing,
    TResult? Function()? paused,
    TResult? Function()? error,
    TResult? Function()? completed,
  }) {
    return completed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? syncing,
    TResult Function()? paused,
    TResult Function()? error,
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IdleSync value) idle,
    required TResult Function(SyncingSync value) syncing,
    required TResult Function(PausedSync value) paused,
    required TResult Function(ErrorSync value) error,
    required TResult Function(CompletedSync value) completed,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(IdleSync value)? idle,
    TResult? Function(SyncingSync value)? syncing,
    TResult? Function(PausedSync value)? paused,
    TResult? Function(ErrorSync value)? error,
    TResult? Function(CompletedSync value)? completed,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(IdleSync value)? idle,
    TResult Function(SyncingSync value)? syncing,
    TResult Function(PausedSync value)? paused,
    TResult Function(ErrorSync value)? error,
    TResult Function(CompletedSync value)? completed,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CompletedSyncImplToJson(
      this,
    );
  }
}

abstract class CompletedSync implements SyncState {
  const factory CompletedSync() = _$CompletedSyncImpl;

  factory CompletedSync.fromJson(Map<String, dynamic> json) =
      _$CompletedSyncImpl.fromJson;
}

SyncResult _$SyncResultFromJson(Map<String, dynamic> json) {
  return _SyncResult.fromJson(json);
}

/// @nodoc
mixin _$SyncResult {
  bool get success => throw _privateConstructorUsedError;
  int get itemsSynced => throw _privateConstructorUsedError;
  int get itemsCreated => throw _privateConstructorUsedError;
  int get itemsUpdated => throw _privateConstructorUsedError;
  int get itemsDeleted => throw _privateConstructorUsedError;
  List<SyncConflict> get conflicts => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;

  /// Serializes this SyncResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SyncResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncResultCopyWith<SyncResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncResultCopyWith<$Res> {
  factory $SyncResultCopyWith(
          SyncResult value, $Res Function(SyncResult) then) =
      _$SyncResultCopyWithImpl<$Res, SyncResult>;
  @useResult
  $Res call(
      {bool success,
      int itemsSynced,
      int itemsCreated,
      int itemsUpdated,
      int itemsDeleted,
      List<SyncConflict> conflicts,
      DateTime timestamp,
      String? error,
      Duration duration});
}

/// @nodoc
class _$SyncResultCopyWithImpl<$Res, $Val extends SyncResult>
    implements $SyncResultCopyWith<$Res> {
  _$SyncResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? itemsSynced = null,
    Object? itemsCreated = null,
    Object? itemsUpdated = null,
    Object? itemsDeleted = null,
    Object? conflicts = null,
    Object? timestamp = null,
    Object? error = freezed,
    Object? duration = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      itemsSynced: null == itemsSynced
          ? _value.itemsSynced
          : itemsSynced // ignore: cast_nullable_to_non_nullable
              as int,
      itemsCreated: null == itemsCreated
          ? _value.itemsCreated
          : itemsCreated // ignore: cast_nullable_to_non_nullable
              as int,
      itemsUpdated: null == itemsUpdated
          ? _value.itemsUpdated
          : itemsUpdated // ignore: cast_nullable_to_non_nullable
              as int,
      itemsDeleted: null == itemsDeleted
          ? _value.itemsDeleted
          : itemsDeleted // ignore: cast_nullable_to_non_nullable
              as int,
      conflicts: null == conflicts
          ? _value.conflicts
          : conflicts // ignore: cast_nullable_to_non_nullable
              as List<SyncConflict>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncResultImplCopyWith<$Res>
    implements $SyncResultCopyWith<$Res> {
  factory _$$SyncResultImplCopyWith(
          _$SyncResultImpl value, $Res Function(_$SyncResultImpl) then) =
      __$$SyncResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      int itemsSynced,
      int itemsCreated,
      int itemsUpdated,
      int itemsDeleted,
      List<SyncConflict> conflicts,
      DateTime timestamp,
      String? error,
      Duration duration});
}

/// @nodoc
class __$$SyncResultImplCopyWithImpl<$Res>
    extends _$SyncResultCopyWithImpl<$Res, _$SyncResultImpl>
    implements _$$SyncResultImplCopyWith<$Res> {
  __$$SyncResultImplCopyWithImpl(
      _$SyncResultImpl _value, $Res Function(_$SyncResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? itemsSynced = null,
    Object? itemsCreated = null,
    Object? itemsUpdated = null,
    Object? itemsDeleted = null,
    Object? conflicts = null,
    Object? timestamp = null,
    Object? error = freezed,
    Object? duration = null,
  }) {
    return _then(_$SyncResultImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      itemsSynced: null == itemsSynced
          ? _value.itemsSynced
          : itemsSynced // ignore: cast_nullable_to_non_nullable
              as int,
      itemsCreated: null == itemsCreated
          ? _value.itemsCreated
          : itemsCreated // ignore: cast_nullable_to_non_nullable
              as int,
      itemsUpdated: null == itemsUpdated
          ? _value.itemsUpdated
          : itemsUpdated // ignore: cast_nullable_to_non_nullable
              as int,
      itemsDeleted: null == itemsDeleted
          ? _value.itemsDeleted
          : itemsDeleted // ignore: cast_nullable_to_non_nullable
              as int,
      conflicts: null == conflicts
          ? _value._conflicts
          : conflicts // ignore: cast_nullable_to_non_nullable
              as List<SyncConflict>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncResultImpl implements _SyncResult {
  const _$SyncResultImpl(
      {required this.success,
      required this.itemsSynced,
      required this.itemsCreated,
      required this.itemsUpdated,
      required this.itemsDeleted,
      required final List<SyncConflict> conflicts,
      required this.timestamp,
      this.error,
      required this.duration})
      : _conflicts = conflicts;

  factory _$SyncResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncResultImplFromJson(json);

  @override
  final bool success;
  @override
  final int itemsSynced;
  @override
  final int itemsCreated;
  @override
  final int itemsUpdated;
  @override
  final int itemsDeleted;
  final List<SyncConflict> _conflicts;
  @override
  List<SyncConflict> get conflicts {
    if (_conflicts is EqualUnmodifiableListView) return _conflicts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conflicts);
  }

  @override
  final DateTime timestamp;
  @override
  final String? error;
  @override
  final Duration duration;

  @override
  String toString() {
    return 'SyncResult(success: $success, itemsSynced: $itemsSynced, itemsCreated: $itemsCreated, itemsUpdated: $itemsUpdated, itemsDeleted: $itemsDeleted, conflicts: $conflicts, timestamp: $timestamp, error: $error, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncResultImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.itemsSynced, itemsSynced) ||
                other.itemsSynced == itemsSynced) &&
            (identical(other.itemsCreated, itemsCreated) ||
                other.itemsCreated == itemsCreated) &&
            (identical(other.itemsUpdated, itemsUpdated) ||
                other.itemsUpdated == itemsUpdated) &&
            (identical(other.itemsDeleted, itemsDeleted) ||
                other.itemsDeleted == itemsDeleted) &&
            const DeepCollectionEquality()
                .equals(other._conflicts, _conflicts) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      success,
      itemsSynced,
      itemsCreated,
      itemsUpdated,
      itemsDeleted,
      const DeepCollectionEquality().hash(_conflicts),
      timestamp,
      error,
      duration);

  /// Create a copy of SyncResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncResultImplCopyWith<_$SyncResultImpl> get copyWith =>
      __$$SyncResultImplCopyWithImpl<_$SyncResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncResultImplToJson(
      this,
    );
  }
}

abstract class _SyncResult implements SyncResult {
  const factory _SyncResult(
      {required final bool success,
      required final int itemsSynced,
      required final int itemsCreated,
      required final int itemsUpdated,
      required final int itemsDeleted,
      required final List<SyncConflict> conflicts,
      required final DateTime timestamp,
      final String? error,
      required final Duration duration}) = _$SyncResultImpl;

  factory _SyncResult.fromJson(Map<String, dynamic> json) =
      _$SyncResultImpl.fromJson;

  @override
  bool get success;
  @override
  int get itemsSynced;
  @override
  int get itemsCreated;
  @override
  int get itemsUpdated;
  @override
  int get itemsDeleted;
  @override
  List<SyncConflict> get conflicts;
  @override
  DateTime get timestamp;
  @override
  String? get error;
  @override
  Duration get duration;

  /// Create a copy of SyncResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncResultImplCopyWith<_$SyncResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SyncConflict _$SyncConflictFromJson(Map<String, dynamic> json) {
  return _SyncConflict.fromJson(json);
}

/// @nodoc
mixin _$SyncConflict {
  String get id => throw _privateConstructorUsedError;
  String get entityType => throw _privateConstructorUsedError;
  Map<String, dynamic> get localData => throw _privateConstructorUsedError;
  Map<String, dynamic> get remoteData => throw _privateConstructorUsedError;
  DateTime get localModified => throw _privateConstructorUsedError;
  DateTime get remoteModified => throw _privateConstructorUsedError;
  ConflictType get type => throw _privateConstructorUsedError;
  ConflictResolution get resolution => throw _privateConstructorUsedError;
  String? get resolutionNote => throw _privateConstructorUsedError;

  /// Serializes this SyncConflict to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SyncConflict
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncConflictCopyWith<SyncConflict> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncConflictCopyWith<$Res> {
  factory $SyncConflictCopyWith(
          SyncConflict value, $Res Function(SyncConflict) then) =
      _$SyncConflictCopyWithImpl<$Res, SyncConflict>;
  @useResult
  $Res call(
      {String id,
      String entityType,
      Map<String, dynamic> localData,
      Map<String, dynamic> remoteData,
      DateTime localModified,
      DateTime remoteModified,
      ConflictType type,
      ConflictResolution resolution,
      String? resolutionNote});

  $ConflictTypeCopyWith<$Res> get type;
  $ConflictResolutionCopyWith<$Res> get resolution;
}

/// @nodoc
class _$SyncConflictCopyWithImpl<$Res, $Val extends SyncConflict>
    implements $SyncConflictCopyWith<$Res> {
  _$SyncConflictCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncConflict
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? entityType = null,
    Object? localData = null,
    Object? remoteData = null,
    Object? localModified = null,
    Object? remoteModified = null,
    Object? type = null,
    Object? resolution = null,
    Object? resolutionNote = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      entityType: null == entityType
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      localData: null == localData
          ? _value.localData
          : localData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      remoteData: null == remoteData
          ? _value.remoteData
          : remoteData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      localModified: null == localModified
          ? _value.localModified
          : localModified // ignore: cast_nullable_to_non_nullable
              as DateTime,
      remoteModified: null == remoteModified
          ? _value.remoteModified
          : remoteModified // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ConflictType,
      resolution: null == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as ConflictResolution,
      resolutionNote: freezed == resolutionNote
          ? _value.resolutionNote
          : resolutionNote // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of SyncConflict
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConflictTypeCopyWith<$Res> get type {
    return $ConflictTypeCopyWith<$Res>(_value.type, (value) {
      return _then(_value.copyWith(type: value) as $Val);
    });
  }

  /// Create a copy of SyncConflict
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConflictResolutionCopyWith<$Res> get resolution {
    return $ConflictResolutionCopyWith<$Res>(_value.resolution, (value) {
      return _then(_value.copyWith(resolution: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SyncConflictImplCopyWith<$Res>
    implements $SyncConflictCopyWith<$Res> {
  factory _$$SyncConflictImplCopyWith(
          _$SyncConflictImpl value, $Res Function(_$SyncConflictImpl) then) =
      __$$SyncConflictImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String entityType,
      Map<String, dynamic> localData,
      Map<String, dynamic> remoteData,
      DateTime localModified,
      DateTime remoteModified,
      ConflictType type,
      ConflictResolution resolution,
      String? resolutionNote});

  @override
  $ConflictTypeCopyWith<$Res> get type;
  @override
  $ConflictResolutionCopyWith<$Res> get resolution;
}

/// @nodoc
class __$$SyncConflictImplCopyWithImpl<$Res>
    extends _$SyncConflictCopyWithImpl<$Res, _$SyncConflictImpl>
    implements _$$SyncConflictImplCopyWith<$Res> {
  __$$SyncConflictImplCopyWithImpl(
      _$SyncConflictImpl _value, $Res Function(_$SyncConflictImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncConflict
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? entityType = null,
    Object? localData = null,
    Object? remoteData = null,
    Object? localModified = null,
    Object? remoteModified = null,
    Object? type = null,
    Object? resolution = null,
    Object? resolutionNote = freezed,
  }) {
    return _then(_$SyncConflictImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      entityType: null == entityType
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      localData: null == localData
          ? _value._localData
          : localData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      remoteData: null == remoteData
          ? _value._remoteData
          : remoteData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      localModified: null == localModified
          ? _value.localModified
          : localModified // ignore: cast_nullable_to_non_nullable
              as DateTime,
      remoteModified: null == remoteModified
          ? _value.remoteModified
          : remoteModified // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ConflictType,
      resolution: null == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as ConflictResolution,
      resolutionNote: freezed == resolutionNote
          ? _value.resolutionNote
          : resolutionNote // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncConflictImpl implements _SyncConflict {
  const _$SyncConflictImpl(
      {required this.id,
      required this.entityType,
      required final Map<String, dynamic> localData,
      required final Map<String, dynamic> remoteData,
      required this.localModified,
      required this.remoteModified,
      required this.type,
      required this.resolution,
      this.resolutionNote})
      : _localData = localData,
        _remoteData = remoteData;

  factory _$SyncConflictImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncConflictImplFromJson(json);

  @override
  final String id;
  @override
  final String entityType;
  final Map<String, dynamic> _localData;
  @override
  Map<String, dynamic> get localData {
    if (_localData is EqualUnmodifiableMapView) return _localData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_localData);
  }

  final Map<String, dynamic> _remoteData;
  @override
  Map<String, dynamic> get remoteData {
    if (_remoteData is EqualUnmodifiableMapView) return _remoteData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_remoteData);
  }

  @override
  final DateTime localModified;
  @override
  final DateTime remoteModified;
  @override
  final ConflictType type;
  @override
  final ConflictResolution resolution;
  @override
  final String? resolutionNote;

  @override
  String toString() {
    return 'SyncConflict(id: $id, entityType: $entityType, localData: $localData, remoteData: $remoteData, localModified: $localModified, remoteModified: $remoteModified, type: $type, resolution: $resolution, resolutionNote: $resolutionNote)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncConflictImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.entityType, entityType) ||
                other.entityType == entityType) &&
            const DeepCollectionEquality()
                .equals(other._localData, _localData) &&
            const DeepCollectionEquality()
                .equals(other._remoteData, _remoteData) &&
            (identical(other.localModified, localModified) ||
                other.localModified == localModified) &&
            (identical(other.remoteModified, remoteModified) ||
                other.remoteModified == remoteModified) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution) &&
            (identical(other.resolutionNote, resolutionNote) ||
                other.resolutionNote == resolutionNote));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      entityType,
      const DeepCollectionEquality().hash(_localData),
      const DeepCollectionEquality().hash(_remoteData),
      localModified,
      remoteModified,
      type,
      resolution,
      resolutionNote);

  /// Create a copy of SyncConflict
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncConflictImplCopyWith<_$SyncConflictImpl> get copyWith =>
      __$$SyncConflictImplCopyWithImpl<_$SyncConflictImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncConflictImplToJson(
      this,
    );
  }
}

abstract class _SyncConflict implements SyncConflict {
  const factory _SyncConflict(
      {required final String id,
      required final String entityType,
      required final Map<String, dynamic> localData,
      required final Map<String, dynamic> remoteData,
      required final DateTime localModified,
      required final DateTime remoteModified,
      required final ConflictType type,
      required final ConflictResolution resolution,
      final String? resolutionNote}) = _$SyncConflictImpl;

  factory _SyncConflict.fromJson(Map<String, dynamic> json) =
      _$SyncConflictImpl.fromJson;

  @override
  String get id;
  @override
  String get entityType;
  @override
  Map<String, dynamic> get localData;
  @override
  Map<String, dynamic> get remoteData;
  @override
  DateTime get localModified;
  @override
  DateTime get remoteModified;
  @override
  ConflictType get type;
  @override
  ConflictResolution get resolution;
  @override
  String? get resolutionNote;

  /// Create a copy of SyncConflict
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncConflictImplCopyWith<_$SyncConflictImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConflictType _$ConflictTypeFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'dataMismatch':
      return DataMismatchConflict.fromJson(json);
    case 'timestampConflict':
      return TimestampConflict.fromJson(json);
    case 'deletionConflict':
      return DeletionConflict.fromJson(json);
    case 'creationConflict':
      return CreationConflict.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'ConflictType',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ConflictType {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() dataMismatch,
    required TResult Function() timestampConflict,
    required TResult Function() deletionConflict,
    required TResult Function() creationConflict,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? dataMismatch,
    TResult? Function()? timestampConflict,
    TResult? Function()? deletionConflict,
    TResult? Function()? creationConflict,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? dataMismatch,
    TResult Function()? timestampConflict,
    TResult Function()? deletionConflict,
    TResult Function()? creationConflict,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataMismatchConflict value) dataMismatch,
    required TResult Function(TimestampConflict value) timestampConflict,
    required TResult Function(DeletionConflict value) deletionConflict,
    required TResult Function(CreationConflict value) creationConflict,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataMismatchConflict value)? dataMismatch,
    TResult? Function(TimestampConflict value)? timestampConflict,
    TResult? Function(DeletionConflict value)? deletionConflict,
    TResult? Function(CreationConflict value)? creationConflict,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataMismatchConflict value)? dataMismatch,
    TResult Function(TimestampConflict value)? timestampConflict,
    TResult Function(DeletionConflict value)? deletionConflict,
    TResult Function(CreationConflict value)? creationConflict,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this ConflictType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConflictTypeCopyWith<$Res> {
  factory $ConflictTypeCopyWith(
          ConflictType value, $Res Function(ConflictType) then) =
      _$ConflictTypeCopyWithImpl<$Res, ConflictType>;
}

/// @nodoc
class _$ConflictTypeCopyWithImpl<$Res, $Val extends ConflictType>
    implements $ConflictTypeCopyWith<$Res> {
  _$ConflictTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConflictType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$DataMismatchConflictImplCopyWith<$Res> {
  factory _$$DataMismatchConflictImplCopyWith(_$DataMismatchConflictImpl value,
          $Res Function(_$DataMismatchConflictImpl) then) =
      __$$DataMismatchConflictImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DataMismatchConflictImplCopyWithImpl<$Res>
    extends _$ConflictTypeCopyWithImpl<$Res, _$DataMismatchConflictImpl>
    implements _$$DataMismatchConflictImplCopyWith<$Res> {
  __$$DataMismatchConflictImplCopyWithImpl(_$DataMismatchConflictImpl _value,
      $Res Function(_$DataMismatchConflictImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConflictType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$DataMismatchConflictImpl implements DataMismatchConflict {
  const _$DataMismatchConflictImpl({final String? $type})
      : $type = $type ?? 'dataMismatch';

  factory _$DataMismatchConflictImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataMismatchConflictImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ConflictType.dataMismatch()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataMismatchConflictImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() dataMismatch,
    required TResult Function() timestampConflict,
    required TResult Function() deletionConflict,
    required TResult Function() creationConflict,
  }) {
    return dataMismatch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? dataMismatch,
    TResult? Function()? timestampConflict,
    TResult? Function()? deletionConflict,
    TResult? Function()? creationConflict,
  }) {
    return dataMismatch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? dataMismatch,
    TResult Function()? timestampConflict,
    TResult Function()? deletionConflict,
    TResult Function()? creationConflict,
    required TResult orElse(),
  }) {
    if (dataMismatch != null) {
      return dataMismatch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataMismatchConflict value) dataMismatch,
    required TResult Function(TimestampConflict value) timestampConflict,
    required TResult Function(DeletionConflict value) deletionConflict,
    required TResult Function(CreationConflict value) creationConflict,
  }) {
    return dataMismatch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataMismatchConflict value)? dataMismatch,
    TResult? Function(TimestampConflict value)? timestampConflict,
    TResult? Function(DeletionConflict value)? deletionConflict,
    TResult? Function(CreationConflict value)? creationConflict,
  }) {
    return dataMismatch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataMismatchConflict value)? dataMismatch,
    TResult Function(TimestampConflict value)? timestampConflict,
    TResult Function(DeletionConflict value)? deletionConflict,
    TResult Function(CreationConflict value)? creationConflict,
    required TResult orElse(),
  }) {
    if (dataMismatch != null) {
      return dataMismatch(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DataMismatchConflictImplToJson(
      this,
    );
  }
}

abstract class DataMismatchConflict implements ConflictType {
  const factory DataMismatchConflict() = _$DataMismatchConflictImpl;

  factory DataMismatchConflict.fromJson(Map<String, dynamic> json) =
      _$DataMismatchConflictImpl.fromJson;
}

/// @nodoc
abstract class _$$TimestampConflictImplCopyWith<$Res> {
  factory _$$TimestampConflictImplCopyWith(_$TimestampConflictImpl value,
          $Res Function(_$TimestampConflictImpl) then) =
      __$$TimestampConflictImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TimestampConflictImplCopyWithImpl<$Res>
    extends _$ConflictTypeCopyWithImpl<$Res, _$TimestampConflictImpl>
    implements _$$TimestampConflictImplCopyWith<$Res> {
  __$$TimestampConflictImplCopyWithImpl(_$TimestampConflictImpl _value,
      $Res Function(_$TimestampConflictImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConflictType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$TimestampConflictImpl implements TimestampConflict {
  const _$TimestampConflictImpl({final String? $type})
      : $type = $type ?? 'timestampConflict';

  factory _$TimestampConflictImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimestampConflictImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ConflictType.timestampConflict()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TimestampConflictImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() dataMismatch,
    required TResult Function() timestampConflict,
    required TResult Function() deletionConflict,
    required TResult Function() creationConflict,
  }) {
    return timestampConflict();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? dataMismatch,
    TResult? Function()? timestampConflict,
    TResult? Function()? deletionConflict,
    TResult? Function()? creationConflict,
  }) {
    return timestampConflict?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? dataMismatch,
    TResult Function()? timestampConflict,
    TResult Function()? deletionConflict,
    TResult Function()? creationConflict,
    required TResult orElse(),
  }) {
    if (timestampConflict != null) {
      return timestampConflict();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataMismatchConflict value) dataMismatch,
    required TResult Function(TimestampConflict value) timestampConflict,
    required TResult Function(DeletionConflict value) deletionConflict,
    required TResult Function(CreationConflict value) creationConflict,
  }) {
    return timestampConflict(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataMismatchConflict value)? dataMismatch,
    TResult? Function(TimestampConflict value)? timestampConflict,
    TResult? Function(DeletionConflict value)? deletionConflict,
    TResult? Function(CreationConflict value)? creationConflict,
  }) {
    return timestampConflict?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataMismatchConflict value)? dataMismatch,
    TResult Function(TimestampConflict value)? timestampConflict,
    TResult Function(DeletionConflict value)? deletionConflict,
    TResult Function(CreationConflict value)? creationConflict,
    required TResult orElse(),
  }) {
    if (timestampConflict != null) {
      return timestampConflict(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TimestampConflictImplToJson(
      this,
    );
  }
}

abstract class TimestampConflict implements ConflictType {
  const factory TimestampConflict() = _$TimestampConflictImpl;

  factory TimestampConflict.fromJson(Map<String, dynamic> json) =
      _$TimestampConflictImpl.fromJson;
}

/// @nodoc
abstract class _$$DeletionConflictImplCopyWith<$Res> {
  factory _$$DeletionConflictImplCopyWith(_$DeletionConflictImpl value,
          $Res Function(_$DeletionConflictImpl) then) =
      __$$DeletionConflictImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DeletionConflictImplCopyWithImpl<$Res>
    extends _$ConflictTypeCopyWithImpl<$Res, _$DeletionConflictImpl>
    implements _$$DeletionConflictImplCopyWith<$Res> {
  __$$DeletionConflictImplCopyWithImpl(_$DeletionConflictImpl _value,
      $Res Function(_$DeletionConflictImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConflictType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$DeletionConflictImpl implements DeletionConflict {
  const _$DeletionConflictImpl({final String? $type})
      : $type = $type ?? 'deletionConflict';

  factory _$DeletionConflictImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeletionConflictImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ConflictType.deletionConflict()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DeletionConflictImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() dataMismatch,
    required TResult Function() timestampConflict,
    required TResult Function() deletionConflict,
    required TResult Function() creationConflict,
  }) {
    return deletionConflict();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? dataMismatch,
    TResult? Function()? timestampConflict,
    TResult? Function()? deletionConflict,
    TResult? Function()? creationConflict,
  }) {
    return deletionConflict?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? dataMismatch,
    TResult Function()? timestampConflict,
    TResult Function()? deletionConflict,
    TResult Function()? creationConflict,
    required TResult orElse(),
  }) {
    if (deletionConflict != null) {
      return deletionConflict();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataMismatchConflict value) dataMismatch,
    required TResult Function(TimestampConflict value) timestampConflict,
    required TResult Function(DeletionConflict value) deletionConflict,
    required TResult Function(CreationConflict value) creationConflict,
  }) {
    return deletionConflict(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataMismatchConflict value)? dataMismatch,
    TResult? Function(TimestampConflict value)? timestampConflict,
    TResult? Function(DeletionConflict value)? deletionConflict,
    TResult? Function(CreationConflict value)? creationConflict,
  }) {
    return deletionConflict?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataMismatchConflict value)? dataMismatch,
    TResult Function(TimestampConflict value)? timestampConflict,
    TResult Function(DeletionConflict value)? deletionConflict,
    TResult Function(CreationConflict value)? creationConflict,
    required TResult orElse(),
  }) {
    if (deletionConflict != null) {
      return deletionConflict(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DeletionConflictImplToJson(
      this,
    );
  }
}

abstract class DeletionConflict implements ConflictType {
  const factory DeletionConflict() = _$DeletionConflictImpl;

  factory DeletionConflict.fromJson(Map<String, dynamic> json) =
      _$DeletionConflictImpl.fromJson;
}

/// @nodoc
abstract class _$$CreationConflictImplCopyWith<$Res> {
  factory _$$CreationConflictImplCopyWith(_$CreationConflictImpl value,
          $Res Function(_$CreationConflictImpl) then) =
      __$$CreationConflictImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreationConflictImplCopyWithImpl<$Res>
    extends _$ConflictTypeCopyWithImpl<$Res, _$CreationConflictImpl>
    implements _$$CreationConflictImplCopyWith<$Res> {
  __$$CreationConflictImplCopyWithImpl(_$CreationConflictImpl _value,
      $Res Function(_$CreationConflictImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConflictType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$CreationConflictImpl implements CreationConflict {
  const _$CreationConflictImpl({final String? $type})
      : $type = $type ?? 'creationConflict';

  factory _$CreationConflictImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreationConflictImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ConflictType.creationConflict()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CreationConflictImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() dataMismatch,
    required TResult Function() timestampConflict,
    required TResult Function() deletionConflict,
    required TResult Function() creationConflict,
  }) {
    return creationConflict();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? dataMismatch,
    TResult? Function()? timestampConflict,
    TResult? Function()? deletionConflict,
    TResult? Function()? creationConflict,
  }) {
    return creationConflict?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? dataMismatch,
    TResult Function()? timestampConflict,
    TResult Function()? deletionConflict,
    TResult Function()? creationConflict,
    required TResult orElse(),
  }) {
    if (creationConflict != null) {
      return creationConflict();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataMismatchConflict value) dataMismatch,
    required TResult Function(TimestampConflict value) timestampConflict,
    required TResult Function(DeletionConflict value) deletionConflict,
    required TResult Function(CreationConflict value) creationConflict,
  }) {
    return creationConflict(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataMismatchConflict value)? dataMismatch,
    TResult? Function(TimestampConflict value)? timestampConflict,
    TResult? Function(DeletionConflict value)? deletionConflict,
    TResult? Function(CreationConflict value)? creationConflict,
  }) {
    return creationConflict?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataMismatchConflict value)? dataMismatch,
    TResult Function(TimestampConflict value)? timestampConflict,
    TResult Function(DeletionConflict value)? deletionConflict,
    TResult Function(CreationConflict value)? creationConflict,
    required TResult orElse(),
  }) {
    if (creationConflict != null) {
      return creationConflict(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CreationConflictImplToJson(
      this,
    );
  }
}

abstract class CreationConflict implements ConflictType {
  const factory CreationConflict() = _$CreationConflictImpl;

  factory CreationConflict.fromJson(Map<String, dynamic> json) =
      _$CreationConflictImpl.fromJson;
}

ConflictResolution _$ConflictResolutionFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'useLocal':
      return UseLocalResolution.fromJson(json);
    case 'useRemote':
      return UseRemoteResolution.fromJson(json);
    case 'merge':
      return MergeResolution.fromJson(json);
    case 'manual':
      return ManualResolution.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'ConflictResolution',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ConflictResolution {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() useLocal,
    required TResult Function() useRemote,
    required TResult Function() merge,
    required TResult Function() manual,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? useLocal,
    TResult? Function()? useRemote,
    TResult? Function()? merge,
    TResult? Function()? manual,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? useLocal,
    TResult Function()? useRemote,
    TResult Function()? merge,
    TResult Function()? manual,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UseLocalResolution value) useLocal,
    required TResult Function(UseRemoteResolution value) useRemote,
    required TResult Function(MergeResolution value) merge,
    required TResult Function(ManualResolution value) manual,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UseLocalResolution value)? useLocal,
    TResult? Function(UseRemoteResolution value)? useRemote,
    TResult? Function(MergeResolution value)? merge,
    TResult? Function(ManualResolution value)? manual,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UseLocalResolution value)? useLocal,
    TResult Function(UseRemoteResolution value)? useRemote,
    TResult Function(MergeResolution value)? merge,
    TResult Function(ManualResolution value)? manual,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this ConflictResolution to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConflictResolutionCopyWith<$Res> {
  factory $ConflictResolutionCopyWith(
          ConflictResolution value, $Res Function(ConflictResolution) then) =
      _$ConflictResolutionCopyWithImpl<$Res, ConflictResolution>;
}

/// @nodoc
class _$ConflictResolutionCopyWithImpl<$Res, $Val extends ConflictResolution>
    implements $ConflictResolutionCopyWith<$Res> {
  _$ConflictResolutionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConflictResolution
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$UseLocalResolutionImplCopyWith<$Res> {
  factory _$$UseLocalResolutionImplCopyWith(_$UseLocalResolutionImpl value,
          $Res Function(_$UseLocalResolutionImpl) then) =
      __$$UseLocalResolutionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UseLocalResolutionImplCopyWithImpl<$Res>
    extends _$ConflictResolutionCopyWithImpl<$Res, _$UseLocalResolutionImpl>
    implements _$$UseLocalResolutionImplCopyWith<$Res> {
  __$$UseLocalResolutionImplCopyWithImpl(_$UseLocalResolutionImpl _value,
      $Res Function(_$UseLocalResolutionImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConflictResolution
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$UseLocalResolutionImpl implements UseLocalResolution {
  const _$UseLocalResolutionImpl({final String? $type})
      : $type = $type ?? 'useLocal';

  factory _$UseLocalResolutionImpl.fromJson(Map<String, dynamic> json) =>
      _$$UseLocalResolutionImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ConflictResolution.useLocal()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UseLocalResolutionImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() useLocal,
    required TResult Function() useRemote,
    required TResult Function() merge,
    required TResult Function() manual,
  }) {
    return useLocal();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? useLocal,
    TResult? Function()? useRemote,
    TResult? Function()? merge,
    TResult? Function()? manual,
  }) {
    return useLocal?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? useLocal,
    TResult Function()? useRemote,
    TResult Function()? merge,
    TResult Function()? manual,
    required TResult orElse(),
  }) {
    if (useLocal != null) {
      return useLocal();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UseLocalResolution value) useLocal,
    required TResult Function(UseRemoteResolution value) useRemote,
    required TResult Function(MergeResolution value) merge,
    required TResult Function(ManualResolution value) manual,
  }) {
    return useLocal(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UseLocalResolution value)? useLocal,
    TResult? Function(UseRemoteResolution value)? useRemote,
    TResult? Function(MergeResolution value)? merge,
    TResult? Function(ManualResolution value)? manual,
  }) {
    return useLocal?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UseLocalResolution value)? useLocal,
    TResult Function(UseRemoteResolution value)? useRemote,
    TResult Function(MergeResolution value)? merge,
    TResult Function(ManualResolution value)? manual,
    required TResult orElse(),
  }) {
    if (useLocal != null) {
      return useLocal(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UseLocalResolutionImplToJson(
      this,
    );
  }
}

abstract class UseLocalResolution implements ConflictResolution {
  const factory UseLocalResolution() = _$UseLocalResolutionImpl;

  factory UseLocalResolution.fromJson(Map<String, dynamic> json) =
      _$UseLocalResolutionImpl.fromJson;
}

/// @nodoc
abstract class _$$UseRemoteResolutionImplCopyWith<$Res> {
  factory _$$UseRemoteResolutionImplCopyWith(_$UseRemoteResolutionImpl value,
          $Res Function(_$UseRemoteResolutionImpl) then) =
      __$$UseRemoteResolutionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UseRemoteResolutionImplCopyWithImpl<$Res>
    extends _$ConflictResolutionCopyWithImpl<$Res, _$UseRemoteResolutionImpl>
    implements _$$UseRemoteResolutionImplCopyWith<$Res> {
  __$$UseRemoteResolutionImplCopyWithImpl(_$UseRemoteResolutionImpl _value,
      $Res Function(_$UseRemoteResolutionImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConflictResolution
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$UseRemoteResolutionImpl implements UseRemoteResolution {
  const _$UseRemoteResolutionImpl({final String? $type})
      : $type = $type ?? 'useRemote';

  factory _$UseRemoteResolutionImpl.fromJson(Map<String, dynamic> json) =>
      _$$UseRemoteResolutionImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ConflictResolution.useRemote()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UseRemoteResolutionImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() useLocal,
    required TResult Function() useRemote,
    required TResult Function() merge,
    required TResult Function() manual,
  }) {
    return useRemote();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? useLocal,
    TResult? Function()? useRemote,
    TResult? Function()? merge,
    TResult? Function()? manual,
  }) {
    return useRemote?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? useLocal,
    TResult Function()? useRemote,
    TResult Function()? merge,
    TResult Function()? manual,
    required TResult orElse(),
  }) {
    if (useRemote != null) {
      return useRemote();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UseLocalResolution value) useLocal,
    required TResult Function(UseRemoteResolution value) useRemote,
    required TResult Function(MergeResolution value) merge,
    required TResult Function(ManualResolution value) manual,
  }) {
    return useRemote(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UseLocalResolution value)? useLocal,
    TResult? Function(UseRemoteResolution value)? useRemote,
    TResult? Function(MergeResolution value)? merge,
    TResult? Function(ManualResolution value)? manual,
  }) {
    return useRemote?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UseLocalResolution value)? useLocal,
    TResult Function(UseRemoteResolution value)? useRemote,
    TResult Function(MergeResolution value)? merge,
    TResult Function(ManualResolution value)? manual,
    required TResult orElse(),
  }) {
    if (useRemote != null) {
      return useRemote(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UseRemoteResolutionImplToJson(
      this,
    );
  }
}

abstract class UseRemoteResolution implements ConflictResolution {
  const factory UseRemoteResolution() = _$UseRemoteResolutionImpl;

  factory UseRemoteResolution.fromJson(Map<String, dynamic> json) =
      _$UseRemoteResolutionImpl.fromJson;
}

/// @nodoc
abstract class _$$MergeResolutionImplCopyWith<$Res> {
  factory _$$MergeResolutionImplCopyWith(_$MergeResolutionImpl value,
          $Res Function(_$MergeResolutionImpl) then) =
      __$$MergeResolutionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MergeResolutionImplCopyWithImpl<$Res>
    extends _$ConflictResolutionCopyWithImpl<$Res, _$MergeResolutionImpl>
    implements _$$MergeResolutionImplCopyWith<$Res> {
  __$$MergeResolutionImplCopyWithImpl(
      _$MergeResolutionImpl _value, $Res Function(_$MergeResolutionImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConflictResolution
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$MergeResolutionImpl implements MergeResolution {
  const _$MergeResolutionImpl({final String? $type}) : $type = $type ?? 'merge';

  factory _$MergeResolutionImpl.fromJson(Map<String, dynamic> json) =>
      _$$MergeResolutionImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ConflictResolution.merge()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MergeResolutionImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() useLocal,
    required TResult Function() useRemote,
    required TResult Function() merge,
    required TResult Function() manual,
  }) {
    return merge();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? useLocal,
    TResult? Function()? useRemote,
    TResult? Function()? merge,
    TResult? Function()? manual,
  }) {
    return merge?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? useLocal,
    TResult Function()? useRemote,
    TResult Function()? merge,
    TResult Function()? manual,
    required TResult orElse(),
  }) {
    if (merge != null) {
      return merge();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UseLocalResolution value) useLocal,
    required TResult Function(UseRemoteResolution value) useRemote,
    required TResult Function(MergeResolution value) merge,
    required TResult Function(ManualResolution value) manual,
  }) {
    return merge(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UseLocalResolution value)? useLocal,
    TResult? Function(UseRemoteResolution value)? useRemote,
    TResult? Function(MergeResolution value)? merge,
    TResult? Function(ManualResolution value)? manual,
  }) {
    return merge?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UseLocalResolution value)? useLocal,
    TResult Function(UseRemoteResolution value)? useRemote,
    TResult Function(MergeResolution value)? merge,
    TResult Function(ManualResolution value)? manual,
    required TResult orElse(),
  }) {
    if (merge != null) {
      return merge(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MergeResolutionImplToJson(
      this,
    );
  }
}

abstract class MergeResolution implements ConflictResolution {
  const factory MergeResolution() = _$MergeResolutionImpl;

  factory MergeResolution.fromJson(Map<String, dynamic> json) =
      _$MergeResolutionImpl.fromJson;
}

/// @nodoc
abstract class _$$ManualResolutionImplCopyWith<$Res> {
  factory _$$ManualResolutionImplCopyWith(_$ManualResolutionImpl value,
          $Res Function(_$ManualResolutionImpl) then) =
      __$$ManualResolutionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ManualResolutionImplCopyWithImpl<$Res>
    extends _$ConflictResolutionCopyWithImpl<$Res, _$ManualResolutionImpl>
    implements _$$ManualResolutionImplCopyWith<$Res> {
  __$$ManualResolutionImplCopyWithImpl(_$ManualResolutionImpl _value,
      $Res Function(_$ManualResolutionImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConflictResolution
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$ManualResolutionImpl implements ManualResolution {
  const _$ManualResolutionImpl({final String? $type})
      : $type = $type ?? 'manual';

  factory _$ManualResolutionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ManualResolutionImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ConflictResolution.manual()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ManualResolutionImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() useLocal,
    required TResult Function() useRemote,
    required TResult Function() merge,
    required TResult Function() manual,
  }) {
    return manual();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? useLocal,
    TResult? Function()? useRemote,
    TResult? Function()? merge,
    TResult? Function()? manual,
  }) {
    return manual?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? useLocal,
    TResult Function()? useRemote,
    TResult Function()? merge,
    TResult Function()? manual,
    required TResult orElse(),
  }) {
    if (manual != null) {
      return manual();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UseLocalResolution value) useLocal,
    required TResult Function(UseRemoteResolution value) useRemote,
    required TResult Function(MergeResolution value) merge,
    required TResult Function(ManualResolution value) manual,
  }) {
    return manual(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UseLocalResolution value)? useLocal,
    TResult? Function(UseRemoteResolution value)? useRemote,
    TResult? Function(MergeResolution value)? merge,
    TResult? Function(ManualResolution value)? manual,
  }) {
    return manual?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UseLocalResolution value)? useLocal,
    TResult Function(UseRemoteResolution value)? useRemote,
    TResult Function(MergeResolution value)? merge,
    TResult Function(ManualResolution value)? manual,
    required TResult orElse(),
  }) {
    if (manual != null) {
      return manual(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ManualResolutionImplToJson(
      this,
    );
  }
}

abstract class ManualResolution implements ConflictResolution {
  const factory ManualResolution() = _$ManualResolutionImpl;

  factory ManualResolution.fromJson(Map<String, dynamic> json) =
      _$ManualResolutionImpl.fromJson;
}
