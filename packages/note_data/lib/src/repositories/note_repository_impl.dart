import 'package:alarm_data/src/datasources/local/isar_service.dart';
import 'package:alarm_data/src/models/note_isar_model.dart';
import 'package:alarm_domain/alarm_domain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:rxdart/rxdart.dart';

@Injectable(as: NoteRepository)
class NoteRepositoryImpl implements NoteRepository {
  final IsarService _isarService;
  final FirebaseFirestore _firestore;

  NoteRepositoryImpl(this._isarService, this._firestore);

  @override
  Stream<List<Note>> watchAllNotes() async* {
    final isar = await _isarService.db;
    yield* isar.noteIsarModels.where().watch(fireImmediately: true).map(
          (isarNotes) => isarNotes.map((e) => e.toEntity()).toList(),
        );
  }

  @override
  Future<Note?> getNoteById(String id) async {
    final isar = await _isarService.db;
    final isarNote = await isar.noteIsarModels
        .where()
        .idEqualTo(id)
        .findFirst();
    return isarNote?.toEntity();
  }

  @override
  Future<void> saveNote(Note note) async {
    final isar = await _isarService.db;
    final noteToSave = note.copyWith(
      updatedAt: DateTime.now(),
      syncStatus: SyncStatus.pending, // Đánh dấu là đang chờ đồng bộ
    );
    final isarModel = noteToSave.toIsarModel();
    await isar.writeTxn(() async {
      await isar.noteIsarModels.putById(isarModel);
    });
  }

  @override
  Future<void> deleteNote(String id) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.noteIsarModels
          .where()
          .idEqualTo(id)
          .deleteAll();
    });
  }

  @override
  Future<void> syncPendingNotes() async {
    final isar = await _isarService.db;
    final pendingNotes = await isar.noteIsarModels
        .filter()
        .syncStatusEqualTo(SyncStatus.pending)
        .findAll();

    if (pendingNotes.isEmpty) return;

    final batch = _firestore.batch();
    for (final isarNote in pendingNotes) {
      final docRef = _firestore.collection('notes').doc(isarNote.id);
      batch.set(docRef, isarNote.toEntity().toJson());
    }

    try {
      await batch.commit();
      // Cập nhật trạng thái thành 'synced' sau khi thành công
      await isar.writeTxn(() async {
        for (final isarNote in pendingNotes) {
          isarNote.syncStatus = SyncStatus.synced;
          await isar.noteIsarModels.putById(isarNote);
        }
      });
    } catch (e) {
      // Xử lý lỗi, có thể cập nhật trạng thái thành 'failed'
      await isar.writeTxn(() async {
        for (final isarNote in pendingNotes) {
          isarNote.syncStatus = SyncStatus.failed;
          await isar.noteIsarModels.putById(isarNote);
        }
      });
    }
  }
}
