// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SyncResult _$SyncResultFromJson(Map<String, dynamic> json) {
  return _SyncResult.fromJson(json);
}

/// @nodoc
mixin _$SyncResult {
  bool get success => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  int get itemsSynced => throw _privateConstructorUsedError;
  int get itemsCreated => throw _privateConstructorUsedError;
  int get itemsUpdated => throw _privateConstructorUsedError;
  int get itemsDeleted => throw _privateConstructorUsedError;
  List<SyncConflict> get conflicts => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

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
      String? error,
      int itemsSynced,
      int itemsCreated,
      int itemsUpdated,
      int itemsDeleted,
      List<SyncConflict> conflicts,
      DateTime timestamp});
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
    Object? error = freezed,
    Object? itemsSynced = null,
    Object? itemsCreated = null,
    Object? itemsUpdated = null,
    Object? itemsDeleted = null,
    Object? conflicts = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
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
      String? error,
      int itemsSynced,
      int itemsCreated,
      int itemsUpdated,
      int itemsDeleted,
      List<SyncConflict> conflicts,
      DateTime timestamp});
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
    Object? error = freezed,
    Object? itemsSynced = null,
    Object? itemsCreated = null,
    Object? itemsUpdated = null,
    Object? itemsDeleted = null,
    Object? conflicts = null,
    Object? timestamp = null,
  }) {
    return _then(_$SyncResultImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncResultImpl implements _SyncResult {
  const _$SyncResultImpl(
      {required this.success,
      this.error,
      required this.itemsSynced,
      required this.itemsCreated,
      required this.itemsUpdated,
      required this.itemsDeleted,
      required final List<SyncConflict> conflicts,
      required this.timestamp})
      : _conflicts = conflicts;

  factory _$SyncResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncResultImplFromJson(json);

  @override
  final bool success;
  @override
  final String? error;
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
  String toString() {
    return 'SyncResult(success: $success, error: $error, itemsSynced: $itemsSynced, itemsCreated: $itemsCreated, itemsUpdated: $itemsUpdated, itemsDeleted: $itemsDeleted, conflicts: $conflicts, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncResultImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.error, error) || other.error == error) &&
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
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      success,
      error,
      itemsSynced,
      itemsCreated,
      itemsUpdated,
      itemsDeleted,
      const DeepCollectionEquality().hash(_conflicts),
      timestamp);

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
      final String? error,
      required final int itemsSynced,
      required final int itemsCreated,
      required final int itemsUpdated,
      required final int itemsDeleted,
      required final List<SyncConflict> conflicts,
      required final DateTime timestamp}) = _$SyncResultImpl;

  factory _SyncResult.fromJson(Map<String, dynamic> json) =
      _$SyncResultImpl.fromJson;

  @override
  bool get success;
  @override
  String? get error;
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

  /// Create a copy of SyncResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncResultImplCopyWith<_$SyncResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
