import 'package:freezed_annotation/freezed_annotation.dart';

part 'ml_config.freezed.dart';
part 'ml_config.g.dart';

/// Machine Learning configuration for advanced AI features
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
    @Default(MLModelType.tensorflow) MLModelType modelType,
    @Default(MLFramework.flutter) MLFramework framework,
    @Default(MLOptimizationLevel.standard) MLOptimizationLevel optimizationLevel,
    @Default(MLAccuracyLevel.high) MLAccuracyLevel accuracyLevel,
    @Default(100) int maxTrainingIterations,
    @Default(0.01) double learningRate,
    @Default(0.9) double momentum,
    @Default(0.0001) double regularization,
    @Default(32) int batchSize,
    @Default(10) int epochs,
    @Default(0.8) double trainTestSplit,
    @Default(0.1) double validationSplit,
    @Default(1000) int maxDataPoints,
    @Default(100) int maxFeatures,
    @Default(true) bool enableDataAugmentation,
    @Default(true) bool enableCrossValidation,
    @Default(true) bool enableEarlyStopping,
    @Default(10) int patience,
    @Default(0.1) double minDelta,
    @Default(true) bool enableModelPersistence,
    @Default(true) bool enableModelVersioning,
    @Default(true) bool enableA_BTesting,
    @Default(0.5) double confidenceThreshold,
    @Default(0.7) double precisionThreshold,
    @Default(0.6) double recallThreshold,
    @Default(0.65) double f1Threshold,
    @Default(MLPrivacyLevel.standard) MLPrivacyLevel privacyLevel,
    @Default(true) bool enableFederatedLearning,
    @Default(true) bool enableDifferentialPrivacy,
    @Default(0.1) double noiseLevel,
    @Default(MLDeploymentMode.cloud) MLDeploymentMode deploymentMode,
    @Default(MLInferenceMode.realtime) MLInferenceMode inferenceMode,
    @Default(1000) int maxInferenceLatencyMs,
    @Default(100) int maxConcurrentInferences,
    @Default(true) bool enableModelMonitoring,
    @Default(true) bool enableDriftDetection,
    @Default(0.1) double driftThreshold,
    @Default(true) bool enablePerformanceTracking,
    @Default(true) bool enableErrorTracking,
    @Default(true) bool enableUsageAnalytics,
    Map<String, dynamic>? customSettings,
  }) = _MLConfig;

  const MLConfig._();

  factory MLConfig.fromJson(Map<String, dynamic> json) =>
      _$MLConfigFromJson(json);

  /// Get default ML configuration
  static MLConfig get defaultConfig => const MLConfig();

  /// Get high performance ML configuration
  static MLConfig get highPerformanceConfig => const MLConfig(
    enableMLFeatures: true,
    enablePredictiveAnalytics: true,
    enablePersonalization: true,
    enableRecommendationEngine: true,
    enableAnomalyDetection: true,
    enablePatternRecognition: true,
    enableNaturalLanguageProcessing: true,
    enableComputerVision: true,
    enableSpeechRecognition: true,
    enableSentimentAnalysis: true,
    modelType: MLModelType.tensorflow,
    framework: MLFramework.flutter,
    optimizationLevel: MLOptimizationLevel.high,
    accuracyLevel: MLAccuracyLevel.maximum,
    maxTrainingIterations: 1000,
    learningRate: 0.001,
    momentum: 0.95,
    regularization: 0.00001,
    batchSize: 64,
    epochs: 50,
    trainTestSplit: 0.8,
    validationSplit: 0.1,
    maxDataPoints: 10000,
    maxFeatures: 500,
    enableDataAugmentation: true,
    enableCrossValidation: true,
    enableEarlyStopping: true,
    patience: 20,
    minDelta: 0.01,
    enableModelPersistence: true,
    enableModelVersioning: true,
    enableA_BTesting: true,
    confidenceThreshold: 0.8,
    precisionThreshold: 0.8,
    recallThreshold: 0.8,
    f1Threshold: 0.8,
    privacyLevel: MLPrivacyLevel.high,
    enableFederatedLearning: true,
    enableDifferentialPrivacy: true,
    noiseLevel: 0.05,
    deploymentMode: MLDeploymentMode.edge,
    inferenceMode: MLInferenceMode.realtime,
    maxInferenceLatencyMs: 100,
    maxConcurrentInferences: 1000,
    enableModelMonitoring: true,
    enableDriftDetection: true,
    driftThreshold: 0.05,
    enablePerformanceTracking: true,
    enableErrorTracking: true,
    enableUsageAnalytics: true,
  );

  /// Get privacy-focused ML configuration
  static MLConfig get privacyFocusedConfig => const MLConfig(
    enableMLFeatures: true,
    enablePredictiveAnalytics: true,
    enablePersonalization: false,
    enableRecommendationEngine: true,
    enableAnomalyDetection: true,
    enablePatternRecognition: false,
    enableNaturalLanguageProcessing: true,
    enableComputerVision: false,
    enableSpeechRecognition: false,
    enableSentimentAnalysis: false,
    modelType: MLModelType.tensorflow,
    framework: MLFramework.flutter,
    optimizationLevel: MLOptimizationLevel.standard,
    accuracyLevel: MLAccuracyLevel.medium,
    maxTrainingIterations: 100,
    learningRate: 0.01,
    momentum: 0.9,
    regularization: 0.001,
    batchSize: 16,
    epochs: 10,
    trainTestSplit: 0.7,
    validationSplit: 0.2,
    maxDataPoints: 1000,
    maxFeatures: 50,
    enableDataAugmentation: false,
    enableCrossValidation: true,
    enableEarlyStopping: true,
    patience: 5,
    minDelta: 0.1,
    enableModelPersistence: true,
    enableModelVersioning: true,
    enableA_BTesting: false,
    confidenceThreshold: 0.9,
    precisionThreshold: 0.9,
    recallThreshold: 0.9,
    f1Threshold: 0.9,
    privacyLevel: MLPrivacyLevel.maximum,
    enableFederatedLearning: true,
    enableDifferentialPrivacy: true,
    noiseLevel: 0.2,
    deploymentMode: MLDeploymentMode.local,
    inferenceMode: MLInferenceMode.batch,
    maxInferenceLatencyMs: 5000,
    maxConcurrentInferences: 10,
    enableModelMonitoring: true,
    enableDriftDetection: true,
    driftThreshold: 0.2,
    enablePerformanceTracking: false,
    enableErrorTracking: true,
    enableUsageAnalytics: false,
  );

  /// Get lightweight ML configuration
  static MLConfig get lightweightConfig => const MLConfig(
    enableMLFeatures: true,
    enablePredictiveAnalytics: false,
    enablePersonalization: false,
    enableRecommendationEngine: false,
    enableAnomalyDetection: true,
    enablePatternRecognition: false,
    enableNaturalLanguageProcessing: false,
    enableComputerVision: false,
    enableSpeechRecognition: false,
    enableSentimentAnalysis: false,
    modelType: MLModelType.tflite,
    framework: MLFramework.flutter,
    optimizationLevel: MLOptimizationLevel.low,
    accuracyLevel: MLAccuracyLevel.low,
    maxTrainingIterations: 10,
    learningRate: 0.1,
    momentum: 0.5,
    regularization: 0.01,
    batchSize: 8,
    epochs: 3,
    trainTestSplit: 0.6,
    validationSplit: 0.3,
    maxDataPoints: 100,
    maxFeatures: 10,
    enableDataAugmentation: false,
    enableCrossValidation: false,
    enableEarlyStopping: false,
    patience: 1,
    minDelta: 0.5,
    enableModelPersistence: true,
    enableModelVersioning: false,
    enableA_BTesting: false,
    confidenceThreshold: 0.5,
    precisionThreshold: 0.5,
    recallThreshold: 0.5,
    f1Threshold: 0.5,
    privacyLevel: MLPrivacyLevel.minimal,
    enableFederatedLearning: false,
    enableDifferentialPrivacy: false,
    noiseLevel: 0.0,
    deploymentMode: MLDeploymentMode.local,
    inferenceMode: MLInferenceMode.batch,
    maxInferenceLatencyMs: 10000,
    maxConcurrentInferences: 1,
    enableModelMonitoring: false,
    enableDriftDetection: false,
    driftThreshold: 0.5,
    enablePerformanceTracking: false,
    enableErrorTracking: false,
    enableUsageAnalytics: false,
  );

  /// Check if ML features are enabled
  bool get isMLEnabled => enableMLFeatures;

  /// Check if specific ML feature is enabled
  bool isFeatureEnabled(MLFeature feature) {
    switch (feature) {
      case MLFeature.predictiveAnalytics:
        return enablePredictiveAnalytics;
      case MLFeature.personalization:
        return enablePersonalization;
      case MLFeature.recommendationEngine:
        return enableRecommendationEngine;
      case MLFeature.anomalyDetection:
        return enableAnomalyDetection;
      case MLFeature.patternRecognition:
        return enablePatternRecognition;
      case MLFeature.naturalLanguageProcessing:
        return enableNaturalLanguageProcessing;
      case MLFeature.computerVision:
        return enableComputerVision;
      case MLFeature.speechRecognition:
        return enableSpeechRecognition;
      case MLFeature.sentimentAnalysis:
        return enableSentimentAnalysis;
    }
  }

  /// Get enabled features count
  int get enabledFeaturesCount {
    int count = 0;
    for (final feature in MLFeature.values) {
      if (isFeatureEnabled(feature)) count++;
    }
    return count;
  }

  /// Get ML configuration description
  String get description {
    final features = enabledFeaturesCount;
    final model = modelType.displayName;
    final framework = framework.displayName;
    final optimization = optimizationLevel.displayName;
    final accuracy = accuracyLevel.displayName;
    
    return '$features features enabled - $model model on $framework with $optimization optimization and $accuracy accuracy';
  }
}

