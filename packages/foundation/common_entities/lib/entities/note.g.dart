// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NoteImpl _$$NoteImplFromJson(Map<String, dynamic> json) => _$NoteImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      isArchived: json['isArchived'] as bool? ?? false,
      isPinned: json['isPinned'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      aiSummary: json['aiSummary'] as String?,
      aiCategory: json['aiCategory'] as String?,
      category: json['category'] as String?,
      isEncrypted: json['isEncrypted'] as bool? ?? false,
      priority: (json['priority'] as num?)?.toInt() ?? 0,
      color: json['color'] as String?,
      icon: json['icon'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$NoteImplToJson(_$NoteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'tags': instance.tags,
      'isArchived': instance.isArchived,
      'isPinned': instance.isPinned,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'aiSummary': instance.aiSummary,
      'aiCategory': instance.aiCategory,
      'category': instance.category,
      'isEncrypted': instance.isEncrypted,
      'priority': instance.priority,
      'color': instance.color,
      'icon': instance.icon,
      'metadata': instance.metadata,
    };
