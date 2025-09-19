// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SecurityEvent _$SecurityEventFromJson(Map<String, dynamic> json) {
  return _SecurityEvent.fromJson(json);
}

/// @nodoc
mixin _$SecurityEvent {
  String get id => throw _privateConstructorUsedError;
  SecurityEventType get type => throw _privateConstructorUsedError;
  SecuritySeverity get severity => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  String? get sessionId => throw _privateConstructorUsedError;
  String? get ipAddress => throw _privateConstructorUsedError;
  String? get userAgent => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  bool? get isResolved => throw _privateConstructorUsedError;
  DateTime? get resolvedAt => throw _privateConstructorUsedError;
  String? get resolutionNote => throw _privateConstructorUsedError;

  /// Serializes this SecurityEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SecurityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SecurityEventCopyWith<SecurityEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecurityEventCopyWith<$Res> {
  factory $SecurityEventCopyWith(
          SecurityEvent value, $Res Function(SecurityEvent) then) =
      _$SecurityEventCopyWithImpl<$Res, SecurityEvent>;
  @useResult
  $Res call(
      {String id,
      SecurityEventType type,
      SecuritySeverity severity,
      DateTime timestamp,
      String description,
      String source,
      Map<String, dynamic> metadata,
      String? userId,
      String? sessionId,
      String? ipAddress,
      String? userAgent,
      String? location,
      bool? isResolved,
      DateTime? resolvedAt,
      String? resolutionNote});

  $SecurityEventTypeCopyWith<$Res> get type;
  $SecuritySeverityCopyWith<$Res> get severity;
}

/// @nodoc
class _$SecurityEventCopyWithImpl<$Res, $Val extends SecurityEvent>
    implements $SecurityEventCopyWith<$Res> {
  _$SecurityEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SecurityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? severity = null,
    Object? timestamp = null,
    Object? description = null,
    Object? source = null,
    Object? metadata = null,
    Object? userId = freezed,
    Object? sessionId = freezed,
    Object? ipAddress = freezed,
    Object? userAgent = freezed,
    Object? location = freezed,
    Object? isResolved = freezed,
    Object? resolvedAt = freezed,
    Object? resolutionNote = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SecurityEventType,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as SecuritySeverity,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      ipAddress: freezed == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      userAgent: freezed == userAgent
          ? _value.userAgent
          : userAgent // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      isResolved: freezed == isResolved
          ? _value.isResolved
          : isResolved // ignore: cast_nullable_to_non_nullable
              as bool?,
      resolvedAt: freezed == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      resolutionNote: freezed == resolutionNote
          ? _value.resolutionNote
          : resolutionNote // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of SecurityEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SecurityEventTypeCopyWith<$Res> get type {
    return $SecurityEventTypeCopyWith<$Res>(_value.type, (value) {
      return _then(_value.copyWith(type: value) as $Val);
    });
  }

  /// Create a copy of SecurityEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SecuritySeverityCopyWith<$Res> get severity {
    return $SecuritySeverityCopyWith<$Res>(_value.severity, (value) {
      return _then(_value.copyWith(severity: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SecurityEventImplCopyWith<$Res>
    implements $SecurityEventCopyWith<$Res> {
  factory _$$SecurityEventImplCopyWith(
          _$SecurityEventImpl value, $Res Function(_$SecurityEventImpl) then) =
      __$$SecurityEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      SecurityEventType type,
      SecuritySeverity severity,
      DateTime timestamp,
      String description,
      String source,
      Map<String, dynamic> metadata,
      String? userId,
      String? sessionId,
      String? ipAddress,
      String? userAgent,
      String? location,
      bool? isResolved,
      DateTime? resolvedAt,
      String? resolutionNote});

  @override
  $SecurityEventTypeCopyWith<$Res> get type;
  @override
  $SecuritySeverityCopyWith<$Res> get severity;
}

/// @nodoc
class __$$SecurityEventImplCopyWithImpl<$Res>
    extends _$SecurityEventCopyWithImpl<$Res, _$SecurityEventImpl>
    implements _$$SecurityEventImplCopyWith<$Res> {
  __$$SecurityEventImplCopyWithImpl(
      _$SecurityEventImpl _value, $Res Function(_$SecurityEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? severity = null,
    Object? timestamp = null,
    Object? description = null,
    Object? source = null,
    Object? metadata = null,
    Object? userId = freezed,
    Object? sessionId = freezed,
    Object? ipAddress = freezed,
    Object? userAgent = freezed,
    Object? location = freezed,
    Object? isResolved = freezed,
    Object? resolvedAt = freezed,
    Object? resolutionNote = freezed,
  }) {
    return _then(_$SecurityEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SecurityEventType,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as SecuritySeverity,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      ipAddress: freezed == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      userAgent: freezed == userAgent
          ? _value.userAgent
          : userAgent // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      isResolved: freezed == isResolved
          ? _value.isResolved
          : isResolved // ignore: cast_nullable_to_non_nullable
              as bool?,
      resolvedAt: freezed == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      resolutionNote: freezed == resolutionNote
          ? _value.resolutionNote
          : resolutionNote // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SecurityEventImpl implements _SecurityEvent {
  const _$SecurityEventImpl(
      {required this.id,
      required this.type,
      required this.severity,
      required this.timestamp,
      required this.description,
      required this.source,
      required final Map<String, dynamic> metadata,
      this.userId,
      this.sessionId,
      this.ipAddress,
      this.userAgent,
      this.location,
      this.isResolved,
      this.resolvedAt,
      this.resolutionNote})
      : _metadata = metadata;

  factory _$SecurityEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$SecurityEventImplFromJson(json);

  @override
  final String id;
  @override
  final SecurityEventType type;
  @override
  final SecuritySeverity severity;
  @override
  final DateTime timestamp;
  @override
  final String description;
  @override
  final String source;
  final Map<String, dynamic> _metadata;
  @override
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  final String? userId;
  @override
  final String? sessionId;
  @override
  final String? ipAddress;
  @override
  final String? userAgent;
  @override
  final String? location;
  @override
  final bool? isResolved;
  @override
  final DateTime? resolvedAt;
  @override
  final String? resolutionNote;

  @override
  String toString() {
    return 'SecurityEvent(id: $id, type: $type, severity: $severity, timestamp: $timestamp, description: $description, source: $source, metadata: $metadata, userId: $userId, sessionId: $sessionId, ipAddress: $ipAddress, userAgent: $userAgent, location: $location, isResolved: $isResolved, resolvedAt: $resolvedAt, resolutionNote: $resolutionNote)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecurityEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.source, source) || other.source == source) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.ipAddress, ipAddress) ||
                other.ipAddress == ipAddress) &&
            (identical(other.userAgent, userAgent) ||
                other.userAgent == userAgent) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.isResolved, isResolved) ||
                other.isResolved == isResolved) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt) &&
            (identical(other.resolutionNote, resolutionNote) ||
                other.resolutionNote == resolutionNote));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      severity,
      timestamp,
      description,
      source,
      const DeepCollectionEquality().hash(_metadata),
      userId,
      sessionId,
      ipAddress,
      userAgent,
      location,
      isResolved,
      resolvedAt,
      resolutionNote);

  /// Create a copy of SecurityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SecurityEventImplCopyWith<_$SecurityEventImpl> get copyWith =>
      __$$SecurityEventImplCopyWithImpl<_$SecurityEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SecurityEventImplToJson(
      this,
    );
  }
}

abstract class _SecurityEvent implements SecurityEvent {
  const factory _SecurityEvent(
      {required final String id,
      required final SecurityEventType type,
      required final SecuritySeverity severity,
      required final DateTime timestamp,
      required final String description,
      required final String source,
      required final Map<String, dynamic> metadata,
      final String? userId,
      final String? sessionId,
      final String? ipAddress,
      final String? userAgent,
      final String? location,
      final bool? isResolved,
      final DateTime? resolvedAt,
      final String? resolutionNote}) = _$SecurityEventImpl;

  factory _SecurityEvent.fromJson(Map<String, dynamic> json) =
      _$SecurityEventImpl.fromJson;

  @override
  String get id;
  @override
  SecurityEventType get type;
  @override
  SecuritySeverity get severity;
  @override
  DateTime get timestamp;
  @override
  String get description;
  @override
  String get source;
  @override
  Map<String, dynamic> get metadata;
  @override
  String? get userId;
  @override
  String? get sessionId;
  @override
  String? get ipAddress;
  @override
  String? get userAgent;
  @override
  String? get location;
  @override
  bool? get isResolved;
  @override
  DateTime? get resolvedAt;
  @override
  String? get resolutionNote;

  /// Create a copy of SecurityEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SecurityEventImplCopyWith<_$SecurityEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SecurityEventType _$SecurityEventTypeFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'login':
      return LoginEvent.fromJson(json);
    case 'logout':
      return LogoutEvent.fromJson(json);
    case 'authenticationFailure':
      return AuthenticationFailureEvent.fromJson(json);
    case 'authorizationFailure':
      return AuthorizationFailureEvent.fromJson(json);
    case 'dataAccess':
      return DataAccessEvent.fromJson(json);
    case 'dataModification':
      return DataModificationEvent.fromJson(json);
    case 'dataExport':
      return DataExportEvent.fromJson(json);
    case 'dataImport':
      return DataImportEvent.fromJson(json);
    case 'systemAccess':
      return SystemAccessEvent.fromJson(json);
    case 'configurationChange':
      return ConfigurationChangeEvent.fromJson(json);
    case 'securityPolicyViolation':
      return SecurityPolicyViolationEvent.fromJson(json);
    case 'suspiciousActivity':
      return SuspiciousActivityEvent.fromJson(json);
    case 'threatDetected':
      return ThreatDetectedEvent.fromJson(json);
    case 'incident':
      return IncidentEvent.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'SecurityEventType',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SecurityEventType {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() login,
    required TResult Function() logout,
    required TResult Function() authenticationFailure,
    required TResult Function() authorizationFailure,
    required TResult Function() dataAccess,
    required TResult Function() dataModification,
    required TResult Function() dataExport,
    required TResult Function() dataImport,
    required TResult Function() systemAccess,
    required TResult Function() configurationChange,
    required TResult Function() securityPolicyViolation,
    required TResult Function() suspiciousActivity,
    required TResult Function() threatDetected,
    required TResult Function() incident,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? login,
    TResult? Function()? logout,
    TResult? Function()? authenticationFailure,
    TResult? Function()? authorizationFailure,
    TResult? Function()? dataAccess,
    TResult? Function()? dataModification,
    TResult? Function()? dataExport,
    TResult? Function()? dataImport,
    TResult? Function()? systemAccess,
    TResult? Function()? configurationChange,
    TResult? Function()? securityPolicyViolation,
    TResult? Function()? suspiciousActivity,
    TResult? Function()? threatDetected,
    TResult? Function()? incident,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? login,
    TResult Function()? logout,
    TResult Function()? authenticationFailure,
    TResult Function()? authorizationFailure,
    TResult Function()? dataAccess,
    TResult Function()? dataModification,
    TResult Function()? dataExport,
    TResult Function()? dataImport,
    TResult Function()? systemAccess,
    TResult Function()? configurationChange,
    TResult Function()? securityPolicyViolation,
    TResult Function()? suspiciousActivity,
    TResult Function()? threatDetected,
    TResult Function()? incident,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginEvent value) login,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(AuthenticationFailureEvent value)
        authenticationFailure,
    required TResult Function(AuthorizationFailureEvent value)
        authorizationFailure,
    required TResult Function(DataAccessEvent value) dataAccess,
    required TResult Function(DataModificationEvent value) dataModification,
    required TResult Function(DataExportEvent value) dataExport,
    required TResult Function(DataImportEvent value) dataImport,
    required TResult Function(SystemAccessEvent value) systemAccess,
    required TResult Function(ConfigurationChangeEvent value)
        configurationChange,
    required TResult Function(SecurityPolicyViolationEvent value)
        securityPolicyViolation,
    required TResult Function(SuspiciousActivityEvent value) suspiciousActivity,
    required TResult Function(ThreatDetectedEvent value) threatDetected,
    required TResult Function(IncidentEvent value) incident,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginEvent value)? login,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult? Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult? Function(DataAccessEvent value)? dataAccess,
    TResult? Function(DataModificationEvent value)? dataModification,
    TResult? Function(DataExportEvent value)? dataExport,
    TResult? Function(DataImportEvent value)? dataImport,
    TResult? Function(SystemAccessEvent value)? systemAccess,
    TResult? Function(ConfigurationChangeEvent value)? configurationChange,
    TResult? Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult? Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult? Function(ThreatDetectedEvent value)? threatDetected,
    TResult? Function(IncidentEvent value)? incident,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginEvent value)? login,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult Function(DataAccessEvent value)? dataAccess,
    TResult Function(DataModificationEvent value)? dataModification,
    TResult Function(DataExportEvent value)? dataExport,
    TResult Function(DataImportEvent value)? dataImport,
    TResult Function(SystemAccessEvent value)? systemAccess,
    TResult Function(ConfigurationChangeEvent value)? configurationChange,
    TResult Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult Function(ThreatDetectedEvent value)? threatDetected,
    TResult Function(IncidentEvent value)? incident,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this SecurityEventType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecurityEventTypeCopyWith<$Res> {
  factory $SecurityEventTypeCopyWith(
          SecurityEventType value, $Res Function(SecurityEventType) then) =
      _$SecurityEventTypeCopyWithImpl<$Res, SecurityEventType>;
}

