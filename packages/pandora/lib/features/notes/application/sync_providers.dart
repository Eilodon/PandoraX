import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/sync_service.dart';

final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService();
});

final isConnectedProvider = FutureProvider<bool>((ref) async {
  final syncService = ref.watch(syncServiceProvider);
  return await syncService.isConnected();
});

final manualSyncProvider = FutureProvider.family<bool, void>((ref, _) async {
  final syncService = ref.watch(syncServiceProvider);
  return await syncService.syncManually();
});
