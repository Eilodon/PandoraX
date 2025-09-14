import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'speech_recognition_state.dart';
import 'speech_recognition_service.dart';

@injectable
class SpeechRecognitionNotifier extends StateNotifier<SpeechRecognitionState> {
  final SpeechRecognitionService _speechService;

  SpeechRecognitionNotifier(this._speechService) : super(const SpeechRecognitionState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    final success = await _speechService.initialize();
    state = state.copyWith(
      isInitialized: success,
      hasError: !success,
      errorMessage: success ? null : 'Không thể khởi tạo nhận dạng giọng nói',
    );

    // Lắng nghe các stream từ service
    _speechService.recognizedTextStream.listen((text) {
      state = state.copyWith(recognizedText: text);
    });

    _speechService.partialTextStream.listen((text) {
      state = state.copyWith(partialText: text);
    });

    _speechService.isListeningStream.listen((isListening) {
      state = state.copyWith(isListening: isListening);
    });

    _speechService.errorStream.listen((error) {
      state = state.copyWith(
        hasError: true,
        errorMessage: error,
        isListening: false,
      );
    });
  }

  Future<void> startListening() async {
    if (!state.isInitialized) {
      state = state.copyWith(
        hasError: true,
        errorMessage: 'Dịch vụ nhận dạng giọng nói chưa được khởi tạo',
      );
      return;
    }

    state = state.copyWith(
      hasError: false,
      errorMessage: null,
      recognizedText: '',
      partialText: '',
    );

    await _speechService.startListening();
  }

  Future<void> stopListening() async {
    await _speechService.stopListening();
  }

  Future<void> cancelListening() async {
    await _speechService.cancelListening();
    state = state.copyWith(
      recognizedText: '',
      partialText: '',
      isListening: false,
    );
  }

  void clearText() {
    state = state.copyWith(
      recognizedText: '',
      partialText: '',
    );
  }

  void clearError() {
    state = state.copyWith(
      hasError: false,
      errorMessage: null,
    );
  }

  @override
  void dispose() {
    _speechService.dispose();
    super.dispose();
  }
}
