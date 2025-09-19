// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ml_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MLConfigImpl _$$MLConfigImplFromJson(Map<String, dynamic> json) =>
    _$MLConfigImpl(
      enablePredictiveAnalytics:
          json['enablePredictiveAnalytics'] as bool? ?? false,
      enablePersonalization: json['enablePersonalization'] as bool? ?? false,
      enableRecommendationEngine:
          json['enableRecommendationEngine'] as bool? ?? false,
      enableAnomalyDetection: json['enableAnomalyDetection'] as bool? ?? false,
      enablePatternRecognition:
          json['enablePatternRecognition'] as bool? ?? false,
      enableNaturalLanguageProcessing:
          json['enableNaturalLanguageProcessing'] as bool? ?? false,
      enableComputerVision: json['enableComputerVision'] as bool? ?? false,
      enableSpeechRecognition:
          json['enableSpeechRecognition'] as bool? ?? false,
      enableSentimentAnalysis:
          json['enableSentimentAnalysis'] as bool? ?? false,
      confidenceThreshold:
          (json['confidenceThreshold'] as num?)?.toDouble() ?? 0.8,
      maxTrainingSamples: (json['maxTrainingSamples'] as num?)?.toInt() ?? 1000,
      maxModelRetries: (json['maxModelRetries'] as num?)?.toInt() ?? 10,
      modelUpdateIntervalDays:
          (json['modelUpdateIntervalDays'] as num?)?.toInt() ?? 30,
      enableModelCaching: json['enableModelCaching'] as bool? ?? true,
      maxCacheSizeMB: (json['maxCacheSizeMB'] as num?)?.toInt() ?? 100,
      cacheExpirationDays: (json['cacheExpirationDays'] as num?)?.toInt() ?? 7,
      enablePrivacyMode: json['enablePrivacyMode'] as bool? ?? true,
      enableDataAnonymization: json['enableDataAnonymization'] as bool? ?? true,
      enableCloudProcessing: json['enableCloudProcessing'] as bool? ?? false,
      cloudEndpoint: json['cloudEndpoint'] as String? ?? '',
      apiKey: json['apiKey'] as String? ?? '',
    );

Map<String, dynamic> _$$MLConfigImplToJson(_$MLConfigImpl instance) =>
    <String, dynamic>{
      'enablePredictiveAnalytics': instance.enablePredictiveAnalytics,
      'enablePersonalization': instance.enablePersonalization,
      'enableRecommendationEngine': instance.enableRecommendationEngine,
      'enableAnomalyDetection': instance.enableAnomalyDetection,
      'enablePatternRecognition': instance.enablePatternRecognition,
      'enableNaturalLanguageProcessing':
          instance.enableNaturalLanguageProcessing,
      'enableComputerVision': instance.enableComputerVision,
      'enableSpeechRecognition': instance.enableSpeechRecognition,
      'enableSentimentAnalysis': instance.enableSentimentAnalysis,
      'confidenceThreshold': instance.confidenceThreshold,
      'maxTrainingSamples': instance.maxTrainingSamples,
      'maxModelRetries': instance.maxModelRetries,
      'modelUpdateIntervalDays': instance.modelUpdateIntervalDays,
      'enableModelCaching': instance.enableModelCaching,
      'maxCacheSizeMB': instance.maxCacheSizeMB,
      'cacheExpirationDays': instance.cacheExpirationDays,
      'enablePrivacyMode': instance.enablePrivacyMode,
      'enableDataAnonymization': instance.enableDataAnonymization,
      'enableCloudProcessing': instance.enableCloudProcessing,
      'cloudEndpoint': instance.cloudEndpoint,
      'apiKey': instance.apiKey,
    };

_$ClassificationModelImpl _$$ClassificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ClassificationModelImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ClassificationModelImplToJson(
        _$ClassificationModelImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$RegressionModelImpl _$$RegressionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RegressionModelImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$RegressionModelImplToJson(
        _$RegressionModelImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$ClusteringModelImpl _$$ClusteringModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ClusteringModelImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ClusteringModelImplToJson(
        _$ClusteringModelImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$RecommendationModelImpl _$$RecommendationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RecommendationModelImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$RecommendationModelImplToJson(
        _$RecommendationModelImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$NLPModelImpl _$$NLPModelImplFromJson(Map<String, dynamic> json) =>
    _$NLPModelImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$NLPModelImplToJson(_$NLPModelImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$VisionModelImpl _$$VisionModelImplFromJson(Map<String, dynamic> json) =>
    _$VisionModelImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$VisionModelImplToJson(_$VisionModelImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$SpeechModelImpl _$$SpeechModelImplFromJson(Map<String, dynamic> json) =>
    _$SpeechModelImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SpeechModelImplToJson(_$SpeechModelImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$MLModelMetricsImpl _$$MLModelMetricsImplFromJson(Map<String, dynamic> json) =>
    _$MLModelMetricsImpl(
      accuracy: (json['accuracy'] as num).toDouble(),
      precision: (json['precision'] as num).toDouble(),
      recall: (json['recall'] as num).toDouble(),
      f1Score: (json['f1Score'] as num).toDouble(),
      confidence: (json['confidence'] as num).toDouble(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      trainingSamples: (json['trainingSamples'] as num).toInt(),
      predictionCount: (json['predictionCount'] as num).toInt(),
    );

Map<String, dynamic> _$$MLModelMetricsImplToJson(
        _$MLModelMetricsImpl instance) =>
    <String, dynamic>{
      'accuracy': instance.accuracy,
      'precision': instance.precision,
      'recall': instance.recall,
      'f1Score': instance.f1Score,
      'confidence': instance.confidence,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'trainingSamples': instance.trainingSamples,
      'predictionCount': instance.predictionCount,
    };
