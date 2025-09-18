import 'package:workmanager/workmanager.dart';
import 'package:note_domain/note_domain.dart';
import '../injection.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      // Khởi tạo DI trong background isolate
      configureDependencies();
      await getIt.allReady(); // Đảm bảo Isar đã sẵn sàng
      
      final noteRepository = getIt<NoteRepository>();
      
      switch (task) {
        case 'syncNotesTask':
          await noteRepository.syncPendingNotes();
          return Future.value(true);
        case 'syncOnConnect':
          await noteRepository.syncPendingNotes();
          return Future.value(true);
        default:
          return Future.value(false);
      }
    } catch (e) {
      print('Background sync error: $e');
      return Future.value(false);
    }
  });
}
