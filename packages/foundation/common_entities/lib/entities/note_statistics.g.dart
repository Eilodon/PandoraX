// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NoteStatisticsImpl _$$NoteStatisticsImplFromJson(Map<String, dynamic> json) =>
    _$NoteStatisticsImpl(
      totalNotes: (json['totalNotes'] as num).toInt(),
      pinnedNotes: (json['pinnedNotes'] as num).toInt(),
      archivedNotes: (json['archivedNotes'] as num).toInt(),
      totalWords: (json['totalWords'] as num).toInt(),
      totalCharacters: (json['totalCharacters'] as num).toInt(),
      categoryCounts: Map<String, int>.from(json['categoryCounts'] as Map),
      tagCounts: Map<String, int>.from(json['tagCounts'] as Map),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$NoteStatisticsImplToJson(
        _$NoteStatisticsImpl instance) =>
    <String, dynamic>{
      'totalNotes': instance.totalNotes,
      'pinnedNotes': instance.pinnedNotes,
      'archivedNotes': instance.archivedNotes,
      'totalWords': instance.totalWords,
      'totalCharacters': instance.totalCharacters,
      'categoryCounts': instance.categoryCounts,
      'tagCounts': instance.tagCounts,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };
