import 'dart:io';
import 'dart:typed_data';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

/// PhoWhisper Offline Speech Recognition Service
/// Vietnamese-optimized ASR model for offline speech recognition
@injectable
class PhoWhisperService {
  static const String _modelUrl = 'https://huggingface.co/uitnlp/PhoWhisper/resolve/main/';
  static const String _modelFileName = 'phowhisper_model.bin';
  static const int _modelSize = 1500 * 1024 * 1024; // ~1.5GB
  
  bool _isModelDownloaded = false;
  bool _isModelLoaded = false;
  String? _modelPath;
  
  /// Check if PhoWhisper model is available
  Future<bool> isModelAvailable() async {
    if (_isModelDownloaded) return true;
    
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final modelFile = File('${appDir.path}/$_modelFileName');
      _isModelDownloaded = await modelFile.exists();
      
      if (_isModelDownloaded) {
        _modelPath = modelFile.path;
      }
      
      return _isModelDownloaded;
    } catch (e) {
      return false;
    }
  }
  
  /// Download PhoWhisper model
  Future<bool> downloadModel({
    Function(double)? onProgress,
    Function(String)? onStatus,
  }) async {
    try {
      onStatus?.call('Bắt đầu tải xuống PhoWhisper model...');
      
      final appDir = await getApplicationDocumentsDirectory();
      final modelFile = File('${appDir.path}/$_modelFileName');
      
      // Check if already downloaded
      if (await modelFile.exists()) {
        _isModelDownloaded = true;
        _modelPath = modelFile.path;
        onStatus?.call('Model đã được tải xuống trước đó');
        return true;
      }
      
      // Download model
      final response = await http.get(
        Uri.parse('$_modelUrl$_modelFileName'),
        headers: {'User-Agent': 'PandoraX/1.0'},
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to download model: ${response.statusCode}');
      }
      
      // Save model file
      await modelFile.writeAsBytes(response.bodyBytes);
      
      _isModelDownloaded = true;
      _modelPath = modelFile.path;
      
      onStatus?.call('Đã tải xuống PhoWhisper model thành công');
      return true;
    } catch (e) {
      onStatus?.call('Lỗi tải xuống model: $e');
      return false;
    }
  }
  
  /// Load PhoWhisper model into memory
  Future<bool> loadModel() async {
    if (!_isModelDownloaded || _modelPath == null) {
      return false;
    }
    
    try {
      // TODO: Implement actual model loading
      // This would involve loading the PhoWhisper model into memory
      // and initializing the inference engine
      
      _isModelLoaded = true;
      return true;
    } catch (e) {
      return false;
    }
  }
  
  /// Transcribe audio using PhoWhisper
  Future<String> transcribeAudio(String audioFilePath) async {
    if (!_isModelLoaded) {
      throw Exception('PhoWhisper model chưa được tải');
    }
    
    try {
      // TODO: Implement actual transcription
      // This would:
      // 1. Load audio file
      // 2. Preprocess audio (convert to required format)
      // 3. Run inference with PhoWhisper model
      // 4. Post-process output
      // 5. Return transcribed text
      
      // For now, return mock result
      return 'Đây là kết quả transcribe từ PhoWhisper (mock)';
    } catch (e) {
      throw Exception('Lỗi transcribe audio: $e');
    }
  }
  
  /// Transcribe audio from bytes
  Future<String> transcribeAudioBytes(Uint8List audioBytes) async {
    if (!_isModelLoaded) {
      throw Exception('PhoWhisper model chưa được tải');
    }
    
    try {
      // TODO: Implement transcription from bytes
      return 'Đây là kết quả transcribe từ bytes (mock)';
    } catch (e) {
      throw Exception('Lỗi transcribe audio bytes: $e');
    }
  }
  
  /// Get model information
  Map<String, dynamic> getModelInfo() {
    return {
      'name': 'PhoWhisper',
      'version': '1.0',
      'language': 'Vietnamese',
      'size': _modelSize,
      'isDownloaded': _isModelDownloaded,
      'isLoaded': _isModelLoaded,
      'path': _modelPath,
    };
  }
  
  /// Check available disk space
  Future<bool> hasEnoughSpace() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final stat = await appDir.stat();
      final availableSpace = stat.type == FileSystemEntityType.directory
          ? await _getAvailableSpace(appDir.path)
          : 0;
      
      return availableSpace > _modelSize * 2; // Need 2x model size for safety
    } catch (e) {
      return false;
    }
  }
  
  /// Get available disk space
  Future<int> _getAvailableSpace(String path) async {
    try {
      final result = await Process.run('df', [path]);
      if (result.exitCode == 0) {
        final lines = result.stdout.toString().split('\n');
        if (lines.length > 1) {
          final fields = lines[1].split(RegExp(r'\s+'));
          if (fields.length > 3) {
            return int.parse(fields[3]) * 1024; // Convert to bytes
          }
        }
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }
  
  /// Delete model file
  Future<bool> deleteModel() async {
    try {
      if (_modelPath != null) {
        final modelFile = File(_modelPath!);
        if (await modelFile.exists()) {
          await modelFile.delete();
          _isModelDownloaded = false;
          _isModelLoaded = false;
          _modelPath = null;
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }
  
  /// Get model download progress (mock implementation)
  Future<double> getDownloadProgress() async {
    // TODO: Implement actual download progress tracking
    return _isModelDownloaded ? 1.0 : 0.0;
  }
}
