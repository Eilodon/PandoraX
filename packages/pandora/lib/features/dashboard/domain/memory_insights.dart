import 'package:freezed_annotation/freezed_annotation.dart';

part 'memory_insights.freezed.dart';
part 'memory_insights.g.dart';

@freezed
class MemoryInsights with _$MemoryInsights {
  const factory MemoryInsights({
    required int totalMemories,
    required int recentMemories,
    required Map<String, int> memoriesByType,
    required List<MemoryPattern> patterns,
    required MemoryStats stats,
    required DateTime generatedAt,
  }) = _MemoryInsights;

  factory MemoryInsights.fromJson(Map<String, dynamic> json) =>
      _$MemoryInsightsFromJson(json);
}

@freezed
class MemoryPattern with _$MemoryPattern {
  const factory MemoryPattern({
    required String type,
    required String description,
    required double frequency,
    required List<String> tags,
  }) = _MemoryPattern;

  factory MemoryPattern.fromJson(Map<String, dynamic> json) =>
      _$MemoryPatternFromJson(json);
}

@freezed
class MemoryStats with _$MemoryStats {
  const factory MemoryStats({
    required int totalCount,
    required int thisWeek,
    required int thisMonth,
    required double averagePerDay,
    required String mostActiveDay,
    required String mostActiveTime,
  }) = _MemoryStats;

  factory MemoryStats.fromJson(Map<String, dynamic> json) =>
      _$MemoryStatsFromJson(json);
}

@freezed
class MemorySearchResult with _$MemorySearchResult {
  const factory MemorySearchResult({
    required List<dynamic> memories,
    required int totalCount,
    required String query,
    required DateTime searchedAt,
  }) = _MemorySearchResult;

  factory MemorySearchResult.fromJson(Map<String, dynamic> json) =>
      _$MemorySearchResultFromJson(json);
}

@freezed
class CognitiveAnalytics with _$CognitiveAnalytics {
  const factory CognitiveAnalytics({
    required double cognitiveLoad,
    required double attentionSpan,
    required double memoryRetention,
    required List<CognitiveMetric> metrics,
    required DateTime analyzedAt,
  }) = _CognitiveAnalytics;

  factory CognitiveAnalytics.fromJson(Map<String, dynamic> json) =>
      _$CognitiveAnalyticsFromJson(json);
}

@freezed
class CognitiveMetric with _$CognitiveMetric {
  const factory CognitiveMetric({
    required String name,
    required double value,
    required String unit,
    required DateTime timestamp,
  }) = _CognitiveMetric;

  factory CognitiveMetric.fromJson(Map<String, dynamic> json) =>
      _$CognitiveMetricFromJson(json);
}
