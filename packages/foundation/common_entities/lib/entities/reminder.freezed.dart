// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Reminder _$ReminderFromJson(Map<String, dynamic> json) {
  return _Reminder.fromJson(json);
}

/// @nodoc
mixin _$Reminder {
  String get id => throw _privateConstructorUsedError;
  String get noteId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get scheduledTime => throw _privateConstructorUsedError;
  ReminderType get type => throw _privateConstructorUsedError;
  ReminderStatus get status => throw _privateConstructorUsedError;
  List<ReminderRepeat> get repeatDays => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String? get soundPath => throw _privateConstructorUsedError;
  int? get vibrationPattern => throw _privateConstructorUsedError;
  bool? get isSilent => throw _privateConstructorUsedError;
  String? get customMessage => throw _privateConstructorUsedError;

  /// Serializes this Reminder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Reminder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReminderCopyWith<Reminder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReminderCopyWith<$Res> {
  factory $ReminderCopyWith(Reminder value, $Res Function(Reminder) then) =
      _$ReminderCopyWithImpl<$Res, Reminder>;
  @useResult
  $Res call(
      {String id,
      String noteId,
      String title,
      String description,
      DateTime scheduledTime,
      ReminderType type,
      ReminderStatus status,
      List<ReminderRepeat> repeatDays,
      bool isActive,
      DateTime createdAt,
      DateTime updatedAt,
      String? soundPath,
      int? vibrationPattern,
      bool? isSilent,
      String? customMessage});

  $ReminderTypeCopyWith<$Res> get type;
  $ReminderStatusCopyWith<$Res> get status;
}

/// @nodoc
class _$ReminderCopyWithImpl<$Res, $Val extends Reminder>
    implements $ReminderCopyWith<$Res> {
  _$ReminderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Reminder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? noteId = null,
    Object? title = null,
    Object? description = null,
    Object? scheduledTime = null,
    Object? type = null,
    Object? status = null,
    Object? repeatDays = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? soundPath = freezed,
    Object? vibrationPattern = freezed,
    Object? isSilent = freezed,
    Object? customMessage = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      noteId: null == noteId
          ? _value.noteId
          : noteId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledTime: null == scheduledTime
          ? _value.scheduledTime
          : scheduledTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ReminderType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReminderStatus,
      repeatDays: null == repeatDays
          ? _value.repeatDays
          : repeatDays // ignore: cast_nullable_to_non_nullable
              as List<ReminderRepeat>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      soundPath: freezed == soundPath
          ? _value.soundPath
          : soundPath // ignore: cast_nullable_to_non_nullable
              as String?,
      vibrationPattern: freezed == vibrationPattern
          ? _value.vibrationPattern
          : vibrationPattern // ignore: cast_nullable_to_non_nullable
              as int?,
      isSilent: freezed == isSilent
          ? _value.isSilent
          : isSilent // ignore: cast_nullable_to_non_nullable
              as bool?,
      customMessage: freezed == customMessage
          ? _value.customMessage
          : customMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of Reminder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReminderTypeCopyWith<$Res> get type {
    return $ReminderTypeCopyWith<$Res>(_value.type, (value) {
      return _then(_value.copyWith(type: value) as $Val);
    });
  }

  /// Create a copy of Reminder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReminderStatusCopyWith<$Res> get status {
    return $ReminderStatusCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReminderImplCopyWith<$Res>
    implements $ReminderCopyWith<$Res> {
  factory _$$ReminderImplCopyWith(
          _$ReminderImpl value, $Res Function(_$ReminderImpl) then) =
      __$$ReminderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String noteId,
      String title,
      String description,
      DateTime scheduledTime,
      ReminderType type,
      ReminderStatus status,
      List<ReminderRepeat> repeatDays,
      bool isActive,
      DateTime createdAt,
      DateTime updatedAt,
      String? soundPath,
      int? vibrationPattern,
      bool? isSilent,
      String? customMessage});

  @override
  $ReminderTypeCopyWith<$Res> get type;
  @override
  $ReminderStatusCopyWith<$Res> get status;
}

/// @nodoc
class __$$ReminderImplCopyWithImpl<$Res>
    extends _$ReminderCopyWithImpl<$Res, _$ReminderImpl>
    implements _$$ReminderImplCopyWith<$Res> {
  __$$ReminderImplCopyWithImpl(
      _$ReminderImpl _value, $Res Function(_$ReminderImpl) _then)
      : super(_value, _then);

  /// Create a copy of Reminder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? noteId = null,
    Object? title = null,
    Object? description = null,
    Object? scheduledTime = null,
    Object? type = null,
    Object? status = null,
    Object? repeatDays = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? soundPath = freezed,
    Object? vibrationPattern = freezed,
    Object? isSilent = freezed,
    Object? customMessage = freezed,
  }) {
    return _then(_$ReminderImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      noteId: null == noteId
          ? _value.noteId
          : noteId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledTime: null == scheduledTime
          ? _value.scheduledTime
          : scheduledTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ReminderType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReminderStatus,
      repeatDays: null == repeatDays
          ? _value._repeatDays
          : repeatDays // ignore: cast_nullable_to_non_nullable
              as List<ReminderRepeat>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      soundPath: freezed == soundPath
          ? _value.soundPath
          : soundPath // ignore: cast_nullable_to_non_nullable
              as String?,
      vibrationPattern: freezed == vibrationPattern
          ? _value.vibrationPattern
          : vibrationPattern // ignore: cast_nullable_to_non_nullable
              as int?,
      isSilent: freezed == isSilent
          ? _value.isSilent
          : isSilent // ignore: cast_nullable_to_non_nullable
              as bool?,
      customMessage: freezed == customMessage
          ? _value.customMessage
          : customMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReminderImpl implements _Reminder {
  const _$ReminderImpl(
      {required this.id,
      required this.noteId,
      required this.title,
      required this.description,
      required this.scheduledTime,
      required this.type,
      required this.status,
      required final List<ReminderRepeat> repeatDays,
      required this.isActive,
      required this.createdAt,
      required this.updatedAt,
      this.soundPath,
      this.vibrationPattern,
      this.isSilent,
      this.customMessage})
      : _repeatDays = repeatDays;

  factory _$ReminderImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReminderImplFromJson(json);

  @override
  final String id;
  @override
  final String noteId;
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime scheduledTime;
  @override
  final ReminderType type;
  @override
  final ReminderStatus status;
  final List<ReminderRepeat> _repeatDays;
  @override
  List<ReminderRepeat> get repeatDays {
    if (_repeatDays is EqualUnmodifiableListView) return _repeatDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_repeatDays);
  }

  @override
  final bool isActive;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String? soundPath;
  @override
  final int? vibrationPattern;
  @override
  final bool? isSilent;
  @override
  final String? customMessage;

  @override
  String toString() {
    return 'Reminder(id: $id, noteId: $noteId, title: $title, description: $description, scheduledTime: $scheduledTime, type: $type, status: $status, repeatDays: $repeatDays, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, soundPath: $soundPath, vibrationPattern: $vibrationPattern, isSilent: $isSilent, customMessage: $customMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReminderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.noteId, noteId) || other.noteId == noteId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.scheduledTime, scheduledTime) ||
                other.scheduledTime == scheduledTime) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._repeatDays, _repeatDays) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.soundPath, soundPath) ||
                other.soundPath == soundPath) &&
            (identical(other.vibrationPattern, vibrationPattern) ||
                other.vibrationPattern == vibrationPattern) &&
            (identical(other.isSilent, isSilent) ||
                other.isSilent == isSilent) &&
            (identical(other.customMessage, customMessage) ||
                other.customMessage == customMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      noteId,
      title,
      description,
      scheduledTime,
      type,
      status,
      const DeepCollectionEquality().hash(_repeatDays),
      isActive,
      createdAt,
      updatedAt,
      soundPath,
      vibrationPattern,
      isSilent,
      customMessage);

  /// Create a copy of Reminder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReminderImplCopyWith<_$ReminderImpl> get copyWith =>
      __$$ReminderImplCopyWithImpl<_$ReminderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReminderImplToJson(
      this,
    );
  }
}

