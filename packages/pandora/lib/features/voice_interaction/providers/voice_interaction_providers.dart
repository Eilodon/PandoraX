import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import '../../../services/voice_interaction_service.dart';
import '../../../services/voice_commands_service.dart';
import '../../../services/fpt_tts_service.dart';
import '../../../services/pho_whisper_service.dart';

/// Voice Interaction Service Provider
final voiceInteractionServiceProvider = Provider<VoiceInteractionService>((ref) {
  return VoiceInteractionService();
});

/// Voice Commands Service Provider
final voiceCommandsServiceProvider = Provider<VoiceCommandsService>((ref) {
  // TODO: Get API key from config
  return VoiceCommandsService('your-google-ai-api-key');
});

/// FPT TTS Service Provider
final fptTtsServiceProvider = Provider<FptTtsService>((ref) {
  return FptTtsService();
});

/// PhoWhisper Service Provider
final phoWhisperServiceProvider = Provider<PhoWhisperService>((ref) {
  return PhoWhisperService();
});

/// Voice Interaction State Provider
final voiceInteractionStateProvider = StateNotifierProvider<VoiceInteractionNotifier, VoiceInteractionState>((ref) {
  final voiceService = ref.watch(voiceInteractionServiceProvider);
  final commandsService = ref.watch(voiceCommandsServiceProvider);
  final ttsService = ref.watch(fptTtsServiceProvider);
  
  return VoiceInteractionNotifier(
    voiceService,
    commandsService,
    ttsService,
  );
});

/// Voice Commands State Provider
final voiceCommandsStateProvider = StateNotifierProvider<VoiceCommandsNotifier, VoiceCommandsState>((ref) {
  final commandsService = ref.watch(voiceCommandsServiceProvider);
  return VoiceCommandsNotifier(commandsService);
});

/// TTS State Provider
final ttsStateProvider = StateNotifierProvider<TtsNotifier, TtsState>((ref) {
  final ttsService = ref.watch(fptTtsServiceProvider);
  return TtsNotifier(ttsService);
});

/// PhoWhisper State Provider
final phoWhisperStateProvider = StateNotifierProvider<PhoWhisperNotifier, PhoWhisperState>((ref) {
  final phoWhisperService = ref.watch(phoWhisperServiceProvider);
  return PhoWhisperNotifier(phoWhisperService);
});

/// Voice Interaction Notifier
class VoiceInteractionNotifier extends StateNotifier<VoiceInteractionState> {
  final VoiceInteractionService _voiceService;
  final VoiceCommandsService _commandsService;
  final FptTtsService _ttsService;

  VoiceInteractionNotifier(
    this._voiceService,
    this._commandsService,
    this._ttsService,
  ) : super(const VoiceInteractionState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    final success = await _voiceService.initialize();
    state = state.copyWith(isInitialized: success);
    
    // Listen to voice service streams
    _voiceService.recognizedTextStream.listen(_onTextRecognized);
    _voiceService.errorStream.listen(_onError);
    _voiceService.isSpeakingStream.listen(_onSpeakingChanged);
  }

  void _onTextRecognized(String text) {
    state = state.copyWith(
      recognizedText: text,
      isProcessing: false,
    );
    
    // Auto-process recognized text
    if (text.isNotEmpty) {
      _processCommand(text);
    }
  }

  void _onError(String error) {
    state = state.copyWith(
      error: error,
      isProcessing: false,
    );
  }

  void _onSpeakingChanged(bool isSpeaking) {
    state = state.copyWith(isSpeaking: isSpeaking);
  }

  Future<void> startListening() async {
    state = state.copyWith(
      isListening: true,
      error: null,
      recognizedText: '',
    );
    
    await _voiceService.startListening();
  }

  Future<void> stopListening() async {
    state = state.copyWith(isListening: false);
    await _voiceService.stopListening();
  }

  Future<void> _processCommand(String command) async {
    state = state.copyWith(
      isProcessing: true,
      lastCommand: command,
    );

    try {
      final result = await _commandsService.processCommand(command);
      
      state = state.copyWith(
        lastResponse: result.response,
        commandResult: result,
        isProcessing: false,
      );
      
      // Speak the response
      await _ttsService.speakText(result.response);
    } catch (e) {
      state = state.copyWith(
        error: 'Lỗi xử lý lệnh: $e',
        isProcessing: false,
      );
    }
  }

