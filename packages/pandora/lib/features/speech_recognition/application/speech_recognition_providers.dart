import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:pandora/injection.dart';
import 'speech_recognition_notifier.dart';
import 'speech_recognition_state.dart';
import 'speech_recognition_service.dart';

@injectable
final speechRecognitionServiceProvider = Provider<SpeechRecognitionService>((ref) {
  return SpeechRecognitionService();
});

final speechRecognitionProvider = StateNotifierProvider<SpeechRecognitionNotifier, SpeechRecognitionState>((ref) {
  final speechService = ref.watch(speechRecognitionServiceProvider);
  return SpeechRecognitionNotifier(speechService);
});
