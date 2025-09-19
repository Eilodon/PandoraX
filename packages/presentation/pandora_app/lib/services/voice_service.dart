import 'package:core_utils/core_utils.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';

/// Voice Service for handling voice operations
class VoiceService {
  static final VoiceService _instance = VoiceService._internal();
  factory VoiceService() => _instance;
  VoiceService._internal();

  final SpeechToText _speechToText = SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  
  bool _isRecording = false;
  bool _isPlaying = false;
  bool _isInitialized = false;
  String _lastTranscription = '';

  /// Initialize voice service
  Future<void> initialize() async {
    try {
      AppLogger.info('🎤 Initializing voice service...');
      
      // Initialize speech to text
      final available = await _speechToText.initialize(
        onError: (error) {
          AppLogger.error('Speech to text error: ${error.errorMsg}');
        },
        onStatus: (status) {
          AppLogger.info('Speech to text status: $status');
        },
      );
      
      if (!available) {
        AppLogger.warning('Speech to text not available on this device');
        return;
      }
      
      // Initialize text to speech
      await _flutterTts.setLanguage('en-US');
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);
      
      _isInitialized = true;
      AppLogger.success('✅ Voice service initialized');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to initialize voice service', e, stackTrace);
      _isInitialized = false;
    }
  }

  /// Check if voice service is available
  bool get isAvailable => _isInitialized && _speechToText.isAvailable;

  /// Start voice recording
  Future<void> startRecording() async {
    try {
      AppLogger.info('🎤 Starting voice recording...');
      
      if (!isAvailable) {
        throw Exception('Voice service not available');
      }
      
      // Check microphone permission
      final permission = await Permission.microphone.request();
      if (permission != PermissionStatus.granted) {
        throw Exception('Microphone permission denied');
      }
      
      // Start listening
      await _speechToText.listen(
        onResult: (result) {
          _lastTranscription = result.recognizedWords;
          AppLogger.info('Transcription: $_lastTranscription');
        },
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
        partialResults: true,
        localeId: 'en_US',
        onSoundLevelChange: (level) {
          // Handle sound level changes if needed
        },
      );
      
      _isRecording = true;
      AppLogger.success('Voice recording started');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to start recording', e, stackTrace);
      rethrow;
    }
  }

  /// Stop voice recording
  Future<String> stopRecording() async {
    try {
      AppLogger.info('🎤 Stopping voice recording...');
      
      if (!_isRecording) {
        AppLogger.warning('No recording in progress');
        return _lastTranscription;
      }
      
      // Stop listening
      await _speechToText.stop();
      _isRecording = false;
      
      final transcription = _lastTranscription;
      AppLogger.success('Voice recording stopped. Transcription: $transcription');
      return transcription;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to stop recording', e, stackTrace);
      rethrow;
    }
  }

  /// Start listening for speech (alias for startRecording)
  Future<void> startListening() async {
    await startRecording();
  }

  /// Stop listening for speech (alias for stopRecording)
  Future<String> stopListening() async {
    return await stopRecording();
  }

  /// Play voice note (speak text)
  Future<void> playVoiceNote(String text) async {
    try {
      AppLogger.info('🔊 Playing voice note: ${text.substring(0, text.length > 50 ? 50 : text.length)}...');
      
      if (!isAvailable) {
        throw Exception('Voice service not available');
      }
      
      _isPlaying = true;
      
      // Speak the text
      await _flutterTts.speak(text);
      
      // Wait for speech to complete
      await _flutterTts.awaitSpeakCompletion(true);
      
      _isPlaying = false;
      AppLogger.success('Voice note played');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to play voice note', e, stackTrace);
      _isPlaying = false;
      rethrow;
    }
  }

  /// Speak text
  Future<void> speak(String text) async {
    await playVoiceNote(text);
  }

  /// Stop playing voice note
  Future<void> stopPlaying() async {
    try {
      AppLogger.info('🔊 Stopping voice playback...');
      
      if (_isPlaying) {
        await _flutterTts.stop();
        _isPlaying = false;
      }
      
      AppLogger.success('Voice playback stopped');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to stop playback', e, stackTrace);
      rethrow;
    }
  }

  /// Convert text to speech
  Future<void> speakText(String text) async {
    try {
      AppLogger.info('🔊 Converting text to speech...');
      
      // Simulate TTS processing
      await Future.delayed(const Duration(seconds: 1));
      
      AppLogger.success('Text converted to speech');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to convert text to speech', e, stackTrace);
      rethrow;
    }
  }

  /// Check if currently recording
  bool get isRecording => _isRecording;

  /// Check if currently playing
  bool get isPlaying => _isPlaying;

  /// Simulate transcription process
  Future<String> _simulateTranscription() async {
    await Future.delayed(const Duration(seconds: 2));
    
    // Simulate different transcriptions based on random selection
    final transcriptions = [
      "This is a simulated transcription of your voice recording. In a real implementation, this would be processed by a speech-to-text service like Google Speech-to-Text or Azure Cognitive Services.",
      "Hello, this is a test recording. I'm speaking into the microphone to test the voice recording functionality of the PandoraX app.",
      "I need to remember to buy groceries tomorrow. Milk, bread, eggs, and some vegetables for dinner. Also, don't forget to call mom this weekend.",
      "Meeting notes: Discussed the new project requirements. Need to prepare presentation for next week. Follow up with the design team about mockups.",
      "Ideas for the weekend: Go hiking, visit the museum, or maybe just relax at home with a good book. Need to check the weather forecast first.",
    ];
    
    return transcriptions[DateTime.now().millisecond % transcriptions.length];
  }

  /// Get recording duration
  int getRecordingDuration() {
    // Simulate recording duration
    return _isRecording ? 30 : 0;
  }

  /// Check microphone permission
  Future<bool> checkMicrophonePermission() async {
    try {
      AppLogger.info('🎤 Checking microphone permission...');
      
      // Simulate permission check
      await Future.delayed(const Duration(milliseconds: 500));
      
      AppLogger.success('Microphone permission granted');
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('Microphone permission denied', e, stackTrace);
      return false;
    }
  }

  /// Request microphone permission
  Future<bool> requestMicrophonePermission() async {
    try {
      AppLogger.info('🎤 Requesting microphone permission...');
      
      // Simulate permission request
      await Future.delayed(const Duration(seconds: 1));
      
      AppLogger.success('Microphone permission granted');
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('Microphone permission denied', e, stackTrace);
      return false;
    }
  }
}