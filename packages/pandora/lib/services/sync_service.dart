import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:workmanager/workmanager.dart';
import 'package:alarm_domain/alarm_domain.dart';
import '../injection.dart';

class SyncService {
  static const String _periodicTaskName = 'syncNotesTask';
  static const String _oneOffTaskName = 'syncOnConnect';
  static const String _periodicTaskId = '1';
  static const String _oneOffTaskId = '2';

  final Connectivity _connectivity = Connectivity();

  /// Khởi tạo sync service
  Future<void> initialize() async {
    // Đăng ký periodic task (mỗi 15 phút)
    await Workmanager().registerPeriodicTask(
      _periodicTaskId,
      _periodicTaskName,
      frequency: const Duration(minutes: 15),
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresDeviceIdle: false,
        requiresStorageNotLow: false,
      ),
    );

    // Lắng nghe thay đổi kết nối mạng
    _connectivity.onConnectivityChanged.listen(_onConnectivityChanged);
  }

  /// Xử lý khi kết nối mạng thay đổi
  void _onConnectivityChanged(List<ConnectivityResult> results) {
    final hasConnection = results.any((result) => result != ConnectivityResult.none);
    
    if (hasConnection) {
      // Khi có kết nối, đăng ký task đồng bộ một lần
      _triggerSync();
    }
  }

  /// Kích hoạt đồng bộ hóa ngay lập tức
  Future<void> triggerSyncNow() async {
    await _triggerSync();
  }

  /// Đăng ký one-off task để đồng bộ
  Future<void> _triggerSync() async {
    await Workmanager().registerOneOffTask(
      _oneOffTaskId,
      _oneOffTaskName,
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresDeviceIdle: false,
        requiresStorageNotLow: false,
      ),
    );
  }

  /// Đồng bộ hóa thủ công (trong foreground)
  Future<bool> syncManually() async {
    try {
      final noteRepository = getIt<NoteRepository>();
      await noteRepository.syncPendingNotes();
      return true;
    } catch (e) {
      print('Manual sync error: $e');
      return false;
    }
  }

  /// Kiểm tra trạng thái kết nối
  Future<bool> isConnected() async {
    final results = await _connectivity.checkConnectivity();
    return results.any((result) => result != ConnectivityResult.none);
  }

  /// Hủy tất cả tasks
  Future<void> cancelAllTasks() async {
    await Workmanager().cancelAll();
  }

  /// Hủy periodic task
  Future<void> cancelPeriodicTask() async {
    await Workmanager().cancelByUniqueName(_periodicTaskName);
  }
}