abstract class _Reminder implements Reminder {
  const factory _Reminder(
      {required final String id,
      required final String noteId,
      required final String title,
      required final String description,
      required final DateTime scheduledTime,
      required final ReminderType type,
      required final ReminderStatus status,
      required final List<ReminderRepeat> repeatDays,
      required final bool isActive,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final String? soundPath,
      final int? vibrationPattern,
      final bool? isSilent,
      final String? customMessage}) = _$ReminderImpl;

  factory _Reminder.fromJson(Map<String, dynamic> json) =
      _$ReminderImpl.fromJson;

  @override
  String get id;
  @override
  String get noteId;
  @override
  String get title;
  @override
  String get description;
  @override
  DateTime get scheduledTime;
  @override
  ReminderType get type;
  @override
  ReminderStatus get status;
  @override
  List<ReminderRepeat> get repeatDays;
  @override
  bool get isActive;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  String? get soundPath;
  @override
  int? get vibrationPattern;
  @override
  bool? get isSilent;
  @override
  String? get customMessage;

  /// Create a copy of Reminder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReminderImplCopyWith<_$ReminderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReminderType _$ReminderTypeFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'alarm':
      return AlarmReminder.fromJson(json);
    case 'notification':
      return NotificationReminder.fromJson(json);
    case 'email':
      return EmailReminder.fromJson(json);
    case 'sms':
      return SmsReminder.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'ReminderType',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ReminderType {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() alarm,
    required TResult Function() notification,
    required TResult Function() email,
    required TResult Function() sms,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? alarm,
    TResult? Function()? notification,
    TResult? Function()? email,
    TResult? Function()? sms,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? alarm,
    TResult Function()? notification,
    TResult Function()? email,
    TResult Function()? sms,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AlarmReminder value) alarm,
    required TResult Function(NotificationReminder value) notification,
    required TResult Function(EmailReminder value) email,
    required TResult Function(SmsReminder value) sms,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AlarmReminder value)? alarm,
    TResult? Function(NotificationReminder value)? notification,
    TResult? Function(EmailReminder value)? email,
    TResult? Function(SmsReminder value)? sms,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AlarmReminder value)? alarm,
    TResult Function(NotificationReminder value)? notification,
    TResult Function(EmailReminder value)? email,
    TResult Function(SmsReminder value)? sms,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this ReminderType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReminderTypeCopyWith<$Res> {
  factory $ReminderTypeCopyWith(
          ReminderType value, $Res Function(ReminderType) then) =
      _$ReminderTypeCopyWithImpl<$Res, ReminderType>;
}

