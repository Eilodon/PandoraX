import 'dart:math';
import 'package:ai_domain/ai_domain.dart';
import 'package:core_utils/core_utils.dart';

/// Service for advanced voice processing
class VoiceProcessingService {
  static final VoiceProcessingService _instance = VoiceProcessingService._internal();
  factory VoiceProcessingService() => _instance;
  VoiceProcessingService._internal();

  bool _isInitialized = false;
  final List<double> _noiseLevels = [];
  final List<double> _voiceLevels = [];
  double _noiseThreshold = 0.1;
  double _voiceThreshold = 0.3;
  int _maxSamples = 100;

  /// Initialize voice processing service
  Future<bool> initialize() async {
    try {
      AppLogger.info('Initializing Voice Processing Service...');
      
      _isInitialized = true;
      AppLogger.success('Voice Processing Service initialized successfully');
      return true;
    } catch (e) {
      AppLogger.error('Failed to initialize Voice Processing Service', e);
      return false;
    }
  }

  /// Process voice input with noise reduction
  String processVoiceInput(String input, {
    bool enableNoiseReduction = true,
    bool enableVoiceEnhancement = true,
    bool enablePunctuation = true,
  }) {
    if (!_isInitialized) {
      AppLogger.warning('Voice Processing Service not initialized');
      return input;
    }

    try {
      AppLogger.info('Processing voice input: ${input.substring(0, input.length > 50 ? 50 : input.length)}...');
      
      String processedInput = input;
      
      // Noise reduction
      if (enableNoiseReduction) {
        processedInput = _reduceNoise(processedInput);
      }
      
      // Voice enhancement
      if (enableVoiceEnhancement) {
        processedInput = _enhanceVoice(processedInput);
      }
      
      // Add punctuation
      if (enablePunctuation) {
        processedInput = _addPunctuation(processedInput);
      }
      
      AppLogger.success('Voice input processed successfully');
      return processedInput;
    } catch (e) {
      AppLogger.error('Failed to process voice input', e);
      return input;
    }
  }

  /// Reduce noise in voice input
  String _reduceNoise(String input) {
    // Simple noise reduction by removing common noise patterns
    final noisePatterns = [
      RegExp(r'\b(um|uh|ah|er|like|you know)\b', caseSensitive: false),
      RegExp(r'\s+'), // Multiple spaces
      RegExp(r'[^\w\s.,!?]'), // Special characters except punctuation
    ];

    String cleaned = input;
    for (final pattern in noisePatterns) {
      cleaned = cleaned.replaceAll(pattern, ' ');
    }

    // Remove extra spaces
    cleaned = cleaned.replaceAll(RegExp(r'\s+'), ' ').trim();
    
    return cleaned;
  }

  /// Enhance voice input
  String _enhanceVoice(String input) {
    // Capitalize first letter of sentences
    String enhanced = input;
    
    // Split into sentences
    final sentences = enhanced.split(RegExp(r'[.!?]+'));
    final processedSentences = <String>[];
    
    for (final sentence in sentences) {
      final trimmed = sentence.trim();
      if (trimmed.isNotEmpty) {
        final capitalized = trimmed[0].toUpperCase() + trimmed.substring(1);
        processedSentences.add(capitalized);
      }
    }
    
    // Join sentences with proper punctuation
    enhanced = processedSentences.join('. ');
    if (enhanced.isNotEmpty && !enhanced.endsWith('.') && !enhanced.endsWith('!') && !enhanced.endsWith('?')) {
      enhanced += '.';
    }
    
    return enhanced;
  }

  /// Add punctuation to voice input
  String _addPunctuation(String input) {
    if (input.isEmpty) return input;
    
    String punctuated = input;
    
    // Add period at the end if no punctuation
    if (!punctuated.endsWith('.') && !punctuated.endsWith('!') && !punctuated.endsWith('?')) {
      punctuated += '.';
    }
    
    // Add commas before common conjunctions
    final conjunctions = ['and', 'but', 'or', 'so', 'yet', 'for', 'nor'];
    for (final conjunction in conjunctions) {
      final pattern = RegExp(r'\s+$conjunction\s+', caseSensitive: false);
      punctuated = punctuated.replaceAll(pattern, ', $conjunction ');
    }
    
    // Add question mark for question words
    final questionWords = ['what', 'where', 'when', 'why', 'how', 'who', 'which'];
    for (final word in questionWords) {
      if (punctuated.toLowerCase().startsWith(word) && !punctuated.endsWith('?')) {
        punctuated = punctuated.replaceAll(RegExp(r'\.$'), '?');
        break;
      }
    }
    
    return punctuated;
  }

