import 'package:flutter/material.dart';
import 'package:note_domain/note_domain.dart';

class SyncStatusBadge extends StatelessWidget {
  final SyncStatus syncStatus;
  final double size;

  const SyncStatusBadge({
    super.key,
    required this.syncStatus,
    this.size = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    switch (syncStatus) {
      case SyncStatus.synced:
        return Tooltip(
          message: 'Synced',
          child: Icon(
            Icons.cloud_done,
            size: size,
            color: Colors.green,
          ),
        );
      case SyncStatus.pending:
        return Tooltip(
          message: 'Syncing...',
          child: SizedBox(
            width: size,
            height: size,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          ),
        );
      case SyncStatus.failed:
        return Tooltip(
          message: 'Sync failed',
          child: Icon(
            Icons.cloud_off,
            size: size,
            color: Colors.red,
          ),
        );
    }
  }
}