/// @nodoc
class _$ReminderTypeCopyWithImpl<$Res, $Val extends ReminderType>
    implements $ReminderTypeCopyWith<$Res> {
  _$ReminderTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReminderType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AlarmReminderImplCopyWith<$Res> {
  factory _$$AlarmReminderImplCopyWith(
          _$AlarmReminderImpl value, $Res Function(_$AlarmReminderImpl) then) =
      __$$AlarmReminderImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AlarmReminderImplCopyWithImpl<$Res>
    extends _$ReminderTypeCopyWithImpl<$Res, _$AlarmReminderImpl>
    implements _$$AlarmReminderImplCopyWith<$Res> {
  __$$AlarmReminderImplCopyWithImpl(
      _$AlarmReminderImpl _value, $Res Function(_$AlarmReminderImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$AlarmReminderImpl implements AlarmReminder {
  const _$AlarmReminderImpl({final String? $type}) : $type = $type ?? 'alarm';

  factory _$AlarmReminderImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlarmReminderImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ReminderType.alarm()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AlarmReminderImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() alarm,
    required TResult Function() notification,
    required TResult Function() email,
    required TResult Function() sms,
  }) {
    return alarm();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? alarm,
    TResult? Function()? notification,
    TResult? Function()? email,
    TResult? Function()? sms,
  }) {
    return alarm?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? alarm,
    TResult Function()? notification,
    TResult Function()? email,
    TResult Function()? sms,
    required TResult orElse(),
  }) {
    if (alarm != null) {
      return alarm();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AlarmReminder value) alarm,
    required TResult Function(NotificationReminder value) notification,
    required TResult Function(EmailReminder value) email,
    required TResult Function(SmsReminder value) sms,
  }) {
    return alarm(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AlarmReminder value)? alarm,
    TResult? Function(NotificationReminder value)? notification,
    TResult? Function(EmailReminder value)? email,
    TResult? Function(SmsReminder value)? sms,
  }) {
    return alarm?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AlarmReminder value)? alarm,
    TResult Function(NotificationReminder value)? notification,
    TResult Function(EmailReminder value)? email,
    TResult Function(SmsReminder value)? sms,
    required TResult orElse(),
  }) {
    if (alarm != null) {
      return alarm(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AlarmReminderImplToJson(
      this,
    );
  }
}

abstract class AlarmReminder implements ReminderType {
  const factory AlarmReminder() = _$AlarmReminderImpl;

  factory AlarmReminder.fromJson(Map<String, dynamic> json) =
      _$AlarmReminderImpl.fromJson;
}

/// @nodoc
abstract class _$$NotificationReminderImplCopyWith<$Res> {
  factory _$$NotificationReminderImplCopyWith(_$NotificationReminderImpl value,
          $Res Function(_$NotificationReminderImpl) then) =
      __$$NotificationReminderImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotificationReminderImplCopyWithImpl<$Res>
    extends _$ReminderTypeCopyWithImpl<$Res, _$NotificationReminderImpl>
    implements _$$NotificationReminderImplCopyWith<$Res> {
  __$$NotificationReminderImplCopyWithImpl(_$NotificationReminderImpl _value,
      $Res Function(_$NotificationReminderImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$NotificationReminderImpl implements NotificationReminder {
  const _$NotificationReminderImpl({final String? $type})
      : $type = $type ?? 'notification';

  factory _$NotificationReminderImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationReminderImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ReminderType.notification()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationReminderImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() alarm,
    required TResult Function() notification,
    required TResult Function() email,
    required TResult Function() sms,
  }) {
    return notification();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? alarm,
    TResult? Function()? notification,
    TResult? Function()? email,
    TResult? Function()? sms,
  }) {
    return notification?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? alarm,
    TResult Function()? notification,
    TResult Function()? email,
    TResult Function()? sms,
    required TResult orElse(),
  }) {
    if (notification != null) {
      return notification();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AlarmReminder value) alarm,
    required TResult Function(NotificationReminder value) notification,
    required TResult Function(EmailReminder value) email,
    required TResult Function(SmsReminder value) sms,
  }) {
    return notification(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AlarmReminder value)? alarm,
    TResult? Function(NotificationReminder value)? notification,
    TResult? Function(EmailReminder value)? email,
    TResult? Function(SmsReminder value)? sms,
  }) {
    return notification?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AlarmReminder value)? alarm,
    TResult Function(NotificationReminder value)? notification,
    TResult Function(EmailReminder value)? email,
    TResult Function(SmsReminder value)? sms,
    required TResult orElse(),
  }) {
    if (notification != null) {
      return notification(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationReminderImplToJson(
      this,
    );
  }
}

abstract class NotificationReminder implements ReminderType {
  const factory NotificationReminder() = _$NotificationReminderImpl;

  factory NotificationReminder.fromJson(Map<String, dynamic> json) =
      _$NotificationReminderImpl.fromJson;
}

/// @nodoc
abstract class _$$EmailReminderImplCopyWith<$Res> {
  factory _$$EmailReminderImplCopyWith(
          _$EmailReminderImpl value, $Res Function(_$EmailReminderImpl) then) =
      __$$EmailReminderImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EmailReminderImplCopyWithImpl<$Res>
    extends _$ReminderTypeCopyWithImpl<$Res, _$EmailReminderImpl>
    implements _$$EmailReminderImplCopyWith<$Res> {
  __$$EmailReminderImplCopyWithImpl(
      _$EmailReminderImpl _value, $Res Function(_$EmailReminderImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$EmailReminderImpl implements EmailReminder {
  const _$EmailReminderImpl({final String? $type}) : $type = $type ?? 'email';

  factory _$EmailReminderImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailReminderImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ReminderType.email()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EmailReminderImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() alarm,
    required TResult Function() notification,
    required TResult Function() email,
    required TResult Function() sms,
  }) {
    return email();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? alarm,
    TResult? Function()? notification,
    TResult? Function()? email,
    TResult? Function()? sms,
  }) {
    return email?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? alarm,
    TResult Function()? notification,
    TResult Function()? email,
    TResult Function()? sms,
    required TResult orElse(),
  }) {
    if (email != null) {
      return email();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AlarmReminder value) alarm,
    required TResult Function(NotificationReminder value) notification,
    required TResult Function(EmailReminder value) email,
    required TResult Function(SmsReminder value) sms,
  }) {
    return email(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AlarmReminder value)? alarm,
    TResult? Function(NotificationReminder value)? notification,
    TResult? Function(EmailReminder value)? email,
    TResult? Function(SmsReminder value)? sms,
  }) {
    return email?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AlarmReminder value)? alarm,
    TResult Function(NotificationReminder value)? notification,
    TResult Function(EmailReminder value)? email,
    TResult Function(SmsReminder value)? sms,
    required TResult orElse(),
  }) {
    if (email != null) {
      return email(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailReminderImplToJson(
      this,
    );
  }
}

abstract class EmailReminder implements ReminderType {
  const factory EmailReminder() = _$EmailReminderImpl;

  factory EmailReminder.fromJson(Map<String, dynamic> json) =
      _$EmailReminderImpl.fromJson;
}

/// @nodoc
abstract class _$$SmsReminderImplCopyWith<$Res> {
  factory _$$SmsReminderImplCopyWith(
          _$SmsReminderImpl value, $Res Function(_$SmsReminderImpl) then) =
      __$$SmsReminderImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SmsReminderImplCopyWithImpl<$Res>
    extends _$ReminderTypeCopyWithImpl<$Res, _$SmsReminderImpl>
    implements _$$SmsReminderImplCopyWith<$Res> {
  __$$SmsReminderImplCopyWithImpl(
      _$SmsReminderImpl _value, $Res Function(_$SmsReminderImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$SmsReminderImpl implements SmsReminder {
  const _$SmsReminderImpl({final String? $type}) : $type = $type ?? 'sms';

  factory _$SmsReminderImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmsReminderImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ReminderType.sms()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SmsReminderImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() alarm,
    required TResult Function() notification,
    required TResult Function() email,
    required TResult Function() sms,
  }) {
    return sms();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? alarm,
    TResult? Function()? notification,
    TResult? Function()? email,
    TResult? Function()? sms,
  }) {
    return sms?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? alarm,
    TResult Function()? notification,
    TResult Function()? email,
    TResult Function()? sms,
    required TResult orElse(),
  }) {
    if (sms != null) {
      return sms();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AlarmReminder value) alarm,
    required TResult Function(NotificationReminder value) notification,
    required TResult Function(EmailReminder value) email,
    required TResult Function(SmsReminder value) sms,
  }) {
    return sms(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AlarmReminder value)? alarm,
    TResult? Function(NotificationReminder value)? notification,
    TResult? Function(EmailReminder value)? email,
    TResult? Function(SmsReminder value)? sms,
  }) {
    return sms?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AlarmReminder value)? alarm,
    TResult Function(NotificationReminder value)? notification,
    TResult Function(EmailReminder value)? email,
    TResult Function(SmsReminder value)? sms,
    required TResult orElse(),
  }) {
    if (sms != null) {
      return sms(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SmsReminderImplToJson(
      this,
    );
  }
}

abstract class SmsReminder implements ReminderType {
  const factory SmsReminder() = _$SmsReminderImpl;

  factory SmsReminder.fromJson(Map<String, dynamic> json) =
      _$SmsReminderImpl.fromJson;
}

ReminderStatus _$ReminderStatusFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'pending':
      return PendingReminder.fromJson(json);
    case 'triggered':
      return TriggeredReminder.fromJson(json);
    case 'cancelled':
      return CancelledReminder.fromJson(json);
    case 'completed':
      return CompletedReminder.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'ReminderStatus',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ReminderStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pending,
    required TResult Function() triggered,
    required TResult Function() cancelled,
    required TResult Function() completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pending,
    TResult? Function()? triggered,
    TResult? Function()? cancelled,
    TResult? Function()? completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pending,
    TResult Function()? triggered,
    TResult Function()? cancelled,
    TResult Function()? completed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PendingReminder value) pending,
    required TResult Function(TriggeredReminder value) triggered,
    required TResult Function(CancelledReminder value) cancelled,
    required TResult Function(CompletedReminder value) completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PendingReminder value)? pending,
    TResult? Function(TriggeredReminder value)? triggered,
    TResult? Function(CancelledReminder value)? cancelled,
    TResult? Function(CompletedReminder value)? completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PendingReminder value)? pending,
    TResult Function(TriggeredReminder value)? triggered,
    TResult Function(CancelledReminder value)? cancelled,
    TResult Function(CompletedReminder value)? completed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this ReminderStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReminderStatusCopyWith<$Res> {
  factory $ReminderStatusCopyWith(
          ReminderStatus value, $Res Function(ReminderStatus) then) =
      _$ReminderStatusCopyWithImpl<$Res, ReminderStatus>;
}

