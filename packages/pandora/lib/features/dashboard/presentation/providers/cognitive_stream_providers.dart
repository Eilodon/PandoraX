import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cac_core/cac_core.dart';

/// Memory Stream Provider
/// 
/// Provides a stream of all memories for the cognitive dashboard
final memoryStreamProvider = StreamProvider<List<MemoryEntry>>((ref) {
  final memoryRepository = ref.watch(memoryRepositoryProvider);
  return memoryRepository.getMemoryStream();
});

/// Filtered Memories Provider
/// 
/// Provides filtered memories based on search criteria
final filteredMemoriesProvider = Provider.family<AsyncValue<List<MemoryEntry>>, ({
  String searchQuery,
  MemoryType? memoryType,
  DateTime? dateRange,
})>((ref, params) {
  final memoriesAsync = ref.watch(memoryStreamProvider);
  
  return memoriesAsync.when(
    data: (memories) {
      var filteredMemories = memories;
      
      // Filter by search query
      if (params.searchQuery.isNotEmpty) {
        filteredMemories = filteredMemories.where((memory) {
          return memory.content.toLowerCase().contains(params.searchQuery.toLowerCase());
        }).toList();
      }
      
      // Filter by memory type
      if (params.memoryType != null) {
        filteredMemories = filteredMemories.where((memory) {
          return memory.type == params.memoryType;
        }).toList();
      }
      
      // Filter by date range
      if (params.dateRange != null) {
        filteredMemories = filteredMemories.where((memory) {
          return memory.timestamp.isAfter(params.dateRange!);
        }).toList();
      }
      
      return AsyncValue.data(filteredMemories);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

/// Memory Search Provider
/// 
/// Provides semantic search results for memories
final memorySearchProvider = FutureProvider.family<List<MemorySearchResult>, String>((ref, query) async {
  if (query.isEmpty) return [];
  
  final memorySearchService = ref.watch(memorySearchServiceProvider);
  return await memorySearchService.searchMemories(query);
});

/// Memory Insights Provider
/// 
/// Provides insights and patterns from memory analysis
final memoryInsightsProvider = FutureProvider<MemoryInsights>((ref) async {
  final memorySearchService = ref.watch(memorySearchServiceProvider);
  return await memorySearchService.getMemoryInsights();
});

/// Cognitive Analytics Provider
/// 
/// Provides analytics data for the cognitive dashboard
final cognitiveAnalyticsProvider = FutureProvider<CognitiveAnalytics>((ref) async {
  final analyticsService = ref.watch(cognitiveAnalyticsServiceProvider);
  return await analyticsService.getAnalytics();
});

/// Memory Repository Provider
final memoryRepositoryProvider = Provider<MemoryRepository>((ref) {
  // This would be injected via dependency injection
  throw UnimplementedError('MemoryRepository must be provided');
});

/// Memory Search Service Provider
final memorySearchServiceProvider = Provider<MemorySearchService>((ref) {
  // This would be injected via dependency injection
  throw UnimplementedError('MemorySearchService must be provided');
});

/// Cognitive Analytics Service Provider
final cognitiveAnalyticsServiceProvider = Provider<CognitiveAnalyticsService>((ref) {
  // This would be injected via dependency injection
  throw UnimplementedError('CognitiveAnalyticsService must be provided');
});

/// Memory Type Filter Provider
final memoryTypeFilterProvider = StateProvider<MemoryType?>((ref) => null);

/// Search Query Provider
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Date Range Filter Provider
final dateRangeFilterProvider = StateProvider<DateTime?>((ref) => null);

/// Memory Statistics Provider
final memoryStatisticsProvider = FutureProvider<MemoryStatistics>((ref) async {
  final memoryRepository = ref.watch(memoryRepositoryProvider);
  final memories = await memoryRepository.getMemories(limit: 1000);
  
  return MemoryStatistics(
    totalMemories: memories.length,
    explicitMemories: memories.where((m) => m.type == MemoryType.explicit).length,
    implicitMemories: memories.where((m) => m.type == MemoryType.implicit).length,
    emotionalMemories: memories.where((m) => m.type == MemoryType.emotional).length,
    temporalMemories: memories.where((m) => m.type == MemoryType.temporal).length,
    spatialMemories: memories.where((m) => m.type == MemoryType.spatial).length,
    socialMemories: memories.where((m) => m.type == MemoryType.social).length,
    pinnedMemories: memories.where((m) => m.isPinned).length,
    archivedMemories: memories.where((m) => m.isArchived).length,
    averageRelevanceScore: memories.isNotEmpty
        ? memories.map((m) => m.relevanceScore).reduce((a, b) => a + b) / memories.length
        : 0.0,
  );
});

/// Recent Activity Provider
final recentActivityProvider = FutureProvider<List<MemoryEntry>>((ref) async {
  final memoryRepository = ref.watch(memoryRepositoryProvider);
  final now = DateTime.now();
  final last24Hours = now.subtract(const Duration(hours: 24));
  
  return await memoryRepository.getMemories(
    from: last24Hours,
    limit: 50,
  );
});

/// Top Sources Provider
final topSourcesProvider = FutureProvider<List<SourceStatistics>>((ref) async {
  final memoryRepository = ref.watch(memoryRepositoryProvider);
  final memories = await memoryRepository.getMemories(limit: 1000);
  
  final sourceCounts = <String, int>{};
  for (final memory in memories) {
    sourceCounts[memory.source] = (sourceCounts[memory.source] ?? 0) + 1;
  }
  
  return sourceCounts.entries
      .map((entry) => SourceStatistics(
            source: entry.key,
            count: entry.value,
            percentage: entry.value / memories.length,
          ))
      .toList()
    ..sort((a, b) => b.count.compareTo(a.count));
});

/// Memory Type Distribution Provider
final memoryTypeDistributionProvider = FutureProvider<Map<String, int>>((ref) async {
  final memoryRepository = ref.watch(memoryRepositoryProvider);
  final memories = await memoryRepository.getMemories(limit: 1000);
  
  final typeCounts = <String, int>{};
  for (final memory in memories) {
    typeCounts[memory.type.name] = (typeCounts[memory.type.name] ?? 0) + 1;
  }
  
  return typeCounts;
});

/// Memory Statistics Data Class
class MemoryStatistics {
  final int totalMemories;
  final int explicitMemories;
  final int implicitMemories;
  final int emotionalMemories;
  final int temporalMemories;
  final int spatialMemories;
  final int socialMemories;
  final int pinnedMemories;
  final int archivedMemories;
  final double averageRelevanceScore;

  const MemoryStatistics({
    required this.totalMemories,
    required this.explicitMemories,
    required this.implicitMemories,
    required this.emotionalMemories,
    required this.temporalMemories,
    required this.spatialMemories,
    required this.socialMemories,
    required this.pinnedMemories,
    required this.archivedMemories,
    required this.averageRelevanceScore,
  });
}

/// Source Statistics Data Class
class SourceStatistics {
  final String source;
  final int count;
  final double percentage;

  const SourceStatistics({
    required this.source,
    required this.count,
    required this.percentage,
  });
}

/// Cognitive Analytics Data Class
class CognitiveAnalytics {
  final int totalMemories;
  final int aiResponses;
  final int searchQueries;
  final int insightsGenerated;
  final Map<String, int> memoryTypeDistribution;
  final int avgResponseTimeMs;
  final double searchAccuracy;
  final double memoryRelevance;
  final double userSatisfaction;
  final DateTime generatedAt;

  const CognitiveAnalytics({
    required this.totalMemories,
    required this.aiResponses,
    required this.searchQueries,
    required this.insightsGenerated,
    required this.memoryTypeDistribution,
    required this.avgResponseTimeMs,
    required this.searchAccuracy,
    required this.memoryRelevance,
    required this.userSatisfaction,
    required this.generatedAt,
  });
}

/// Cognitive Analytics Service Interface
abstract class CognitiveAnalyticsService {
  Future<CognitiveAnalytics> getAnalytics();
}
