import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:core_utils/core_utils.dart';
import 'package:ai_domain/ai_domain.dart';

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
  VoiceLanguage _currentLanguage = VoiceLanguages.vietnamese;
  final Map<String, VoiceLanguage> _supportedLanguages = {};

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

  /// Get current language
  VoiceLanguage get currentLanguage => _currentLanguage;

  /// Set voice language
  Future<void> setLanguage(VoiceLanguage language) async {
    try {
      AppLogger.info('Setting voice language to: ${language.displayName}');
      
      _currentLanguage = language;
      
      // Set TTS language
      if (language.isTTSSupported) {
        await _tts.setLanguage(language.ttsCode);
        await _tts.setSpeechRate(language.defaultSpeechRate);
        await _tts.setVolume(language.defaultVolume);
        await _tts.setPitch(language.defaultPitch);
      }
      
      AppLogger.success('Voice language set to: ${language.displayName}');
    } catch (e) {
      AppLogger.error('Failed to set voice language', e);
    }
  }

  /// Get supported languages
  List<VoiceLanguage> getSupportedLanguages() {
    return VoiceLanguages.all;
  }

  /// Get languages by region
  List<VoiceLanguage> getLanguagesByRegion(String region) {
    return VoiceLanguages.getByRegion(region);
  }

  /// Get language by code
  VoiceLanguage? getLanguageByCode(String code) {
    return VoiceLanguages.getByCode(code);
  }

  /// Check if language is supported for STT
  bool isSTTSupported(VoiceLanguage language) {
    return language.isSTTSupported;
  }

  /// Check if language is supported for TTS
  bool isTTSSupported(VoiceLanguage language) {
    return language.isTTSSupported;
  }

  /// Start listening with specific language
  Future<void> startListeningWithLanguage({
    required Function(String) onResult,
    Function(String)? onError,
    VoiceLanguage? language,
  }) async {
    final targetLanguage = language ?? _currentLanguage;
    await setLanguage(targetLanguage);
    
    await startListening(
      onResult: onResult,
      onError: onError,
      localeId: targetLanguage.sttCode,
    );
  }

  /// Speak text with specific language
  Future<void> speakWithLanguage(
    String text, {
    VoiceLanguage? language,
    double? speechRate,
    double? volume,
    double? pitch,
  }) async {
    final targetLanguage = language ?? _currentLanguage;
    await setLanguage(targetLanguage);
    
    // Override with custom parameters if provided
    if (speechRate != null) await _tts.setSpeechRate(speechRate);
    if (volume != null) await _tts.setVolume(volume);
    if (pitch != null) await _tts.setPitch(pitch);
    
    await speak(text);
  }

  /// Get voice configuration for current language
  Map<String, dynamic> getVoiceConfig() {
    return _currentLanguage.ttsConfig;
  }

  /// Set voice configuration
  Future<void> setVoiceConfig({
    double? speechRate,
    double? volume,
    double? pitch,
  }) async {
    try {
      if (speechRate != null) await _tts.setSpeechRate(speechRate);
      if (volume != null) await _tts.setVolume(volume);
      if (pitch != null) await _tts.setPitch(pitch);
      
      AppLogger.info('Voice configuration updated');
    } catch (e) {
      AppLogger.error('Failed to set voice configuration', e);
    }
  }

  /// Get available voices for current language
  Future<List<dynamic>> getAvailableVoices() async {
    try {
      final voices = await _tts.getVoices;
      return voices ?? [];
    } catch (e) {
      AppLogger.error('Failed to get available voices', e);
      return [];
    }
  }

  /// Set voice
  Future<void> setVoice(String voice) async {
    try {
      await _tts.setVoice({'name': voice, 'locale': _currentLanguage.ttsCode});
      AppLogger.info('Voice set to: $voice');
    } catch (e) {
      AppLogger.error('Failed to set voice', e);
    }
  }

  /// Dispose resources
  Future<void> dispose() async {
    try {
      await _speech.stop();
      await _tts.stop();
      _isListening = false;
      _isSpeaking = false;
      _isInitialized = false;
      _supportedLanguages.clear();
      AppLogger.info('Voice Service disposed');
    } catch (e) {
      AppLogger.error('Error disposing Voice Service', e);
    }
  }
}