/// @nodoc
class _$SecurityEventTypeCopyWithImpl<$Res, $Val extends SecurityEventType>
    implements $SecurityEventTypeCopyWith<$Res> {
  _$SecurityEventTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SecurityEventType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoginEventImplCopyWith<$Res> {
  factory _$$LoginEventImplCopyWith(
          _$LoginEventImpl value, $Res Function(_$LoginEventImpl) then) =
      __$$LoginEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginEventImplCopyWithImpl<$Res>
    extends _$SecurityEventTypeCopyWithImpl<$Res, _$LoginEventImpl>
    implements _$$LoginEventImplCopyWith<$Res> {
  __$$LoginEventImplCopyWithImpl(
      _$LoginEventImpl _value, $Res Function(_$LoginEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityEventType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$LoginEventImpl implements LoginEvent {
  const _$LoginEventImpl({final String? $type}) : $type = $type ?? 'login';

  factory _$LoginEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginEventImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SecurityEventType.login()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoginEventImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() login,
    required TResult Function() logout,
    required TResult Function() authenticationFailure,
    required TResult Function() authorizationFailure,
    required TResult Function() dataAccess,
    required TResult Function() dataModification,
    required TResult Function() dataExport,
    required TResult Function() dataImport,
    required TResult Function() systemAccess,
    required TResult Function() configurationChange,
    required TResult Function() securityPolicyViolation,
    required TResult Function() suspiciousActivity,
    required TResult Function() threatDetected,
    required TResult Function() incident,
  }) {
    return login();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? login,
    TResult? Function()? logout,
    TResult? Function()? authenticationFailure,
    TResult? Function()? authorizationFailure,
    TResult? Function()? dataAccess,
    TResult? Function()? dataModification,
    TResult? Function()? dataExport,
    TResult? Function()? dataImport,
    TResult? Function()? systemAccess,
    TResult? Function()? configurationChange,
    TResult? Function()? securityPolicyViolation,
    TResult? Function()? suspiciousActivity,
    TResult? Function()? threatDetected,
    TResult? Function()? incident,
  }) {
    return login?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? login,
    TResult Function()? logout,
    TResult Function()? authenticationFailure,
    TResult Function()? authorizationFailure,
    TResult Function()? dataAccess,
    TResult Function()? dataModification,
    TResult Function()? dataExport,
    TResult Function()? dataImport,
    TResult Function()? systemAccess,
    TResult Function()? configurationChange,
    TResult Function()? securityPolicyViolation,
    TResult Function()? suspiciousActivity,
    TResult Function()? threatDetected,
    TResult Function()? incident,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginEvent value) login,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(AuthenticationFailureEvent value)
        authenticationFailure,
    required TResult Function(AuthorizationFailureEvent value)
        authorizationFailure,
    required TResult Function(DataAccessEvent value) dataAccess,
    required TResult Function(DataModificationEvent value) dataModification,
    required TResult Function(DataExportEvent value) dataExport,
    required TResult Function(DataImportEvent value) dataImport,
    required TResult Function(SystemAccessEvent value) systemAccess,
    required TResult Function(ConfigurationChangeEvent value)
        configurationChange,
    required TResult Function(SecurityPolicyViolationEvent value)
        securityPolicyViolation,
    required TResult Function(SuspiciousActivityEvent value) suspiciousActivity,
    required TResult Function(ThreatDetectedEvent value) threatDetected,
    required TResult Function(IncidentEvent value) incident,
  }) {
    return login(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginEvent value)? login,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult? Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult? Function(DataAccessEvent value)? dataAccess,
    TResult? Function(DataModificationEvent value)? dataModification,
    TResult? Function(DataExportEvent value)? dataExport,
    TResult? Function(DataImportEvent value)? dataImport,
    TResult? Function(SystemAccessEvent value)? systemAccess,
    TResult? Function(ConfigurationChangeEvent value)? configurationChange,
    TResult? Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult? Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult? Function(ThreatDetectedEvent value)? threatDetected,
    TResult? Function(IncidentEvent value)? incident,
  }) {
    return login?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginEvent value)? login,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult Function(DataAccessEvent value)? dataAccess,
    TResult Function(DataModificationEvent value)? dataModification,
    TResult Function(DataExportEvent value)? dataExport,
    TResult Function(DataImportEvent value)? dataImport,
    TResult Function(SystemAccessEvent value)? systemAccess,
    TResult Function(ConfigurationChangeEvent value)? configurationChange,
    TResult Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult Function(ThreatDetectedEvent value)? threatDetected,
    TResult Function(IncidentEvent value)? incident,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginEventImplToJson(
      this,
    );
  }
}

abstract class LoginEvent implements SecurityEventType {
  const factory LoginEvent() = _$LoginEventImpl;

  factory LoginEvent.fromJson(Map<String, dynamic> json) =
      _$LoginEventImpl.fromJson;
}

/// @nodoc
abstract class _$$LogoutEventImplCopyWith<$Res> {
  factory _$$LogoutEventImplCopyWith(
          _$LogoutEventImpl value, $Res Function(_$LogoutEventImpl) then) =
      __$$LogoutEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LogoutEventImplCopyWithImpl<$Res>
    extends _$SecurityEventTypeCopyWithImpl<$Res, _$LogoutEventImpl>
    implements _$$LogoutEventImplCopyWith<$Res> {
  __$$LogoutEventImplCopyWithImpl(
      _$LogoutEventImpl _value, $Res Function(_$LogoutEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityEventType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$LogoutEventImpl implements LogoutEvent {
  const _$LogoutEventImpl({final String? $type}) : $type = $type ?? 'logout';

  factory _$LogoutEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$LogoutEventImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SecurityEventType.logout()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LogoutEventImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() login,
    required TResult Function() logout,
    required TResult Function() authenticationFailure,
    required TResult Function() authorizationFailure,
    required TResult Function() dataAccess,
    required TResult Function() dataModification,
    required TResult Function() dataExport,
    required TResult Function() dataImport,
    required TResult Function() systemAccess,
    required TResult Function() configurationChange,
    required TResult Function() securityPolicyViolation,
    required TResult Function() suspiciousActivity,
    required TResult Function() threatDetected,
    required TResult Function() incident,
  }) {
    return logout();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? login,
    TResult? Function()? logout,
    TResult? Function()? authenticationFailure,
    TResult? Function()? authorizationFailure,
    TResult? Function()? dataAccess,
    TResult? Function()? dataModification,
    TResult? Function()? dataExport,
    TResult? Function()? dataImport,
    TResult? Function()? systemAccess,
    TResult? Function()? configurationChange,
    TResult? Function()? securityPolicyViolation,
    TResult? Function()? suspiciousActivity,
    TResult? Function()? threatDetected,
    TResult? Function()? incident,
  }) {
    return logout?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? login,
    TResult Function()? logout,
    TResult Function()? authenticationFailure,
    TResult Function()? authorizationFailure,
    TResult Function()? dataAccess,
    TResult Function()? dataModification,
    TResult Function()? dataExport,
    TResult Function()? dataImport,
    TResult Function()? systemAccess,
    TResult Function()? configurationChange,
    TResult Function()? securityPolicyViolation,
    TResult Function()? suspiciousActivity,
    TResult Function()? threatDetected,
    TResult Function()? incident,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginEvent value) login,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(AuthenticationFailureEvent value)
        authenticationFailure,
    required TResult Function(AuthorizationFailureEvent value)
        authorizationFailure,
    required TResult Function(DataAccessEvent value) dataAccess,
    required TResult Function(DataModificationEvent value) dataModification,
    required TResult Function(DataExportEvent value) dataExport,
    required TResult Function(DataImportEvent value) dataImport,
    required TResult Function(SystemAccessEvent value) systemAccess,
    required TResult Function(ConfigurationChangeEvent value)
        configurationChange,
    required TResult Function(SecurityPolicyViolationEvent value)
        securityPolicyViolation,
    required TResult Function(SuspiciousActivityEvent value) suspiciousActivity,
    required TResult Function(ThreatDetectedEvent value) threatDetected,
    required TResult Function(IncidentEvent value) incident,
  }) {
    return logout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginEvent value)? login,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult? Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult? Function(DataAccessEvent value)? dataAccess,
    TResult? Function(DataModificationEvent value)? dataModification,
    TResult? Function(DataExportEvent value)? dataExport,
    TResult? Function(DataImportEvent value)? dataImport,
    TResult? Function(SystemAccessEvent value)? systemAccess,
    TResult? Function(ConfigurationChangeEvent value)? configurationChange,
    TResult? Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult? Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult? Function(ThreatDetectedEvent value)? threatDetected,
    TResult? Function(IncidentEvent value)? incident,
  }) {
    return logout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginEvent value)? login,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult Function(DataAccessEvent value)? dataAccess,
    TResult Function(DataModificationEvent value)? dataModification,
    TResult Function(DataExportEvent value)? dataExport,
    TResult Function(DataImportEvent value)? dataImport,
    TResult Function(SystemAccessEvent value)? systemAccess,
    TResult Function(ConfigurationChangeEvent value)? configurationChange,
    TResult Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult Function(ThreatDetectedEvent value)? threatDetected,
    TResult Function(IncidentEvent value)? incident,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LogoutEventImplToJson(
      this,
    );
  }
}

abstract class LogoutEvent implements SecurityEventType {
  const factory LogoutEvent() = _$LogoutEventImpl;

  factory LogoutEvent.fromJson(Map<String, dynamic> json) =
      _$LogoutEventImpl.fromJson;
}