  /// Analyze voice quality
  VoiceQuality analyzeVoiceQuality(String input, List<double> audioLevels) {
    try {
      AppLogger.info('Analyzing voice quality...');
      
      final clarity = _calculateClarity(input);
      final volume = _calculateVolume(audioLevels);
      final noise = _calculateNoise(audioLevels);
      final overall = (clarity + volume + (1.0 - noise)) / 3.0;
      
      final quality = VoiceQuality(
        clarity: clarity,
        volume: volume,
        noise: noise,
        overall: overall,
        recommendations: _getRecommendations(clarity, volume, noise),
      );
      
      AppLogger.success('Voice quality analyzed: ${quality.overall.toStringAsFixed(2)}');
      return quality;
    } catch (e) {
      AppLogger.error('Failed to analyze voice quality', e);
      return VoiceQuality(
        clarity: 0.5,
        volume: 0.5,
        noise: 0.5,
        overall: 0.5,
        recommendations: ['Unable to analyze voice quality'],
      );
    }
  }

  /// Calculate clarity score
  double _calculateClarity(String input) {
    if (input.isEmpty) return 0.0;
    
    // Check for common speech recognition errors
    final errorPatterns = [
      RegExp(r'\b(um|uh|ah|er)\b', caseSensitive: false),
      RegExp(r'[^\w\s.,!?]'), // Special characters
      RegExp(r'\s{2,}'), // Multiple spaces
    ];
    
    int errorCount = 0;
    for (final pattern in errorPatterns) {
      errorCount += pattern.allMatches(input).length;
    }
    
    // Calculate clarity based on error count and length
    final errorRate = errorCount / input.length;
    return (1.0 - errorRate).clamp(0.0, 1.0);
  }

  /// Calculate volume score
  double _calculateVolume(List<double> audioLevels) {
    if (audioLevels.isEmpty) return 0.5;
    
    final averageLevel = audioLevels.reduce((a, b) => a + b) / audioLevels.length;
    final maxLevel = audioLevels.reduce(max);
    
    // Volume score based on average and consistency
    final averageScore = (averageLevel / 1.0).clamp(0.0, 1.0);
    final consistencyScore = 1.0 - (maxLevel - averageLevel).abs();
    
    return (averageScore + consistencyScore) / 2.0;
  }

  /// Calculate noise score
  double _calculateNoise(List<double> audioLevels) {
    if (audioLevels.isEmpty) return 0.5;
    
    // Calculate noise based on variance in audio levels
    final average = audioLevels.reduce((a, b) => a + b) / audioLevels.length;
    final variance = audioLevels.map((level) => pow(level - average, 2)).reduce((a, b) => a + b) / audioLevels.length;
    
    // Higher variance indicates more noise
    return (variance / 1.0).clamp(0.0, 1.0);
  }

  /// Get recommendations based on analysis
  List<String> _getRecommendations(double clarity, double volume, double noise) {
    final recommendations = <String>[];
    
    if (clarity < 0.6) {
      recommendations.add('Speak more clearly and slowly');
      recommendations.add('Reduce background noise');
    }
    
    if (volume < 0.4) {
      recommendations.add('Speak louder');
      recommendations.add('Move closer to the microphone');
    } else if (volume > 0.8) {
      recommendations.add('Speak softer');
      recommendations.add('Move away from the microphone');
    }
    
    if (noise > 0.6) {
      recommendations.add('Reduce background noise');
      recommendations.add('Use a quieter environment');
    }
    
    if (recommendations.isEmpty) {
      recommendations.add('Voice quality is good');
    }
    
    return recommendations;
  }

  /// Detect speaker emotion
  EmotionDetection detectEmotion(String input, List<double> audioLevels) {
    try {
      AppLogger.info('Detecting speaker emotion...');
      
      final textEmotion = _analyzeTextEmotion(input);
      final audioEmotion = _analyzeAudioEmotion(audioLevels);
      final combinedEmotion = _combineEmotions(textEmotion, audioEmotion);
      
      final detection = EmotionDetection(
        emotion: combinedEmotion,
        confidence: _calculateEmotionConfidence(textEmotion, audioEmotion),
        textEmotion: textEmotion,
        audioEmotion: audioEmotion,
      );
      
      AppLogger.success('Emotion detected: ${detection.emotion}');
      return detection;
    } catch (e) {
      AppLogger.error('Failed to detect emotion', e);
      return EmotionDetection(
        emotion: Emotion.neutral,
        confidence: 0.5,
        textEmotion: Emotion.neutral,
        audioEmotion: Emotion.neutral,
      );
    }
  }

