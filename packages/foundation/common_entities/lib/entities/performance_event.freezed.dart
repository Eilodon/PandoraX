// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'performance_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PerformanceEvent _$PerformanceEventFromJson(Map<String, dynamic> json) {
  return _PerformanceEvent.fromJson(json);
}

/// @nodoc
mixin _$PerformanceEvent {
  String get id => throw _privateConstructorUsedError;
  PerformanceEventType get type => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this PerformanceEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PerformanceEventCopyWith<PerformanceEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PerformanceEventCopyWith<$Res> {
  factory $PerformanceEventCopyWith(
          PerformanceEvent value, $Res Function(PerformanceEvent) then) =
      _$PerformanceEventCopyWithImpl<$Res, PerformanceEvent>;
  @useResult
  $Res call(
      {String id,
      PerformanceEventType type,
      String message,
      DateTime timestamp,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$PerformanceEventCopyWithImpl<$Res, $Val extends PerformanceEvent>
    implements $PerformanceEventCopyWith<$Res> {
  _$PerformanceEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? message = null,
    Object? timestamp = null,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PerformanceEventType,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PerformanceEventImplCopyWith<$Res>
    implements $PerformanceEventCopyWith<$Res> {
  factory _$$PerformanceEventImplCopyWith(_$PerformanceEventImpl value,
          $Res Function(_$PerformanceEventImpl) then) =
      __$$PerformanceEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      PerformanceEventType type,
      String message,
      DateTime timestamp,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$PerformanceEventImplCopyWithImpl<$Res>
    extends _$PerformanceEventCopyWithImpl<$Res, _$PerformanceEventImpl>
    implements _$$PerformanceEventImplCopyWith<$Res> {
  __$$PerformanceEventImplCopyWithImpl(_$PerformanceEventImpl _value,
      $Res Function(_$PerformanceEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? message = null,
    Object? timestamp = null,
    Object? metadata = freezed,
  }) {
    return _then(_$PerformanceEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PerformanceEventType,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PerformanceEventImpl implements _PerformanceEvent {
  const _$PerformanceEventImpl(
      {required this.id,
      required this.type,
      required this.message,
      required this.timestamp,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$PerformanceEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$PerformanceEventImplFromJson(json);

  @override
  final String id;
  @override
  final PerformanceEventType type;
  @override
  final String message;
  @override
  final DateTime timestamp;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'PerformanceEvent(id: $id, type: $type, message: $message, timestamp: $timestamp, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerformanceEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, message, timestamp,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PerformanceEventImplCopyWith<_$PerformanceEventImpl> get copyWith =>
      __$$PerformanceEventImplCopyWithImpl<_$PerformanceEventImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PerformanceEventImplToJson(
      this,
    );
  }
}

abstract class _PerformanceEvent implements PerformanceEvent {
  const factory _PerformanceEvent(
      {required final String id,
      required final PerformanceEventType type,
      required final String message,
      required final DateTime timestamp,
      final Map<String, dynamic>? metadata}) = _$PerformanceEventImpl;

  factory _PerformanceEvent.fromJson(Map<String, dynamic> json) =
      _$PerformanceEventImpl.fromJson;

  @override
  String get id;
  @override
  PerformanceEventType get type;
  @override
  String get message;
  @override
  DateTime get timestamp;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PerformanceEventImplCopyWith<_$PerformanceEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
