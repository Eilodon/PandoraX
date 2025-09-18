// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voice_command.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VoiceCommand _$VoiceCommandFromJson(Map<String, dynamic> json) {
  return _VoiceCommand.fromJson(json);
}

/// @nodoc
mixin _$VoiceCommand {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  VoiceCommandType get type => throw _privateConstructorUsedError;
  List<String> get keywords => throw _privateConstructorUsedError;
  bool get isEnabled => throw _privateConstructorUsedError;
  Map<String, dynamic>? get parameters => throw _privateConstructorUsedError;

  /// Serializes this VoiceCommand to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VoiceCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoiceCommandCopyWith<VoiceCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoiceCommandCopyWith<$Res> {
  factory $VoiceCommandCopyWith(
          VoiceCommand value, $Res Function(VoiceCommand) then) =
      _$VoiceCommandCopyWithImpl<$Res, VoiceCommand>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      VoiceCommandType type,
      List<String> keywords,
      bool isEnabled,
      Map<String, dynamic>? parameters});
}

/// @nodoc
class _$VoiceCommandCopyWithImpl<$Res, $Val extends VoiceCommand>
    implements $VoiceCommandCopyWith<$Res> {
  _$VoiceCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VoiceCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? keywords = null,
    Object? isEnabled = null,
    Object? parameters = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as VoiceCommandType,
      keywords: null == keywords
          ? _value.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      parameters: freezed == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoiceCommandImplCopyWith<$Res>
    implements $VoiceCommandCopyWith<$Res> {
  factory _$$VoiceCommandImplCopyWith(
          _$VoiceCommandImpl value, $Res Function(_$VoiceCommandImpl) then) =
      __$$VoiceCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      VoiceCommandType type,
      List<String> keywords,
      bool isEnabled,
      Map<String, dynamic>? parameters});
}

/// @nodoc
class __$$VoiceCommandImplCopyWithImpl<$Res>
    extends _$VoiceCommandCopyWithImpl<$Res, _$VoiceCommandImpl>
    implements _$$VoiceCommandImplCopyWith<$Res> {
  __$$VoiceCommandImplCopyWithImpl(
      _$VoiceCommandImpl _value, $Res Function(_$VoiceCommandImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoiceCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? keywords = null,
    Object? isEnabled = null,
    Object? parameters = freezed,
  }) {
    return _then(_$VoiceCommandImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as VoiceCommandType,
      keywords: null == keywords
          ? _value._keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      parameters: freezed == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoiceCommandImpl implements _VoiceCommand {
  const _$VoiceCommandImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.type,
      required final List<String> keywords,
      this.isEnabled = true,
      final Map<String, dynamic>? parameters})
      : _keywords = keywords,
        _parameters = parameters;

  factory _$VoiceCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoiceCommandImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final VoiceCommandType type;
  final List<String> _keywords;
  @override
  List<String> get keywords {
    if (_keywords is EqualUnmodifiableListView) return _keywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keywords);
  }

  @override
  @JsonKey()
  final bool isEnabled;
  final Map<String, dynamic>? _parameters;
  @override
  Map<String, dynamic>? get parameters {
    final value = _parameters;
    if (value == null) return null;
    if (_parameters is EqualUnmodifiableMapView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'VoiceCommand(id: $id, name: $name, description: $description, type: $type, keywords: $keywords, isEnabled: $isEnabled, parameters: $parameters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoiceCommandImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._keywords, _keywords) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      type,
      const DeepCollectionEquality().hash(_keywords),
      isEnabled,
      const DeepCollectionEquality().hash(_parameters));

  /// Create a copy of VoiceCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoiceCommandImplCopyWith<_$VoiceCommandImpl> get copyWith =>
      __$$VoiceCommandImplCopyWithImpl<_$VoiceCommandImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoiceCommandImplToJson(
      this,
    );
  }
}

abstract class _VoiceCommand implements VoiceCommand {
  const factory _VoiceCommand(
      {required final String id,
      required final String name,
      required final String description,
      required final VoiceCommandType type,
      required final List<String> keywords,
      final bool isEnabled,
      final Map<String, dynamic>? parameters}) = _$VoiceCommandImpl;

  factory _VoiceCommand.fromJson(Map<String, dynamic> json) =
      _$VoiceCommandImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  VoiceCommandType get type;
  @override
  List<String> get keywords;
  @override
  bool get isEnabled;
  @override
  Map<String, dynamic>? get parameters;

  /// Create a copy of VoiceCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoiceCommandImplCopyWith<_$VoiceCommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