/// @nodoc
abstract class _$$AuthenticationFailureEventImplCopyWith<$Res> {
  factory _$$AuthenticationFailureEventImplCopyWith(
          _$AuthenticationFailureEventImpl value,
          $Res Function(_$AuthenticationFailureEventImpl) then) =
      __$$AuthenticationFailureEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationFailureEventImplCopyWithImpl<$Res>
    extends _$SecurityEventTypeCopyWithImpl<$Res,
        _$AuthenticationFailureEventImpl>
    implements _$$AuthenticationFailureEventImplCopyWith<$Res> {
  __$$AuthenticationFailureEventImplCopyWithImpl(
      _$AuthenticationFailureEventImpl _value,
      $Res Function(_$AuthenticationFailureEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityEventType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$AuthenticationFailureEventImpl implements AuthenticationFailureEvent {
  const _$AuthenticationFailureEventImpl({final String? $type})
      : $type = $type ?? 'authenticationFailure';

  factory _$AuthenticationFailureEventImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AuthenticationFailureEventImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SecurityEventType.authenticationFailure()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationFailureEventImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() login,
    required TResult Function() logout,
    required TResult Function() authenticationFailure,
    required TResult Function() authorizationFailure,
    required TResult Function() dataAccess,
    required TResult Function() dataModification,
    required TResult Function() dataExport,
    required TResult Function() dataImport,
    required TResult Function() systemAccess,
    required TResult Function() configurationChange,
    required TResult Function() securityPolicyViolation,
    required TResult Function() suspiciousActivity,
    required TResult Function() threatDetected,
    required TResult Function() incident,
  }) {
    return authenticationFailure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? login,
    TResult? Function()? logout,
    TResult? Function()? authenticationFailure,
    TResult? Function()? authorizationFailure,
    TResult? Function()? dataAccess,
    TResult? Function()? dataModification,
    TResult? Function()? dataExport,
    TResult? Function()? dataImport,
    TResult? Function()? systemAccess,
    TResult? Function()? configurationChange,
    TResult? Function()? securityPolicyViolation,
    TResult? Function()? suspiciousActivity,
    TResult? Function()? threatDetected,
    TResult? Function()? incident,
  }) {
    return authenticationFailure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? login,
    TResult Function()? logout,
    TResult Function()? authenticationFailure,
    TResult Function()? authorizationFailure,
    TResult Function()? dataAccess,
    TResult Function()? dataModification,
    TResult Function()? dataExport,
    TResult Function()? dataImport,
    TResult Function()? systemAccess,
    TResult Function()? configurationChange,
    TResult Function()? securityPolicyViolation,
    TResult Function()? suspiciousActivity,
    TResult Function()? threatDetected,
    TResult Function()? incident,
    required TResult orElse(),
  }) {
    if (authenticationFailure != null) {
      return authenticationFailure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginEvent value) login,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(AuthenticationFailureEvent value)
        authenticationFailure,
    required TResult Function(AuthorizationFailureEvent value)
        authorizationFailure,
    required TResult Function(DataAccessEvent value) dataAccess,
    required TResult Function(DataModificationEvent value) dataModification,
    required TResult Function(DataExportEvent value) dataExport,
    required TResult Function(DataImportEvent value) dataImport,
    required TResult Function(SystemAccessEvent value) systemAccess,
    required TResult Function(ConfigurationChangeEvent value)
        configurationChange,
    required TResult Function(SecurityPolicyViolationEvent value)
        securityPolicyViolation,
    required TResult Function(SuspiciousActivityEvent value) suspiciousActivity,
    required TResult Function(ThreatDetectedEvent value) threatDetected,
    required TResult Function(IncidentEvent value) incident,
  }) {
    return authenticationFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginEvent value)? login,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult? Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult? Function(DataAccessEvent value)? dataAccess,
    TResult? Function(DataModificationEvent value)? dataModification,
    TResult? Function(DataExportEvent value)? dataExport,
    TResult? Function(DataImportEvent value)? dataImport,
    TResult? Function(SystemAccessEvent value)? systemAccess,
    TResult? Function(ConfigurationChangeEvent value)? configurationChange,
    TResult? Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult? Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult? Function(ThreatDetectedEvent value)? threatDetected,
    TResult? Function(IncidentEvent value)? incident,
  }) {
    return authenticationFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginEvent value)? login,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult Function(DataAccessEvent value)? dataAccess,
    TResult Function(DataModificationEvent value)? dataModification,
    TResult Function(DataExportEvent value)? dataExport,
    TResult Function(DataImportEvent value)? dataImport,
    TResult Function(SystemAccessEvent value)? systemAccess,
    TResult Function(ConfigurationChangeEvent value)? configurationChange,
    TResult Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult Function(ThreatDetectedEvent value)? threatDetected,
    TResult Function(IncidentEvent value)? incident,
    required TResult orElse(),
  }) {
    if (authenticationFailure != null) {
      return authenticationFailure(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthenticationFailureEventImplToJson(
      this,
    );
  }
}

abstract class AuthenticationFailureEvent implements SecurityEventType {
  const factory AuthenticationFailureEvent() = _$AuthenticationFailureEventImpl;

  factory AuthenticationFailureEvent.fromJson(Map<String, dynamic> json) =
      _$AuthenticationFailureEventImpl.fromJson;
}

/// @nodoc
abstract class _$$AuthorizationFailureEventImplCopyWith<$Res> {
  factory _$$AuthorizationFailureEventImplCopyWith(
          _$AuthorizationFailureEventImpl value,
          $Res Function(_$AuthorizationFailureEventImpl) then) =
      __$$AuthorizationFailureEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthorizationFailureEventImplCopyWithImpl<$Res>
    extends _$SecurityEventTypeCopyWithImpl<$Res,
        _$AuthorizationFailureEventImpl>
    implements _$$AuthorizationFailureEventImplCopyWith<$Res> {
  __$$AuthorizationFailureEventImplCopyWithImpl(
      _$AuthorizationFailureEventImpl _value,
      $Res Function(_$AuthorizationFailureEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityEventType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$AuthorizationFailureEventImpl implements AuthorizationFailureEvent {
  const _$AuthorizationFailureEventImpl({final String? $type})
      : $type = $type ?? 'authorizationFailure';

  factory _$AuthorizationFailureEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthorizationFailureEventImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SecurityEventType.authorizationFailure()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthorizationFailureEventImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() login,
    required TResult Function() logout,
    required TResult Function() authenticationFailure,
    required TResult Function() authorizationFailure,
    required TResult Function() dataAccess,
    required TResult Function() dataModification,
    required TResult Function() dataExport,
    required TResult Function() dataImport,
    required TResult Function() systemAccess,
    required TResult Function() configurationChange,
    required TResult Function() securityPolicyViolation,
    required TResult Function() suspiciousActivity,
    required TResult Function() threatDetected,
    required TResult Function() incident,
  }) {
    return authorizationFailure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? login,
    TResult? Function()? logout,
    TResult? Function()? authenticationFailure,
    TResult? Function()? authorizationFailure,
    TResult? Function()? dataAccess,
    TResult? Function()? dataModification,
    TResult? Function()? dataExport,
    TResult? Function()? dataImport,
    TResult? Function()? systemAccess,
    TResult? Function()? configurationChange,
    TResult? Function()? securityPolicyViolation,
    TResult? Function()? suspiciousActivity,
    TResult? Function()? threatDetected,
    TResult? Function()? incident,
  }) {
    return authorizationFailure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? login,
    TResult Function()? logout,
    TResult Function()? authenticationFailure,
    TResult Function()? authorizationFailure,
    TResult Function()? dataAccess,
    TResult Function()? dataModification,
    TResult Function()? dataExport,
    TResult Function()? dataImport,
    TResult Function()? systemAccess,
    TResult Function()? configurationChange,
    TResult Function()? securityPolicyViolation,
    TResult Function()? suspiciousActivity,
    TResult Function()? threatDetected,
    TResult Function()? incident,
    required TResult orElse(),
  }) {
    if (authorizationFailure != null) {
      return authorizationFailure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginEvent value) login,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(AuthenticationFailureEvent value)
        authenticationFailure,
    required TResult Function(AuthorizationFailureEvent value)
        authorizationFailure,
    required TResult Function(DataAccessEvent value) dataAccess,
    required TResult Function(DataModificationEvent value) dataModification,
    required TResult Function(DataExportEvent value) dataExport,
    required TResult Function(DataImportEvent value) dataImport,
    required TResult Function(SystemAccessEvent value) systemAccess,
    required TResult Function(ConfigurationChangeEvent value)
        configurationChange,
    required TResult Function(SecurityPolicyViolationEvent value)
        securityPolicyViolation,
    required TResult Function(SuspiciousActivityEvent value) suspiciousActivity,
    required TResult Function(ThreatDetectedEvent value) threatDetected,
    required TResult Function(IncidentEvent value) incident,
  }) {
    return authorizationFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginEvent value)? login,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult? Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult? Function(DataAccessEvent value)? dataAccess,
    TResult? Function(DataModificationEvent value)? dataModification,
    TResult? Function(DataExportEvent value)? dataExport,
    TResult? Function(DataImportEvent value)? dataImport,
    TResult? Function(SystemAccessEvent value)? systemAccess,
    TResult? Function(ConfigurationChangeEvent value)? configurationChange,
    TResult? Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult? Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult? Function(ThreatDetectedEvent value)? threatDetected,
    TResult? Function(IncidentEvent value)? incident,
  }) {
    return authorizationFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginEvent value)? login,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult Function(DataAccessEvent value)? dataAccess,
    TResult Function(DataModificationEvent value)? dataModification,
    TResult Function(DataExportEvent value)? dataExport,
    TResult Function(DataImportEvent value)? dataImport,
    TResult Function(SystemAccessEvent value)? systemAccess,
    TResult Function(ConfigurationChangeEvent value)? configurationChange,
    TResult Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult Function(ThreatDetectedEvent value)? threatDetected,
    TResult Function(IncidentEvent value)? incident,
    required TResult orElse(),
  }) {
    if (authorizationFailure != null) {
      return authorizationFailure(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthorizationFailureEventImplToJson(
      this,
    );
  }
}

abstract class AuthorizationFailureEvent implements SecurityEventType {
  const factory AuthorizationFailureEvent() = _$AuthorizationFailureEventImpl;

  factory AuthorizationFailureEvent.fromJson(Map<String, dynamic> json) =
      _$AuthorizationFailureEventImpl.fromJson;
}

/// @nodoc
abstract class _$$DataAccessEventImplCopyWith<$Res> {
  factory _$$DataAccessEventImplCopyWith(_$DataAccessEventImpl value,
          $Res Function(_$DataAccessEventImpl) then) =
      __$$DataAccessEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DataAccessEventImplCopyWithImpl<$Res>
    extends _$SecurityEventTypeCopyWithImpl<$Res, _$DataAccessEventImpl>
    implements _$$DataAccessEventImplCopyWith<$Res> {
  __$$DataAccessEventImplCopyWithImpl(
      _$DataAccessEventImpl _value, $Res Function(_$DataAccessEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityEventType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$DataAccessEventImpl implements DataAccessEvent {
  const _$DataAccessEventImpl({final String? $type})
      : $type = $type ?? 'dataAccess';

  factory _$DataAccessEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataAccessEventImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SecurityEventType.dataAccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DataAccessEventImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() login,
    required TResult Function() logout,
    required TResult Function() authenticationFailure,
    required TResult Function() authorizationFailure,
    required TResult Function() dataAccess,
    required TResult Function() dataModification,
    required TResult Function() dataExport,
    required TResult Function() dataImport,
    required TResult Function() systemAccess,
    required TResult Function() configurationChange,
    required TResult Function() securityPolicyViolation,
    required TResult Function() suspiciousActivity,
    required TResult Function() threatDetected,
    required TResult Function() incident,
  }) {
    return dataAccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? login,
    TResult? Function()? logout,
    TResult? Function()? authenticationFailure,
    TResult? Function()? authorizationFailure,
    TResult? Function()? dataAccess,
    TResult? Function()? dataModification,
    TResult? Function()? dataExport,
    TResult? Function()? dataImport,
    TResult? Function()? systemAccess,
    TResult? Function()? configurationChange,
    TResult? Function()? securityPolicyViolation,
    TResult? Function()? suspiciousActivity,
    TResult? Function()? threatDetected,
    TResult? Function()? incident,
  }) {
    return dataAccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? login,
    TResult Function()? logout,
    TResult Function()? authenticationFailure,
    TResult Function()? authorizationFailure,
    TResult Function()? dataAccess,
    TResult Function()? dataModification,
    TResult Function()? dataExport,
    TResult Function()? dataImport,
    TResult Function()? systemAccess,
    TResult Function()? configurationChange,
    TResult Function()? securityPolicyViolation,
    TResult Function()? suspiciousActivity,
    TResult Function()? threatDetected,
    TResult Function()? incident,
    required TResult orElse(),
  }) {
    if (dataAccess != null) {
      return dataAccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginEvent value) login,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(AuthenticationFailureEvent value)
        authenticationFailure,
    required TResult Function(AuthorizationFailureEvent value)
        authorizationFailure,
    required TResult Function(DataAccessEvent value) dataAccess,
    required TResult Function(DataModificationEvent value) dataModification,
    required TResult Function(DataExportEvent value) dataExport,
    required TResult Function(DataImportEvent value) dataImport,
    required TResult Function(SystemAccessEvent value) systemAccess,
    required TResult Function(ConfigurationChangeEvent value)
        configurationChange,
    required TResult Function(SecurityPolicyViolationEvent value)
        securityPolicyViolation,
    required TResult Function(SuspiciousActivityEvent value) suspiciousActivity,
    required TResult Function(ThreatDetectedEvent value) threatDetected,
    required TResult Function(IncidentEvent value) incident,
  }) {
    return dataAccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginEvent value)? login,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult? Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult? Function(DataAccessEvent value)? dataAccess,
    TResult? Function(DataModificationEvent value)? dataModification,
    TResult? Function(DataExportEvent value)? dataExport,
    TResult? Function(DataImportEvent value)? dataImport,
    TResult? Function(SystemAccessEvent value)? systemAccess,
    TResult? Function(ConfigurationChangeEvent value)? configurationChange,
    TResult? Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult? Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult? Function(ThreatDetectedEvent value)? threatDetected,
    TResult? Function(IncidentEvent value)? incident,
  }) {
    return dataAccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginEvent value)? login,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult Function(DataAccessEvent value)? dataAccess,
    TResult Function(DataModificationEvent value)? dataModification,
    TResult Function(DataExportEvent value)? dataExport,
    TResult Function(DataImportEvent value)? dataImport,
    TResult Function(SystemAccessEvent value)? systemAccess,
    TResult Function(ConfigurationChangeEvent value)? configurationChange,
    TResult Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult Function(ThreatDetectedEvent value)? threatDetected,
    TResult Function(IncidentEvent value)? incident,
    required TResult orElse(),
  }) {
    if (dataAccess != null) {
      return dataAccess(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DataAccessEventImplToJson(
      this,
    );
  }
}

abstract class DataAccessEvent implements SecurityEventType {
  const factory DataAccessEvent() = _$DataAccessEventImpl;

  factory DataAccessEvent.fromJson(Map<String, dynamic> json) =
      _$DataAccessEventImpl.fromJson;
}

/// @nodoc
abstract class _$$DataModificationEventImplCopyWith<$Res> {
  factory _$$DataModificationEventImplCopyWith(
          _$DataModificationEventImpl value,
          $Res Function(_$DataModificationEventImpl) then) =
      __$$DataModificationEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DataModificationEventImplCopyWithImpl<$Res>
    extends _$SecurityEventTypeCopyWithImpl<$Res, _$DataModificationEventImpl>
    implements _$$DataModificationEventImplCopyWith<$Res> {
  __$$DataModificationEventImplCopyWithImpl(_$DataModificationEventImpl _value,
      $Res Function(_$DataModificationEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityEventType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$DataModificationEventImpl implements DataModificationEvent {
  const _$DataModificationEventImpl({final String? $type})
      : $type = $type ?? 'dataModification';

  factory _$DataModificationEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataModificationEventImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SecurityEventType.dataModification()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataModificationEventImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() login,
    required TResult Function() logout,
    required TResult Function() authenticationFailure,
    required TResult Function() authorizationFailure,
    required TResult Function() dataAccess,
    required TResult Function() dataModification,
    required TResult Function() dataExport,
    required TResult Function() dataImport,
    required TResult Function() systemAccess,
    required TResult Function() configurationChange,
    required TResult Function() securityPolicyViolation,
    required TResult Function() suspiciousActivity,
    required TResult Function() threatDetected,
    required TResult Function() incident,
  }) {
    return dataModification();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? login,
    TResult? Function()? logout,
    TResult? Function()? authenticationFailure,
    TResult? Function()? authorizationFailure,
    TResult? Function()? dataAccess,
    TResult? Function()? dataModification,
    TResult? Function()? dataExport,
    TResult? Function()? dataImport,
    TResult? Function()? systemAccess,
    TResult? Function()? configurationChange,
    TResult? Function()? securityPolicyViolation,
    TResult? Function()? suspiciousActivity,
    TResult? Function()? threatDetected,
    TResult? Function()? incident,
  }) {
    return dataModification?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? login,
    TResult Function()? logout,
    TResult Function()? authenticationFailure,
    TResult Function()? authorizationFailure,
    TResult Function()? dataAccess,
    TResult Function()? dataModification,
    TResult Function()? dataExport,
    TResult Function()? dataImport,
    TResult Function()? systemAccess,
    TResult Function()? configurationChange,
    TResult Function()? securityPolicyViolation,
    TResult Function()? suspiciousActivity,
    TResult Function()? threatDetected,
    TResult Function()? incident,
    required TResult orElse(),
  }) {
    if (dataModification != null) {
      return dataModification();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginEvent value) login,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(AuthenticationFailureEvent value)
        authenticationFailure,
    required TResult Function(AuthorizationFailureEvent value)
        authorizationFailure,
    required TResult Function(DataAccessEvent value) dataAccess,
    required TResult Function(DataModificationEvent value) dataModification,
    required TResult Function(DataExportEvent value) dataExport,
    required TResult Function(DataImportEvent value) dataImport,
    required TResult Function(SystemAccessEvent value) systemAccess,
    required TResult Function(ConfigurationChangeEvent value)
        configurationChange,
    required TResult Function(SecurityPolicyViolationEvent value)
        securityPolicyViolation,
    required TResult Function(SuspiciousActivityEvent value) suspiciousActivity,
    required TResult Function(ThreatDetectedEvent value) threatDetected,
    required TResult Function(IncidentEvent value) incident,
  }) {
    return dataModification(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginEvent value)? login,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult? Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult? Function(DataAccessEvent value)? dataAccess,
    TResult? Function(DataModificationEvent value)? dataModification,
    TResult? Function(DataExportEvent value)? dataExport,
    TResult? Function(DataImportEvent value)? dataImport,
    TResult? Function(SystemAccessEvent value)? systemAccess,
    TResult? Function(ConfigurationChangeEvent value)? configurationChange,
    TResult? Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult? Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult? Function(ThreatDetectedEvent value)? threatDetected,
    TResult? Function(IncidentEvent value)? incident,
  }) {
    return dataModification?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginEvent value)? login,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult Function(DataAccessEvent value)? dataAccess,
    TResult Function(DataModificationEvent value)? dataModification,
    TResult Function(DataExportEvent value)? dataExport,
    TResult Function(DataImportEvent value)? dataImport,
    TResult Function(SystemAccessEvent value)? systemAccess,
    TResult Function(ConfigurationChangeEvent value)? configurationChange,
    TResult Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult Function(ThreatDetectedEvent value)? threatDetected,
    TResult Function(IncidentEvent value)? incident,
    required TResult orElse(),
  }) {
    if (dataModification != null) {
      return dataModification(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DataModificationEventImplToJson(
      this,
    );
  }
}

abstract class DataModificationEvent implements SecurityEventType {
  const factory DataModificationEvent() = _$DataModificationEventImpl;

  factory DataModificationEvent.fromJson(Map<String, dynamic> json) =
      _$DataModificationEventImpl.fromJson;
}

/// @nodoc
abstract class _$$DataExportEventImplCopyWith<$Res> {
  factory _$$DataExportEventImplCopyWith(_$DataExportEventImpl value,
          $Res Function(_$DataExportEventImpl) then) =
      __$$DataExportEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DataExportEventImplCopyWithImpl<$Res>
    extends _$SecurityEventTypeCopyWithImpl<$Res, _$DataExportEventImpl>
    implements _$$DataExportEventImplCopyWith<$Res> {
  __$$DataExportEventImplCopyWithImpl(
      _$DataExportEventImpl _value, $Res Function(_$DataExportEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityEventType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$DataExportEventImpl implements DataExportEvent {
  const _$DataExportEventImpl({final String? $type})
      : $type = $type ?? 'dataExport';

  factory _$DataExportEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataExportEventImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SecurityEventType.dataExport()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DataExportEventImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() login,
    required TResult Function() logout,
    required TResult Function() authenticationFailure,
    required TResult Function() authorizationFailure,
    required TResult Function() dataAccess,
    required TResult Function() dataModification,
    required TResult Function() dataExport,
    required TResult Function() dataImport,
    required TResult Function() systemAccess,
    required TResult Function() configurationChange,
    required TResult Function() securityPolicyViolation,
    required TResult Function() suspiciousActivity,
    required TResult Function() threatDetected,
    required TResult Function() incident,
  }) {
    return dataExport();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? login,
    TResult? Function()? logout,
    TResult? Function()? authenticationFailure,
    TResult? Function()? authorizationFailure,
    TResult? Function()? dataAccess,
    TResult? Function()? dataModification,
    TResult? Function()? dataExport,
    TResult? Function()? dataImport,
    TResult? Function()? systemAccess,
    TResult? Function()? configurationChange,
    TResult? Function()? securityPolicyViolation,
    TResult? Function()? suspiciousActivity,
    TResult? Function()? threatDetected,
    TResult? Function()? incident,
  }) {
    return dataExport?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? login,
    TResult Function()? logout,
    TResult Function()? authenticationFailure,
    TResult Function()? authorizationFailure,
    TResult Function()? dataAccess,
    TResult Function()? dataModification,
    TResult Function()? dataExport,
    TResult Function()? dataImport,
    TResult Function()? systemAccess,
    TResult Function()? configurationChange,
    TResult Function()? securityPolicyViolation,
    TResult Function()? suspiciousActivity,
    TResult Function()? threatDetected,
    TResult Function()? incident,
    required TResult orElse(),
  }) {
    if (dataExport != null) {
      return dataExport();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginEvent value) login,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(AuthenticationFailureEvent value)
        authenticationFailure,
    required TResult Function(AuthorizationFailureEvent value)
        authorizationFailure,
    required TResult Function(DataAccessEvent value) dataAccess,
    required TResult Function(DataModificationEvent value) dataModification,
    required TResult Function(DataExportEvent value) dataExport,
    required TResult Function(DataImportEvent value) dataImport,
    required TResult Function(SystemAccessEvent value) systemAccess,
    required TResult Function(ConfigurationChangeEvent value)
        configurationChange,
    required TResult Function(SecurityPolicyViolationEvent value)
        securityPolicyViolation,
    required TResult Function(SuspiciousActivityEvent value) suspiciousActivity,
    required TResult Function(ThreatDetectedEvent value) threatDetected,
    required TResult Function(IncidentEvent value) incident,
  }) {
    return dataExport(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginEvent value)? login,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult? Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult? Function(DataAccessEvent value)? dataAccess,
    TResult? Function(DataModificationEvent value)? dataModification,
    TResult? Function(DataExportEvent value)? dataExport,
    TResult? Function(DataImportEvent value)? dataImport,
    TResult? Function(SystemAccessEvent value)? systemAccess,
    TResult? Function(ConfigurationChangeEvent value)? configurationChange,
    TResult? Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult? Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult? Function(ThreatDetectedEvent value)? threatDetected,
    TResult? Function(IncidentEvent value)? incident,
  }) {
    return dataExport?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginEvent value)? login,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult Function(DataAccessEvent value)? dataAccess,
    TResult Function(DataModificationEvent value)? dataModification,
    TResult Function(DataExportEvent value)? dataExport,
    TResult Function(DataImportEvent value)? dataImport,
    TResult Function(SystemAccessEvent value)? systemAccess,
    TResult Function(ConfigurationChangeEvent value)? configurationChange,
    TResult Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult Function(ThreatDetectedEvent value)? threatDetected,
    TResult Function(IncidentEvent value)? incident,
    required TResult orElse(),
  }) {
    if (dataExport != null) {
      return dataExport(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DataExportEventImplToJson(
      this,
    );
  }
}

abstract class DataExportEvent implements SecurityEventType {
  const factory DataExportEvent() = _$DataExportEventImpl;

  factory DataExportEvent.fromJson(Map<String, dynamic> json) =
      _$DataExportEventImpl.fromJson;
}

/// @nodoc
abstract class _$$DataImportEventImplCopyWith<$Res> {
  factory _$$DataImportEventImplCopyWith(_$DataImportEventImpl value,
          $Res Function(_$DataImportEventImpl) then) =
      __$$DataImportEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DataImportEventImplCopyWithImpl<$Res>
    extends _$SecurityEventTypeCopyWithImpl<$Res, _$DataImportEventImpl>
    implements _$$DataImportEventImplCopyWith<$Res> {
  __$$DataImportEventImplCopyWithImpl(
      _$DataImportEventImpl _value, $Res Function(_$DataImportEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityEventType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$DataImportEventImpl implements DataImportEvent {
  const _$DataImportEventImpl({final String? $type})
      : $type = $type ?? 'dataImport';

  factory _$DataImportEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataImportEventImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SecurityEventType.dataImport()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DataImportEventImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() login,
    required TResult Function() logout,
    required TResult Function() authenticationFailure,
    required TResult Function() authorizationFailure,
    required TResult Function() dataAccess,
    required TResult Function() dataModification,
    required TResult Function() dataExport,
    required TResult Function() dataImport,
    required TResult Function() systemAccess,
    required TResult Function() configurationChange,
    required TResult Function() securityPolicyViolation,
    required TResult Function() suspiciousActivity,
    required TResult Function() threatDetected,
    required TResult Function() incident,
  }) {
    return dataImport();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? login,
    TResult? Function()? logout,
    TResult? Function()? authenticationFailure,
    TResult? Function()? authorizationFailure,
    TResult? Function()? dataAccess,
    TResult? Function()? dataModification,
    TResult? Function()? dataExport,
    TResult? Function()? dataImport,
    TResult? Function()? systemAccess,
    TResult? Function()? configurationChange,
    TResult? Function()? securityPolicyViolation,
    TResult? Function()? suspiciousActivity,
    TResult? Function()? threatDetected,
    TResult? Function()? incident,
  }) {
    return dataImport?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? login,
    TResult Function()? logout,
    TResult Function()? authenticationFailure,
    TResult Function()? authorizationFailure,
    TResult Function()? dataAccess,
    TResult Function()? dataModification,
    TResult Function()? dataExport,
    TResult Function()? dataImport,
    TResult Function()? systemAccess,
    TResult Function()? configurationChange,
    TResult Function()? securityPolicyViolation,
    TResult Function()? suspiciousActivity,
    TResult Function()? threatDetected,
    TResult Function()? incident,
    required TResult orElse(),
  }) {
    if (dataImport != null) {
      return dataImport();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginEvent value) login,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(AuthenticationFailureEvent value)
        authenticationFailure,
    required TResult Function(AuthorizationFailureEvent value)
        authorizationFailure,
    required TResult Function(DataAccessEvent value) dataAccess,
    required TResult Function(DataModificationEvent value) dataModification,
    required TResult Function(DataExportEvent value) dataExport,
    required TResult Function(DataImportEvent value) dataImport,
    required TResult Function(SystemAccessEvent value) systemAccess,
    required TResult Function(ConfigurationChangeEvent value)
        configurationChange,
    required TResult Function(SecurityPolicyViolationEvent value)
        securityPolicyViolation,
    required TResult Function(SuspiciousActivityEvent value) suspiciousActivity,
    required TResult Function(ThreatDetectedEvent value) threatDetected,
    required TResult Function(IncidentEvent value) incident,
  }) {
    return dataImport(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginEvent value)? login,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult? Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult? Function(DataAccessEvent value)? dataAccess,
    TResult? Function(DataModificationEvent value)? dataModification,
    TResult? Function(DataExportEvent value)? dataExport,
    TResult? Function(DataImportEvent value)? dataImport,
    TResult? Function(SystemAccessEvent value)? systemAccess,
    TResult? Function(ConfigurationChangeEvent value)? configurationChange,
    TResult? Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult? Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult? Function(ThreatDetectedEvent value)? threatDetected,
    TResult? Function(IncidentEvent value)? incident,
  }) {
    return dataImport?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginEvent value)? login,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult Function(DataAccessEvent value)? dataAccess,
    TResult Function(DataModificationEvent value)? dataModification,
    TResult Function(DataExportEvent value)? dataExport,
    TResult Function(DataImportEvent value)? dataImport,
    TResult Function(SystemAccessEvent value)? systemAccess,
    TResult Function(ConfigurationChangeEvent value)? configurationChange,
    TResult Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult Function(ThreatDetectedEvent value)? threatDetected,
    TResult Function(IncidentEvent value)? incident,
    required TResult orElse(),
  }) {
    if (dataImport != null) {
      return dataImport(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DataImportEventImplToJson(
      this,
    );
  }
}

abstract class DataImportEvent implements SecurityEventType {
  const factory DataImportEvent() = _$DataImportEventImpl;

  factory DataImportEvent.fromJson(Map<String, dynamic> json) =
      _$DataImportEventImpl.fromJson;
}

/// @nodoc
abstract class _$$SystemAccessEventImplCopyWith<$Res> {
  factory _$$SystemAccessEventImplCopyWith(_$SystemAccessEventImpl value,
          $Res Function(_$SystemAccessEventImpl) then) =
      __$$SystemAccessEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SystemAccessEventImplCopyWithImpl<$Res>
    extends _$SecurityEventTypeCopyWithImpl<$Res, _$SystemAccessEventImpl>
    implements _$$SystemAccessEventImplCopyWith<$Res> {
  __$$SystemAccessEventImplCopyWithImpl(_$SystemAccessEventImpl _value,
      $Res Function(_$SystemAccessEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityEventType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$SystemAccessEventImpl implements SystemAccessEvent {
  const _$SystemAccessEventImpl({final String? $type})
      : $type = $type ?? 'systemAccess';

  factory _$SystemAccessEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$SystemAccessEventImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SecurityEventType.systemAccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SystemAccessEventImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() login,
    required TResult Function() logout,
    required TResult Function() authenticationFailure,
    required TResult Function() authorizationFailure,
    required TResult Function() dataAccess,
    required TResult Function() dataModification,
    required TResult Function() dataExport,
    required TResult Function() dataImport,
    required TResult Function() systemAccess,
    required TResult Function() configurationChange,
    required TResult Function() securityPolicyViolation,
    required TResult Function() suspiciousActivity,
    required TResult Function() threatDetected,
    required TResult Function() incident,
  }) {
    return systemAccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? login,
    TResult? Function()? logout,
    TResult? Function()? authenticationFailure,
    TResult? Function()? authorizationFailure,
    TResult? Function()? dataAccess,
    TResult? Function()? dataModification,
    TResult? Function()? dataExport,
    TResult? Function()? dataImport,
    TResult? Function()? systemAccess,
    TResult? Function()? configurationChange,
    TResult? Function()? securityPolicyViolation,
    TResult? Function()? suspiciousActivity,
    TResult? Function()? threatDetected,
    TResult? Function()? incident,
  }) {
    return systemAccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? login,
    TResult Function()? logout,
    TResult Function()? authenticationFailure,
    TResult Function()? authorizationFailure,
    TResult Function()? dataAccess,
    TResult Function()? dataModification,
    TResult Function()? dataExport,
    TResult Function()? dataImport,
    TResult Function()? systemAccess,
    TResult Function()? configurationChange,
    TResult Function()? securityPolicyViolation,
    TResult Function()? suspiciousActivity,
    TResult Function()? threatDetected,
    TResult Function()? incident,
    required TResult orElse(),
  }) {
    if (systemAccess != null) {
      return systemAccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginEvent value) login,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(AuthenticationFailureEvent value)
        authenticationFailure,
    required TResult Function(AuthorizationFailureEvent value)
        authorizationFailure,
    required TResult Function(DataAccessEvent value) dataAccess,
    required TResult Function(DataModificationEvent value) dataModification,
    required TResult Function(DataExportEvent value) dataExport,
    required TResult Function(DataImportEvent value) dataImport,
    required TResult Function(SystemAccessEvent value) systemAccess,
    required TResult Function(ConfigurationChangeEvent value)
        configurationChange,
    required TResult Function(SecurityPolicyViolationEvent value)
        securityPolicyViolation,
    required TResult Function(SuspiciousActivityEvent value) suspiciousActivity,
    required TResult Function(ThreatDetectedEvent value) threatDetected,
    required TResult Function(IncidentEvent value) incident,
  }) {
    return systemAccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginEvent value)? login,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult? Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult? Function(DataAccessEvent value)? dataAccess,
    TResult? Function(DataModificationEvent value)? dataModification,
    TResult? Function(DataExportEvent value)? dataExport,
    TResult? Function(DataImportEvent value)? dataImport,
    TResult? Function(SystemAccessEvent value)? systemAccess,
    TResult? Function(ConfigurationChangeEvent value)? configurationChange,
    TResult? Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult? Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult? Function(ThreatDetectedEvent value)? threatDetected,
    TResult? Function(IncidentEvent value)? incident,
  }) {
    return systemAccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginEvent value)? login,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult Function(DataAccessEvent value)? dataAccess,
    TResult Function(DataModificationEvent value)? dataModification,
    TResult Function(DataExportEvent value)? dataExport,
    TResult Function(DataImportEvent value)? dataImport,
    TResult Function(SystemAccessEvent value)? systemAccess,
    TResult Function(ConfigurationChangeEvent value)? configurationChange,
    TResult Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult Function(ThreatDetectedEvent value)? threatDetected,
    TResult Function(IncidentEvent value)? incident,
    required TResult orElse(),
  }) {
    if (systemAccess != null) {
      return systemAccess(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SystemAccessEventImplToJson(
      this,
    );
  }
}

abstract class SystemAccessEvent implements SecurityEventType {
  const factory SystemAccessEvent() = _$SystemAccessEventImpl;

  factory SystemAccessEvent.fromJson(Map<String, dynamic> json) =
      _$SystemAccessEventImpl.fromJson;
}

/// @nodoc
abstract class _$$ConfigurationChangeEventImplCopyWith<$Res> {
  factory _$$ConfigurationChangeEventImplCopyWith(
          _$ConfigurationChangeEventImpl value,
          $Res Function(_$ConfigurationChangeEventImpl) then) =
      __$$ConfigurationChangeEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConfigurationChangeEventImplCopyWithImpl<$Res>
    extends _$SecurityEventTypeCopyWithImpl<$Res,
        _$ConfigurationChangeEventImpl>
    implements _$$ConfigurationChangeEventImplCopyWith<$Res> {
  __$$ConfigurationChangeEventImplCopyWithImpl(
      _$ConfigurationChangeEventImpl _value,
      $Res Function(_$ConfigurationChangeEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityEventType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$ConfigurationChangeEventImpl implements ConfigurationChangeEvent {
  const _$ConfigurationChangeEventImpl({final String? $type})
      : $type = $type ?? 'configurationChange';

  factory _$ConfigurationChangeEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfigurationChangeEventImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SecurityEventType.configurationChange()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigurationChangeEventImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() login,
    required TResult Function() logout,
    required TResult Function() authenticationFailure,
    required TResult Function() authorizationFailure,
    required TResult Function() dataAccess,
    required TResult Function() dataModification,
    required TResult Function() dataExport,
    required TResult Function() dataImport,
    required TResult Function() systemAccess,
    required TResult Function() configurationChange,
    required TResult Function() securityPolicyViolation,
    required TResult Function() suspiciousActivity,
    required TResult Function() threatDetected,
    required TResult Function() incident,
  }) {
    return configurationChange();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? login,
    TResult? Function()? logout,
    TResult? Function()? authenticationFailure,
    TResult? Function()? authorizationFailure,
    TResult? Function()? dataAccess,
    TResult? Function()? dataModification,
    TResult? Function()? dataExport,
    TResult? Function()? dataImport,
    TResult? Function()? systemAccess,
    TResult? Function()? configurationChange,
    TResult? Function()? securityPolicyViolation,
    TResult? Function()? suspiciousActivity,
    TResult? Function()? threatDetected,
    TResult? Function()? incident,
  }) {
    return configurationChange?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? login,
    TResult Function()? logout,
    TResult Function()? authenticationFailure,
    TResult Function()? authorizationFailure,
    TResult Function()? dataAccess,
    TResult Function()? dataModification,
    TResult Function()? dataExport,
    TResult Function()? dataImport,
    TResult Function()? systemAccess,
    TResult Function()? configurationChange,
    TResult Function()? securityPolicyViolation,
    TResult Function()? suspiciousActivity,
    TResult Function()? threatDetected,
    TResult Function()? incident,
    required TResult orElse(),
  }) {
    if (configurationChange != null) {
      return configurationChange();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginEvent value) login,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(AuthenticationFailureEvent value)
        authenticationFailure,
    required TResult Function(AuthorizationFailureEvent value)
        authorizationFailure,
    required TResult Function(DataAccessEvent value) dataAccess,
    required TResult Function(DataModificationEvent value) dataModification,
    required TResult Function(DataExportEvent value) dataExport,
    required TResult Function(DataImportEvent value) dataImport,
    required TResult Function(SystemAccessEvent value) systemAccess,
    required TResult Function(ConfigurationChangeEvent value)
        configurationChange,
    required TResult Function(SecurityPolicyViolationEvent value)
        securityPolicyViolation,
    required TResult Function(SuspiciousActivityEvent value) suspiciousActivity,
    required TResult Function(ThreatDetectedEvent value) threatDetected,
    required TResult Function(IncidentEvent value) incident,
  }) {
    return configurationChange(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginEvent value)? login,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult? Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult? Function(DataAccessEvent value)? dataAccess,
    TResult? Function(DataModificationEvent value)? dataModification,
    TResult? Function(DataExportEvent value)? dataExport,
    TResult? Function(DataImportEvent value)? dataImport,
    TResult? Function(SystemAccessEvent value)? systemAccess,
    TResult? Function(ConfigurationChangeEvent value)? configurationChange,
    TResult? Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult? Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult? Function(ThreatDetectedEvent value)? threatDetected,
    TResult? Function(IncidentEvent value)? incident,
  }) {
    return configurationChange?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginEvent value)? login,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult Function(DataAccessEvent value)? dataAccess,
    TResult Function(DataModificationEvent value)? dataModification,
    TResult Function(DataExportEvent value)? dataExport,
    TResult Function(DataImportEvent value)? dataImport,
    TResult Function(SystemAccessEvent value)? systemAccess,
    TResult Function(ConfigurationChangeEvent value)? configurationChange,
    TResult Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult Function(ThreatDetectedEvent value)? threatDetected,
    TResult Function(IncidentEvent value)? incident,
    required TResult orElse(),
  }) {
    if (configurationChange != null) {
      return configurationChange(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfigurationChangeEventImplToJson(
      this,
    );
  }
}

abstract class ConfigurationChangeEvent implements SecurityEventType {
  const factory ConfigurationChangeEvent() = _$ConfigurationChangeEventImpl;

  factory ConfigurationChangeEvent.fromJson(Map<String, dynamic> json) =
      _$ConfigurationChangeEventImpl.fromJson;
}

/// @nodoc
abstract class _$$SecurityPolicyViolationEventImplCopyWith<$Res> {
  factory _$$SecurityPolicyViolationEventImplCopyWith(
          _$SecurityPolicyViolationEventImpl value,
          $Res Function(_$SecurityPolicyViolationEventImpl) then) =
      __$$SecurityPolicyViolationEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SecurityPolicyViolationEventImplCopyWithImpl<$Res>
    extends _$SecurityEventTypeCopyWithImpl<$Res,
        _$SecurityPolicyViolationEventImpl>
    implements _$$SecurityPolicyViolationEventImplCopyWith<$Res> {
  __$$SecurityPolicyViolationEventImplCopyWithImpl(
      _$SecurityPolicyViolationEventImpl _value,
      $Res Function(_$SecurityPolicyViolationEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityEventType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$SecurityPolicyViolationEventImpl
    implements SecurityPolicyViolationEvent {
  const _$SecurityPolicyViolationEventImpl({final String? $type})
      : $type = $type ?? 'securityPolicyViolation';

  factory _$SecurityPolicyViolationEventImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SecurityPolicyViolationEventImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SecurityEventType.securityPolicyViolation()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecurityPolicyViolationEventImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() login,
    required TResult Function() logout,
    required TResult Function() authenticationFailure,
    required TResult Function() authorizationFailure,
    required TResult Function() dataAccess,
    required TResult Function() dataModification,
    required TResult Function() dataExport,
    required TResult Function() dataImport,
    required TResult Function() systemAccess,
    required TResult Function() configurationChange,
    required TResult Function() securityPolicyViolation,
    required TResult Function() suspiciousActivity,
    required TResult Function() threatDetected,
    required TResult Function() incident,
  }) {
    return securityPolicyViolation();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? login,
    TResult? Function()? logout,
    TResult? Function()? authenticationFailure,
    TResult? Function()? authorizationFailure,
    TResult? Function()? dataAccess,
    TResult? Function()? dataModification,
    TResult? Function()? dataExport,
    TResult? Function()? dataImport,
    TResult? Function()? systemAccess,
    TResult? Function()? configurationChange,
    TResult? Function()? securityPolicyViolation,
    TResult? Function()? suspiciousActivity,
    TResult? Function()? threatDetected,
    TResult? Function()? incident,
  }) {
    return securityPolicyViolation?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? login,
    TResult Function()? logout,
    TResult Function()? authenticationFailure,
    TResult Function()? authorizationFailure,
    TResult Function()? dataAccess,
    TResult Function()? dataModification,
    TResult Function()? dataExport,
    TResult Function()? dataImport,
    TResult Function()? systemAccess,
    TResult Function()? configurationChange,
    TResult Function()? securityPolicyViolation,
    TResult Function()? suspiciousActivity,
    TResult Function()? threatDetected,
    TResult Function()? incident,
    required TResult orElse(),
  }) {
    if (securityPolicyViolation != null) {
      return securityPolicyViolation();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginEvent value) login,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(AuthenticationFailureEvent value)
        authenticationFailure,
    required TResult Function(AuthorizationFailureEvent value)
        authorizationFailure,
    required TResult Function(DataAccessEvent value) dataAccess,
    required TResult Function(DataModificationEvent value) dataModification,
    required TResult Function(DataExportEvent value) dataExport,
    required TResult Function(DataImportEvent value) dataImport,
    required TResult Function(SystemAccessEvent value) systemAccess,
    required TResult Function(ConfigurationChangeEvent value)
        configurationChange,
    required TResult Function(SecurityPolicyViolationEvent value)
        securityPolicyViolation,
    required TResult Function(SuspiciousActivityEvent value) suspiciousActivity,
    required TResult Function(ThreatDetectedEvent value) threatDetected,
    required TResult Function(IncidentEvent value) incident,
  }) {
    return securityPolicyViolation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginEvent value)? login,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult? Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult? Function(DataAccessEvent value)? dataAccess,
    TResult? Function(DataModificationEvent value)? dataModification,
    TResult? Function(DataExportEvent value)? dataExport,
    TResult? Function(DataImportEvent value)? dataImport,
    TResult? Function(SystemAccessEvent value)? systemAccess,
    TResult? Function(ConfigurationChangeEvent value)? configurationChange,
    TResult? Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult? Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult? Function(ThreatDetectedEvent value)? threatDetected,
    TResult? Function(IncidentEvent value)? incident,
  }) {
    return securityPolicyViolation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginEvent value)? login,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult Function(DataAccessEvent value)? dataAccess,
    TResult Function(DataModificationEvent value)? dataModification,
    TResult Function(DataExportEvent value)? dataExport,
    TResult Function(DataImportEvent value)? dataImport,
    TResult Function(SystemAccessEvent value)? systemAccess,
    TResult Function(ConfigurationChangeEvent value)? configurationChange,
    TResult Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult Function(ThreatDetectedEvent value)? threatDetected,
    TResult Function(IncidentEvent value)? incident,
    required TResult orElse(),
  }) {
    if (securityPolicyViolation != null) {
      return securityPolicyViolation(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SecurityPolicyViolationEventImplToJson(
      this,
    );
  }
}

abstract class SecurityPolicyViolationEvent implements SecurityEventType {
  const factory SecurityPolicyViolationEvent() =
      _$SecurityPolicyViolationEventImpl;

  factory SecurityPolicyViolationEvent.fromJson(Map<String, dynamic> json) =
      _$SecurityPolicyViolationEventImpl.fromJson;
}

/// @nodoc
abstract class _$$SuspiciousActivityEventImplCopyWith<$Res> {
  factory _$$SuspiciousActivityEventImplCopyWith(
          _$SuspiciousActivityEventImpl value,
          $Res Function(_$SuspiciousActivityEventImpl) then) =
      __$$SuspiciousActivityEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SuspiciousActivityEventImplCopyWithImpl<$Res>
    extends _$SecurityEventTypeCopyWithImpl<$Res, _$SuspiciousActivityEventImpl>
    implements _$$SuspiciousActivityEventImplCopyWith<$Res> {
  __$$SuspiciousActivityEventImplCopyWithImpl(
      _$SuspiciousActivityEventImpl _value,
      $Res Function(_$SuspiciousActivityEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityEventType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$SuspiciousActivityEventImpl implements SuspiciousActivityEvent {
  const _$SuspiciousActivityEventImpl({final String? $type})
      : $type = $type ?? 'suspiciousActivity';

  factory _$SuspiciousActivityEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$SuspiciousActivityEventImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SecurityEventType.suspiciousActivity()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuspiciousActivityEventImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() login,
    required TResult Function() logout,
    required TResult Function() authenticationFailure,
    required TResult Function() authorizationFailure,
    required TResult Function() dataAccess,
    required TResult Function() dataModification,
    required TResult Function() dataExport,
    required TResult Function() dataImport,
    required TResult Function() systemAccess,
    required TResult Function() configurationChange,
    required TResult Function() securityPolicyViolation,
    required TResult Function() suspiciousActivity,
    required TResult Function() threatDetected,
    required TResult Function() incident,
  }) {
    return suspiciousActivity();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? login,
    TResult? Function()? logout,
    TResult? Function()? authenticationFailure,
    TResult? Function()? authorizationFailure,
    TResult? Function()? dataAccess,
    TResult? Function()? dataModification,
    TResult? Function()? dataExport,
    TResult? Function()? dataImport,
    TResult? Function()? systemAccess,
    TResult? Function()? configurationChange,
    TResult? Function()? securityPolicyViolation,
    TResult? Function()? suspiciousActivity,
    TResult? Function()? threatDetected,
    TResult? Function()? incident,
  }) {
    return suspiciousActivity?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? login,
    TResult Function()? logout,
    TResult Function()? authenticationFailure,
    TResult Function()? authorizationFailure,
    TResult Function()? dataAccess,
    TResult Function()? dataModification,
    TResult Function()? dataExport,
    TResult Function()? dataImport,
    TResult Function()? systemAccess,
    TResult Function()? configurationChange,
    TResult Function()? securityPolicyViolation,
    TResult Function()? suspiciousActivity,
    TResult Function()? threatDetected,
    TResult Function()? incident,
    required TResult orElse(),
  }) {
    if (suspiciousActivity != null) {
      return suspiciousActivity();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginEvent value) login,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(AuthenticationFailureEvent value)
        authenticationFailure,
    required TResult Function(AuthorizationFailureEvent value)
        authorizationFailure,
    required TResult Function(DataAccessEvent value) dataAccess,
    required TResult Function(DataModificationEvent value) dataModification,
    required TResult Function(DataExportEvent value) dataExport,
    required TResult Function(DataImportEvent value) dataImport,
    required TResult Function(SystemAccessEvent value) systemAccess,
    required TResult Function(ConfigurationChangeEvent value)
        configurationChange,
    required TResult Function(SecurityPolicyViolationEvent value)
        securityPolicyViolation,
    required TResult Function(SuspiciousActivityEvent value) suspiciousActivity,
    required TResult Function(ThreatDetectedEvent value) threatDetected,
    required TResult Function(IncidentEvent value) incident,
  }) {
    return suspiciousActivity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginEvent value)? login,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult? Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult? Function(DataAccessEvent value)? dataAccess,
    TResult? Function(DataModificationEvent value)? dataModification,
    TResult? Function(DataExportEvent value)? dataExport,
    TResult? Function(DataImportEvent value)? dataImport,
    TResult? Function(SystemAccessEvent value)? systemAccess,
    TResult? Function(ConfigurationChangeEvent value)? configurationChange,
    TResult? Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult? Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult? Function(ThreatDetectedEvent value)? threatDetected,
    TResult? Function(IncidentEvent value)? incident,
  }) {
    return suspiciousActivity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginEvent value)? login,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult Function(DataAccessEvent value)? dataAccess,
    TResult Function(DataModificationEvent value)? dataModification,
    TResult Function(DataExportEvent value)? dataExport,
    TResult Function(DataImportEvent value)? dataImport,
    TResult Function(SystemAccessEvent value)? systemAccess,
    TResult Function(ConfigurationChangeEvent value)? configurationChange,
    TResult Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult Function(ThreatDetectedEvent value)? threatDetected,
    TResult Function(IncidentEvent value)? incident,
    required TResult orElse(),
  }) {
    if (suspiciousActivity != null) {
      return suspiciousActivity(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SuspiciousActivityEventImplToJson(
      this,
    );
  }
}

abstract class SuspiciousActivityEvent implements SecurityEventType {
  const factory SuspiciousActivityEvent() = _$SuspiciousActivityEventImpl;

  factory SuspiciousActivityEvent.fromJson(Map<String, dynamic> json) =
      _$SuspiciousActivityEventImpl.fromJson;
}

/// @nodoc
abstract class _$$ThreatDetectedEventImplCopyWith<$Res> {
  factory _$$ThreatDetectedEventImplCopyWith(_$ThreatDetectedEventImpl value,
          $Res Function(_$ThreatDetectedEventImpl) then) =
      __$$ThreatDetectedEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ThreatDetectedEventImplCopyWithImpl<$Res>
    extends _$SecurityEventTypeCopyWithImpl<$Res, _$ThreatDetectedEventImpl>
    implements _$$ThreatDetectedEventImplCopyWith<$Res> {
  __$$ThreatDetectedEventImplCopyWithImpl(_$ThreatDetectedEventImpl _value,
      $Res Function(_$ThreatDetectedEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityEventType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$ThreatDetectedEventImpl implements ThreatDetectedEvent {
  const _$ThreatDetectedEventImpl({final String? $type})
      : $type = $type ?? 'threatDetected';

  factory _$ThreatDetectedEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThreatDetectedEventImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SecurityEventType.threatDetected()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThreatDetectedEventImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() login,
    required TResult Function() logout,
    required TResult Function() authenticationFailure,
    required TResult Function() authorizationFailure,
    required TResult Function() dataAccess,
    required TResult Function() dataModification,
    required TResult Function() dataExport,
    required TResult Function() dataImport,
    required TResult Function() systemAccess,
    required TResult Function() configurationChange,
    required TResult Function() securityPolicyViolation,
    required TResult Function() suspiciousActivity,
    required TResult Function() threatDetected,
    required TResult Function() incident,
  }) {
    return threatDetected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? login,
    TResult? Function()? logout,
    TResult? Function()? authenticationFailure,
    TResult? Function()? authorizationFailure,
    TResult? Function()? dataAccess,
    TResult? Function()? dataModification,
    TResult? Function()? dataExport,
    TResult? Function()? dataImport,
    TResult? Function()? systemAccess,
    TResult? Function()? configurationChange,
    TResult? Function()? securityPolicyViolation,
    TResult? Function()? suspiciousActivity,
    TResult? Function()? threatDetected,
    TResult? Function()? incident,
  }) {
    return threatDetected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? login,
    TResult Function()? logout,
    TResult Function()? authenticationFailure,
    TResult Function()? authorizationFailure,
    TResult Function()? dataAccess,
    TResult Function()? dataModification,
    TResult Function()? dataExport,
    TResult Function()? dataImport,
    TResult Function()? systemAccess,
    TResult Function()? configurationChange,
    TResult Function()? securityPolicyViolation,
    TResult Function()? suspiciousActivity,
    TResult Function()? threatDetected,
    TResult Function()? incident,
    required TResult orElse(),
  }) {
    if (threatDetected != null) {
      return threatDetected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginEvent value) login,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(AuthenticationFailureEvent value)
        authenticationFailure,
    required TResult Function(AuthorizationFailureEvent value)
        authorizationFailure,
    required TResult Function(DataAccessEvent value) dataAccess,
    required TResult Function(DataModificationEvent value) dataModification,
    required TResult Function(DataExportEvent value) dataExport,
    required TResult Function(DataImportEvent value) dataImport,
    required TResult Function(SystemAccessEvent value) systemAccess,
    required TResult Function(ConfigurationChangeEvent value)
        configurationChange,
    required TResult Function(SecurityPolicyViolationEvent value)
        securityPolicyViolation,
    required TResult Function(SuspiciousActivityEvent value) suspiciousActivity,
    required TResult Function(ThreatDetectedEvent value) threatDetected,
    required TResult Function(IncidentEvent value) incident,
  }) {
    return threatDetected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginEvent value)? login,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult? Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult? Function(DataAccessEvent value)? dataAccess,
    TResult? Function(DataModificationEvent value)? dataModification,
    TResult? Function(DataExportEvent value)? dataExport,
    TResult? Function(DataImportEvent value)? dataImport,
    TResult? Function(SystemAccessEvent value)? systemAccess,
    TResult? Function(ConfigurationChangeEvent value)? configurationChange,
    TResult? Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult? Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult? Function(ThreatDetectedEvent value)? threatDetected,
    TResult? Function(IncidentEvent value)? incident,
  }) {
    return threatDetected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginEvent value)? login,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult Function(DataAccessEvent value)? dataAccess,
    TResult Function(DataModificationEvent value)? dataModification,
    TResult Function(DataExportEvent value)? dataExport,
    TResult Function(DataImportEvent value)? dataImport,
    TResult Function(SystemAccessEvent value)? systemAccess,
    TResult Function(ConfigurationChangeEvent value)? configurationChange,
    TResult Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult Function(ThreatDetectedEvent value)? threatDetected,
    TResult Function(IncidentEvent value)? incident,
    required TResult orElse(),
  }) {
    if (threatDetected != null) {
      return threatDetected(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ThreatDetectedEventImplToJson(
      this,
    );
  }
}

abstract class ThreatDetectedEvent implements SecurityEventType {
  const factory ThreatDetectedEvent() = _$ThreatDetectedEventImpl;

  factory ThreatDetectedEvent.fromJson(Map<String, dynamic> json) =
      _$ThreatDetectedEventImpl.fromJson;
}

/// @nodoc
abstract class _$$IncidentEventImplCopyWith<$Res> {
  factory _$$IncidentEventImplCopyWith(
          _$IncidentEventImpl value, $Res Function(_$IncidentEventImpl) then) =
      __$$IncidentEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$IncidentEventImplCopyWithImpl<$Res>
    extends _$SecurityEventTypeCopyWithImpl<$Res, _$IncidentEventImpl>
    implements _$$IncidentEventImplCopyWith<$Res> {
  __$$IncidentEventImplCopyWithImpl(
      _$IncidentEventImpl _value, $Res Function(_$IncidentEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityEventType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$IncidentEventImpl implements IncidentEvent {
  const _$IncidentEventImpl({final String? $type})
      : $type = $type ?? 'incident';

  factory _$IncidentEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$IncidentEventImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SecurityEventType.incident()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$IncidentEventImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() login,
    required TResult Function() logout,
    required TResult Function() authenticationFailure,
    required TResult Function() authorizationFailure,
    required TResult Function() dataAccess,
    required TResult Function() dataModification,
    required TResult Function() dataExport,
    required TResult Function() dataImport,
    required TResult Function() systemAccess,
    required TResult Function() configurationChange,
    required TResult Function() securityPolicyViolation,
    required TResult Function() suspiciousActivity,
    required TResult Function() threatDetected,
    required TResult Function() incident,
  }) {
    return incident();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? login,
    TResult? Function()? logout,
    TResult? Function()? authenticationFailure,
    TResult? Function()? authorizationFailure,
    TResult? Function()? dataAccess,
    TResult? Function()? dataModification,
    TResult? Function()? dataExport,
    TResult? Function()? dataImport,
    TResult? Function()? systemAccess,
    TResult? Function()? configurationChange,
    TResult? Function()? securityPolicyViolation,
    TResult? Function()? suspiciousActivity,
    TResult? Function()? threatDetected,
    TResult? Function()? incident,
  }) {
    return incident?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? login,
    TResult Function()? logout,
    TResult Function()? authenticationFailure,
    TResult Function()? authorizationFailure,
    TResult Function()? dataAccess,
    TResult Function()? dataModification,
    TResult Function()? dataExport,
    TResult Function()? dataImport,
    TResult Function()? systemAccess,
    TResult Function()? configurationChange,
    TResult Function()? securityPolicyViolation,
    TResult Function()? suspiciousActivity,
    TResult Function()? threatDetected,
    TResult Function()? incident,
    required TResult orElse(),
  }) {
    if (incident != null) {
      return incident();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginEvent value) login,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(AuthenticationFailureEvent value)
        authenticationFailure,
    required TResult Function(AuthorizationFailureEvent value)
        authorizationFailure,
    required TResult Function(DataAccessEvent value) dataAccess,
    required TResult Function(DataModificationEvent value) dataModification,
    required TResult Function(DataExportEvent value) dataExport,
    required TResult Function(DataImportEvent value) dataImport,
    required TResult Function(SystemAccessEvent value) systemAccess,
    required TResult Function(ConfigurationChangeEvent value)
        configurationChange,
    required TResult Function(SecurityPolicyViolationEvent value)
        securityPolicyViolation,
    required TResult Function(SuspiciousActivityEvent value) suspiciousActivity,
    required TResult Function(ThreatDetectedEvent value) threatDetected,
    required TResult Function(IncidentEvent value) incident,
  }) {
    return incident(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginEvent value)? login,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult? Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult? Function(DataAccessEvent value)? dataAccess,
    TResult? Function(DataModificationEvent value)? dataModification,
    TResult? Function(DataExportEvent value)? dataExport,
    TResult? Function(DataImportEvent value)? dataImport,
    TResult? Function(SystemAccessEvent value)? systemAccess,
    TResult? Function(ConfigurationChangeEvent value)? configurationChange,
    TResult? Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult? Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult? Function(ThreatDetectedEvent value)? threatDetected,
    TResult? Function(IncidentEvent value)? incident,
  }) {
    return incident?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginEvent value)? login,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(AuthenticationFailureEvent value)? authenticationFailure,
    TResult Function(AuthorizationFailureEvent value)? authorizationFailure,
    TResult Function(DataAccessEvent value)? dataAccess,
    TResult Function(DataModificationEvent value)? dataModification,
    TResult Function(DataExportEvent value)? dataExport,
    TResult Function(DataImportEvent value)? dataImport,
    TResult Function(SystemAccessEvent value)? systemAccess,
    TResult Function(ConfigurationChangeEvent value)? configurationChange,
    TResult Function(SecurityPolicyViolationEvent value)?
        securityPolicyViolation,
    TResult Function(SuspiciousActivityEvent value)? suspiciousActivity,
    TResult Function(ThreatDetectedEvent value)? threatDetected,
    TResult Function(IncidentEvent value)? incident,
    required TResult orElse(),
  }) {
    if (incident != null) {
      return incident(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$IncidentEventImplToJson(
      this,
    );
  }
}

abstract class IncidentEvent implements SecurityEventType {
  const factory IncidentEvent() = _$IncidentEventImpl;

  factory IncidentEvent.fromJson(Map<String, dynamic> json) =
      _$IncidentEventImpl.fromJson;
}

SecuritySeverity _$SecuritySeverityFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'low':
      return LowSeverity.fromJson(json);
    case 'medium':
      return MediumSeverity.fromJson(json);
    case 'high':
      return HighSeverity.fromJson(json);
    case 'critical':
      return CriticalSeverity.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'SecuritySeverity',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SecuritySeverity {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() low,
    required TResult Function() medium,
    required TResult Function() high,
    required TResult Function() critical,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? low,
    TResult? Function()? medium,
    TResult? Function()? high,
    TResult? Function()? critical,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? low,
    TResult Function()? medium,
    TResult Function()? high,
    TResult Function()? critical,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LowSeverity value) low,
    required TResult Function(MediumSeverity value) medium,
    required TResult Function(HighSeverity value) high,
    required TResult Function(CriticalSeverity value) critical,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LowSeverity value)? low,
    TResult? Function(MediumSeverity value)? medium,
    TResult? Function(HighSeverity value)? high,
    TResult? Function(CriticalSeverity value)? critical,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LowSeverity value)? low,
    TResult Function(MediumSeverity value)? medium,
    TResult Function(HighSeverity value)? high,
    TResult Function(CriticalSeverity value)? critical,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this SecuritySeverity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecuritySeverityCopyWith<$Res> {
  factory $SecuritySeverityCopyWith(
          SecuritySeverity value, $Res Function(SecuritySeverity) then) =
      _$SecuritySeverityCopyWithImpl<$Res, SecuritySeverity>;
}