/// ML model types
enum MLModelType {
  tensorflow,
  pytorch,
  onnx,
  tflite,
  coreml,
  custom,
}

/// ML frameworks
enum MLFramework {
  flutter,
  tensorflow,
  pytorch,
  onnx,
  coreml,
  custom,
}

/// ML optimization levels
enum MLOptimizationLevel {
  low,
  standard,
  high,
  maximum,
}

/// ML accuracy levels
enum MLAccuracyLevel {
  low,
  medium,
  high,
  maximum,
}

/// ML privacy levels
enum MLPrivacyLevel {
  minimal,
  standard,
  high,
  maximum,
}

/// ML deployment modes
enum MLDeploymentMode {
  local,
  edge,
  cloud,
  hybrid,
}

/// ML inference modes
enum MLInferenceMode {
  realtime,
  batch,
  streaming,
  hybrid,
}

/// ML features
enum MLFeature {
  predictiveAnalytics,
  personalization,
  recommendationEngine,
  anomalyDetection,
  patternRecognition,
  naturalLanguageProcessing,
  computerVision,
  speechRecognition,
  sentimentAnalysis,
}

/// Extension for MLModelType
extension MLModelTypeExtension on MLModelType {
  String get displayName {
    switch (this) {
      case MLModelType.tensorflow:
        return 'TensorFlow';
      case MLModelType.pytorch:
        return 'PyTorch';
      case MLModelType.onnx:
        return 'ONNX';
      case MLModelType.tflite:
        return 'TensorFlow Lite';
      case MLModelType.coreml:
        return 'Core ML';
      case MLModelType.custom:
        return 'Custom';
    }
  }

