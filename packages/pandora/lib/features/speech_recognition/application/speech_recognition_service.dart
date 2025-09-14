import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';

@injectable
class SpeechRecognitionService {
  final SpeechToText _speechToText = SpeechToText();
  bool _isInitialized = false;
  String _recognizedText = '';
  String _partialText = '';
  
  final StreamController<String> _textController = StreamController<String>.broadcast();
  final StreamController<String> _partialTextController = StreamController<String>.broadcast();
  final StreamController<bool> _isListeningController = StreamController<bool>.broadcast();
  final StreamController<String> _errorController = StreamController<String>.broadcast();

  Stream<String> get recognizedTextStream => _textController.stream;
  Stream<String> get partialTextStream => _partialTextController.stream;
  Stream<bool> get isListeningStream => _isListeningController.stream;
  Stream<String> get errorStream => _errorController.stream;

  String get recognizedText => _recognizedText;
  String get partialText => _partialText;
  bool get isInitialized => _isInitialized;

  Future<bool> initialize() async {
    try {
      // Kiểm tra quyền microphone
      final microphoneStatus = await Permission.microphone.request();
      if (microphoneStatus != PermissionStatus.granted) {
        _errorController.add('Cần quyền truy cập microphone để sử dụng tính năng nhận dạng giọng nói');
        return false;
      }

      // Khởi tạo speech_to_text
      final available = await _speechToText.initialize(
        onError: (error) {
          _errorController.add('Lỗi nhận dạng giọng nói: ${error.errorMsg}');
        },
        onStatus: (status) {
          if (status == 'listening') {
            _isListeningController.add(true);
          } else if (status == 'notListening') {
            _isListeningController.add(false);
          }
        },
      );
      
      if (!available) {
        _errorController.add('Nhận dạng giọng nói không khả dụng trên thiết bị này');
        return false;
      }
      
      _isInitialized = true;
      return true;
    } catch (e) {
      _errorController.add('Lỗi khởi tạo nhận dạng giọng nói: $e');
      return false;
    }
  }

  Future<void> startListening() async {
    if (!_isInitialized) {
      _errorController.add('Dịch vụ nhận dạng giọng nói chưa được khởi tạo');
      return;
    }

    try {
      _recognizedText = '';
      _partialText = '';
      
      await _speechToText.listen(
        onResult: (result) {
          _partialText = result.recognizedWords;
          _partialTextController.add(_partialText);
          
          if (result.finalResult) {
            _recognizedText = result.recognizedWords;
            _textController.add(_recognizedText);
            _partialText = '';
            _partialTextController.add('');
          }
        },
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
        partialResults: true,
        localeId: 'vi_VN', // Thử tiếng Việt, fallback về mặc định nếu không hỗ trợ
        onSoundLevelChange: (level) {
          // Có thể sử dụng để hiển thị mức âm thanh
        },
      );
    } catch (e) {
      _errorController.add('Lỗi khi bắt đầu nghe: $e');
      _isListeningController.add(false);
    }
  }

  Future<void> stopListening() async {
    try {
      await _speechToText.stop();
      _isListeningController.add(false);
    } catch (e) {
      _errorController.add('Lỗi khi dừng nghe: $e');
    }
  }

  Future<void> cancelListening() async {
    try {
      await _speechToText.cancel();
      _isListeningController.add(false);
      _recognizedText = '';
      _partialText = '';
      _textController.add('');
      _partialTextController.add('');
    } catch (e) {
      _errorController.add('Lỗi khi hủy nghe: $e');
    }
  }

  void dispose() {
    _speechToText.cancel();
    _textController.close();
    _partialTextController.close();
    _isListeningController.close();
    _errorController.close();
  }
}