/// @nodoc
class _$ReminderStatusCopyWithImpl<$Res, $Val extends ReminderStatus>
    implements $ReminderStatusCopyWith<$Res> {
  _$ReminderStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReminderStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PendingReminderImplCopyWith<$Res> {
  factory _$$PendingReminderImplCopyWith(_$PendingReminderImpl value,
          $Res Function(_$PendingReminderImpl) then) =
      __$$PendingReminderImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PendingReminderImplCopyWithImpl<$Res>
    extends _$ReminderStatusCopyWithImpl<$Res, _$PendingReminderImpl>
    implements _$$PendingReminderImplCopyWith<$Res> {
  __$$PendingReminderImplCopyWithImpl(
      _$PendingReminderImpl _value, $Res Function(_$PendingReminderImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$PendingReminderImpl implements PendingReminder {
  const _$PendingReminderImpl({final String? $type})
      : $type = $type ?? 'pending';

  factory _$PendingReminderImpl.fromJson(Map<String, dynamic> json) =>
      _$$PendingReminderImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ReminderStatus.pending()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PendingReminderImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pending,
    required TResult Function() triggered,
    required TResult Function() cancelled,
    required TResult Function() completed,
  }) {
    return pending();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pending,
    TResult? Function()? triggered,
    TResult? Function()? cancelled,
    TResult? Function()? completed,
  }) {
    return pending?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pending,
    TResult Function()? triggered,
    TResult Function()? cancelled,
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    if (pending != null) {
      return pending();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PendingReminder value) pending,
    required TResult Function(TriggeredReminder value) triggered,
    required TResult Function(CancelledReminder value) cancelled,
    required TResult Function(CompletedReminder value) completed,
  }) {
    return pending(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PendingReminder value)? pending,
    TResult? Function(TriggeredReminder value)? triggered,
    TResult? Function(CancelledReminder value)? cancelled,
    TResult? Function(CompletedReminder value)? completed,
  }) {
    return pending?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PendingReminder value)? pending,
    TResult Function(TriggeredReminder value)? triggered,
    TResult Function(CancelledReminder value)? cancelled,
    TResult Function(CompletedReminder value)? completed,
    required TResult orElse(),
  }) {
    if (pending != null) {
      return pending(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PendingReminderImplToJson(
      this,
    );
  }
}

abstract class PendingReminder implements ReminderStatus {
  const factory PendingReminder() = _$PendingReminderImpl;

  factory PendingReminder.fromJson(Map<String, dynamic> json) =
      _$PendingReminderImpl.fromJson;
}

/// @nodoc
abstract class _$$TriggeredReminderImplCopyWith<$Res> {
  factory _$$TriggeredReminderImplCopyWith(_$TriggeredReminderImpl value,
          $Res Function(_$TriggeredReminderImpl) then) =
      __$$TriggeredReminderImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TriggeredReminderImplCopyWithImpl<$Res>
    extends _$ReminderStatusCopyWithImpl<$Res, _$TriggeredReminderImpl>
    implements _$$TriggeredReminderImplCopyWith<$Res> {
  __$$TriggeredReminderImplCopyWithImpl(_$TriggeredReminderImpl _value,
      $Res Function(_$TriggeredReminderImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$TriggeredReminderImpl implements TriggeredReminder {
  const _$TriggeredReminderImpl({final String? $type})
      : $type = $type ?? 'triggered';

  factory _$TriggeredReminderImpl.fromJson(Map<String, dynamic> json) =>
      _$$TriggeredReminderImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ReminderStatus.triggered()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TriggeredReminderImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pending,
    required TResult Function() triggered,
    required TResult Function() cancelled,
    required TResult Function() completed,
  }) {
    return triggered();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pending,
    TResult? Function()? triggered,
    TResult? Function()? cancelled,
    TResult? Function()? completed,
  }) {
    return triggered?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pending,
    TResult Function()? triggered,
    TResult Function()? cancelled,
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    if (triggered != null) {
      return triggered();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PendingReminder value) pending,
    required TResult Function(TriggeredReminder value) triggered,
    required TResult Function(CancelledReminder value) cancelled,
    required TResult Function(CompletedReminder value) completed,
  }) {
    return triggered(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PendingReminder value)? pending,
    TResult? Function(TriggeredReminder value)? triggered,
    TResult? Function(CancelledReminder value)? cancelled,
    TResult? Function(CompletedReminder value)? completed,
  }) {
    return triggered?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PendingReminder value)? pending,
    TResult Function(TriggeredReminder value)? triggered,
    TResult Function(CancelledReminder value)? cancelled,
    TResult Function(CompletedReminder value)? completed,
    required TResult orElse(),
  }) {
    if (triggered != null) {
      return triggered(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TriggeredReminderImplToJson(
      this,
    );
  }
}

abstract class TriggeredReminder implements ReminderStatus {
  const factory TriggeredReminder() = _$TriggeredReminderImpl;

  factory TriggeredReminder.fromJson(Map<String, dynamic> json) =
      _$TriggeredReminderImpl.fromJson;
}

/// @nodoc
abstract class _$$CancelledReminderImplCopyWith<$Res> {
  factory _$$CancelledReminderImplCopyWith(_$CancelledReminderImpl value,
          $Res Function(_$CancelledReminderImpl) then) =
      __$$CancelledReminderImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CancelledReminderImplCopyWithImpl<$Res>
    extends _$ReminderStatusCopyWithImpl<$Res, _$CancelledReminderImpl>
    implements _$$CancelledReminderImplCopyWith<$Res> {
  __$$CancelledReminderImplCopyWithImpl(_$CancelledReminderImpl _value,
      $Res Function(_$CancelledReminderImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$CancelledReminderImpl implements CancelledReminder {
  const _$CancelledReminderImpl({final String? $type})
      : $type = $type ?? 'cancelled';

  factory _$CancelledReminderImpl.fromJson(Map<String, dynamic> json) =>
      _$$CancelledReminderImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ReminderStatus.cancelled()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CancelledReminderImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pending,
    required TResult Function() triggered,
    required TResult Function() cancelled,
    required TResult Function() completed,
  }) {
    return cancelled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pending,
    TResult? Function()? triggered,
    TResult? Function()? cancelled,
    TResult? Function()? completed,
  }) {
    return cancelled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pending,
    TResult Function()? triggered,
    TResult Function()? cancelled,
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    if (cancelled != null) {
      return cancelled();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PendingReminder value) pending,
    required TResult Function(TriggeredReminder value) triggered,
    required TResult Function(CancelledReminder value) cancelled,
    required TResult Function(CompletedReminder value) completed,
  }) {
    return cancelled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PendingReminder value)? pending,
    TResult? Function(TriggeredReminder value)? triggered,
    TResult? Function(CancelledReminder value)? cancelled,
    TResult? Function(CompletedReminder value)? completed,
  }) {
    return cancelled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PendingReminder value)? pending,
    TResult Function(TriggeredReminder value)? triggered,
    TResult Function(CancelledReminder value)? cancelled,
    TResult Function(CompletedReminder value)? completed,
    required TResult orElse(),
  }) {
    if (cancelled != null) {
      return cancelled(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CancelledReminderImplToJson(
      this,
    );
  }
}

abstract class CancelledReminder implements ReminderStatus {
  const factory CancelledReminder() = _$CancelledReminderImpl;

  factory CancelledReminder.fromJson(Map<String, dynamic> json) =
      _$CancelledReminderImpl.fromJson;
}

/// @nodoc
abstract class _$$CompletedReminderImplCopyWith<$Res> {
  factory _$$CompletedReminderImplCopyWith(_$CompletedReminderImpl value,
          $Res Function(_$CompletedReminderImpl) then) =
      __$$CompletedReminderImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CompletedReminderImplCopyWithImpl<$Res>
    extends _$ReminderStatusCopyWithImpl<$Res, _$CompletedReminderImpl>
    implements _$$CompletedReminderImplCopyWith<$Res> {
  __$$CompletedReminderImplCopyWithImpl(_$CompletedReminderImpl _value,
      $Res Function(_$CompletedReminderImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$CompletedReminderImpl implements CompletedReminder {
  const _$CompletedReminderImpl({final String? $type})
      : $type = $type ?? 'completed';

  factory _$CompletedReminderImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompletedReminderImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ReminderStatus.completed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CompletedReminderImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pending,
    required TResult Function() triggered,
    required TResult Function() cancelled,
    required TResult Function() completed,
  }) {
    return completed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pending,
    TResult? Function()? triggered,
    TResult? Function()? cancelled,
    TResult? Function()? completed,
  }) {
    return completed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pending,
    TResult Function()? triggered,
    TResult Function()? cancelled,
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
    required TResult Function(PendingReminder value) pending,
    required TResult Function(TriggeredReminder value) triggered,
    required TResult Function(CancelledReminder value) cancelled,
    required TResult Function(CompletedReminder value) completed,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PendingReminder value)? pending,
    TResult? Function(TriggeredReminder value)? triggered,
    TResult? Function(CancelledReminder value)? cancelled,
    TResult? Function(CompletedReminder value)? completed,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PendingReminder value)? pending,
    TResult Function(TriggeredReminder value)? triggered,
    TResult Function(CancelledReminder value)? cancelled,
    TResult Function(CompletedReminder value)? completed,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CompletedReminderImplToJson(
      this,
    );
  }
}

