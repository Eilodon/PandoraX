// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AIResponse _$AIResponseFromJson(Map<String, dynamic> json) {
  return _AIResponse.fromJson(json);
}

/// @nodoc
mixin _$AIResponse {
  String get id => throw _privateConstructorUsedError;
  String get query => throw _privateConstructorUsedError;
  String get response => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this AIResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AIResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AIResponseCopyWith<AIResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AIResponseCopyWith<$Res> {
  factory $AIResponseCopyWith(
          AIResponse value, $Res Function(AIResponse) then) =
      _$AIResponseCopyWithImpl<$Res, AIResponse>;
  @useResult
  $Res call(
      {String id,
      String query,
      String response,
      DateTime timestamp,
      double confidence,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$AIResponseCopyWithImpl<$Res, $Val extends AIResponse>
    implements $AIResponseCopyWith<$Res> {
  _$AIResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AIResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? query = null,
    Object? response = null,
    Object? timestamp = null,
    Object? confidence = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AIResponseImplCopyWith<$Res>
    implements $AIResponseCopyWith<$Res> {
  factory _$$AIResponseImplCopyWith(
          _$AIResponseImpl value, $Res Function(_$AIResponseImpl) then) =
      __$$AIResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String query,
      String response,
      DateTime timestamp,
      double confidence,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$$AIResponseImplCopyWithImpl<$Res>
    extends _$AIResponseCopyWithImpl<$Res, _$AIResponseImpl>
    implements _$$AIResponseImplCopyWith<$Res> {
  __$$AIResponseImplCopyWithImpl(
      _$AIResponseImpl _value, $Res Function(_$AIResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AIResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? query = null,
    Object? response = null,
    Object? timestamp = null,
    Object? confidence = null,
    Object? metadata = null,
  }) {
    return _then(_$AIResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AIResponseImpl implements _AIResponse {
  const _$AIResponseImpl(
      {required this.id,
      required this.query,
      required this.response,
      required this.timestamp,
      this.confidence = 0.0,
      final Map<String, dynamic> metadata = const {}})
      : _metadata = metadata;

  factory _$AIResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AIResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String query;
  @override
  final String response;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final double confidence;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'AIResponse(id: $id, query: $query, response: $response, timestamp: $timestamp, confidence: $confidence, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AIResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, query, response, timestamp,
      confidence, const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of AIResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AIResponseImplCopyWith<_$AIResponseImpl> get copyWith =>
      __$$AIResponseImplCopyWithImpl<_$AIResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AIResponseImplToJson(
      this,
    );
  }
}

abstract class _AIResponse implements AIResponse {
  const factory _AIResponse(
      {required final String id,
      required final String query,
      required final String response,
      required final DateTime timestamp,
      final double confidence,
      final Map<String, dynamic> metadata}) = _$AIResponseImpl;

  factory _AIResponse.fromJson(Map<String, dynamic> json) =
      _$AIResponseImpl.fromJson;

  @override
  String get id;
  @override
  String get query;
  @override
  String get response;
  @override
  DateTime get timestamp;
  @override
  double get confidence;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of AIResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AIResponseImplCopyWith<_$AIResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