  String get icon {
    switch (this) {
      case MLModelType.tensorflow:
        return '🧠';
      case MLModelType.pytorch:
        return '🔥';
      case MLModelType.onnx:
        return '🔗';
      case MLModelType.tflite:
        return '📱';
      case MLModelType.coreml:
        return '🍎';
      case MLModelType.custom:
        return '⚙️';
    }
  }

  String get description {
    switch (this) {
      case MLModelType.tensorflow:
        return 'Google\'s open-source machine learning framework';
      case MLModelType.pytorch:
        return 'Facebook\'s open-source machine learning framework';
      case MLModelType.onnx:
        return 'Open Neural Network Exchange format';
      case MLModelType.tflite:
        return 'Lightweight TensorFlow for mobile and edge devices';
      case MLModelType.coreml:
        return 'Apple\'s machine learning framework for iOS';
      case MLModelType.custom:
        return 'Custom machine learning model implementation';
    }
  }
}

/// Extension for MLFramework
extension MLFrameworkExtension on MLFramework {
  String get displayName {
    switch (this) {
      case MLFramework.flutter:
        return 'Flutter';
      case MLFramework.tensorflow:
        return 'TensorFlow';
      case MLFramework.pytorch:
        return 'PyTorch';
      case MLFramework.onnx:
        return 'ONNX';
      case MLFramework.coreml:
        return 'Core ML';
      case MLFramework.custom:
        return 'Custom';
    }
  }

