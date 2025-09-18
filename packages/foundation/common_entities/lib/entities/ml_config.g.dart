// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ml_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MLConfigImpl _$$MLConfigImplFromJson(Map<String, dynamic> json) =>
    _$MLConfigImpl(
      enableMLFeatures: json['enableMLFeatures'] as bool? ?? true,
      enablePredictiveAnalytics:
          json['enablePredictiveAnalytics'] as bool? ?? true,
      enablePersonalization: json['enablePersonalization'] as bool? ?? true,
      enableRecommendationEngine:
          json['enableRecommendationEngine'] as bool? ?? true,
      enableAnomalyDetection: json['enableAnomalyDetection'] as bool? ?? true,
      enablePatternRecognition:
          json['enablePatternRecognition'] as bool? ?? true,
      enableNaturalLanguageProcessing:
          json['enableNaturalLanguageProcessing'] as bool? ?? true,
      enableComputerVision: json['enableComputerVision'] as bool? ?? true,
      enableSpeechRecognition: json['enableSpeechRecognition'] as bool? ?? true,
      enableSentimentAnalysis: json['enableSentimentAnalysis'] as bool? ?? true,
      learningRate: (json['learningRate'] as num?)?.toDouble() ?? 0.01,
      momentum: (json['momentum'] as num?)?.toDouble() ?? 0.9,
      regularization: (json['regularization'] as num?)?.toDouble() ?? 0.001,
      batchSize: (json['batchSize'] as num?)?.toInt() ?? 32,
      epochs: (json['epochs'] as num?)?.toInt() ?? 100,
      optimizationLevel: (json['optimizationLevel'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$MLConfigImplToJson(_$MLConfigImpl instance) =>
    <String, dynamic>{
      'enableMLFeatures': instance.enableMLFeatures,
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
      'learningRate': instance.learningRate,
      'momentum': instance.momentum,
      'regularization': instance.regularization,
      'batchSize': instance.batchSize,
      'epochs': instance.epochs,
      'optimizationLevel': instance.optimizationLevel,
    };
