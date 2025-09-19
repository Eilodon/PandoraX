// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ml_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MLConfig _$MLConfigFromJson(Map<String, dynamic> json) {
  return _MLConfig.fromJson(json);
}

/// @nodoc
mixin _$MLConfig {
  bool get enablePredictiveAnalytics => throw _privateConstructorUsedError;
  bool get enablePersonalization => throw _privateConstructorUsedError;
  bool get enableRecommendationEngine => throw _privateConstructorUsedError;
  bool get enableAnomalyDetection => throw _privateConstructorUsedError;
  bool get enablePatternRecognition => throw _privateConstructorUsedError;
  bool get enableNaturalLanguageProcessing =>
      throw _privateConstructorUsedError;
  bool get enableComputerVision => throw _privateConstructorUsedError;
  bool get enableSpeechRecognition => throw _privateConstructorUsedError;
  bool get enableSentimentAnalysis => throw _privateConstructorUsedError;
  double get confidenceThreshold => throw _privateConstructorUsedError;
  int get maxTrainingSamples => throw _privateConstructorUsedError;
  int get maxModelRetries => throw _privateConstructorUsedError;
  int get modelUpdateIntervalDays => throw _privateConstructorUsedError;
  bool get enableModelCaching => throw _privateConstructorUsedError;
  int get maxCacheSizeMB => throw _privateConstructorUsedError;
  int get cacheExpirationDays => throw _privateConstructorUsedError;
  bool get enablePrivacyMode => throw _privateConstructorUsedError;
  bool get enableDataAnonymization => throw _privateConstructorUsedError;
  bool get enableCloudProcessing => throw _privateConstructorUsedError;
  String get cloudEndpoint => throw _privateConstructorUsedError;
  String get apiKey => throw _privateConstructorUsedError;

  /// Serializes this MLConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MLConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MLConfigCopyWith<MLConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MLConfigCopyWith<$Res> {
  factory $MLConfigCopyWith(MLConfig value, $Res Function(MLConfig) then) =
      _$MLConfigCopyWithImpl<$Res, MLConfig>;
  @useResult
  $Res call(
      {bool enablePredictiveAnalytics,
      bool enablePersonalization,
      bool enableRecommendationEngine,
      bool enableAnomalyDetection,
      bool enablePatternRecognition,
      bool enableNaturalLanguageProcessing,
      bool enableComputerVision,
      bool enableSpeechRecognition,
      bool enableSentimentAnalysis,
      double confidenceThreshold,
      int maxTrainingSamples,
      int maxModelRetries,
      int modelUpdateIntervalDays,
      bool enableModelCaching,
      int maxCacheSizeMB,
      int cacheExpirationDays,
      bool enablePrivacyMode,
      bool enableDataAnonymization,
      bool enableCloudProcessing,
      String cloudEndpoint,
      String apiKey});
}

