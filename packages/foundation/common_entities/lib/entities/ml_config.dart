import 'package:freezed_annotation/freezed_annotation.dart';

part 'ml_config.freezed.dart';
part 'ml_config.g.dart';

/// ML configuration entity
@freezed
class MLConfig with _$MLConfig {
  const factory MLConfig({
    @Default(true) bool enableMLFeatures,
    @Default(true) bool enablePredictiveAnalytics,
    @Default(true) bool enablePersonalization,
    @Default(true) bool enableRecommendationEngine,
    @Default(true) bool enableAnomalyDetection,
    @Default(true) bool enablePatternRecognition,
    @Default(true) bool enableNaturalLanguageProcessing,
    @Default(true) bool enableComputerVision,
    @Default(true) bool enableSpeechRecognition,
    @Default(true) bool enableSentimentAnalysis,
    @Default(0.01) double learningRate,
    @Default(0.9) double momentum,
    @Default(0.001) double regularization,
    @Default(32) int batchSize,
    @Default(100) int epochs,
    @Default(1) int optimizationLevel,
  }) = _MLConfig;

  factory MLConfig.fromJson(Map<String, dynamic> json) =>
      _$MLConfigFromJson(json);
}