  String get icon {
    switch (this) {
      case MLFramework.flutter:
        return '🎯';
      case MLFramework.tensorflow:
        return '🧠';
      case MLFramework.pytorch:
        return '🔥';
      case MLFramework.onnx:
        return '🔗';
      case MLFramework.coreml:
        return '🍎';
      case MLFramework.custom:
        return '⚙️';
    }
  }

  String get description {
    switch (this) {
      case MLFramework.flutter:
        return 'Google\'s UI toolkit for building natively compiled applications';
      case MLFramework.tensorflow:
        return 'Google\'s open-source machine learning framework';
      case MLFramework.pytorch:
        return 'Facebook\'s open-source machine learning framework';
      case MLFramework.onnx:
        return 'Open Neural Network Exchange format';
      case MLFramework.coreml:
        return 'Apple\'s machine learning framework for iOS';
      case MLFramework.custom:
        return 'Custom machine learning framework implementation';
    }
  }
}

/// Extension for MLOptimizationLevel
extension MLOptimizationLevelExtension on MLOptimizationLevel {
  String get displayName {
    switch (this) {
      case MLOptimizationLevel.low:
        return 'Low';
      case MLOptimizationLevel.standard:
        return 'Standard';
      case MLOptimizationLevel.high:
        return 'High';
      case MLOptimizationLevel.maximum:
        return 'Maximum';
    }
  }

  String get icon {
    switch (this) {
      case MLOptimizationLevel.low:
        return '🐌';
      case MLOptimizationLevel.standard:
        return '🚀';
      case MLOptimizationLevel.high:
        return '🚀';
      case MLOptimizationLevel.maximum:
        return '🚀';
    }
  }

  String get description {
    switch (this) {
      case MLOptimizationLevel.low:
        return 'Basic optimization with minimal resource usage';
      case MLOptimizationLevel.standard:
        return 'Balanced optimization for good performance';
      case MLOptimizationLevel.high:
        return 'Advanced optimization for high performance';
      case MLOptimizationLevel.maximum:
        return 'Maximum optimization for best performance';
    }
  }
}

/// Extension for MLAccuracyLevel
extension MLAccuracyLevelExtension on MLAccuracyLevel {
  String get displayName {
    switch (this) {
      case MLAccuracyLevel.low:
        return 'Low';
      case MLAccuracyLevel.medium:
        return 'Medium';
      case MLAccuracyLevel.high:
        return 'High';
      case MLAccuracyLevel.maximum:
        return 'Maximum';
    }
  }

  String get icon {
    switch (this) {
      case MLAccuracyLevel.low:
        return '🎯';
      case MLAccuracyLevel.medium:
        return '🎯';
      case MLAccuracyLevel.high:
        return '🎯';
      case MLAccuracyLevel.maximum:
        return '🎯';
    }
  }

  String get description {
    switch (this) {
      case MLAccuracyLevel.low:
        return 'Basic accuracy suitable for simple tasks';
      case MLAccuracyLevel.medium:
        return 'Good accuracy for most applications';
      case MLAccuracyLevel.high:
        return 'High accuracy for critical applications';
      case MLAccuracyLevel.maximum:
        return 'Maximum accuracy for mission-critical applications';
    }
  }
}

/// Extension for MLPrivacyLevel
extension MLPrivacyLevelExtension on MLPrivacyLevel {
  String get displayName {
    switch (this) {
      case MLPrivacyLevel.minimal:
        return 'Minimal';
      case MLPrivacyLevel.standard:
        return 'Standard';
      case MLPrivacyLevel.high:
        return 'High';
      case MLPrivacyLevel.maximum:
        return 'Maximum';
    }
  }

  String get icon {
    switch (this) {
      case MLPrivacyLevel.minimal:
        return '🔓';
      case MLPrivacyLevel.standard:
        return '🔒';
      case MLPrivacyLevel.high:
        return '🔒';
      case MLPrivacyLevel.maximum:
        return '🔒';
    }
  }

  String get description {
    switch (this) {
      case MLPrivacyLevel.minimal:
        return 'Basic privacy protection';
      case MLPrivacyLevel.standard:
        return 'Standard privacy protection';
      case MLPrivacyLevel.high:
        return 'High privacy protection with encryption';
      case MLPrivacyLevel.maximum:
        return 'Maximum privacy protection with advanced techniques';
    }
  }
}

