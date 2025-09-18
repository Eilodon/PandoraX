import 'dart:io';
import 'dart:typed_data';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import '../config/voice_config.dart';

/// FPT.AI Text-to-Speech Service
/// High-quality Vietnamese TTS with multiple voice options
@injectable
class FptTtsService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  /// Convert text to speech using FPT.AI API
  Future<Uint8List?> textToSpeech(
    String text, {
    String? voice,
    double? speed,
    double? volume,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(VoiceConfig.fptTtsUrl),
        headers: {
          'api-key': VoiceConfig.fptApiKey,
          'voice': voice ?? VoiceConfig.defaultVoice,
          'speed': (speed ?? VoiceConfig.defaultSpeed).toString(),
          'format': VoiceConfig.audioFormat,
        },
        body: text,
      );
      
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception('FPT.AI TTS API error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Lỗi FPT.AI TTS: $e');
    }
  }
  
  /// Convert text to speech and save to file
  Future<String?> textToSpeechFile(
    String text, {
    String? voice,
    double? speed,
    double? volume,
    String? fileName,
  }) async {
    try {
      final audioBytes = await textToSpeech(
        text,
        voice: voice,
        speed: speed,
        volume: volume,
      );
      
      if (audioBytes == null) return null;
      
      final tempDir = await getTemporaryDirectory();
      final audioFile = File('${tempDir.path}/${fileName ?? 'tts_${DateTime.now().millisecondsSinceEpoch}.mp3'}');
      await audioFile.writeAsBytes(audioBytes);
      
      return audioFile.path;
    } catch (e) {
      throw Exception('Lỗi tạo file TTS: $e');
    }
  }
  
  /// Play text as speech
  Future<void> speakText(
    String text, {
    String? voice,
    double? speed,
    double? volume,
    Function()? onComplete,
    Function(String)? onError,
  }) async {
    try {
      final audioFile = await textToSpeechFile(
        text,
        voice: voice,
        speed: speed,
        volume: volume,
      );
      
      if (audioFile == null) {
        onError?.call('Không thể tạo audio từ text');
        return;
      }
      
      await _audioPlayer.play(DeviceFileSource(audioFile));
      
      _audioPlayer.onPlayerComplete.listen((_) {
        onComplete?.call();
      });
      
      _audioPlayer.onPlayerStateChanged.listen((state) {
        if (state == PlayerState.stopped) {
          // Clean up temp file
          File(audioFile).delete().catchError((_) {});
        }
      });
    } catch (e) {
      onError?.call('Lỗi phát âm: $e');
    }
  }
  
  /// Get available voices
  List<Map<String, String>> getAvailableVoices() {
    return VoiceConfig.vietnameseVoices.entries
        .map((entry) => {
          'id': entry.key,
          'name': entry.value,
          'language': 'vi-VN',
        })
        .toList();
  }
  
  /// Validate voice ID
  bool isValidVoice(String voiceId) {
    return VoiceConfig.vietnameseVoices.containsKey(voiceId);
  }
  
  /// Get voice information
  Map<String, dynamic>? getVoiceInfo(String voiceId) {
    if (!isValidVoice(voiceId)) return null;
    
    return {
      'id': voiceId,
      'name': VoiceConfig.vietnameseVoices[voiceId],
      'language': 'vi-VN',
      'gender': _getVoiceGender(voiceId),
      'region': _getVoiceRegion(voiceId),
    };
  }
  
  /// Get voice gender
  String _getVoiceGender(String voiceId) {
    switch (voiceId) {
      case 'banmai':
      case 'linhsan':
      case 'thuminh':
      case 'lannhi':
        return 'female';
      case 'minhquan':
        return 'male';
      default:
        return 'unknown';
    }
  }
  
  /// Get voice region
  String _getVoiceRegion(String voiceId) {
    switch (voiceId) {
      case 'banmai':
      case 'minhquan':
        return 'north';
      case 'thuminh':
        return 'central';
      case 'linhsan':
      case 'lannhi':
        return 'south';
      default:
        return 'unknown';
    }
  }
  
  /// Check API quota and limits
  Future<Map<String, dynamic>> getApiStatus() async {
    try {
      // TODO: Implement API status check
      // This would check remaining quota, rate limits, etc.
      return {
        'status': 'active',
        'quota_remaining': 1000,
        'quota_limit': 1000,
        'reset_time': DateTime.now().add(const Duration(days: 1)).toIso8601String(),
      };
    } catch (e) {
      return {
        'status': 'error',
        'error': e.toString(),
      };
    }
  }
  
  /// Stop current speech
  Future<void> stopSpeaking() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      // Ignore errors when stopping
    }
  }
  
  /// Pause current speech
  Future<void> pauseSpeaking() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      // Ignore errors when pausing
    }
  }
  
  /// Resume paused speech
  Future<void> resumeSpeaking() async {
    try {
      await _audioPlayer.resume();
    } catch (e) {
      // Ignore errors when resuming
    }
  }
  
  /// Check if currently speaking
  bool get isSpeaking => _audioPlayer.state == PlayerState.playing;
  
  /// Get current playback position
  Future<Duration?> getCurrentPosition() async {
    try {
      return await _audioPlayer.getCurrentPosition();
    } catch (e) {
      return null;
    }
  }
  
  /// Set playback speed
  Future<void> setPlaybackSpeed(double speed) async {
    try {
      await _audioPlayer.setPlaybackRate(speed);
    } catch (e) {
      // Ignore errors
    }
  }
  
  /// Set volume
  Future<void> setVolume(double volume) async {
    try {
      await _audioPlayer.setVolume(volume);
    } catch (e) {
      // Ignore errors
    }
  }
  
  /// Dispose resources
  void dispose() {
    _audioPlayer.dispose();
  }
}