abstract class CompletedReminder implements ReminderStatus {
  const factory CompletedReminder() = _$CompletedReminderImpl;

  factory CompletedReminder.fromJson(Map<String, dynamic> json) =
      _$CompletedReminderImpl.fromJson;
}

ReminderRepeat _$ReminderRepeatFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'daily':
      return DailyRepeat.fromJson(json);
    case 'weekly':
      return WeeklyRepeat.fromJson(json);
    case 'monthly':
      return MonthlyRepeat.fromJson(json);
    case 'yearly':
      return YearlyRepeat.fromJson(json);
    case 'custom':
      return CustomRepeat.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'ReminderRepeat',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ReminderRepeat {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() daily,
    required TResult Function() weekly,
    required TResult Function() monthly,
    required TResult Function() yearly,
    required TResult Function(List<int> daysOfWeek) custom,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? daily,
    TResult? Function()? weekly,
    TResult? Function()? monthly,
    TResult? Function()? yearly,
    TResult? Function(List<int> daysOfWeek)? custom,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? daily,
    TResult Function()? weekly,
    TResult Function()? monthly,
    TResult Function()? yearly,
    TResult Function(List<int> daysOfWeek)? custom,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DailyRepeat value) daily,
    required TResult Function(WeeklyRepeat value) weekly,
    required TResult Function(MonthlyRepeat value) monthly,
    required TResult Function(YearlyRepeat value) yearly,
    required TResult Function(CustomRepeat value) custom,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DailyRepeat value)? daily,
    TResult? Function(WeeklyRepeat value)? weekly,
    TResult? Function(MonthlyRepeat value)? monthly,
    TResult? Function(YearlyRepeat value)? yearly,
    TResult? Function(CustomRepeat value)? custom,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DailyRepeat value)? daily,
    TResult Function(WeeklyRepeat value)? weekly,
    TResult Function(MonthlyRepeat value)? monthly,
    TResult Function(YearlyRepeat value)? yearly,
    TResult Function(CustomRepeat value)? custom,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this ReminderRepeat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReminderRepeatCopyWith<$Res> {
  factory $ReminderRepeatCopyWith(
          ReminderRepeat value, $Res Function(ReminderRepeat) then) =
      _$ReminderRepeatCopyWithImpl<$Res, ReminderRepeat>;
}

