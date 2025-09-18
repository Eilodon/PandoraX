import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/note_providers.dart';
import '../application/note_watcher/note_watcher_state.dart';
import 'note_detail_screen.dart';
import '../../ai/presentation/ai_chat_screen.dart';
import '../../speech_recognition/presentation/voice_recording_screen.dart';

class NotesPage extends ConsumerWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteWatcherState = ref.watch(noteWatcherProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: noteWatcherState.when(
        initial: () => const Center(child: Text('Initial state')),
        loading: () => const Center(child: CircularProgressIndicator()),
        loadSuccess: (notes) => ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return ListTile(
              title: Text(note.title),
              subtitle: Text(note.content),
              trailing: note.pinned
                  ? const Icon(Icons.push_pin, color: Colors.orange)
                  : null,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NoteDetailScreen(note: note),
                  ),
                );
              },
            );
          },
        ),
        loadFailure: (message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text('Error: $message'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(noteWatcherProvider.notifier).watchAllNotes();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const VoiceRecordingScreen(),
                ),
              );
            },
            tooltip: 'Ghi âm tạo ghi chú',
            heroTag: 'voice_recording',
            backgroundColor: Colors.purple,
            child: const Icon(Icons.mic),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AiChatScreen(),
                ),
              );
            },
            tooltip: 'Trò chuyện với AI',
            heroTag: 'ai_chat',
            child: const Icon(Icons.chat),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              // TODO: Implement add note functionality
            },
            tooltip: 'Thêm ghi chú',
            heroTag: 'add_note',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
