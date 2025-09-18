import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:core_utils/core_utils.dart';

/// Service for voice recognition and text-to-speech functionality
class VoiceService {
  static final VoiceService _instance = VoiceService._internal();
  factory VoiceService() => _instance;
  VoiceService._internal();

  final SpeechToText _speech = SpeechToText();
  final FlutterTts _tts = FlutterTts();
  
  bool _isListening = false;
  bool _isSpeaking = false;
  bool _isInitialized = false;

  /// Initialize voice services
  Future<bool> initialize() async {
    try {
      AppLogger.info('Initializing Voice Service...');
      
      // Initialize speech-to-text
      final speechInitialized = await _speech.initialize(
        onError: (error) {
          AppLogger.error('Speech recognition error', error);
        },
        onStatus: (status) {
          AppLogger.info('Speech recognition status: $status');
          if (status == 'done' || status == 'notListening') {
            _isListening = false;
          }
        },
      );

      // Initialize text-to-speech
      await _tts.setLanguage('vi-VN'); // Vietnamese
      await _tts.setSpeechRate(0.5);
      await _tts.setVolume(1.0);
      await _tts.setPitch(1.0);

      _tts.setStartHandler(() {
        AppLogger.info('TTS started');
        _isSpeaking = true;
      });

      _tts.setCompletionHandler(() {
        AppLogger.info('TTS completed');
        _isSpeaking = false;
      });

      _tts.setErrorHandler((message) {
        AppLogger.error('TTS error: $message');
        _isSpeaking = false;
      });

      _isInitialized = speechInitialized;
      
      if (_isInitialized) {
        AppLogger.success('Voice Service initialized successfully');
      } else {
        AppLogger.warning('Voice Service initialization failed');
      }
      
      return _isInitialized;
    } catch (e) {
      AppLogger.error('Failed to initialize Voice Service', e);
      return false;
    }
  }

  /// Start listening for speech input
  Future<void> startListening({
    required Function(String) onResult,
    Function(String)? onError,
    String localeId = 'vi_VN',
  }) async {
    if (!_isInitialized) {
      AppLogger.warning('Voice Service not initialized');
      return;
    }

    if (_isListening) {
      AppLogger.warning('Already listening');
      return;
    }

    try {
      AppLogger.info('Starting speech recognition...');
      
      await _speech.listen(
        onResult: (result) {
          if (result.finalResult) {
            AppLogger.info('Speech recognition result: ${result.recognizedWords}');
            onResult(result.recognizedWords);
          }
        },
        localeId: localeId,
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
        partialResults: true,
        onSoundLevelChange: (level) {
          // Handle sound level changes if needed
        },
      );
      
      _isListening = true;
      AppLogger.success('Speech recognition started');
    } catch (e) {
      AppLogger.error('Failed to start speech recognition', e);
      onError?.call(e.toString());
    }
  }

  /// Stop listening for speech input
  Future<void> stopListening() async {
    if (!_isListening) {
      AppLogger.warning('Not currently listening');
      return;
    }

    try {
      await _speech.stop();
      _isListening = false;
      AppLogger.info('Speech recognition stopped');
    } catch (e) {
      AppLogger.error('Failed to stop speech recognition', e);
    }
  }

  /// Speak text using text-to-speech
  Future<void> speak(String text) async {
    if (!_isInitialized) {
      AppLogger.warning('Voice Service not initialized');
      return;
    }

    if (_isSpeaking) {
      AppLogger.warning('Already speaking');
      return;
    }

    try {
      AppLogger.info('Speaking text: ${text.substring(0, text.length > 50 ? 50 : text.length)}...');
      
      await _tts.speak(text);
      AppLogger.success('Text-to-speech started');
    } catch (e) {
      AppLogger.error('Failed to speak text', e);
    }
  }

  /// Stop speaking
  Future<void> stopSpeaking() async {
    if (!_isSpeaking) {
      AppLogger.warning('Not currently speaking');
      return;
    }

    try {
      await _tts.stop();
      _isSpeaking = false;
      AppLogger.info('Text-to-speech stopped');
    } catch (e) {
      AppLogger.error('Failed to stop text-to-speech', e);
    }
  }

  /// Check if speech recognition is available
  Future<bool> isSpeechAvailable() async {
    if (!_isInitialized) {
      return false;
    }
    
    return await _speech.hasPermission && await _speech.isAvailable();
  }

  /// Get available languages for speech recognition
  Future<List<LocaleName>> getAvailableLanguages() async {
    if (!_isInitialized) {
      return [];
    }
    
    return await _speech.locales();
  }

  /// Set language for text-to-speech
  Future<void> setTtsLanguage(String languageCode) async {
    try {
      await _tts.setLanguage(languageCode);
      AppLogger.info('TTS language set to: $languageCode');
    } catch (e) {
      AppLogger.error('Failed to set TTS language', e);
    }
  }

  /// Set speech rate for text-to-speech
  Future<void> setSpeechRate(double rate) async {
    try {
      await _tts.setSpeechRate(rate);
      AppLogger.info('TTS speech rate set to: $rate');
    } catch (e) {
      AppLogger.error('Failed to set TTS speech rate', e);
    }
  }

  /// Set volume for text-to-speech
  Future<void> setVolume(double volume) async {
    try {
      await _tts.setVolume(volume);
      AppLogger.info('TTS volume set to: $volume');
    } catch (e) {
      AppLogger.error('Failed to set TTS volume', e);
    }
  }

  /// Get current status
  bool get isListening => _isListening;
  bool get isSpeaking => _isSpeaking;
  bool get isInitialized => _isInitialized;

  /// Dispose resources
  Future<void> dispose() async {
    try {
      await _speech.stop();
      await _tts.stop();
      _isListening = false;
      _isSpeaking = false;
      _isInitialized = false;
      AppLogger.info('Voice Service disposed');
    } catch (e) {
      AppLogger.error('Error disposing Voice Service', e);
    }
  }
}
