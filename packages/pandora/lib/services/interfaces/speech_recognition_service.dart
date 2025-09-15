/// Abstract interface for speech recognition services
abstract class SpeechRecognitionService {
  /// Initialize the speech recognition service
  Future<bool> initialize();

  /// Check if speech recognition is available on the device
  Future<bool> get isAvailable;

  /// Get list of available languages
  Future<List<String>> getAvailableLanguages();

  /// Start listening for speech input
  Future<void> startListening({
    String? language,
    bool partialResults = true,
    Duration? timeout,
  });

  /// Stop listening for speech input
  Future<void> stopListening();

  /// Cancel current listening session
  Future<void> cancel();

  /// Check if currently listening
  bool get isListening;

  /// Check if speech recognition has permission
  Future<bool> hasPermission();

  /// Request speech recognition permission
  Future<bool> requestPermission();

  /// Get current recognition status
  String get status;

  /// Stream of recognized speech results
  Stream<String> get onResult;

  /// Stream of partial speech results (real-time)
  Stream<String> get onPartialResult;

  /// Stream of recognition errors
  Stream<String> get onError;

  /// Stream of status changes
  Stream<String> get onStatus;

  /// Dispose resources
  void dispose();
}