/// @nodoc
class _$ReminderRepeatCopyWithImpl<$Res, $Val extends ReminderRepeat>
    implements $ReminderRepeatCopyWith<$Res> {
  _$ReminderRepeatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReminderRepeat
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$DailyRepeatImplCopyWith<$Res> {
  factory _$$DailyRepeatImplCopyWith(
          _$DailyRepeatImpl value, $Res Function(_$DailyRepeatImpl) then) =
      __$$DailyRepeatImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DailyRepeatImplCopyWithImpl<$Res>
    extends _$ReminderRepeatCopyWithImpl<$Res, _$DailyRepeatImpl>
    implements _$$DailyRepeatImplCopyWith<$Res> {
  __$$DailyRepeatImplCopyWithImpl(
      _$DailyRepeatImpl _value, $Res Function(_$DailyRepeatImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderRepeat
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$DailyRepeatImpl implements DailyRepeat {
  const _$DailyRepeatImpl({final String? $type}) : $type = $type ?? 'daily';

  factory _$DailyRepeatImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyRepeatImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ReminderRepeat.daily()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DailyRepeatImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() daily,
    required TResult Function() weekly,
    required TResult Function() monthly,
    required TResult Function() yearly,
    required TResult Function(List<int> daysOfWeek) custom,
  }) {
    return daily();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? daily,
    TResult? Function()? weekly,
    TResult? Function()? monthly,
    TResult? Function()? yearly,
    TResult? Function(List<int> daysOfWeek)? custom,
  }) {
    return daily?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? daily,
    TResult Function()? weekly,
    TResult Function()? monthly,
    TResult Function()? yearly,
    TResult Function(List<int> daysOfWeek)? custom,
    required TResult orElse(),
  }) {
    if (daily != null) {
      return daily();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DailyRepeat value) daily,
    required TResult Function(WeeklyRepeat value) weekly,
    required TResult Function(MonthlyRepeat value) monthly,
    required TResult Function(YearlyRepeat value) yearly,
    required TResult Function(CustomRepeat value) custom,
  }) {
    return daily(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DailyRepeat value)? daily,
    TResult? Function(WeeklyRepeat value)? weekly,
    TResult? Function(MonthlyRepeat value)? monthly,
    TResult? Function(YearlyRepeat value)? yearly,
    TResult? Function(CustomRepeat value)? custom,
  }) {
    return daily?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DailyRepeat value)? daily,
    TResult Function(WeeklyRepeat value)? weekly,
    TResult Function(MonthlyRepeat value)? monthly,
    TResult Function(YearlyRepeat value)? yearly,
    TResult Function(CustomRepeat value)? custom,
    required TResult orElse(),
  }) {
    if (daily != null) {
      return daily(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyRepeatImplToJson(
      this,
    );
  }
}

abstract class DailyRepeat implements ReminderRepeat {
  const factory DailyRepeat() = _$DailyRepeatImpl;

  factory DailyRepeat.fromJson(Map<String, dynamic> json) =
      _$DailyRepeatImpl.fromJson;
}

/// @nodoc
abstract class _$$WeeklyRepeatImplCopyWith<$Res> {
  factory _$$WeeklyRepeatImplCopyWith(
          _$WeeklyRepeatImpl value, $Res Function(_$WeeklyRepeatImpl) then) =
      __$$WeeklyRepeatImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WeeklyRepeatImplCopyWithImpl<$Res>
    extends _$ReminderRepeatCopyWithImpl<$Res, _$WeeklyRepeatImpl>
    implements _$$WeeklyRepeatImplCopyWith<$Res> {
  __$$WeeklyRepeatImplCopyWithImpl(
      _$WeeklyRepeatImpl _value, $Res Function(_$WeeklyRepeatImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderRepeat
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$WeeklyRepeatImpl implements WeeklyRepeat {
  const _$WeeklyRepeatImpl({final String? $type}) : $type = $type ?? 'weekly';

  factory _$WeeklyRepeatImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeeklyRepeatImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ReminderRepeat.weekly()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WeeklyRepeatImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() daily,
    required TResult Function() weekly,
    required TResult Function() monthly,
    required TResult Function() yearly,
    required TResult Function(List<int> daysOfWeek) custom,
  }) {
    return weekly();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? daily,
    TResult? Function()? weekly,
    TResult? Function()? monthly,
    TResult? Function()? yearly,
    TResult? Function(List<int> daysOfWeek)? custom,
  }) {
    return weekly?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? daily,
    TResult Function()? weekly,
    TResult Function()? monthly,
    TResult Function()? yearly,
    TResult Function(List<int> daysOfWeek)? custom,
    required TResult orElse(),
  }) {
    if (weekly != null) {
      return weekly();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DailyRepeat value) daily,
    required TResult Function(WeeklyRepeat value) weekly,
    required TResult Function(MonthlyRepeat value) monthly,
    required TResult Function(YearlyRepeat value) yearly,
    required TResult Function(CustomRepeat value) custom,
  }) {
    return weekly(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DailyRepeat value)? daily,
    TResult? Function(WeeklyRepeat value)? weekly,
    TResult? Function(MonthlyRepeat value)? monthly,
    TResult? Function(YearlyRepeat value)? yearly,
    TResult? Function(CustomRepeat value)? custom,
  }) {
    return weekly?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DailyRepeat value)? daily,
    TResult Function(WeeklyRepeat value)? weekly,
    TResult Function(MonthlyRepeat value)? monthly,
    TResult Function(YearlyRepeat value)? yearly,
    TResult Function(CustomRepeat value)? custom,
    required TResult orElse(),
  }) {
    if (weekly != null) {
      return weekly(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WeeklyRepeatImplToJson(
      this,
    );
  }
}

abstract class WeeklyRepeat implements ReminderRepeat {
  const factory WeeklyRepeat() = _$WeeklyRepeatImpl;

  factory WeeklyRepeat.fromJson(Map<String, dynamic> json) =
      _$WeeklyRepeatImpl.fromJson;
}

/// @nodoc
abstract class _$$MonthlyRepeatImplCopyWith<$Res> {
  factory _$$MonthlyRepeatImplCopyWith(
          _$MonthlyRepeatImpl value, $Res Function(_$MonthlyRepeatImpl) then) =
      __$$MonthlyRepeatImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MonthlyRepeatImplCopyWithImpl<$Res>
    extends _$ReminderRepeatCopyWithImpl<$Res, _$MonthlyRepeatImpl>
    implements _$$MonthlyRepeatImplCopyWith<$Res> {
  __$$MonthlyRepeatImplCopyWithImpl(
      _$MonthlyRepeatImpl _value, $Res Function(_$MonthlyRepeatImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderRepeat
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$MonthlyRepeatImpl implements MonthlyRepeat {
  const _$MonthlyRepeatImpl({final String? $type}) : $type = $type ?? 'monthly';

  factory _$MonthlyRepeatImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyRepeatImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ReminderRepeat.monthly()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MonthlyRepeatImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() daily,
    required TResult Function() weekly,
    required TResult Function() monthly,
    required TResult Function() yearly,
    required TResult Function(List<int> daysOfWeek) custom,
  }) {
    return monthly();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? daily,
    TResult? Function()? weekly,
    TResult? Function()? monthly,
    TResult? Function()? yearly,
    TResult? Function(List<int> daysOfWeek)? custom,
  }) {
    return monthly?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? daily,
    TResult Function()? weekly,
    TResult Function()? monthly,
    TResult Function()? yearly,
    TResult Function(List<int> daysOfWeek)? custom,
    required TResult orElse(),
  }) {
    if (monthly != null) {
      return monthly();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DailyRepeat value) daily,
    required TResult Function(WeeklyRepeat value) weekly,
    required TResult Function(MonthlyRepeat value) monthly,
    required TResult Function(YearlyRepeat value) yearly,
    required TResult Function(CustomRepeat value) custom,
  }) {
    return monthly(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DailyRepeat value)? daily,
    TResult? Function(WeeklyRepeat value)? weekly,
    TResult? Function(MonthlyRepeat value)? monthly,
    TResult? Function(YearlyRepeat value)? yearly,
    TResult? Function(CustomRepeat value)? custom,
  }) {
    return monthly?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DailyRepeat value)? daily,
    TResult Function(WeeklyRepeat value)? weekly,
    TResult Function(MonthlyRepeat value)? monthly,
    TResult Function(YearlyRepeat value)? yearly,
    TResult Function(CustomRepeat value)? custom,
    required TResult orElse(),
  }) {
    if (monthly != null) {
      return monthly(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlyRepeatImplToJson(
      this,
    );
  }
}

abstract class MonthlyRepeat implements ReminderRepeat {
  const factory MonthlyRepeat() = _$MonthlyRepeatImpl;

  factory MonthlyRepeat.fromJson(Map<String, dynamic> json) =
      _$MonthlyRepeatImpl.fromJson;
}

/// @nodoc
abstract class _$$YearlyRepeatImplCopyWith<$Res> {
  factory _$$YearlyRepeatImplCopyWith(
          _$YearlyRepeatImpl value, $Res Function(_$YearlyRepeatImpl) then) =
      __$$YearlyRepeatImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$YearlyRepeatImplCopyWithImpl<$Res>
    extends _$ReminderRepeatCopyWithImpl<$Res, _$YearlyRepeatImpl>
    implements _$$YearlyRepeatImplCopyWith<$Res> {
  __$$YearlyRepeatImplCopyWithImpl(
      _$YearlyRepeatImpl _value, $Res Function(_$YearlyRepeatImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderRepeat
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$YearlyRepeatImpl implements YearlyRepeat {
  const _$YearlyRepeatImpl({final String? $type}) : $type = $type ?? 'yearly';

  factory _$YearlyRepeatImpl.fromJson(Map<String, dynamic> json) =>
      _$$YearlyRepeatImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ReminderRepeat.yearly()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$YearlyRepeatImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() daily,
    required TResult Function() weekly,
    required TResult Function() monthly,
    required TResult Function() yearly,
    required TResult Function(List<int> daysOfWeek) custom,
  }) {
    return yearly();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? daily,
    TResult? Function()? weekly,
    TResult? Function()? monthly,
    TResult? Function()? yearly,
    TResult? Function(List<int> daysOfWeek)? custom,
  }) {
    return yearly?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? daily,
    TResult Function()? weekly,
    TResult Function()? monthly,
    TResult Function()? yearly,
    TResult Function(List<int> daysOfWeek)? custom,
    required TResult orElse(),
  }) {
    if (yearly != null) {
      return yearly();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DailyRepeat value) daily,
    required TResult Function(WeeklyRepeat value) weekly,
    required TResult Function(MonthlyRepeat value) monthly,
    required TResult Function(YearlyRepeat value) yearly,
    required TResult Function(CustomRepeat value) custom,
  }) {
    return yearly(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DailyRepeat value)? daily,
    TResult? Function(WeeklyRepeat value)? weekly,
    TResult? Function(MonthlyRepeat value)? monthly,
    TResult? Function(YearlyRepeat value)? yearly,
    TResult? Function(CustomRepeat value)? custom,
  }) {
    return yearly?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DailyRepeat value)? daily,
    TResult Function(WeeklyRepeat value)? weekly,
    TResult Function(MonthlyRepeat value)? monthly,
    TResult Function(YearlyRepeat value)? yearly,
    TResult Function(CustomRepeat value)? custom,
    required TResult orElse(),
  }) {
    if (yearly != null) {
      return yearly(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$YearlyRepeatImplToJson(
      this,
    );
  }
}

abstract class YearlyRepeat implements ReminderRepeat {
  const factory YearlyRepeat() = _$YearlyRepeatImpl;

  factory YearlyRepeat.fromJson(Map<String, dynamic> json) =
      _$YearlyRepeatImpl.fromJson;
}

/// @nodoc
abstract class _$$CustomRepeatImplCopyWith<$Res> {
  factory _$$CustomRepeatImplCopyWith(
          _$CustomRepeatImpl value, $Res Function(_$CustomRepeatImpl) then) =
      __$$CustomRepeatImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<int> daysOfWeek});
}