  /// Analyze text emotion
  Emotion _analyzeTextEmotion(String input) {
    final lowerInput = input.toLowerCase();
    
    // Positive emotion indicators
    final positiveWords = ['happy', 'great', 'excellent', 'wonderful', 'amazing', 'love', 'like', 'good', 'yes'];
    final positiveCount = positiveWords.where((word) => lowerInput.contains(word)).length;
    
    // Negative emotion indicators
    final negativeWords = ['sad', 'bad', 'terrible', 'awful', 'hate', 'dislike', 'no', 'angry', 'frustrated'];
    final negativeCount = negativeWords.where((word) => lowerInput.contains(word)).length;
    
    // Exclamation marks indicate excitement
    final exclamationCount = input.split('!').length - 1;
    
    if (positiveCount > negativeCount && exclamationCount > 0) {
      return Emotion.happy;
    } else if (negativeCount > positiveCount) {
      return Emotion.sad;
    } else if (exclamationCount > 2) {
      return Emotion.excited;
    } else {
      return Emotion.neutral;
    }
  }

  /// Analyze audio emotion
  Emotion _analyzeAudioEmotion(List<double> audioLevels) {
    if (audioLevels.isEmpty) return Emotion.neutral;
    
    final averageLevel = audioLevels.reduce((a, b) => a + b) / audioLevels.length;
    final variance = audioLevels.map((level) => pow(level - averageLevel, 2)).reduce((a, b) => a + b) / audioLevels.length;
    
    if (averageLevel > 0.7 && variance > 0.3) {
      return Emotion.excited;
    } else if (averageLevel < 0.3) {
      return Emotion.sad;
    } else {
      return Emotion.neutral;
    }
  }

  /// Combine text and audio emotions
  Emotion _combineEmotions(Emotion textEmotion, Emotion audioEmotion) {
    if (textEmotion == audioEmotion) {
      return textEmotion;
    } else if (textEmotion == Emotion.neutral) {
      return audioEmotion;
    } else if (audioEmotion == Emotion.neutral) {
      return textEmotion;
    } else {
      // If both are different and not neutral, return the more intense one
      return textEmotion;
    }
  }

  /// Calculate emotion confidence
  double _calculateEmotionConfidence(Emotion textEmotion, Emotion audioEmotion) {
    if (textEmotion == audioEmotion) {
      return 0.9; // High confidence when both agree
    } else if (textEmotion == Emotion.neutral || audioEmotion == Emotion.neutral) {
      return 0.6; // Medium confidence when one is neutral
    } else {
      return 0.4; // Low confidence when they disagree
    }
  }

  /// Set noise threshold
  void setNoiseThreshold(double threshold) {
    _noiseThreshold = threshold.clamp(0.0, 1.0);
    AppLogger.info('Noise threshold set to: $_noiseThreshold');
  }

  /// Set voice threshold
  void setVoiceThreshold(double threshold) {
    _voiceThreshold = threshold.clamp(0.0, 1.0);
    AppLogger.info('Voice threshold set to: $_voiceThreshold');
  }

  /// Check if service is initialized
  bool get isInitialized => _isInitialized;

  /// Dispose service
  Future<void> dispose() async {
    _noiseLevels.clear();
    _voiceLevels.clear();
    _isInitialized = false;
    AppLogger.info('Voice Processing Service disposed');
  }
}

/// Voice quality analysis result
class VoiceQuality {
  final double clarity;
  final double volume;
  final double noise;
  final double overall;
  final List<String> recommendations;

  const VoiceQuality({
    required this.clarity,
    required this.volume,
    required this.noise,
    required this.overall,
    required this.recommendations,
  });
}

/// Emotion detection result
class EmotionDetection {
  final Emotion emotion;
  final double confidence;
  final Emotion textEmotion;
  final Emotion audioEmotion;

  const EmotionDetection({
    required this.emotion,
    required this.confidence,
    required this.textEmotion,
    required this.audioEmotion,
  });
}

/// Emotion types
enum Emotion {
  happy,
  sad,
  excited,
  angry,
  neutral,
  surprised,
  fearful,
  disgusted,
}
