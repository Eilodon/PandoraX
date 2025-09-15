import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_domain/note_domain.dart';
import 'package:pandora_ui/pandora_ui.dart';
import '../application/note_providers.dart';
import '../application/sync_providers.dart';
import 'widgets/sync_status_badge.dart';
import 'widgets/sync_status_indicator.dart';
import 'widgets/loading_skeleton.dart';
import 'note_form_screen.dart';
import '../../demo/pandora_demo_screen.dart';
import '../../ai/presentation/ai_note_generator_screen.dart';
import '../../ai/presentation/voice_commands_screen.dart';
import '../../ai/presentation/ai_features_overview_screen.dart';
import '../../../widgets/mascot_widget.dart';
import '../../../services/mascot_service.dart';
import '../../../services/mascot_enums.dart';

class NotesListScreen extends ConsumerWidget {
  const NotesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(noteWatcherProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Notes'),
            const SizedBox(width: 8),
            const SyncStatusIndicator(),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // AI Features Overview button
          IconButton(
            icon: const Icon(Icons.dashboard),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AiFeaturesOverviewScreen(),
                ),
              );
            },
            tooltip: 'AI Features',
          ),
          // Voice Commands button
          IconButton(
            icon: const Icon(Icons.mic),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const VoiceCommandsScreen(),
                ),
              );
            },
            tooltip: 'Voice Commands',
          ),
          // AI Note Generator button
          IconButton(
            icon: const Icon(Icons.auto_awesome),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AiNoteGeneratorScreen(),
                ),
              );
            },
            tooltip: 'AI Note Generator',
          ),
          // Demo button
          IconButton(
            icon: const Icon(Icons.palette),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PandoraDemoScreen(),
                ),
              );
            },
            tooltip: 'Pandora UI Demo',
          ),
          // Manual sync button
          Consumer(
            builder: (context, ref, child) {
              final isConnected = ref.watch(isConnectedProvider);
              return isConnected.when(
                data: (connected) => IconButton(
                  icon: const Icon(Icons.sync),
                  onPressed: connected ? () => _triggerManualSync(context, ref) : null,
                  tooltip: connected ? 'Sync now' : 'No connection',
                ),
                loading: () => const IconButton(
                  icon: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  onPressed: null,
                ),
                error: (_, __) => IconButton(
                  icon: const Icon(Icons.cloud_off),
                  onPressed: null,
                  tooltip: 'Connection error',
                ),
              );
            },
          ),
          // Refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(noteWatcherProvider.notifier).watchAllNotes();
            },
          ),
        ],
      ),
      body: state.when(
        initial: () => const SizedBox.shrink(),
        loading: () => _buildLoadingState(),
        loadSuccess: (notes) => _buildSuccessState(notes, ref),
        loadFailure: (message) => _buildErrorState(message, ref),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Mascot Floating Action Button
          MascotFloatingActionButton(
            onPressed: () {
              // Mascot interaction
              ref.read(mascotServiceProvider.notifier).handleInteraction(
                MascotInteraction.tap,
              );
            },
          ),
          const SizedBox(height: PTokens.spacingSm),
          // Add Note Button
          FloatingActionButton(
            onPressed: () {
              ref.read(mascotServiceProvider.notifier).handleUserAction(
                UserAction.createNote,
              );
              _navigateToForm(context);
            },
            tooltip: 'Add Note',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const MascotLoadingWidget(
      message: 'Đang tải ghi chú...',
    );
  }

  Widget _buildSuccessState(List<Note> notes, WidgetRef ref) {
    // Cập nhật trạng thái mascot dựa trên số lượng ghi chú (delayed to avoid build cycle violation)
    Future.microtask(() {
      ref.read(mascotServiceProvider.notifier).updateNoteCount(notes.length);
    });
    
    if (notes.isEmpty) {
      return _buildEmptyState();
    }
    
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh data
        ref.read(noteWatcherProvider.notifier).watchAllNotes();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(PTokens.spacingMd),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return _buildNoteCard(context, note);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return MascotEmptyStateWidget(
      title: 'Chưa có ghi chú nào',
      subtitle: 'Hãy tạo ghi chú đầu tiên của bạn để bắt đầu!',
      onAction: () {
        // TODO: Navigate to create note
      },
    );
  }

  Widget _buildErrorState(String message, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            PandoraButton(
              onPressed: () {
                ref.read(noteWatcherProvider.notifier).watchAllNotes();
              },
              icon: const Icon(Icons.refresh),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteCard(BuildContext context, Note note) {
    return ResultCard(
      title: note.title,
      subtitle: note.content,
      onTap: () => _navigateToForm(context, note: note),
      securityCue: SecurityCue(
        level: note.syncStatus == SyncStatus.synced
            ? SecurityLevel.cloud
            : note.syncStatus == SyncStatus.pending
                ? SecurityLevel.hybrid
                : SecurityLevel.onDevice,
      ),
    );
  }


  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  Future<void> _navigateToForm(BuildContext context, {Note? note}) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => NoteFormScreen(note: note),
      ),
    );
    
    if (result == true && context.mounted) {
      // Refresh the notes list if a note was saved or deleted
      // ref.read(noteWatcherProvider.notifier).watchAllNotes();
    }
  }

  Future<void> _triggerManualSync(BuildContext context, WidgetRef ref) async {
    try {
      final syncResult = await ref.read(manualSyncProvider(null).future);
      
      if (syncResult) {
        if (context.mounted) {
          PandoraSnackbar.show(
            context,
            message: 'Sync completed successfully',
            variant: PandoraSnackbarVariant.success,
          );
        }
        // Refresh the notes list
        ref.read(noteWatcherProvider.notifier).watchAllNotes();
      } else {
        if (context.mounted) {
          PandoraSnackbar.show(
            context,
            message: 'Sync failed. Please try again.',
            variant: PandoraSnackbarVariant.error,
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        PandoraSnackbar.show(
          context,
          message: 'Sync error: $e',
          variant: PandoraSnackbarVariant.error,
        );
      }
    }
  }
}
