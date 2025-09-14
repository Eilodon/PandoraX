import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/speech_recognition_providers.dart';
import '../application/speech_recognition_state.dart';
import '../../notes/presentation/note_form_screen.dart';

class VoiceRecordingScreen extends ConsumerStatefulWidget {
  const VoiceRecordingScreen({super.key});

  @override
  ConsumerState<VoiceRecordingScreen> createState() => _VoiceRecordingScreenState();
}

class _VoiceRecordingScreenState extends ConsumerState<VoiceRecordingScreen> {
  @override
  Widget build(BuildContext context) {
    final speechState = ref.watch(speechRecognitionProvider);
    final speechNotifier = ref.read(speechRecognitionProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ghi âm tạo ghi chú'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (speechState.recognizedText.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                speechNotifier.clearText();
              },
              tooltip: 'Xóa văn bản',
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Trạng thái khởi tạo
            if (!speechState.isInitialized)
              Card(
                color: Colors.orange[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text(
                          'Đang khởi tạo nhận dạng giọng nói...',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Thông báo lỗi
            if (speechState.hasError)
              Card(
                color: Colors.red[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.error, color: Colors.red[700]),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          speechState.errorMessage ?? 'Có lỗi xảy ra',
                          style: TextStyle(color: Colors.red[700]),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => speechNotifier.clearError(),
                        color: Colors.red[700],
                      ),
                    ],
                  ),
                ),
              ),

            // Nút điều khiển ghi âm
            if (speechState.isInitialized && !speechState.hasError)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      // Trạng thái ghi âm
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: speechState.isListening
                              ? Colors.red[100]
                              : Colors.grey[200],
                          border: Border.all(
                            color: speechState.isListening
                                ? Colors.red
                                : Colors.grey,
                            width: 3,
                          ),
                        ),
                        child: Icon(
                          speechState.isListening ? Icons.mic : Icons.mic_none,
                          size: 48,
                          color: speechState.isListening
                              ? Colors.red
                              : Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Nút ghi âm
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (!speechState.isListening) ...[
                            ElevatedButton.icon(
                              onPressed: () => speechNotifier.startListening(),
                              icon: const Icon(Icons.mic),
                              label: const Text('Bắt đầu ghi âm'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ] else ...[
                            ElevatedButton.icon(
                              onPressed: () => speechNotifier.stopListening(),
                              icon: const Icon(Icons.stop),
                              label: const Text('Dừng ghi âm'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () => speechNotifier.cancelListening(),
                              icon: const Icon(Icons.cancel),
                              label: const Text('Hủy'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: 16),
                      Text(
                        speechState.isListening
                            ? 'Đang nghe... Hãy nói vào microphone'
                            : 'Nhấn nút để bắt đầu ghi âm',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 16),

            // Hiển thị văn bản được nhận dạng
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.text_fields),
                          const SizedBox(width: 8),
                          const Text(
                            'Văn bản được nhận dạng:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          if (speechState.recognizedText.isNotEmpty)
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _createNoteFromText(),
                              tooltip: 'Tạo ghi chú từ văn bản này',
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Văn bản đã được nhận dạng hoàn chỉnh
                                if (speechState.recognizedText.isNotEmpty)
                                  Text(
                                    speechState.recognizedText,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                
                                // Văn bản đang được nhận dạng (partial)
                                if (speechState.partialText.isNotEmpty)
                                  Text(
                                    speechState.partialText,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue[700],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                
                                // Thông báo khi chưa có văn bản
                                if (speechState.recognizedText.isEmpty && speechState.partialText.isEmpty)
                                  Text(
                                    speechState.isListening
                                        ? 'Đang nghe...'
                                        : 'Văn bản được nhận dạng sẽ hiển thị ở đây',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Nút tạo ghi chú
            if (speechState.recognizedText.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _createNoteFromText(),
                    icon: const Icon(Icons.note_add),
                    label: const Text('Tạo ghi chú từ văn bản này'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _createNoteFromText() {
    final speechState = ref.read(speechRecognitionProvider);
    if (speechState.recognizedText.isNotEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NoteFormScreen(
            initialContent: speechState.recognizedText,
          ),
        ),
      );
    }
  }
}
