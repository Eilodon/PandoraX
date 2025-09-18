// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_statistics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NoteStatistics _$NoteStatisticsFromJson(Map<String, dynamic> json) {
  return _NoteStatistics.fromJson(json);
}

/// @nodoc
mixin _$NoteStatistics {
  int get totalNotes => throw _privateConstructorUsedError;
  int get pinnedNotes => throw _privateConstructorUsedError;
  int get archivedNotes => throw _privateConstructorUsedError;
  int get totalWords => throw _privateConstructorUsedError;
  int get totalCharacters => throw _privateConstructorUsedError;
  Map<String, int> get categoryCounts => throw _privateConstructorUsedError;
  Map<String, int> get tagCounts => throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this NoteStatistics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NoteStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoteStatisticsCopyWith<NoteStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteStatisticsCopyWith<$Res> {
  factory $NoteStatisticsCopyWith(
          NoteStatistics value, $Res Function(NoteStatistics) then) =
      _$NoteStatisticsCopyWithImpl<$Res, NoteStatistics>;
  @useResult
  $Res call(
      {int totalNotes,
      int pinnedNotes,
      int archivedNotes,
      int totalWords,
      int totalCharacters,
      Map<String, int> categoryCounts,
      Map<String, int> tagCounts,
      DateTime lastUpdated});
}

/// @nodoc
class _$NoteStatisticsCopyWithImpl<$Res, $Val extends NoteStatistics>
    implements $NoteStatisticsCopyWith<$Res> {
  _$NoteStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NoteStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalNotes = null,
    Object? pinnedNotes = null,
    Object? archivedNotes = null,
    Object? totalWords = null,
    Object? totalCharacters = null,
    Object? categoryCounts = null,
    Object? tagCounts = null,
    Object? lastUpdated = null,
  }) {
    return _then(_value.copyWith(
      totalNotes: null == totalNotes
          ? _value.totalNotes
          : totalNotes // ignore: cast_nullable_to_non_nullable
              as int,
      pinnedNotes: null == pinnedNotes
          ? _value.pinnedNotes
          : pinnedNotes // ignore: cast_nullable_to_non_nullable
              as int,
      archivedNotes: null == archivedNotes
          ? _value.archivedNotes
          : archivedNotes // ignore: cast_nullable_to_non_nullable
              as int,
      totalWords: null == totalWords
          ? _value.totalWords
          : totalWords // ignore: cast_nullable_to_non_nullable
              as int,
      totalCharacters: null == totalCharacters
          ? _value.totalCharacters
          : totalCharacters // ignore: cast_nullable_to_non_nullable
              as int,
      categoryCounts: null == categoryCounts
          ? _value.categoryCounts
          : categoryCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      tagCounts: null == tagCounts
          ? _value.tagCounts
          : tagCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NoteStatisticsImplCopyWith<$Res>
    implements $NoteStatisticsCopyWith<$Res> {
  factory _$$NoteStatisticsImplCopyWith(_$NoteStatisticsImpl value,
          $Res Function(_$NoteStatisticsImpl) then) =
      __$$NoteStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalNotes,
      int pinnedNotes,
      int archivedNotes,
      int totalWords,
      int totalCharacters,
      Map<String, int> categoryCounts,
      Map<String, int> tagCounts,
      DateTime lastUpdated});
}

/// @nodoc
class __$$NoteStatisticsImplCopyWithImpl<$Res>
    extends _$NoteStatisticsCopyWithImpl<$Res, _$NoteStatisticsImpl>
    implements _$$NoteStatisticsImplCopyWith<$Res> {
  __$$NoteStatisticsImplCopyWithImpl(
      _$NoteStatisticsImpl _value, $Res Function(_$NoteStatisticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of NoteStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalNotes = null,
    Object? pinnedNotes = null,
    Object? archivedNotes = null,
    Object? totalWords = null,
    Object? totalCharacters = null,
    Object? categoryCounts = null,
    Object? tagCounts = null,
    Object? lastUpdated = null,
  }) {
    return _then(_$NoteStatisticsImpl(
      totalNotes: null == totalNotes
          ? _value.totalNotes
          : totalNotes // ignore: cast_nullable_to_non_nullable
              as int,
      pinnedNotes: null == pinnedNotes
          ? _value.pinnedNotes
          : pinnedNotes // ignore: cast_nullable_to_non_nullable
              as int,
      archivedNotes: null == archivedNotes
          ? _value.archivedNotes
          : archivedNotes // ignore: cast_nullable_to_non_nullable
              as int,
      totalWords: null == totalWords
          ? _value.totalWords
          : totalWords // ignore: cast_nullable_to_non_nullable
              as int,
      totalCharacters: null == totalCharacters
          ? _value.totalCharacters
          : totalCharacters // ignore: cast_nullable_to_non_nullable
              as int,
      categoryCounts: null == categoryCounts
          ? _value._categoryCounts
          : categoryCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      tagCounts: null == tagCounts
          ? _value._tagCounts
          : tagCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NoteStatisticsImpl implements _NoteStatistics {
  const _$NoteStatisticsImpl(
      {required this.totalNotes,
      required this.pinnedNotes,
      required this.archivedNotes,
      required this.totalWords,
      required this.totalCharacters,
      required final Map<String, int> categoryCounts,
      required final Map<String, int> tagCounts,
      required this.lastUpdated})
      : _categoryCounts = categoryCounts,
        _tagCounts = tagCounts;

  factory _$NoteStatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoteStatisticsImplFromJson(json);

  @override
  final int totalNotes;
  @override
  final int pinnedNotes;
  @override
  final int archivedNotes;
  @override
  final int totalWords;
  @override
  final int totalCharacters;
  final Map<String, int> _categoryCounts;
  @override
  Map<String, int> get categoryCounts {
    if (_categoryCounts is EqualUnmodifiableMapView) return _categoryCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categoryCounts);
  }

  final Map<String, int> _tagCounts;
  @override
  Map<String, int> get tagCounts {
    if (_tagCounts is EqualUnmodifiableMapView) return _tagCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_tagCounts);
  }

  @override
  final DateTime lastUpdated;

  @override
  String toString() {
    return 'NoteStatistics(totalNotes: $totalNotes, pinnedNotes: $pinnedNotes, archivedNotes: $archivedNotes, totalWords: $totalWords, totalCharacters: $totalCharacters, categoryCounts: $categoryCounts, tagCounts: $tagCounts, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoteStatisticsImpl &&
            (identical(other.totalNotes, totalNotes) ||
                other.totalNotes == totalNotes) &&
            (identical(other.pinnedNotes, pinnedNotes) ||
                other.pinnedNotes == pinnedNotes) &&
            (identical(other.archivedNotes, archivedNotes) ||
                other.archivedNotes == archivedNotes) &&
            (identical(other.totalWords, totalWords) ||
                other.totalWords == totalWords) &&
            (identical(other.totalCharacters, totalCharacters) ||
                other.totalCharacters == totalCharacters) &&
            const DeepCollectionEquality()
                .equals(other._categoryCounts, _categoryCounts) &&
            const DeepCollectionEquality()
                .equals(other._tagCounts, _tagCounts) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalNotes,
      pinnedNotes,
      archivedNotes,
      totalWords,
      totalCharacters,
      const DeepCollectionEquality().hash(_categoryCounts),
      const DeepCollectionEquality().hash(_tagCounts),
      lastUpdated);

  /// Create a copy of NoteStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoteStatisticsImplCopyWith<_$NoteStatisticsImpl> get copyWith =>
      __$$NoteStatisticsImplCopyWithImpl<_$NoteStatisticsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoteStatisticsImplToJson(
      this,
    );
  }
}

abstract class _NoteStatistics implements NoteStatistics {
  const factory _NoteStatistics(
      {required final int totalNotes,
      required final int pinnedNotes,
      required final int archivedNotes,
      required final int totalWords,
      required final int totalCharacters,
      required final Map<String, int> categoryCounts,
      required final Map<String, int> tagCounts,
      required final DateTime lastUpdated}) = _$NoteStatisticsImpl;

  factory _NoteStatistics.fromJson(Map<String, dynamic> json) =
      _$NoteStatisticsImpl.fromJson;

  @override
  int get totalNotes;
  @override
  int get pinnedNotes;
  @override
  int get archivedNotes;
  @override
  int get totalWords;
  @override
  int get totalCharacters;
  @override
  Map<String, int> get categoryCounts;
  @override
  Map<String, int> get tagCounts;
  @override
  DateTime get lastUpdated;

  /// Create a copy of NoteStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoteStatisticsImplCopyWith<_$NoteStatisticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
