import 'package:freezed_annotation/freezed_annotation.dart';

part 'ml_config.freezed.dart';
part 'ml_config.g.dart';

/// Machine Learning configuration
@freezed
class MLConfig with _$MLConfig {
  const factory MLConfig({
    @Default(false) bool enablePredictiveAnalytics,
    @Default(false) bool enablePersonalization,
    @Default(false) bool enableRecommendationEngine,
    @Default(false) bool enableAnomalyDetection,
    @Default(false) bool enablePatternRecognition,
    @Default(false) bool enableNaturalLanguageProcessing,
    @Default(false) bool enableComputerVision,
    @Default(false) bool enableSpeechRecognition,
    @Default(false) bool enableSentimentAnalysis,
    @Default(0.8) double confidenceThreshold,
    @Default(1000) int maxTrainingSamples,
    @Default(10) int maxModelRetries,
    @Default(30) int modelUpdateIntervalDays,
    @Default(true) bool enableModelCaching,
    @Default(100) int maxCacheSizeMB,
    @Default(7) int cacheExpirationDays,
    @Default(true) bool enablePrivacyMode,
    @Default(true) bool enableDataAnonymization,
    @Default(false) bool enableCloudProcessing,
    @Default('') String cloudEndpoint,
    @Default('') String apiKey,
  }) = _MLConfig;

  factory MLConfig.fromJson(Map<String, dynamic> json) =>
      _$MLConfigFromJson(json);
}

/// ML model types
@freezed
class MLModelType with _$MLModelType {
  const factory MLModelType.classification() = ClassificationModel;
  const factory MLModelType.regression() = RegressionModel;
  const factory MLModelType.clustering() = ClusteringModel;
  const factory MLModelType.recommendation() = RecommendationModel;
  const factory MLModelType.nlp() = NLPModel;
  const factory MLModelType.vision() = VisionModel;
  const factory MLModelType.speech() = SpeechModel;

  factory MLModelType.fromJson(Map<String, dynamic> json) =>
      _$MLModelTypeFromJson(json);
}

/// ML model performance metrics
@freezed
class MLModelMetrics with _$MLModelMetrics {
  const factory MLModelMetrics({
    required double accuracy,
    required double precision,
    required double recall,
    required double f1Score,
    required double confidence,
    required DateTime lastUpdated,
    required int trainingSamples,
    required int predictionCount,
  }) = _MLModelMetrics;

  factory MLModelMetrics.fromJson(Map<String, dynamic> json) =>
      _$MLModelMetricsFromJson(json);
}