/// @nodoc
class _$MLConfigCopyWithImpl<$Res, $Val extends MLConfig>
    implements $MLConfigCopyWith<$Res> {
  _$MLConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MLConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enablePredictiveAnalytics = null,
    Object? enablePersonalization = null,
    Object? enableRecommendationEngine = null,
    Object? enableAnomalyDetection = null,
    Object? enablePatternRecognition = null,
    Object? enableNaturalLanguageProcessing = null,
    Object? enableComputerVision = null,
    Object? enableSpeechRecognition = null,
    Object? enableSentimentAnalysis = null,
    Object? confidenceThreshold = null,
    Object? maxTrainingSamples = null,
    Object? maxModelRetries = null,
    Object? modelUpdateIntervalDays = null,
    Object? enableModelCaching = null,
    Object? maxCacheSizeMB = null,
    Object? cacheExpirationDays = null,
    Object? enablePrivacyMode = null,
    Object? enableDataAnonymization = null,
    Object? enableCloudProcessing = null,
    Object? cloudEndpoint = null,
    Object? apiKey = null,
  }) {
    return _then(_value.copyWith(
      enablePredictiveAnalytics: null == enablePredictiveAnalytics
          ? _value.enablePredictiveAnalytics
          : enablePredictiveAnalytics // ignore: cast_nullable_to_non_nullable
              as bool,
      enablePersonalization: null == enablePersonalization
          ? _value.enablePersonalization
          : enablePersonalization // ignore: cast_nullable_to_non_nullable
              as bool,
      enableRecommendationEngine: null == enableRecommendationEngine
          ? _value.enableRecommendationEngine
          : enableRecommendationEngine // ignore: cast_nullable_to_non_nullable
              as bool,
      enableAnomalyDetection: null == enableAnomalyDetection
          ? _value.enableAnomalyDetection
          : enableAnomalyDetection // ignore: cast_nullable_to_non_nullable
              as bool,
      enablePatternRecognition: null == enablePatternRecognition
          ? _value.enablePatternRecognition
          : enablePatternRecognition // ignore: cast_nullable_to_non_nullable
              as bool,
      enableNaturalLanguageProcessing: null == enableNaturalLanguageProcessing
          ? _value.enableNaturalLanguageProcessing
          : enableNaturalLanguageProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      enableComputerVision: null == enableComputerVision
          ? _value.enableComputerVision
          : enableComputerVision // ignore: cast_nullable_to_non_nullable
              as bool,
      enableSpeechRecognition: null == enableSpeechRecognition
          ? _value.enableSpeechRecognition
          : enableSpeechRecognition // ignore: cast_nullable_to_non_nullable
              as bool,
      enableSentimentAnalysis: null == enableSentimentAnalysis
          ? _value.enableSentimentAnalysis
          : enableSentimentAnalysis // ignore: cast_nullable_to_non_nullable
              as bool,
      confidenceThreshold: null == confidenceThreshold
          ? _value.confidenceThreshold
          : confidenceThreshold // ignore: cast_nullable_to_non_nullable
              as double,
      maxTrainingSamples: null == maxTrainingSamples
          ? _value.maxTrainingSamples
          : maxTrainingSamples // ignore: cast_nullable_to_non_nullable
              as int,
      maxModelRetries: null == maxModelRetries
          ? _value.maxModelRetries
          : maxModelRetries // ignore: cast_nullable_to_non_nullable
              as int,
      modelUpdateIntervalDays: null == modelUpdateIntervalDays
          ? _value.modelUpdateIntervalDays
          : modelUpdateIntervalDays // ignore: cast_nullable_to_non_nullable
              as int,
      enableModelCaching: null == enableModelCaching
          ? _value.enableModelCaching
          : enableModelCaching // ignore: cast_nullable_to_non_nullable
              as bool,
      maxCacheSizeMB: null == maxCacheSizeMB
          ? _value.maxCacheSizeMB
          : maxCacheSizeMB // ignore: cast_nullable_to_non_nullable
              as int,
      cacheExpirationDays: null == cacheExpirationDays
          ? _value.cacheExpirationDays
          : cacheExpirationDays // ignore: cast_nullable_to_non_nullable
              as int,
      enablePrivacyMode: null == enablePrivacyMode
          ? _value.enablePrivacyMode
          : enablePrivacyMode // ignore: cast_nullable_to_non_nullable
              as bool,
      enableDataAnonymization: null == enableDataAnonymization
          ? _value.enableDataAnonymization
          : enableDataAnonymization // ignore: cast_nullable_to_non_nullable
              as bool,
      enableCloudProcessing: null == enableCloudProcessing
          ? _value.enableCloudProcessing
          : enableCloudProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      cloudEndpoint: null == cloudEndpoint
          ? _value.cloudEndpoint
          : cloudEndpoint // ignore: cast_nullable_to_non_nullable
              as String,
      apiKey: null == apiKey
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MLConfigImplCopyWith<$Res>
    implements $MLConfigCopyWith<$Res> {
  factory _$$MLConfigImplCopyWith(
          _$MLConfigImpl value, $Res Function(_$MLConfigImpl) then) =
      __$$MLConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool enablePredictiveAnalytics,
      bool enablePersonalization,
      bool enableRecommendationEngine,
      bool enableAnomalyDetection,
      bool enablePatternRecognition,
      bool enableNaturalLanguageProcessing,
      bool enableComputerVision,
      bool enableSpeechRecognition,
      bool enableSentimentAnalysis,
      double confidenceThreshold,
      int maxTrainingSamples,
      int maxModelRetries,
      int modelUpdateIntervalDays,
      bool enableModelCaching,
      int maxCacheSizeMB,
      int cacheExpirationDays,
      bool enablePrivacyMode,
      bool enableDataAnonymization,
      bool enableCloudProcessing,
      String cloudEndpoint,
      String apiKey});
}

/// @nodoc
class __$$MLConfigImplCopyWithImpl<$Res>
    extends _$MLConfigCopyWithImpl<$Res, _$MLConfigImpl>
    implements _$$MLConfigImplCopyWith<$Res> {
  __$$MLConfigImplCopyWithImpl(
      _$MLConfigImpl _value, $Res Function(_$MLConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of MLConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enablePredictiveAnalytics = null,
    Object? enablePersonalization = null,
    Object? enableRecommendationEngine = null,
    Object? enableAnomalyDetection = null,
    Object? enablePatternRecognition = null,
    Object? enableNaturalLanguageProcessing = null,
    Object? enableComputerVision = null,
    Object? enableSpeechRecognition = null,
    Object? enableSentimentAnalysis = null,
    Object? confidenceThreshold = null,
    Object? maxTrainingSamples = null,
    Object? maxModelRetries = null,
    Object? modelUpdateIntervalDays = null,
    Object? enableModelCaching = null,
    Object? maxCacheSizeMB = null,
    Object? cacheExpirationDays = null,
    Object? enablePrivacyMode = null,
    Object? enableDataAnonymization = null,
    Object? enableCloudProcessing = null,
    Object? cloudEndpoint = null,
    Object? apiKey = null,
  }) {
    return _then(_$MLConfigImpl(
      enablePredictiveAnalytics: null == enablePredictiveAnalytics
          ? _value.enablePredictiveAnalytics
          : enablePredictiveAnalytics // ignore: cast_nullable_to_non_nullable
              as bool,
      enablePersonalization: null == enablePersonalization
          ? _value.enablePersonalization
          : enablePersonalization // ignore: cast_nullable_to_non_nullable
              as bool,
      enableRecommendationEngine: null == enableRecommendationEngine
          ? _value.enableRecommendationEngine
          : enableRecommendationEngine // ignore: cast_nullable_to_non_nullable
              as bool,
      enableAnomalyDetection: null == enableAnomalyDetection
          ? _value.enableAnomalyDetection
          : enableAnomalyDetection // ignore: cast_nullable_to_non_nullable
              as bool,
      enablePatternRecognition: null == enablePatternRecognition
          ? _value.enablePatternRecognition
          : enablePatternRecognition // ignore: cast_nullable_to_non_nullable
              as bool,
      enableNaturalLanguageProcessing: null == enableNaturalLanguageProcessing
          ? _value.enableNaturalLanguageProcessing
          : enableNaturalLanguageProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      enableComputerVision: null == enableComputerVision
          ? _value.enableComputerVision
          : enableComputerVision // ignore: cast_nullable_to_non_nullable
              as bool,
      enableSpeechRecognition: null == enableSpeechRecognition
          ? _value.enableSpeechRecognition
          : enableSpeechRecognition // ignore: cast_nullable_to_non_nullable
              as bool,
      enableSentimentAnalysis: null == enableSentimentAnalysis
          ? _value.enableSentimentAnalysis
          : enableSentimentAnalysis // ignore: cast_nullable_to_non_nullable
              as bool,
      confidenceThreshold: null == confidenceThreshold
          ? _value.confidenceThreshold
          : confidenceThreshold // ignore: cast_nullable_to_non_nullable
              as double,
      maxTrainingSamples: null == maxTrainingSamples
          ? _value.maxTrainingSamples
          : maxTrainingSamples // ignore: cast_nullable_to_non_nullable
              as int,
      maxModelRetries: null == maxModelRetries
          ? _value.maxModelRetries
          : maxModelRetries // ignore: cast_nullable_to_non_nullable
              as int,
      modelUpdateIntervalDays: null == modelUpdateIntervalDays
          ? _value.modelUpdateIntervalDays
          : modelUpdateIntervalDays // ignore: cast_nullable_to_non_nullable
              as int,
      enableModelCaching: null == enableModelCaching
          ? _value.enableModelCaching
          : enableModelCaching // ignore: cast_nullable_to_non_nullable
              as bool,
      maxCacheSizeMB: null == maxCacheSizeMB
          ? _value.maxCacheSizeMB
          : maxCacheSizeMB // ignore: cast_nullable_to_non_nullable
              as int,
      cacheExpirationDays: null == cacheExpirationDays
          ? _value.cacheExpirationDays
          : cacheExpirationDays // ignore: cast_nullable_to_non_nullable
              as int,
      enablePrivacyMode: null == enablePrivacyMode
          ? _value.enablePrivacyMode
          : enablePrivacyMode // ignore: cast_nullable_to_non_nullable
              as bool,
      enableDataAnonymization: null == enableDataAnonymization
          ? _value.enableDataAnonymization
          : enableDataAnonymization // ignore: cast_nullable_to_non_nullable
              as bool,
      enableCloudProcessing: null == enableCloudProcessing
          ? _value.enableCloudProcessing
          : enableCloudProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      cloudEndpoint: null == cloudEndpoint
          ? _value.cloudEndpoint
          : cloudEndpoint // ignore: cast_nullable_to_non_nullable
              as String,
      apiKey: null == apiKey
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MLConfigImpl implements _MLConfig {
  const _$MLConfigImpl(
      {this.enablePredictiveAnalytics = false,
      this.enablePersonalization = false,
      this.enableRecommendationEngine = false,
      this.enableAnomalyDetection = false,
      this.enablePatternRecognition = false,
      this.enableNaturalLanguageProcessing = false,
      this.enableComputerVision = false,
      this.enableSpeechRecognition = false,
      this.enableSentimentAnalysis = false,
      this.confidenceThreshold = 0.8,
      this.maxTrainingSamples = 1000,
      this.maxModelRetries = 10,
      this.modelUpdateIntervalDays = 30,
      this.enableModelCaching = true,
      this.maxCacheSizeMB = 100,
      this.cacheExpirationDays = 7,
      this.enablePrivacyMode = true,
      this.enableDataAnonymization = true,
      this.enableCloudProcessing = false,
      this.cloudEndpoint = '',
      this.apiKey = ''});

  factory _$MLConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$MLConfigImplFromJson(json);

  @override
  @JsonKey()
  final bool enablePredictiveAnalytics;
  @override
  @JsonKey()
  final bool enablePersonalization;
  @override
  @JsonKey()
  final bool enableRecommendationEngine;
  @override
  @JsonKey()
  final bool enableAnomalyDetection;
  @override
  @JsonKey()
  final bool enablePatternRecognition;
  @override
  @JsonKey()
  final bool enableNaturalLanguageProcessing;
  @override
  @JsonKey()
  final bool enableComputerVision;
  @override
  @JsonKey()
  final bool enableSpeechRecognition;
  @override
  @JsonKey()
  final bool enableSentimentAnalysis;
  @override
  @JsonKey()
  final double confidenceThreshold;
  @override
  @JsonKey()
  final int maxTrainingSamples;
  @override
  @JsonKey()
  final int maxModelRetries;
  @override
  @JsonKey()
  final int modelUpdateIntervalDays;
  @override
  @JsonKey()
  final bool enableModelCaching;
  @override
  @JsonKey()
  final int maxCacheSizeMB;
  @override
  @JsonKey()
  final int cacheExpirationDays;
  @override
  @JsonKey()
  final bool enablePrivacyMode;
  @override
  @JsonKey()
  final bool enableDataAnonymization;
  @override
  @JsonKey()
  final bool enableCloudProcessing;
  @override
  @JsonKey()
  final String cloudEndpoint;
  @override
  @JsonKey()
  final String apiKey;

  @override
  String toString() {
    return 'MLConfig(enablePredictiveAnalytics: $enablePredictiveAnalytics, enablePersonalization: $enablePersonalization, enableRecommendationEngine: $enableRecommendationEngine, enableAnomalyDetection: $enableAnomalyDetection, enablePatternRecognition: $enablePatternRecognition, enableNaturalLanguageProcessing: $enableNaturalLanguageProcessing, enableComputerVision: $enableComputerVision, enableSpeechRecognition: $enableSpeechRecognition, enableSentimentAnalysis: $enableSentimentAnalysis, confidenceThreshold: $confidenceThreshold, maxTrainingSamples: $maxTrainingSamples, maxModelRetries: $maxModelRetries, modelUpdateIntervalDays: $modelUpdateIntervalDays, enableModelCaching: $enableModelCaching, maxCacheSizeMB: $maxCacheSizeMB, cacheExpirationDays: $cacheExpirationDays, enablePrivacyMode: $enablePrivacyMode, enableDataAnonymization: $enableDataAnonymization, enableCloudProcessing: $enableCloudProcessing, cloudEndpoint: $cloudEndpoint, apiKey: $apiKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MLConfigImpl &&
            (identical(other.enablePredictiveAnalytics, enablePredictiveAnalytics) ||
                other.enablePredictiveAnalytics == enablePredictiveAnalytics) &&
            (identical(other.enablePersonalization, enablePersonalization) ||
                other.enablePersonalization == enablePersonalization) &&
            (identical(other.enableRecommendationEngine, enableRecommendationEngine) ||
                other.enableRecommendationEngine ==
                    enableRecommendationEngine) &&
            (identical(other.enableAnomalyDetection, enableAnomalyDetection) ||
                other.enableAnomalyDetection == enableAnomalyDetection) &&
            (identical(other.enablePatternRecognition, enablePatternRecognition) ||
                other.enablePatternRecognition == enablePatternRecognition) &&
            (identical(other.enableNaturalLanguageProcessing, enableNaturalLanguageProcessing) ||
                other.enableNaturalLanguageProcessing ==
                    enableNaturalLanguageProcessing) &&
            (identical(other.enableComputerVision, enableComputerVision) ||
                other.enableComputerVision == enableComputerVision) &&
            (identical(other.enableSpeechRecognition, enableSpeechRecognition) ||
                other.enableSpeechRecognition == enableSpeechRecognition) &&
            (identical(other.enableSentimentAnalysis, enableSentimentAnalysis) ||
                other.enableSentimentAnalysis == enableSentimentAnalysis) &&
            (identical(other.confidenceThreshold, confidenceThreshold) ||
                other.confidenceThreshold == confidenceThreshold) &&
            (identical(other.maxTrainingSamples, maxTrainingSamples) ||
                other.maxTrainingSamples == maxTrainingSamples) &&
            (identical(other.maxModelRetries, maxModelRetries) ||
                other.maxModelRetries == maxModelRetries) &&
            (identical(other.modelUpdateIntervalDays, modelUpdateIntervalDays) ||
                other.modelUpdateIntervalDays == modelUpdateIntervalDays) &&
            (identical(other.enableModelCaching, enableModelCaching) ||
                other.enableModelCaching == enableModelCaching) &&
            (identical(other.maxCacheSizeMB, maxCacheSizeMB) ||
                other.maxCacheSizeMB == maxCacheSizeMB) &&
            (identical(other.cacheExpirationDays, cacheExpirationDays) ||
                other.cacheExpirationDays == cacheExpirationDays) &&
            (identical(other.enablePrivacyMode, enablePrivacyMode) ||
                other.enablePrivacyMode == enablePrivacyMode) &&
            (identical(other.enableDataAnonymization, enableDataAnonymization) ||
                other.enableDataAnonymization == enableDataAnonymization) &&
            (identical(other.enableCloudProcessing, enableCloudProcessing) ||
                other.enableCloudProcessing == enableCloudProcessing) &&
            (identical(other.cloudEndpoint, cloudEndpoint) || other.cloudEndpoint == cloudEndpoint) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        enablePredictiveAnalytics,
        enablePersonalization,
        enableRecommendationEngine,
        enableAnomalyDetection,
        enablePatternRecognition,
        enableNaturalLanguageProcessing,
        enableComputerVision,
        enableSpeechRecognition,
        enableSentimentAnalysis,
        confidenceThreshold,
        maxTrainingSamples,
        maxModelRetries,
        modelUpdateIntervalDays,
        enableModelCaching,
        maxCacheSizeMB,
        cacheExpirationDays,
        enablePrivacyMode,
        enableDataAnonymization,
        enableCloudProcessing,
        cloudEndpoint,
        apiKey
      ]);

  /// Create a copy of MLConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MLConfigImplCopyWith<_$MLConfigImpl> get copyWith =>
      __$$MLConfigImplCopyWithImpl<_$MLConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MLConfigImplToJson(
      this,
    );
  }
}

abstract class _MLConfig implements MLConfig {
  const factory _MLConfig(
      {final bool enablePredictiveAnalytics,
      final bool enablePersonalization,
      final bool enableRecommendationEngine,
      final bool enableAnomalyDetection,
      final bool enablePatternRecognition,
      final bool enableNaturalLanguageProcessing,
      final bool enableComputerVision,
      final bool enableSpeechRecognition,
      final bool enableSentimentAnalysis,
      final double confidenceThreshold,
      final int maxTrainingSamples,
      final int maxModelRetries,
      final int modelUpdateIntervalDays,
      final bool enableModelCaching,
      final int maxCacheSizeMB,
      final int cacheExpirationDays,
      final bool enablePrivacyMode,
      final bool enableDataAnonymization,
      final bool enableCloudProcessing,
      final String cloudEndpoint,
      final String apiKey}) = _$MLConfigImpl;

  factory _MLConfig.fromJson(Map<String, dynamic> json) =
      _$MLConfigImpl.fromJson;

  @override
  bool get enablePredictiveAnalytics;
  @override
  bool get enablePersonalization;
  @override
  bool get enableRecommendationEngine;
  @override
  bool get enableAnomalyDetection;
  @override
  bool get enablePatternRecognition;
  @override
  bool get enableNaturalLanguageProcessing;
  @override
  bool get enableComputerVision;
  @override
  bool get enableSpeechRecognition;
  @override
  bool get enableSentimentAnalysis;
  @override
  double get confidenceThreshold;
  @override
  int get maxTrainingSamples;
  @override
  int get maxModelRetries;
  @override
  int get modelUpdateIntervalDays;
  @override
  bool get enableModelCaching;
  @override
  int get maxCacheSizeMB;
  @override
  int get cacheExpirationDays;
  @override
  bool get enablePrivacyMode;
  @override
  bool get enableDataAnonymization;
  @override
  bool get enableCloudProcessing;
  @override
  String get cloudEndpoint;
  @override
  String get apiKey;

  /// Create a copy of MLConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MLConfigImplCopyWith<_$MLConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MLModelType _$MLModelTypeFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'classification':
      return ClassificationModel.fromJson(json);
    case 'regression':
      return RegressionModel.fromJson(json);
    case 'clustering':
      return ClusteringModel.fromJson(json);
    case 'recommendation':
      return RecommendationModel.fromJson(json);
    case 'nlp':
      return NLPModel.fromJson(json);
    case 'vision':
      return VisionModel.fromJson(json);
    case 'speech':
      return SpeechModel.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'MLModelType',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$MLModelType {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() classification,
    required TResult Function() regression,
    required TResult Function() clustering,
    required TResult Function() recommendation,
    required TResult Function() nlp,
    required TResult Function() vision,
    required TResult Function() speech,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? classification,
    TResult? Function()? regression,
    TResult? Function()? clustering,
    TResult? Function()? recommendation,
    TResult? Function()? nlp,
    TResult? Function()? vision,
    TResult? Function()? speech,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? classification,
    TResult Function()? regression,
    TResult Function()? clustering,
    TResult Function()? recommendation,
    TResult Function()? nlp,
    TResult Function()? vision,
    TResult Function()? speech,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClassificationModel value) classification,
    required TResult Function(RegressionModel value) regression,
    required TResult Function(ClusteringModel value) clustering,
    required TResult Function(RecommendationModel value) recommendation,
    required TResult Function(NLPModel value) nlp,
    required TResult Function(VisionModel value) vision,
    required TResult Function(SpeechModel value) speech,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClassificationModel value)? classification,
    TResult? Function(RegressionModel value)? regression,
    TResult? Function(ClusteringModel value)? clustering,
    TResult? Function(RecommendationModel value)? recommendation,
    TResult? Function(NLPModel value)? nlp,
    TResult? Function(VisionModel value)? vision,
    TResult? Function(SpeechModel value)? speech,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClassificationModel value)? classification,
    TResult Function(RegressionModel value)? regression,
    TResult Function(ClusteringModel value)? clustering,
    TResult Function(RecommendationModel value)? recommendation,
    TResult Function(NLPModel value)? nlp,
    TResult Function(VisionModel value)? vision,
    TResult Function(SpeechModel value)? speech,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this MLModelType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MLModelTypeCopyWith<$Res> {
  factory $MLModelTypeCopyWith(
          MLModelType value, $Res Function(MLModelType) then) =
      _$MLModelTypeCopyWithImpl<$Res, MLModelType>;
}

/// @nodoc
class _$MLModelTypeCopyWithImpl<$Res, $Val extends MLModelType>
    implements $MLModelTypeCopyWith<$Res> {
  _$MLModelTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MLModelType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ClassificationModelImplCopyWith<$Res> {
  factory _$$ClassificationModelImplCopyWith(_$ClassificationModelImpl value,
          $Res Function(_$ClassificationModelImpl) then) =
      __$$ClassificationModelImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClassificationModelImplCopyWithImpl<$Res>
    extends _$MLModelTypeCopyWithImpl<$Res, _$ClassificationModelImpl>
    implements _$$ClassificationModelImplCopyWith<$Res> {
  __$$ClassificationModelImplCopyWithImpl(_$ClassificationModelImpl _value,
      $Res Function(_$ClassificationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MLModelType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$ClassificationModelImpl implements ClassificationModel {
  const _$ClassificationModelImpl({final String? $type})
      : $type = $type ?? 'classification';

  factory _$ClassificationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassificationModelImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'MLModelType.classification()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassificationModelImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() classification,
    required TResult Function() regression,
    required TResult Function() clustering,
    required TResult Function() recommendation,
    required TResult Function() nlp,
    required TResult Function() vision,
    required TResult Function() speech,
  }) {
    return classification();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? classification,
    TResult? Function()? regression,
    TResult? Function()? clustering,
    TResult? Function()? recommendation,
    TResult? Function()? nlp,
    TResult? Function()? vision,
    TResult? Function()? speech,
  }) {
    return classification?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? classification,
    TResult Function()? regression,
    TResult Function()? clustering,
    TResult Function()? recommendation,
    TResult Function()? nlp,
    TResult Function()? vision,
    TResult Function()? speech,
    required TResult orElse(),
  }) {
    if (classification != null) {
      return classification();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClassificationModel value) classification,
    required TResult Function(RegressionModel value) regression,
    required TResult Function(ClusteringModel value) clustering,
    required TResult Function(RecommendationModel value) recommendation,
    required TResult Function(NLPModel value) nlp,
    required TResult Function(VisionModel value) vision,
    required TResult Function(SpeechModel value) speech,
  }) {
    return classification(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClassificationModel value)? classification,
    TResult? Function(RegressionModel value)? regression,
    TResult? Function(ClusteringModel value)? clustering,
    TResult? Function(RecommendationModel value)? recommendation,
    TResult? Function(NLPModel value)? nlp,
    TResult? Function(VisionModel value)? vision,
    TResult? Function(SpeechModel value)? speech,
  }) {
    return classification?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClassificationModel value)? classification,
    TResult Function(RegressionModel value)? regression,
    TResult Function(ClusteringModel value)? clustering,
    TResult Function(RecommendationModel value)? recommendation,
    TResult Function(NLPModel value)? nlp,
    TResult Function(VisionModel value)? vision,
    TResult Function(SpeechModel value)? speech,
    required TResult orElse(),
  }) {
    if (classification != null) {
      return classification(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassificationModelImplToJson(
      this,
    );
  }
}

abstract class ClassificationModel implements MLModelType {
  const factory ClassificationModel() = _$ClassificationModelImpl;

  factory ClassificationModel.fromJson(Map<String, dynamic> json) =
      _$ClassificationModelImpl.fromJson;
}

/// @nodoc
abstract class _$$RegressionModelImplCopyWith<$Res> {
  factory _$$RegressionModelImplCopyWith(_$RegressionModelImpl value,
          $Res Function(_$RegressionModelImpl) then) =
      __$$RegressionModelImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegressionModelImplCopyWithImpl<$Res>
    extends _$MLModelTypeCopyWithImpl<$Res, _$RegressionModelImpl>
    implements _$$RegressionModelImplCopyWith<$Res> {
  __$$RegressionModelImplCopyWithImpl(
      _$RegressionModelImpl _value, $Res Function(_$RegressionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MLModelType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$RegressionModelImpl implements RegressionModel {
  const _$RegressionModelImpl({final String? $type})
      : $type = $type ?? 'regression';

  factory _$RegressionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegressionModelImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'MLModelType.regression()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RegressionModelImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() classification,
    required TResult Function() regression,
    required TResult Function() clustering,
    required TResult Function() recommendation,
    required TResult Function() nlp,
    required TResult Function() vision,
    required TResult Function() speech,
  }) {
    return regression();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? classification,
    TResult? Function()? regression,
    TResult? Function()? clustering,
    TResult? Function()? recommendation,
    TResult? Function()? nlp,
    TResult? Function()? vision,
    TResult? Function()? speech,
  }) {
    return regression?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? classification,
    TResult Function()? regression,
    TResult Function()? clustering,
    TResult Function()? recommendation,
    TResult Function()? nlp,
    TResult Function()? vision,
    TResult Function()? speech,
    required TResult orElse(),
  }) {
    if (regression != null) {
      return regression();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClassificationModel value) classification,
    required TResult Function(RegressionModel value) regression,
    required TResult Function(ClusteringModel value) clustering,
    required TResult Function(RecommendationModel value) recommendation,
    required TResult Function(NLPModel value) nlp,
    required TResult Function(VisionModel value) vision,
    required TResult Function(SpeechModel value) speech,
  }) {
    return regression(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClassificationModel value)? classification,
    TResult? Function(RegressionModel value)? regression,
    TResult? Function(ClusteringModel value)? clustering,
    TResult? Function(RecommendationModel value)? recommendation,
    TResult? Function(NLPModel value)? nlp,
    TResult? Function(VisionModel value)? vision,
    TResult? Function(SpeechModel value)? speech,
  }) {
    return regression?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClassificationModel value)? classification,
    TResult Function(RegressionModel value)? regression,
    TResult Function(ClusteringModel value)? clustering,
    TResult Function(RecommendationModel value)? recommendation,
    TResult Function(NLPModel value)? nlp,
    TResult Function(VisionModel value)? vision,
    TResult Function(SpeechModel value)? speech,
    required TResult orElse(),
  }) {
    if (regression != null) {
      return regression(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RegressionModelImplToJson(
      this,
    );
  }
}

abstract class RegressionModel implements MLModelType {
  const factory RegressionModel() = _$RegressionModelImpl;

  factory RegressionModel.fromJson(Map<String, dynamic> json) =
      _$RegressionModelImpl.fromJson;
}

/// @nodoc
abstract class _$$ClusteringModelImplCopyWith<$Res> {
  factory _$$ClusteringModelImplCopyWith(_$ClusteringModelImpl value,
          $Res Function(_$ClusteringModelImpl) then) =
      __$$ClusteringModelImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClusteringModelImplCopyWithImpl<$Res>
    extends _$MLModelTypeCopyWithImpl<$Res, _$ClusteringModelImpl>
    implements _$$ClusteringModelImplCopyWith<$Res> {
  __$$ClusteringModelImplCopyWithImpl(
      _$ClusteringModelImpl _value, $Res Function(_$ClusteringModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MLModelType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$ClusteringModelImpl implements ClusteringModel {
  const _$ClusteringModelImpl({final String? $type})
      : $type = $type ?? 'clustering';

  factory _$ClusteringModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClusteringModelImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'MLModelType.clustering()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClusteringModelImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() classification,
    required TResult Function() regression,
    required TResult Function() clustering,
    required TResult Function() recommendation,
    required TResult Function() nlp,
    required TResult Function() vision,
    required TResult Function() speech,
  }) {
    return clustering();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? classification,
    TResult? Function()? regression,
    TResult? Function()? clustering,
    TResult? Function()? recommendation,
    TResult? Function()? nlp,
    TResult? Function()? vision,
    TResult? Function()? speech,
  }) {
    return clustering?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? classification,
    TResult Function()? regression,
    TResult Function()? clustering,
    TResult Function()? recommendation,
    TResult Function()? nlp,
    TResult Function()? vision,
    TResult Function()? speech,
    required TResult orElse(),
  }) {
    if (clustering != null) {
      return clustering();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClassificationModel value) classification,
    required TResult Function(RegressionModel value) regression,
    required TResult Function(ClusteringModel value) clustering,
    required TResult Function(RecommendationModel value) recommendation,
    required TResult Function(NLPModel value) nlp,
    required TResult Function(VisionModel value) vision,
    required TResult Function(SpeechModel value) speech,
  }) {
    return clustering(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClassificationModel value)? classification,
    TResult? Function(RegressionModel value)? regression,
    TResult? Function(ClusteringModel value)? clustering,
    TResult? Function(RecommendationModel value)? recommendation,
    TResult? Function(NLPModel value)? nlp,
    TResult? Function(VisionModel value)? vision,
    TResult? Function(SpeechModel value)? speech,
  }) {
    return clustering?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClassificationModel value)? classification,
    TResult Function(RegressionModel value)? regression,
    TResult Function(ClusteringModel value)? clustering,
    TResult Function(RecommendationModel value)? recommendation,
    TResult Function(NLPModel value)? nlp,
    TResult Function(VisionModel value)? vision,
    TResult Function(SpeechModel value)? speech,
    required TResult orElse(),
  }) {
    if (clustering != null) {
      return clustering(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ClusteringModelImplToJson(
      this,
    );
  }
}

abstract class ClusteringModel implements MLModelType {
  const factory ClusteringModel() = _$ClusteringModelImpl;

  factory ClusteringModel.fromJson(Map<String, dynamic> json) =
      _$ClusteringModelImpl.fromJson;
}

/// @nodoc
abstract class _$$RecommendationModelImplCopyWith<$Res> {
  factory _$$RecommendationModelImplCopyWith(_$RecommendationModelImpl value,
          $Res Function(_$RecommendationModelImpl) then) =
      __$$RecommendationModelImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RecommendationModelImplCopyWithImpl<$Res>
    extends _$MLModelTypeCopyWithImpl<$Res, _$RecommendationModelImpl>
    implements _$$RecommendationModelImplCopyWith<$Res> {
  __$$RecommendationModelImplCopyWithImpl(_$RecommendationModelImpl _value,
      $Res Function(_$RecommendationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MLModelType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$RecommendationModelImpl implements RecommendationModel {
  const _$RecommendationModelImpl({final String? $type})
      : $type = $type ?? 'recommendation';

  factory _$RecommendationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecommendationModelImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'MLModelType.recommendation()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendationModelImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() classification,
    required TResult Function() regression,
    required TResult Function() clustering,
    required TResult Function() recommendation,
    required TResult Function() nlp,
    required TResult Function() vision,
    required TResult Function() speech,
  }) {
    return recommendation();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? classification,
    TResult? Function()? regression,
    TResult? Function()? clustering,
    TResult? Function()? recommendation,
    TResult? Function()? nlp,
    TResult? Function()? vision,
    TResult? Function()? speech,
  }) {
    return recommendation?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? classification,
    TResult Function()? regression,
    TResult Function()? clustering,
    TResult Function()? recommendation,
    TResult Function()? nlp,
    TResult Function()? vision,
    TResult Function()? speech,
    required TResult orElse(),
  }) {
    if (recommendation != null) {
      return recommendation();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClassificationModel value) classification,
    required TResult Function(RegressionModel value) regression,
    required TResult Function(ClusteringModel value) clustering,
    required TResult Function(RecommendationModel value) recommendation,
    required TResult Function(NLPModel value) nlp,
    required TResult Function(VisionModel value) vision,
    required TResult Function(SpeechModel value) speech,
  }) {
    return recommendation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClassificationModel value)? classification,
    TResult? Function(RegressionModel value)? regression,
    TResult? Function(ClusteringModel value)? clustering,
    TResult? Function(RecommendationModel value)? recommendation,
    TResult? Function(NLPModel value)? nlp,
    TResult? Function(VisionModel value)? vision,
    TResult? Function(SpeechModel value)? speech,
  }) {
    return recommendation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClassificationModel value)? classification,
    TResult Function(RegressionModel value)? regression,
    TResult Function(ClusteringModel value)? clustering,
    TResult Function(RecommendationModel value)? recommendation,
    TResult Function(NLPModel value)? nlp,
    TResult Function(VisionModel value)? vision,
    TResult Function(SpeechModel value)? speech,
    required TResult orElse(),
  }) {
    if (recommendation != null) {
      return recommendation(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RecommendationModelImplToJson(
      this,
    );
  }
}

abstract class RecommendationModel implements MLModelType {
  const factory RecommendationModel() = _$RecommendationModelImpl;

  factory RecommendationModel.fromJson(Map<String, dynamic> json) =
      _$RecommendationModelImpl.fromJson;
}

/// @nodoc
abstract class _$$NLPModelImplCopyWith<$Res> {
  factory _$$NLPModelImplCopyWith(
          _$NLPModelImpl value, $Res Function(_$NLPModelImpl) then) =
      __$$NLPModelImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NLPModelImplCopyWithImpl<$Res>
    extends _$MLModelTypeCopyWithImpl<$Res, _$NLPModelImpl>
    implements _$$NLPModelImplCopyWith<$Res> {
  __$$NLPModelImplCopyWithImpl(
      _$NLPModelImpl _value, $Res Function(_$NLPModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MLModelType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$NLPModelImpl implements NLPModel {
  const _$NLPModelImpl({final String? $type}) : $type = $type ?? 'nlp';

  factory _$NLPModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NLPModelImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'MLModelType.nlp()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NLPModelImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() classification,
    required TResult Function() regression,
    required TResult Function() clustering,
    required TResult Function() recommendation,
    required TResult Function() nlp,
    required TResult Function() vision,
    required TResult Function() speech,
  }) {
    return nlp();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? classification,
    TResult? Function()? regression,
    TResult? Function()? clustering,
    TResult? Function()? recommendation,
    TResult? Function()? nlp,
    TResult? Function()? vision,
    TResult? Function()? speech,
  }) {
    return nlp?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? classification,
    TResult Function()? regression,
    TResult Function()? clustering,
    TResult Function()? recommendation,
    TResult Function()? nlp,
    TResult Function()? vision,
    TResult Function()? speech,
    required TResult orElse(),
  }) {
    if (nlp != null) {
      return nlp();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClassificationModel value) classification,
    required TResult Function(RegressionModel value) regression,
    required TResult Function(ClusteringModel value) clustering,
    required TResult Function(RecommendationModel value) recommendation,
    required TResult Function(NLPModel value) nlp,
    required TResult Function(VisionModel value) vision,
    required TResult Function(SpeechModel value) speech,
  }) {
    return nlp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClassificationModel value)? classification,
    TResult? Function(RegressionModel value)? regression,
    TResult? Function(ClusteringModel value)? clustering,
    TResult? Function(RecommendationModel value)? recommendation,
    TResult? Function(NLPModel value)? nlp,
    TResult? Function(VisionModel value)? vision,
    TResult? Function(SpeechModel value)? speech,
  }) {
    return nlp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClassificationModel value)? classification,
    TResult Function(RegressionModel value)? regression,
    TResult Function(ClusteringModel value)? clustering,
    TResult Function(RecommendationModel value)? recommendation,
    TResult Function(NLPModel value)? nlp,
    TResult Function(VisionModel value)? vision,
    TResult Function(SpeechModel value)? speech,
    required TResult orElse(),
  }) {
    if (nlp != null) {
      return nlp(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$NLPModelImplToJson(
      this,
    );
  }
}

abstract class NLPModel implements MLModelType {
  const factory NLPModel() = _$NLPModelImpl;

  factory NLPModel.fromJson(Map<String, dynamic> json) =
      _$NLPModelImpl.fromJson;
}

/// @nodoc
abstract class _$$VisionModelImplCopyWith<$Res> {
  factory _$$VisionModelImplCopyWith(
          _$VisionModelImpl value, $Res Function(_$VisionModelImpl) then) =
      __$$VisionModelImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$VisionModelImplCopyWithImpl<$Res>
    extends _$MLModelTypeCopyWithImpl<$Res, _$VisionModelImpl>
    implements _$$VisionModelImplCopyWith<$Res> {
  __$$VisionModelImplCopyWithImpl(
      _$VisionModelImpl _value, $Res Function(_$VisionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MLModelType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$VisionModelImpl implements VisionModel {
  const _$VisionModelImpl({final String? $type}) : $type = $type ?? 'vision';

  factory _$VisionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VisionModelImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'MLModelType.vision()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$VisionModelImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() classification,
    required TResult Function() regression,
    required TResult Function() clustering,
    required TResult Function() recommendation,
    required TResult Function() nlp,
    required TResult Function() vision,
    required TResult Function() speech,
  }) {
    return vision();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? classification,
    TResult? Function()? regression,
    TResult? Function()? clustering,
    TResult? Function()? recommendation,
    TResult? Function()? nlp,
    TResult? Function()? vision,
    TResult? Function()? speech,
  }) {
    return vision?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? classification,
    TResult Function()? regression,
    TResult Function()? clustering,
    TResult Function()? recommendation,
    TResult Function()? nlp,
    TResult Function()? vision,
    TResult Function()? speech,
    required TResult orElse(),
  }) {
    if (vision != null) {
      return vision();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClassificationModel value) classification,
    required TResult Function(RegressionModel value) regression,
    required TResult Function(ClusteringModel value) clustering,
    required TResult Function(RecommendationModel value) recommendation,
    required TResult Function(NLPModel value) nlp,
    required TResult Function(VisionModel value) vision,
    required TResult Function(SpeechModel value) speech,
  }) {
    return vision(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClassificationModel value)? classification,
    TResult? Function(RegressionModel value)? regression,
    TResult? Function(ClusteringModel value)? clustering,
    TResult? Function(RecommendationModel value)? recommendation,
    TResult? Function(NLPModel value)? nlp,
    TResult? Function(VisionModel value)? vision,
    TResult? Function(SpeechModel value)? speech,
  }) {
    return vision?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClassificationModel value)? classification,
    TResult Function(RegressionModel value)? regression,
    TResult Function(ClusteringModel value)? clustering,
    TResult Function(RecommendationModel value)? recommendation,
    TResult Function(NLPModel value)? nlp,
    TResult Function(VisionModel value)? vision,
    TResult Function(SpeechModel value)? speech,
    required TResult orElse(),
  }) {
    if (vision != null) {
      return vision(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$VisionModelImplToJson(
      this,
    );
  }
}

abstract class VisionModel implements MLModelType {
  const factory VisionModel() = _$VisionModelImpl;

  factory VisionModel.fromJson(Map<String, dynamic> json) =
      _$VisionModelImpl.fromJson;
}

/// @nodoc
abstract class _$$SpeechModelImplCopyWith<$Res> {
  factory _$$SpeechModelImplCopyWith(
          _$SpeechModelImpl value, $Res Function(_$SpeechModelImpl) then) =
      __$$SpeechModelImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SpeechModelImplCopyWithImpl<$Res>
    extends _$MLModelTypeCopyWithImpl<$Res, _$SpeechModelImpl>
    implements _$$SpeechModelImplCopyWith<$Res> {
  __$$SpeechModelImplCopyWithImpl(
      _$SpeechModelImpl _value, $Res Function(_$SpeechModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MLModelType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$SpeechModelImpl implements SpeechModel {
  const _$SpeechModelImpl({final String? $type}) : $type = $type ?? 'speech';

  factory _$SpeechModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpeechModelImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'MLModelType.speech()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SpeechModelImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() classification,
    required TResult Function() regression,
    required TResult Function() clustering,
    required TResult Function() recommendation,
    required TResult Function() nlp,
    required TResult Function() vision,
    required TResult Function() speech,
  }) {
    return speech();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? classification,
    TResult? Function()? regression,
    TResult? Function()? clustering,
    TResult? Function()? recommendation,
    TResult? Function()? nlp,
    TResult? Function()? vision,
    TResult? Function()? speech,
  }) {
    return speech?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? classification,
    TResult Function()? regression,
    TResult Function()? clustering,
    TResult Function()? recommendation,
    TResult Function()? nlp,
    TResult Function()? vision,
    TResult Function()? speech,
    required TResult orElse(),
  }) {
    if (speech != null) {
      return speech();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClassificationModel value) classification,
    required TResult Function(RegressionModel value) regression,
    required TResult Function(ClusteringModel value) clustering,
    required TResult Function(RecommendationModel value) recommendation,
    required TResult Function(NLPModel value) nlp,
    required TResult Function(VisionModel value) vision,
    required TResult Function(SpeechModel value) speech,
  }) {
    return speech(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClassificationModel value)? classification,
    TResult? Function(RegressionModel value)? regression,
    TResult? Function(ClusteringModel value)? clustering,
    TResult? Function(RecommendationModel value)? recommendation,
    TResult? Function(NLPModel value)? nlp,
    TResult? Function(VisionModel value)? vision,
    TResult? Function(SpeechModel value)? speech,
  }) {
    return speech?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClassificationModel value)? classification,
    TResult Function(RegressionModel value)? regression,
    TResult Function(ClusteringModel value)? clustering,
    TResult Function(RecommendationModel value)? recommendation,
    TResult Function(NLPModel value)? nlp,
    TResult Function(VisionModel value)? vision,
    TResult Function(SpeechModel value)? speech,
    required TResult orElse(),
  }) {
    if (speech != null) {
      return speech(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SpeechModelImplToJson(
      this,
    );
  }
}

abstract class SpeechModel implements MLModelType {
  const factory SpeechModel() = _$SpeechModelImpl;

  factory SpeechModel.fromJson(Map<String, dynamic> json) =
      _$SpeechModelImpl.fromJson;
}

MLModelMetrics _$MLModelMetricsFromJson(Map<String, dynamic> json) {
  return _MLModelMetrics.fromJson(json);
}

/// @nodoc
mixin _$MLModelMetrics {
  double get accuracy => throw _privateConstructorUsedError;
  double get precision => throw _privateConstructorUsedError;
  double get recall => throw _privateConstructorUsedError;
  double get f1Score => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;
  int get trainingSamples => throw _privateConstructorUsedError;
  int get predictionCount => throw _privateConstructorUsedError;

  /// Serializes this MLModelMetrics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MLModelMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MLModelMetricsCopyWith<MLModelMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MLModelMetricsCopyWith<$Res> {
  factory $MLModelMetricsCopyWith(
          MLModelMetrics value, $Res Function(MLModelMetrics) then) =
      _$MLModelMetricsCopyWithImpl<$Res, MLModelMetrics>;
  @useResult
  $Res call(
      {double accuracy,
      double precision,
      double recall,
      double f1Score,
      double confidence,
      DateTime lastUpdated,
      int trainingSamples,
      int predictionCount});
}

/// @nodoc
class _$MLModelMetricsCopyWithImpl<$Res, $Val extends MLModelMetrics>
    implements $MLModelMetricsCopyWith<$Res> {
  _$MLModelMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MLModelMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accuracy = null,
    Object? precision = null,
    Object? recall = null,
    Object? f1Score = null,
    Object? confidence = null,
    Object? lastUpdated = null,
    Object? trainingSamples = null,
    Object? predictionCount = null,
  }) {
    return _then(_value.copyWith(
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      precision: null == precision
          ? _value.precision
          : precision // ignore: cast_nullable_to_non_nullable
              as double,
      recall: null == recall
          ? _value.recall
          : recall // ignore: cast_nullable_to_non_nullable
              as double,
      f1Score: null == f1Score
          ? _value.f1Score
          : f1Score // ignore: cast_nullable_to_non_nullable
              as double,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      trainingSamples: null == trainingSamples
          ? _value.trainingSamples
          : trainingSamples // ignore: cast_nullable_to_non_nullable
              as int,
      predictionCount: null == predictionCount
          ? _value.predictionCount
          : predictionCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MLModelMetricsImplCopyWith<$Res>
    implements $MLModelMetricsCopyWith<$Res> {
  factory _$$MLModelMetricsImplCopyWith(_$MLModelMetricsImpl value,
          $Res Function(_$MLModelMetricsImpl) then) =
      __$$MLModelMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double accuracy,
      double precision,
      double recall,
      double f1Score,
      double confidence,
      DateTime lastUpdated,
      int trainingSamples,
      int predictionCount});
}

/// @nodoc
class __$$MLModelMetricsImplCopyWithImpl<$Res>
    extends _$MLModelMetricsCopyWithImpl<$Res, _$MLModelMetricsImpl>
    implements _$$MLModelMetricsImplCopyWith<$Res> {
  __$$MLModelMetricsImplCopyWithImpl(
      _$MLModelMetricsImpl _value, $Res Function(_$MLModelMetricsImpl) _then)
      : super(_value, _then);

  /// Create a copy of MLModelMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accuracy = null,
    Object? precision = null,
    Object? recall = null,
    Object? f1Score = null,
    Object? confidence = null,
    Object? lastUpdated = null,
    Object? trainingSamples = null,
    Object? predictionCount = null,
  }) {
    return _then(_$MLModelMetricsImpl(
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      precision: null == precision
          ? _value.precision
          : precision // ignore: cast_nullable_to_non_nullable
              as double,
      recall: null == recall
          ? _value.recall
          : recall // ignore: cast_nullable_to_non_nullable
              as double,
      f1Score: null == f1Score
          ? _value.f1Score
          : f1Score // ignore: cast_nullable_to_non_nullable
              as double,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      trainingSamples: null == trainingSamples
          ? _value.trainingSamples
          : trainingSamples // ignore: cast_nullable_to_non_nullable
              as int,
      predictionCount: null == predictionCount
          ? _value.predictionCount
          : predictionCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MLModelMetricsImpl implements _MLModelMetrics {
  const _$MLModelMetricsImpl(
      {required this.accuracy,
      required this.precision,
      required this.recall,
      required this.f1Score,
      required this.confidence,
      required this.lastUpdated,
      required this.trainingSamples,
      required this.predictionCount});

  factory _$MLModelMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MLModelMetricsImplFromJson(json);

  @override
  final double accuracy;
  @override
  final double precision;
  @override
  final double recall;
  @override
  final double f1Score;
  @override
  final double confidence;
  @override
  final DateTime lastUpdated;
  @override
  final int trainingSamples;
  @override
  final int predictionCount;

  @override
  String toString() {
    return 'MLModelMetrics(accuracy: $accuracy, precision: $precision, recall: $recall, f1Score: $f1Score, confidence: $confidence, lastUpdated: $lastUpdated, trainingSamples: $trainingSamples, predictionCount: $predictionCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MLModelMetricsImpl &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.precision, precision) ||
                other.precision == precision) &&
            (identical(other.recall, recall) || other.recall == recall) &&
            (identical(other.f1Score, f1Score) || other.f1Score == f1Score) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.trainingSamples, trainingSamples) ||
                other.trainingSamples == trainingSamples) &&
            (identical(other.predictionCount, predictionCount) ||
                other.predictionCount == predictionCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accuracy, precision, recall,
      f1Score, confidence, lastUpdated, trainingSamples, predictionCount);

  /// Create a copy of MLModelMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MLModelMetricsImplCopyWith<_$MLModelMetricsImpl> get copyWith =>
      __$$MLModelMetricsImplCopyWithImpl<_$MLModelMetricsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MLModelMetricsImplToJson(
      this,
    );
  }
}

abstract class _MLModelMetrics implements MLModelMetrics {
  const factory _MLModelMetrics(
      {required final double accuracy,
      required final double precision,
      required final double recall,
      required final double f1Score,
      required final double confidence,
      required final DateTime lastUpdated,
      required final int trainingSamples,
      required final int predictionCount}) = _$MLModelMetricsImpl;

  factory _MLModelMetrics.fromJson(Map<String, dynamic> json) =
      _$MLModelMetricsImpl.fromJson;

  @override
  double get accuracy;
  @override
  double get precision;
  @override
  double get recall;
  @override
  double get f1Score;
  @override
  double get confidence;
  @override
  DateTime get lastUpdated;
  @override
  int get trainingSamples;
  @override
  int get predictionCount;

  /// Create a copy of MLModelMetrics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MLModelMetricsImplCopyWith<_$MLModelMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
