import 'dart:async';
import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:convert';

/// Advanced Voice Interaction Service
/// Combines offline STT with high-quality TTS for seamless Vietnamese voice interaction
@injectable
class VoiceInteractionService {
  final SpeechToText _speechToText = SpeechToText();
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  // Configuration
  static const String _fptTtsApiUrl = 'https://api.fpt.ai/hmi/tts/v5';
  static const String _fptApiKey = '0yIksLsjgseDhDBTi5Zfcxk7GD50H3RW'; // FPT TTS-STT API Key
  
  // State management
  bool _isInitialized = false;
  bool _isListening = false;
  bool _isSpeaking = false;
  
  // Stream controllers
  final StreamController<String> _recognizedTextController = StreamController<String>.broadcast();
  final StreamController<String> _partialTextController = StreamController<String>.broadcast();
  final StreamController<bool> _isListeningController = StreamController<bool>.broadcast();
  final StreamController<bool> _isSpeakingController = StreamController<bool>.broadcast();
  final StreamController<String> _errorController = StreamController<String>.broadcast();
  
  // Getters
  Stream<String> get recognizedTextStream => _recognizedTextController.stream;
  Stream<String> get partialTextStream => _partialTextController.stream;
  Stream<bool> get isListeningStream => _isListeningController.stream;
  Stream<bool> get isSpeakingStream => _isSpeakingController.stream;
  Stream<String> get errorStream => _errorController.stream;
  
  bool get isInitialized => _isInitialized;
  bool get isListening => _isListening;
  bool get isSpeaking => _isSpeaking;

  /// Initialize the voice interaction service
  Future<bool> initialize() async {
    try {
      // Check microphone permission
      final microphoneStatus = await Permission.microphone.request();
      if (microphoneStatus != PermissionStatus.granted) {
        _errorController.add('Cần quyền truy cập microphone để sử dụng tính năng giọng nói');
        return false;
      }

      // Initialize speech-to-text
      final available = await _speechToText.initialize(
        onError: (error) {
          _errorController.add('Lỗi nhận dạng giọng nói: ${error.errorMsg}');
        },
        onStatus: (status) {
          _isListening = (status == 'listening');
          _isListeningController.add(_isListening);
        },
      );
      
      if (!available) {
        _errorController.add('Nhận dạng giọng nói không khả dụng trên thiết bị này');
        return false;
      }
      
      _isInitialized = true;
      return true;
    } catch (e) {
      _errorController.add('Lỗi khởi tạo dịch vụ giọng nói: $e');
      return false;
    }
  }

  /// Start listening for voice input
  Future<void> startListening() async {
    if (!_isInitialized) {
      _errorController.add('Dịch vụ giọng nói chưa được khởi tạo');
      return;
    }

    try {
      await _speechToText.listen(
        onResult: (result) {
          _partialTextController.add(result.recognizedWords);
          
          if (result.finalResult) {
            _recognizedTextController.add(result.recognizedWords);
          }
        },
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
        partialResults: true,
        localeId: 'vi_VN', // Vietnamese locale
        onSoundLevelChange: (level) {
          // Can be used for visual feedback
        },
      );
    } catch (e) {
      _errorController.add('Lỗi khi bắt đầu nghe: $e');
    }
  }

  /// Stop listening
  Future<void> stopListening() async {
    try {
      await _speechToText.stop();
      _isListening = false;
      _isListeningController.add(false);
    } catch (e) {
      _errorController.add('Lỗi khi dừng nghe: $e');
    }
  }

  /// Convert text to speech using FPT.AI API
  Future<void> speakText(String text, {String voice = 'banmai'}) async {
    if (text.trim().isEmpty) return;
    
    try {
      _isSpeaking = true;
      _isSpeakingController.add(true);
      
      // Check internet connection
      if (!await _hasInternetConnection()) {
        // Fallback to system TTS
        await _speakWithSystemTts(text);
        return;
      }
      
      // Call FPT.AI TTS API
      final response = await http.post(
        Uri.parse(_fptTtsApiUrl),
        headers: {
          'api-key': _fptApiKey,
          'voice': voice,
          'format': 'mp3',
          'speed': '0.8',
        },
        body: text,
      );
      
      if (response.statusCode == 200) {
        // Save audio file and play
        final audioBytes = response.bodyBytes;
        final tempDir = await getTemporaryDirectory();
        final audioFile = File('${tempDir.path}/tts_${DateTime.now().millisecondsSinceEpoch}.mp3');
        await audioFile.writeAsBytes(audioBytes);
        
        await _audioPlayer.play(DeviceFileSource(audioFile.path));
        
        // Wait for audio to finish
        _audioPlayer.onPlayerComplete.listen((_) {
          _isSpeaking = false;
          _isSpeakingController.add(false);
        });
      } else {
        throw Exception('TTS API error: ${response.statusCode}');
      }
    } catch (e) {
      _errorController.add('Lỗi khi phát âm: $e');
      // Fallback to system TTS
      await _speakWithSystemTts(text);
    }
  }

  /// Fallback to system TTS
  Future<void> _speakWithSystemTts(String text) async {
    try {
      // This would use Flutter TTS package as fallback
      // Implementation depends on Flutter TTS package
      _isSpeaking = false;
      _isSpeakingController.add(false);
    } catch (e) {
      _errorController.add('Lỗi hệ thống TTS: $e');
    }
  }

  /// Check internet connection
  Future<bool> _hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Stop speaking
  Future<void> stopSpeaking() async {
    try {
      await _audioPlayer.stop();
      _isSpeaking = false;
      _isSpeakingController.add(false);
    } catch (e) {
      _errorController.add('Lỗi khi dừng phát âm: $e');
    }
  }

  /// Process voice command with AI and respond
  Future<void> processVoiceCommand(String command) async {
    try {
      // This would integrate with AI service to process the command
      // and generate appropriate response
      
      // For now, simple echo response
      final response = 'Tôi đã nghe bạn nói: $command';
      await speakText(response);
    } catch (e) {
      _errorController.add('Lỗi xử lý lệnh giọng nói: $e');
    }
  }

  /// Dispose resources
  void dispose() {
    _speechToText.cancel();
    _audioPlayer.dispose();
    _recognizedTextController.close();
    _partialTextController.close();
    _isListeningController.close();
    _isSpeakingController.close();
    _errorController.close();
  }
}