/// @nodoc
class _$SecuritySeverityCopyWithImpl<$Res, $Val extends SecuritySeverity>
    implements $SecuritySeverityCopyWith<$Res> {
  _$SecuritySeverityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SecuritySeverity
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LowSeverityImplCopyWith<$Res> {
  factory _$$LowSeverityImplCopyWith(
          _$LowSeverityImpl value, $Res Function(_$LowSeverityImpl) then) =
      __$$LowSeverityImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LowSeverityImplCopyWithImpl<$Res>
    extends _$SecuritySeverityCopyWithImpl<$Res, _$LowSeverityImpl>
    implements _$$LowSeverityImplCopyWith<$Res> {
  __$$LowSeverityImplCopyWithImpl(
      _$LowSeverityImpl _value, $Res Function(_$LowSeverityImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecuritySeverity
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$LowSeverityImpl implements LowSeverity {
  const _$LowSeverityImpl({final String? $type}) : $type = $type ?? 'low';

  factory _$LowSeverityImpl.fromJson(Map<String, dynamic> json) =>
      _$$LowSeverityImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SecuritySeverity.low()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LowSeverityImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() low,
    required TResult Function() medium,
    required TResult Function() high,
    required TResult Function() critical,
  }) {
    return low();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? low,
    TResult? Function()? medium,
    TResult? Function()? high,
    TResult? Function()? critical,
  }) {
    return low?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? low,
    TResult Function()? medium,
    TResult Function()? high,
    TResult Function()? critical,
    required TResult orElse(),
  }) {
    if (low != null) {
      return low();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LowSeverity value) low,
    required TResult Function(MediumSeverity value) medium,
    required TResult Function(HighSeverity value) high,
    required TResult Function(CriticalSeverity value) critical,
  }) {
    return low(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LowSeverity value)? low,
    TResult? Function(MediumSeverity value)? medium,
    TResult? Function(HighSeverity value)? high,
    TResult? Function(CriticalSeverity value)? critical,
  }) {
    return low?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LowSeverity value)? low,
    TResult Function(MediumSeverity value)? medium,
    TResult Function(HighSeverity value)? high,
    TResult Function(CriticalSeverity value)? critical,
    required TResult orElse(),
  }) {
    if (low != null) {
      return low(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LowSeverityImplToJson(
      this,
    );
  }
}

abstract class LowSeverity implements SecuritySeverity {
  const factory LowSeverity() = _$LowSeverityImpl;

  factory LowSeverity.fromJson(Map<String, dynamic> json) =
      _$LowSeverityImpl.fromJson;
}

/// @nodoc
abstract class _$$MediumSeverityImplCopyWith<$Res> {
  factory _$$MediumSeverityImplCopyWith(_$MediumSeverityImpl value,
          $Res Function(_$MediumSeverityImpl) then) =
      __$$MediumSeverityImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MediumSeverityImplCopyWithImpl<$Res>
    extends _$SecuritySeverityCopyWithImpl<$Res, _$MediumSeverityImpl>
    implements _$$MediumSeverityImplCopyWith<$Res> {
  __$$MediumSeverityImplCopyWithImpl(
      _$MediumSeverityImpl _value, $Res Function(_$MediumSeverityImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecuritySeverity
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$MediumSeverityImpl implements MediumSeverity {
  const _$MediumSeverityImpl({final String? $type}) : $type = $type ?? 'medium';

  factory _$MediumSeverityImpl.fromJson(Map<String, dynamic> json) =>
      _$$MediumSeverityImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SecuritySeverity.medium()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MediumSeverityImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() low,
    required TResult Function() medium,
    required TResult Function() high,
    required TResult Function() critical,
  }) {
    return medium();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? low,
    TResult? Function()? medium,
    TResult? Function()? high,
    TResult? Function()? critical,
  }) {
    return medium?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? low,
    TResult Function()? medium,
    TResult Function()? high,
    TResult Function()? critical,
    required TResult orElse(),
  }) {
    if (medium != null) {
      return medium();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LowSeverity value) low,
    required TResult Function(MediumSeverity value) medium,
    required TResult Function(HighSeverity value) high,
    required TResult Function(CriticalSeverity value) critical,
  }) {
    return medium(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LowSeverity value)? low,
    TResult? Function(MediumSeverity value)? medium,
    TResult? Function(HighSeverity value)? high,
    TResult? Function(CriticalSeverity value)? critical,
  }) {
    return medium?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LowSeverity value)? low,
    TResult Function(MediumSeverity value)? medium,
    TResult Function(HighSeverity value)? high,
    TResult Function(CriticalSeverity value)? critical,
    required TResult orElse(),
  }) {
    if (medium != null) {
      return medium(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MediumSeverityImplToJson(
      this,
    );
  }
}

abstract class MediumSeverity implements SecuritySeverity {
  const factory MediumSeverity() = _$MediumSeverityImpl;

  factory MediumSeverity.fromJson(Map<String, dynamic> json) =
      _$MediumSeverityImpl.fromJson;
}

/// @nodoc
abstract class _$$HighSeverityImplCopyWith<$Res> {
  factory _$$HighSeverityImplCopyWith(
          _$HighSeverityImpl value, $Res Function(_$HighSeverityImpl) then) =
      __$$HighSeverityImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HighSeverityImplCopyWithImpl<$Res>
    extends _$SecuritySeverityCopyWithImpl<$Res, _$HighSeverityImpl>
    implements _$$HighSeverityImplCopyWith<$Res> {
  __$$HighSeverityImplCopyWithImpl(
      _$HighSeverityImpl _value, $Res Function(_$HighSeverityImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecuritySeverity
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$HighSeverityImpl implements HighSeverity {
  const _$HighSeverityImpl({final String? $type}) : $type = $type ?? 'high';

  factory _$HighSeverityImpl.fromJson(Map<String, dynamic> json) =>
      _$$HighSeverityImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SecuritySeverity.high()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HighSeverityImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() low,
    required TResult Function() medium,
    required TResult Function() high,
    required TResult Function() critical,
  }) {
    return high();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? low,
    TResult? Function()? medium,
    TResult? Function()? high,
    TResult? Function()? critical,
  }) {
    return high?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? low,
    TResult Function()? medium,
    TResult Function()? high,
    TResult Function()? critical,
    required TResult orElse(),
  }) {
    if (high != null) {
      return high();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LowSeverity value) low,
    required TResult Function(MediumSeverity value) medium,
    required TResult Function(HighSeverity value) high,
    required TResult Function(CriticalSeverity value) critical,
  }) {
    return high(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LowSeverity value)? low,
    TResult? Function(MediumSeverity value)? medium,
    TResult? Function(HighSeverity value)? high,
    TResult? Function(CriticalSeverity value)? critical,
  }) {
    return high?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LowSeverity value)? low,
    TResult Function(MediumSeverity value)? medium,
    TResult Function(HighSeverity value)? high,
    TResult Function(CriticalSeverity value)? critical,
    required TResult orElse(),
  }) {
    if (high != null) {
      return high(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$HighSeverityImplToJson(
      this,
    );
  }
}

abstract class HighSeverity implements SecuritySeverity {
  const factory HighSeverity() = _$HighSeverityImpl;

  factory HighSeverity.fromJson(Map<String, dynamic> json) =
      _$HighSeverityImpl.fromJson;
}

/// @nodoc
abstract class _$$CriticalSeverityImplCopyWith<$Res> {
  factory _$$CriticalSeverityImplCopyWith(_$CriticalSeverityImpl value,
          $Res Function(_$CriticalSeverityImpl) then) =
      __$$CriticalSeverityImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CriticalSeverityImplCopyWithImpl<$Res>
    extends _$SecuritySeverityCopyWithImpl<$Res, _$CriticalSeverityImpl>
    implements _$$CriticalSeverityImplCopyWith<$Res> {
  __$$CriticalSeverityImplCopyWithImpl(_$CriticalSeverityImpl _value,
      $Res Function(_$CriticalSeverityImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecuritySeverity
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$CriticalSeverityImpl implements CriticalSeverity {
  const _$CriticalSeverityImpl({final String? $type})
      : $type = $type ?? 'critical';

  factory _$CriticalSeverityImpl.fromJson(Map<String, dynamic> json) =>
      _$$CriticalSeverityImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SecuritySeverity.critical()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CriticalSeverityImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() low,
    required TResult Function() medium,
    required TResult Function() high,
    required TResult Function() critical,
  }) {
    return critical();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? low,
    TResult? Function()? medium,
    TResult? Function()? high,
    TResult? Function()? critical,
  }) {
    return critical?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? low,
    TResult Function()? medium,
    TResult Function()? high,
    TResult Function()? critical,
    required TResult orElse(),
  }) {
    if (critical != null) {
      return critical();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LowSeverity value) low,
    required TResult Function(MediumSeverity value) medium,
    required TResult Function(HighSeverity value) high,
    required TResult Function(CriticalSeverity value) critical,
  }) {
    return critical(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LowSeverity value)? low,
    TResult? Function(MediumSeverity value)? medium,
    TResult? Function(HighSeverity value)? high,
    TResult? Function(CriticalSeverity value)? critical,
  }) {
    return critical?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LowSeverity value)? low,
    TResult Function(MediumSeverity value)? medium,
    TResult Function(HighSeverity value)? high,
    TResult Function(CriticalSeverity value)? critical,
    required TResult orElse(),
  }) {
    if (critical != null) {
      return critical(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CriticalSeverityImplToJson(
      this,
    );
  }
}

abstract class CriticalSeverity implements SecuritySeverity {
  const factory CriticalSeverity() = _$CriticalSeverityImpl;

  factory CriticalSeverity.fromJson(Map<String, dynamic> json) =
      _$CriticalSeverityImpl.fromJson;
}