/// Extension for MLDeploymentMode
extension MLDeploymentModeExtension on MLDeploymentMode {
  String get displayName {
    switch (this) {
      case MLDeploymentMode.local:
        return 'Local';
      case MLDeploymentMode.edge:
        return 'Edge';
      case MLDeploymentMode.cloud:
        return 'Cloud';
      case MLDeploymentMode.hybrid:
        return 'Hybrid';
    }
  }

  String get icon {
    switch (this) {
      case MLDeploymentMode.local:
        return '💻';
      case MLDeploymentMode.edge:
        return '📱';
      case MLDeploymentMode.cloud:
        return '☁️';
      case MLDeploymentMode.hybrid:
        return '🔄';
    }
  }

  String get description {
    switch (this) {
      case MLDeploymentMode.local:
        return 'Deploy models locally on device';
      case MLDeploymentMode.edge:
        return 'Deploy models on edge devices';
      case MLDeploymentMode.cloud:
        return 'Deploy models in the cloud';
      case MLDeploymentMode.hybrid:
        return 'Deploy models across local, edge, and cloud';
    }
  }
}

/// Extension for MLInferenceMode
extension MLInferenceModeExtension on MLInferenceMode {
  String get displayName {
    switch (this) {
      case MLInferenceMode.realtime:
        return 'Real-time';
      case MLInferenceMode.batch:
        return 'Batch';
      case MLInferenceMode.streaming:
        return 'Streaming';
      case MLInferenceMode.hybrid:
        return 'Hybrid';
    }
  }

  String get icon {
    switch (this) {
      case MLInferenceMode.realtime:
        return '⚡';
      case MLInferenceMode.batch:
        return '📦';
      case MLInferenceMode.streaming:
        return '🌊';
      case MLInferenceMode.hybrid:
        return '🔄';
    }
  }

  String get description {
    switch (this) {
      case MLInferenceMode.realtime:
        return 'Process data in real-time as it arrives';
      case MLInferenceMode.batch:
        return 'Process data in batches for efficiency';
      case MLInferenceMode.streaming:
        return 'Process continuous data streams';
      case MLInferenceMode.hybrid:
        return 'Combine real-time and batch processing';
    }
  }
}

/// Extension for MLFeature
extension MLFeatureExtension on MLFeature {
  String get displayName {
    switch (this) {
      case MLFeature.predictiveAnalytics:
        return 'Predictive Analytics';
      case MLFeature.personalization:
        return 'Personalization';
      case MLFeature.recommendationEngine:
        return 'Recommendation Engine';
      case MLFeature.anomalyDetection:
        return 'Anomaly Detection';
      case MLFeature.patternRecognition:
        return 'Pattern Recognition';
      case MLFeature.naturalLanguageProcessing:
        return 'Natural Language Processing';
      case MLFeature.computerVision:
        return 'Computer Vision';
      case MLFeature.speechRecognition:
        return 'Speech Recognition';
      case MLFeature.sentimentAnalysis:
        return 'Sentiment Analysis';
    }
  }

  String get icon {
    switch (this) {
      case MLFeature.predictiveAnalytics:
        return '🔮';
      case MLFeature.personalization:
        return '👤';
      case MLFeature.recommendationEngine:
        return '💡';
      case MLFeature.anomalyDetection:
        return '🚨';
      case MLFeature.patternRecognition:
        return '🔍';
      case MLFeature.naturalLanguageProcessing:
        return '💬';
      case MLFeature.computerVision:
        return '👁️';
      case MLFeature.speechRecognition:
        return '🎤';
      case MLFeature.sentimentAnalysis:
        return '😊';
    }
  }

  String get description {
    switch (this) {
      case MLFeature.predictiveAnalytics:
        return 'Predict future trends and behaviors';
      case MLFeature.personalization:
        return 'Customize experiences for individual users';
      case MLFeature.recommendationEngine:
        return 'Suggest relevant content and products';
      case MLFeature.anomalyDetection:
        return 'Identify unusual patterns and outliers';
      case MLFeature.patternRecognition:
        return 'Recognize patterns in data';
      case MLFeature.naturalLanguageProcessing:
        return 'Process and understand human language';
      case MLFeature.computerVision:
        return 'Analyze and understand visual content';
      case MLFeature.speechRecognition:
        return 'Convert speech to text and understand voice commands';
      case MLFeature.sentimentAnalysis:
        return 'Analyze emotions and opinions in text';
    }
  }
}
