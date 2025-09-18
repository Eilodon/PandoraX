import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:cac_core/cac_core.dart';

@LazySingleton()
class NightlyAnalysisService {
  final MemoryRepository _memoryRepository;
  final EventBusService _eventBusService;
  final Logger _logger = Logger();
  Timer? _analysisTimer;

  NightlyAnalysisService(this._memoryRepository, this._eventBusService);

  void startNightlyAnalysis() {
    _analysisTimer = Timer.periodic(
      const Duration(hours: 24),
      (_) => _performAnalysis(),
    );
    _logger.i('Nightly analysis service started');
  }

  Future<void> _performAnalysis() async {
    try {
      _logger.i('Starting nightly cognitive analysis...');
      
      // Get recent memories
      final recentMemories = await _memoryRepository.getMemories(
        from: DateTime.now().subtract(const Duration(days: 7)),
        limit: 1000,
      );

      if (recentMemories.isEmpty) {
        _logger.i('No recent memories to analyze');
        return;
      }

      // Analyze patterns and generate insights
      final insights = await _analyzePatterns(recentMemories);
      
      for (final insight in insights) {
        _eventBusService.publishEvent(
          CacEvent.cognitiveInsight(
            insight: insight['insight'] as String,
            relatedMemories: insight['relatedMemories'] as List<String>,
            timestamp: DateTime.now(),
            confidence: insight['confidence'] as double,
          ),
        );
      }

      _logger.i('Nightly analysis completed. Generated ${insights.length} insights');
    } catch (e) {
      _logger.e('Error during nightly analysis: $e');
    }
  }

  Future<List<Map<String, dynamic>>> _analyzePatterns(List<MemoryEntry> memories) async {
    final insights = <Map<String, dynamic>>[];
    
    // Group memories by type
    final memoriesByType = <String, List<MemoryEntry>>{};
    for (final memory in memories) {
      memoriesByType.putIfAbsent(memory.type.name, () => []).add(memory);
    }

    // Analyze temporal patterns
    final temporalInsight = _analyzeTemporalPatterns(memories);
    if (temporalInsight != null) {
      insights.add(temporalInsight);
    }

    // Analyze content patterns
    final contentInsight = _analyzeContentPatterns(memories);
    if (contentInsight != null) {
      insights.add(contentInsight);
    }

    // Analyze emotional patterns
    final emotionalInsight = _analyzeEmotionalPatterns(memories);
    if (emotionalInsight != null) {
      insights.add(emotionalInsight);
    }

    return insights;
  }

  Map<String, dynamic>? _analyzeTemporalPatterns(List<MemoryEntry> memories) {
    // Simple temporal analysis - can be enhanced with ML
    final hourCounts = <int, int>{};
    for (final memory in memories) {
      final hour = memory.timestamp.hour;
      hourCounts[hour] = (hourCounts[hour] ?? 0) + 1;
    }

    final mostActiveHour = hourCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b);

    if (mostActiveHour.value > 5) { // Threshold for significance
      return {
        'insight': 'Most active during hour ${mostActiveHour.key}:00',
        'relatedMemories': memories
            .where((m) => m.timestamp.hour == mostActiveHour.key)
            .map((m) => m.id)
            .take(5)
            .toList(),
        'confidence': 0.7,
      };
    }

    return null;
  }

  Map<String, dynamic>? _analyzeContentPatterns(List<MemoryEntry> memories) {
    // Simple content analysis - can be enhanced with NLP
    final wordCounts = <String, int>{};
    for (final memory in memories) {
      final words = memory.content.toLowerCase().split(RegExp(r'\s+'));
      for (final word in words) {
        if (word.length > 3) { // Filter short words
          wordCounts[word] = (wordCounts[word] ?? 0) + 1;
        }
      }
    }

    final topWords = wordCounts.entries
        .where((e) => e.value > 3)
        .toList()
        ..sort((a, b) => b.value.compareTo(a.value));

    if (topWords.isNotEmpty) {
      return {
        'insight': 'Frequently mentioned topics: ${topWords.take(3).map((e) => e.key).join(', ')}',
        'relatedMemories': memories
            .where((m) => topWords.any((w) => m.content.toLowerCase().contains(w.key)))
            .map((m) => m.id)
            .take(5)
            .toList(),
        'confidence': 0.6,
      };
    }

    return null;
  }

  Map<String, dynamic>? _analyzeEmotionalPatterns(List<MemoryEntry> memories) {
    // Simple emotional analysis - can be enhanced with sentiment analysis
    final emotionalMemories = memories.where((m) => m.type == MemoryType.emotional).toList();
    
    if (emotionalMemories.length > 3) {
      return {
        'insight': 'Emotional patterns detected in ${emotionalMemories.length} entries',
        'relatedMemories': emotionalMemories.map((m) => m.id).take(5).toList(),
        'confidence': 0.5,
      };
    }

    return null;
  }

  void dispose() {
    _analysisTimer?.cancel();
  }
}