  Future<void> speakResponse(String text) async {
    try {
      await _ttsService.speakText(text);
    } catch (e) {
      state = state.copyWith(error: 'Lỗi phát âm: $e');
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearHistory() {
    state = state.copyWith(
      recognizedText: '',
      lastCommand: '',
      lastResponse: '',
      commandResult: null,
    );
  }
}

/// Voice Commands Notifier
class VoiceCommandsNotifier extends StateNotifier<VoiceCommandsState> {
  final VoiceCommandsService _commandsService;

  VoiceCommandsNotifier(this._commandsService) : super(const VoiceCommandsState());

  Future<void> processCommand(String command) async {
    state = state.copyWith(isProcessing: true);
    
    try {
      final result = await _commandsService.processCommand(command);
      state = state.copyWith(
        lastResult: result,
        isProcessing: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Lỗi xử lý lệnh: $e',
        isProcessing: false,
      );
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// TTS Notifier
class TtsNotifier extends StateNotifier<TtsState> {
  final FptTtsService _ttsService;

  TtsNotifier(this._ttsService) : super(const TtsState());

  Future<void> speakText(String text, {String? voice}) async {
    state = state.copyWith(isSpeaking: true);
    
    try {
      await _ttsService.speakText(
        text,
        voice: voice,
        onComplete: () {
          state = state.copyWith(isSpeaking: false);
        },
        onError: (error) {
          state = state.copyWith(
            isSpeaking: false,
            error: error,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isSpeaking: false,
        error: 'Lỗi phát âm: $e',
      );
    }
  }

  Future<void> stopSpeaking() async {
    await _ttsService.stopSpeaking();
    state = state.copyWith(isSpeaking: false);
  }

  List<Map<String, String>> getAvailableVoices() {
    return _ttsService.getAvailableVoices();
  }
}

/// PhoWhisper Notifier
class PhoWhisperNotifier extends StateNotifier<PhoWhisperState> {
  final PhoWhisperService _phoWhisperService;

  PhoWhisperNotifier(this._phoWhisperService) : super(const PhoWhisperState()) {
    _checkModelStatus();
  }

  Future<void> _checkModelStatus() async {
    final isAvailable = await _phoWhisperService.isModelAvailable();
    state = state.copyWith(isModelAvailable: isAvailable);
  }

  Future<void> downloadModel({
    Function(double)? onProgress,
    Function(String)? onStatus,
  }) async {
    state = state.copyWith(isDownloading: true);
    
    try {
      final success = await _phoWhisperService.downloadModel(
        onProgress: onProgress,
        onStatus: onStatus,
      );
      
      state = state.copyWith(
        isDownloading: false,
        isModelAvailable: success,
      );
    } catch (e) {
      state = state.copyWith(
        isDownloading: false,
        error: 'Lỗi tải xuống model: $e',
      );
    }
  }

  Future<void> loadModel() async {
    state = state.copyWith(isLoading: true);
    
    try {
      final success = await _phoWhisperService.loadModel();
      state = state.copyWith(
        isLoading: false,
        isModelLoaded: success,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Lỗi tải model: $e',
      );
    }
  }

  Future<String> transcribeAudio(String audioPath) async {
    try {
      return await _phoWhisperService.transcribeAudio(audioPath);
    } catch (e) {
      state = state.copyWith(error: 'Lỗi transcribe: $e');
      rethrow;
    }
  }

  Map<String, dynamic> getModelInfo() {
    return _phoWhisperService.getModelInfo();
  }
}

/// Voice Interaction State
class VoiceInteractionState {
  final bool isInitialized;
  final bool isListening;
  final bool isSpeaking;
  final bool isProcessing;
  final String recognizedText;
  final String lastCommand;
  final String lastResponse;
  final String? error;
  final VoiceCommandResult? commandResult;

  const VoiceInteractionState({
    this.isInitialized = false,
    this.isListening = false,
    this.isSpeaking = false,
    this.isProcessing = false,
    this.recognizedText = '',
    this.lastCommand = '',
    this.lastResponse = '',
    this.error,
    this.commandResult,
  });

  VoiceInteractionState copyWith({
    bool? isInitialized,
    bool? isListening,
    bool? isSpeaking,
    bool? isProcessing,
    String? recognizedText,
    String? lastCommand,
    String? lastResponse,
    String? error,
    VoiceCommandResult? commandResult,
  }) {
    return VoiceInteractionState(
      isInitialized: isInitialized ?? this.isInitialized,
      isListening: isListening ?? this.isListening,
      isSpeaking: isSpeaking ?? this.isSpeaking,
      isProcessing: isProcessing ?? this.isProcessing,
      recognizedText: recognizedText ?? this.recognizedText,
      lastCommand: lastCommand ?? this.lastCommand,
      lastResponse: lastResponse ?? this.lastResponse,
      error: error ?? this.error,
      commandResult: commandResult ?? this.commandResult,
    );
  }
}

/// Voice Commands State
class VoiceCommandsState {
  final bool isProcessing;
  final VoiceCommandResult? lastResult;
  final String? error;

  const VoiceCommandsState({
    this.isProcessing = false,
    this.lastResult,
    this.error,
  });

  VoiceCommandsState copyWith({
    bool? isProcessing,
    VoiceCommandResult? lastResult,
    String? error,
  }) {
    return VoiceCommandsState(
      isProcessing: isProcessing ?? this.isProcessing,
      lastResult: lastResult ?? this.lastResult,
      error: error ?? this.error,
    );
  }
}

/// TTS State
class TtsState {
  final bool isSpeaking;
  final String? error;

  const TtsState({
    this.isSpeaking = false,
    this.error,
  });

  TtsState copyWith({
    bool? isSpeaking,
    String? error,
  }) {
    return TtsState(
      isSpeaking: isSpeaking ?? this.isSpeaking,
      error: error ?? this.error,
    );
  }
}

/// PhoWhisper State
class PhoWhisperState {
  final bool isModelAvailable;
  final bool isModelLoaded;
  final bool isDownloading;
  final bool isLoading;
  final String? error;

  const PhoWhisperState({
    this.isModelAvailable = false,
    this.isModelLoaded = false,
    this.isDownloading = false,
    this.isLoading = false,
    this.error,
  });

  PhoWhisperState copyWith({
    bool? isModelAvailable,
    bool? isModelLoaded,
    bool? isDownloading,
    bool? isLoading,
    String? error,
  }) {
    return PhoWhisperState(
      isModelAvailable: isModelAvailable ?? this.isModelAvailable,
      isModelLoaded: isModelLoaded ?? this.isModelLoaded,
      isDownloading: isDownloading ?? this.isDownloading,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
