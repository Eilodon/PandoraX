import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/unified_sync_service.dart';
import '../../../injection.dart';

final syncServiceProvider = Provider<UnifiedSyncService>((ref) {
  return getIt<UnifiedSyncService>();
});

final isConnectedProvider = FutureProvider<bool>((ref) async {
  final syncService = ref.watch(syncServiceProvider);
  return syncService.isOnline;
});

final manualSyncProvider = FutureProvider.family<bool, void>((ref, _) async {
  final syncService = ref.watch(syncServiceProvider);
  try {
    await syncService.syncNow();
    return true;
  } catch (e) {
    return false;
  }
});