/// @nodoc
class __$$CustomRepeatImplCopyWithImpl<$Res>
    extends _$ReminderRepeatCopyWithImpl<$Res, _$CustomRepeatImpl>
    implements _$$CustomRepeatImplCopyWith<$Res> {
  __$$CustomRepeatImplCopyWithImpl(
      _$CustomRepeatImpl _value, $Res Function(_$CustomRepeatImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderRepeat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? daysOfWeek = null,
  }) {
    return _then(_$CustomRepeatImpl(
      daysOfWeek: null == daysOfWeek
          ? _value._daysOfWeek
          : daysOfWeek // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomRepeatImpl implements CustomRepeat {
  const _$CustomRepeatImpl(
      {required final List<int> daysOfWeek, final String? $type})
      : _daysOfWeek = daysOfWeek,
        $type = $type ?? 'custom';

  factory _$CustomRepeatImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomRepeatImplFromJson(json);

  final List<int> _daysOfWeek;
  @override
  List<int> get daysOfWeek {
    if (_daysOfWeek is EqualUnmodifiableListView) return _daysOfWeek;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_daysOfWeek);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ReminderRepeat.custom(daysOfWeek: $daysOfWeek)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomRepeatImpl &&
            const DeepCollectionEquality()
                .equals(other._daysOfWeek, _daysOfWeek));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_daysOfWeek));

  /// Create a copy of ReminderRepeat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomRepeatImplCopyWith<_$CustomRepeatImpl> get copyWith =>
      __$$CustomRepeatImplCopyWithImpl<_$CustomRepeatImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() daily,
    required TResult Function() weekly,
    required TResult Function() monthly,
    required TResult Function() yearly,
    required TResult Function(List<int> daysOfWeek) custom,
  }) {
    return custom(daysOfWeek);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? daily,
    TResult? Function()? weekly,
    TResult? Function()? monthly,
    TResult? Function()? yearly,
    TResult? Function(List<int> daysOfWeek)? custom,
  }) {
    return custom?.call(daysOfWeek);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? daily,
    TResult Function()? weekly,
    TResult Function()? monthly,
    TResult Function()? yearly,
    TResult Function(List<int> daysOfWeek)? custom,
    required TResult orElse(),
  }) {
    if (custom != null) {
      return custom(daysOfWeek);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DailyRepeat value) daily,
    required TResult Function(WeeklyRepeat value) weekly,
    required TResult Function(MonthlyRepeat value) monthly,
    required TResult Function(YearlyRepeat value) yearly,
    required TResult Function(CustomRepeat value) custom,
  }) {
    return custom(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DailyRepeat value)? daily,
    TResult? Function(WeeklyRepeat value)? weekly,
    TResult? Function(MonthlyRepeat value)? monthly,
    TResult? Function(YearlyRepeat value)? yearly,
    TResult? Function(CustomRepeat value)? custom,
  }) {
    return custom?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DailyRepeat value)? daily,
    TResult Function(WeeklyRepeat value)? weekly,
    TResult Function(MonthlyRepeat value)? monthly,
    TResult Function(YearlyRepeat value)? yearly,
    TResult Function(CustomRepeat value)? custom,
    required TResult orElse(),
  }) {
    if (custom != null) {
      return custom(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomRepeatImplToJson(
      this,
    );
  }
}

abstract class CustomRepeat implements ReminderRepeat {
  const factory CustomRepeat({required final List<int> daysOfWeek}) =
      _$CustomRepeatImpl;

  factory CustomRepeat.fromJson(Map<String, dynamic> json) =
      _$CustomRepeatImpl.fromJson;

  List<int> get daysOfWeek;

  /// Create a copy of ReminderRepeat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomRepeatImplCopyWith<_$CustomRepeatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReminderNotificationSettings _$ReminderNotificationSettingsFromJson(
    Map<String, dynamic> json) {
  return _ReminderNotificationSettings.fromJson(json);
}

/// @nodoc
mixin _$ReminderNotificationSettings {
  bool get enableSound => throw _privateConstructorUsedError;
  bool get enableVibration => throw _privateConstructorUsedError;
  bool get enableLight => throw _privateConstructorUsedError;
  String get soundPath => throw _privateConstructorUsedError;
  int get vibrationPattern => throw _privateConstructorUsedError;
  int get ledColor => throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;
  bool get showOnLockScreen => throw _privateConstructorUsedError;
  bool get showBadge => throw _privateConstructorUsedError;

  /// Serializes this ReminderNotificationSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReminderNotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReminderNotificationSettingsCopyWith<ReminderNotificationSettings>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReminderNotificationSettingsCopyWith<$Res> {
  factory $ReminderNotificationSettingsCopyWith(
          ReminderNotificationSettings value,
          $Res Function(ReminderNotificationSettings) then) =
      _$ReminderNotificationSettingsCopyWithImpl<$Res,
          ReminderNotificationSettings>;
  @useResult
  $Res call(
      {bool enableSound,
      bool enableVibration,
      bool enableLight,
      String soundPath,
      int vibrationPattern,
      int ledColor,
      int priority,
      bool showOnLockScreen,
      bool showBadge});
}

/// @nodoc
class _$ReminderNotificationSettingsCopyWithImpl<$Res,
        $Val extends ReminderNotificationSettings>
    implements $ReminderNotificationSettingsCopyWith<$Res> {
  _$ReminderNotificationSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReminderNotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enableSound = null,
    Object? enableVibration = null,
    Object? enableLight = null,
    Object? soundPath = null,
    Object? vibrationPattern = null,
    Object? ledColor = null,
    Object? priority = null,
    Object? showOnLockScreen = null,
    Object? showBadge = null,
  }) {
    return _then(_value.copyWith(
      enableSound: null == enableSound
          ? _value.enableSound
          : enableSound // ignore: cast_nullable_to_non_nullable
              as bool,
      enableVibration: null == enableVibration
          ? _value.enableVibration
          : enableVibration // ignore: cast_nullable_to_non_nullable
              as bool,
      enableLight: null == enableLight
          ? _value.enableLight
          : enableLight // ignore: cast_nullable_to_non_nullable
              as bool,
      soundPath: null == soundPath
          ? _value.soundPath
          : soundPath // ignore: cast_nullable_to_non_nullable
              as String,
      vibrationPattern: null == vibrationPattern
          ? _value.vibrationPattern
          : vibrationPattern // ignore: cast_nullable_to_non_nullable
              as int,
      ledColor: null == ledColor
          ? _value.ledColor
          : ledColor // ignore: cast_nullable_to_non_nullable
              as int,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      showOnLockScreen: null == showOnLockScreen
          ? _value.showOnLockScreen
          : showOnLockScreen // ignore: cast_nullable_to_non_nullable
              as bool,
      showBadge: null == showBadge
          ? _value.showBadge
          : showBadge // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReminderNotificationSettingsImplCopyWith<$Res>
    implements $ReminderNotificationSettingsCopyWith<$Res> {
  factory _$$ReminderNotificationSettingsImplCopyWith(
          _$ReminderNotificationSettingsImpl value,
          $Res Function(_$ReminderNotificationSettingsImpl) then) =
      __$$ReminderNotificationSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool enableSound,
      bool enableVibration,
      bool enableLight,
      String soundPath,
      int vibrationPattern,
      int ledColor,
      int priority,
      bool showOnLockScreen,
      bool showBadge});
}

/// @nodoc
class __$$ReminderNotificationSettingsImplCopyWithImpl<$Res>
    extends _$ReminderNotificationSettingsCopyWithImpl<$Res,
        _$ReminderNotificationSettingsImpl>
    implements _$$ReminderNotificationSettingsImplCopyWith<$Res> {
  __$$ReminderNotificationSettingsImplCopyWithImpl(
      _$ReminderNotificationSettingsImpl _value,
      $Res Function(_$ReminderNotificationSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderNotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enableSound = null,
    Object? enableVibration = null,
    Object? enableLight = null,
    Object? soundPath = null,
    Object? vibrationPattern = null,
    Object? ledColor = null,
    Object? priority = null,
    Object? showOnLockScreen = null,
    Object? showBadge = null,
  }) {
    return _then(_$ReminderNotificationSettingsImpl(
      enableSound: null == enableSound
          ? _value.enableSound
          : enableSound // ignore: cast_nullable_to_non_nullable
              as bool,
      enableVibration: null == enableVibration
          ? _value.enableVibration
          : enableVibration // ignore: cast_nullable_to_non_nullable
              as bool,
      enableLight: null == enableLight
          ? _value.enableLight
          : enableLight // ignore: cast_nullable_to_non_nullable
              as bool,
      soundPath: null == soundPath
          ? _value.soundPath
          : soundPath // ignore: cast_nullable_to_non_nullable
              as String,
      vibrationPattern: null == vibrationPattern
          ? _value.vibrationPattern
          : vibrationPattern // ignore: cast_nullable_to_non_nullable
              as int,
      ledColor: null == ledColor
          ? _value.ledColor
          : ledColor // ignore: cast_nullable_to_non_nullable
              as int,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      showOnLockScreen: null == showOnLockScreen
          ? _value.showOnLockScreen
          : showOnLockScreen // ignore: cast_nullable_to_non_nullable
              as bool,
      showBadge: null == showBadge
          ? _value.showBadge
          : showBadge // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReminderNotificationSettingsImpl
    implements _ReminderNotificationSettings {
  const _$ReminderNotificationSettingsImpl(
      {required this.enableSound,
      required this.enableVibration,
      required this.enableLight,
      required this.soundPath,
      required this.vibrationPattern,
      required this.ledColor,
      required this.priority,
      required this.showOnLockScreen,
      required this.showBadge});

  factory _$ReminderNotificationSettingsImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ReminderNotificationSettingsImplFromJson(json);

  @override
  final bool enableSound;
  @override
  final bool enableVibration;
  @override
  final bool enableLight;
  @override
  final String soundPath;
  @override
  final int vibrationPattern;
  @override
  final int ledColor;
  @override
  final int priority;
  @override
  final bool showOnLockScreen;
  @override
  final bool showBadge;

  @override
  String toString() {
    return 'ReminderNotificationSettings(enableSound: $enableSound, enableVibration: $enableVibration, enableLight: $enableLight, soundPath: $soundPath, vibrationPattern: $vibrationPattern, ledColor: $ledColor, priority: $priority, showOnLockScreen: $showOnLockScreen, showBadge: $showBadge)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReminderNotificationSettingsImpl &&
            (identical(other.enableSound, enableSound) ||
                other.enableSound == enableSound) &&
            (identical(other.enableVibration, enableVibration) ||
                other.enableVibration == enableVibration) &&
            (identical(other.enableLight, enableLight) ||
                other.enableLight == enableLight) &&
            (identical(other.soundPath, soundPath) ||
                other.soundPath == soundPath) &&
            (identical(other.vibrationPattern, vibrationPattern) ||
                other.vibrationPattern == vibrationPattern) &&
            (identical(other.ledColor, ledColor) ||
                other.ledColor == ledColor) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.showOnLockScreen, showOnLockScreen) ||
                other.showOnLockScreen == showOnLockScreen) &&
            (identical(other.showBadge, showBadge) ||
                other.showBadge == showBadge));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      enableSound,
      enableVibration,
      enableLight,
      soundPath,
      vibrationPattern,
      ledColor,
      priority,
      showOnLockScreen,
      showBadge);

  /// Create a copy of ReminderNotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReminderNotificationSettingsImplCopyWith<
          _$ReminderNotificationSettingsImpl>
      get copyWith => __$$ReminderNotificationSettingsImplCopyWithImpl<
          _$ReminderNotificationSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReminderNotificationSettingsImplToJson(
      this,
    );
  }
}

abstract class _ReminderNotificationSettings
    implements ReminderNotificationSettings {
  const factory _ReminderNotificationSettings(
      {required final bool enableSound,
      required final bool enableVibration,
      required final bool enableLight,
      required final String soundPath,
      required final int vibrationPattern,
      required final int ledColor,
      required final int priority,
      required final bool showOnLockScreen,
      required final bool showBadge}) = _$ReminderNotificationSettingsImpl;

  factory _ReminderNotificationSettings.fromJson(Map<String, dynamic> json) =
      _$ReminderNotificationSettingsImpl.fromJson;

  @override
  bool get enableSound;
  @override
  bool get enableVibration;
  @override
  bool get enableLight;
  @override
  String get soundPath;
  @override
  int get vibrationPattern;
  @override
  int get ledColor;
  @override
  int get priority;
  @override
  bool get showOnLockScreen;
  @override
  bool get showBadge;

  /// Create a copy of ReminderNotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReminderNotificationSettingsImplCopyWith<
          _$ReminderNotificationSettingsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
