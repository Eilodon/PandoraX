import 'package:isar/isar.dart';
import 'package:alarm_domain/alarm_domain.dart';

part 'note_isar_model.g.dart';

@collection
class NoteIsarModel {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String id;
  
  late String title;
  late String content;
  late DateTime createdAt;
  late DateTime updatedAt;
  late bool pinned;

  @enumerated
  late SyncStatus syncStatus;
}

// Mappers để chuyển đổi giữa Domain Entity và Isar Model
extension NoteIsarModelMapper on NoteIsarModel {
  Note toEntity() => Note(
    id: id,
    title: title,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
    pinned: pinned,
    syncStatus: syncStatus,
  );
}

extension NoteEntityMapper on Note {
  NoteIsarModel toIsarModel() => NoteIsarModel()
    ..id = id
    ..title = title
    ..content = content
    ..createdAt = createdAt
    ..updatedAt = updatedAt
    ..pinned = pinned
    ..syncStatus = syncStatus;
}
