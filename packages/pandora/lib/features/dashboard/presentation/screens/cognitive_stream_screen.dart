import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cac_core/cac_core.dart';
import 'package:pandora_ui/pandora_ui.dart';
import '../widgets/memory_card.dart';
import '../widgets/memory_insights_widget.dart';
import '../widgets/cognitive_activity_chart.dart';
import '../widgets/memory_search_bar.dart';
import '../providers/cognitive_stream_providers.dart';

/// Cognitive Stream Dashboard Screen
/// 
/// This screen provides a comprehensive view of the user's cognitive activity,
/// memories, insights, and patterns in real-time.
class CognitiveStreamScreen extends ConsumerStatefulWidget {
  const CognitiveStreamScreen({super.key});

  @override
  ConsumerState<CognitiveStreamScreen> createState() => _CognitiveStreamScreenState();
}

class _CognitiveStreamScreenState extends ConsumerState<CognitiveStreamScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  MemoryType? _selectedMemoryType;
  DateTime? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cognitive Stream'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.timeline), text: 'Stream'),
            Tab(icon: Icon(Icons.insights), text: 'Insights'),
            Tab(icon: Icon(Icons.search), text: 'Search'),
            Tab(icon: Icon(Icons.analytics), text: 'Analytics'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _refreshData(),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettings(context),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildStreamTab(),
          _buildInsightsTab(),
          _buildSearchTab(),
          _buildAnalyticsTab(),
        ],
      ),
    );
  }

  Widget _buildStreamTab() {
    return Column(
      children: [
        // Search and filters
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              MemorySearchBar(
                controller: _searchController,
                onSearchChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildFilters(),
            ],
          ),
        ),
        
        // Memory stream
        Expanded(
          child: _buildMemoryStream(),
        ),
      ],
    );
  }

  Widget _buildInsightsTab() {
    return Consumer(
      builder: (context, ref, child) {
        final insightsAsync = ref.watch(memoryInsightsProvider);
        
        return insightsAsync.when(
          data: (insights) => SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MemoryInsightsWidget(insights: insights),
                const SizedBox(height: 24),
                _buildPatternAnalysis(insights),
                const SizedBox(height: 24),
                _buildRecommendations(insights),
              ],
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, size: 64, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text('Error loading insights: $error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.refresh(memoryInsightsProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: MemorySearchBar(
            controller: _searchController,
            onSearchChanged: (query) {
              setState(() {
                _searchQuery = query;
              });
            },
            showAdvancedFilters: true,
          ),
        ),
        Expanded(
          child: _buildSearchResults(),
        ),
      ],
    );
  }

  Widget _buildAnalyticsTab() {
    return Consumer(
      builder: (context, ref, child) {
        final analyticsAsync = ref.watch(cognitiveAnalyticsProvider);
        
        return analyticsAsync.when(
          data: (analytics) => SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAnalyticsOverview(analytics),
                const SizedBox(height: 24),
                CognitiveActivityChart(analytics: analytics),
                const SizedBox(height: 24),
                _buildMemoryDistribution(analytics),
                const SizedBox(height: 24),
                _buildPerformanceMetrics(analytics),
              ],
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, size: 64, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text('Error loading analytics: $error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.refresh(cognitiveAnalyticsProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilters() {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<MemoryType?>(
            value: _selectedMemoryType,
            decoration: const InputDecoration(
              labelText: 'Memory Type',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            items: [
              const DropdownMenuItem<MemoryType?>(
                value: null,
                child: Text('All Types'),
              ),
              ...MemoryType.values.map((type) => DropdownMenuItem(
                value: type,
                child: Text(type.name.toUpperCase()),
              )),
            ],
            onChanged: (value) {
              setState(() {
                _selectedMemoryType = value;
              });
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Date Range',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              suffixIcon: Icon(Icons.calendar_today),
            ),
            readOnly: true,
            onTap: () => _selectDateRange(context),
            controller: TextEditingController(
              text: _selectedDateRange != null
                  ? '${_selectedDateRange!.day}/${_selectedDateRange!.month}/${_selectedDateRange!.year}'
                  : 'All Time',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMemoryStream() {
    return Consumer(
      builder: (context, ref, child) {
        final memoriesAsync = ref.watch(filteredMemoriesProvider(
          searchQuery: _searchQuery,
          memoryType: _selectedMemoryType,
          dateRange: _selectedDateRange,
        ));
        
        return memoriesAsync.when(
          data: (memories) {
            if (memories.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.memory, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No memories found',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Start creating notes or interacting with AI to build your memory stream',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }
            
            return RefreshIndicator(
              onRefresh: () => _refreshData(),
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: memories.length,
                itemBuilder: (context, index) {
                  final memory = memories[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: MemoryCard(
                      memory: memory,
                      onTap: () => _showMemoryDetails(context, memory),
                      onPin: () => _togglePin(memory),
                      onArchive: () => _archiveMemory(memory),
                    ),
                  );
                },
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, size: 64, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text('Error loading memories: $error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _refreshData(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    return Consumer(
      builder: (context, ref, child) {
        final searchResultsAsync = ref.watch(memorySearchProvider(_searchQuery));
        
        return searchResultsAsync.when(
          data: (results) {
            if (results.isEmpty && _searchQuery.isNotEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No results found',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Try different keywords or check your spelling',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }
            
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final result = results[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: MemoryCard(
                    memory: result.memory,
                    similarity: result.similarity,
                    onTap: () => _showMemoryDetails(context, result.memory),
                    onPin: () => _togglePin(result.memory),
                    onArchive: () => _archiveMemory(result.memory),
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, size: 64, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text('Error searching memories: $error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.refresh(memorySearchProvider(_searchQuery)),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPatternAnalysis(MemoryInsights insights) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pattern Analysis',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            if (insights.patterns.isNotEmpty) ...[
              ...insights.patterns.entries.map((entry) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Text(
                      '${entry.key}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(entry.value.toString()),
                    ),
                  ],
                ),
              )),
            ] else
              const Text('No patterns detected yet'),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendations(MemoryInsights insights) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommendations',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            if (insights.recommendations.isNotEmpty) ...[
              ...insights.recommendations.map((recommendation) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.lightbulb_outline, size: 20),
                    const SizedBox(width: 8),
                    Expanded(child: Text(recommendation)),
                  ],
                ),
              )),
            ] else
              const Text('No recommendations available yet'),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsOverview(CognitiveAnalytics analytics) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Analytics Overview',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total Memories',
                    analytics.totalMemories.toString(),
                    Icons.memory,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'AI Responses',
                    analytics.aiResponses.toString(),
                    Icons.smart_toy,
                    Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Search Queries',
                    analytics.searchQueries.toString(),
                    Icons.search,
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Insights Generated',
                    analytics.insightsGenerated.toString(),
                    Icons.insights,
                    Colors.purple,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMemoryDistribution(CognitiveAnalytics analytics) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Memory Distribution',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ...analytics.memoryTypeDistribution.entries.map((entry) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(entry.key.toUpperCase()),
                  ),
                  Expanded(
                    flex: 3,
                    child: LinearProgressIndicator(
                      value: entry.value / analytics.totalMemories,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('${entry.value}'),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceMetrics(CognitiveAnalytics analytics) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance Metrics',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            _buildMetricRow('Average Response Time', '${analytics.avgResponseTimeMs}ms'),
            _buildMetricRow('Search Accuracy', '${(analytics.searchAccuracy * 100).toStringAsFixed(1)}%'),
            _buildMetricRow('Memory Relevance', '${(analytics.memoryRelevance * 100).toStringAsFixed(1)}%'),
            _buildMetricRow('User Satisfaction', '${(analytics.userSatisfaction * 100).toStringAsFixed(1)}%'),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _selectedDateRange != null
          ? DateTimeRange(
              start: _selectedDateRange!,
              end: _selectedDateRange!,
            )
          : null,
    );
    
    if (picked != null) {
      setState(() {
        _selectedDateRange = picked.start;
      });
    }
  }

  void _refreshData() {
    ref.refresh(memoryStreamProvider);
    ref.refresh(memoryInsightsProvider);
    ref.refresh(cognitiveAnalyticsProvider);
  }

  void _showSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const SettingsBottomSheet(),
    );
  }

  void _showMemoryDetails(BuildContext context, MemoryEntry memory) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => MemoryDetailsBottomSheet(memory: memory),
    );
  }

  Future<void> _togglePin(MemoryEntry memory) async {
    // Implementation for pinning/unpinning memory
  }

  Future<void> _archiveMemory(MemoryEntry memory) async {
    // Implementation for archiving memory
  }
}

class SettingsBottomSheet extends StatelessWidget {
  const SettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Cognitive Stream Settings',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          // Settings options would go here
          const Text('Settings options coming soon...'),
        ],
      ),
    );
  }
}

class MemoryDetailsBottomSheet extends StatelessWidget {
  final MemoryEntry memory;

  const MemoryDetailsBottomSheet({
    super.key,
    required this.memory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Memory Details',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Text('Content: ${memory.content}'),
          const SizedBox(height: 8),
          Text('Source: ${memory.source}'),
          const SizedBox(height: 8),
          Text('Type: ${memory.type.name}'),
          const SizedBox(height: 8),
          Text('Created: ${memory.timestamp}'),
          const SizedBox(height: 8),
          Text('Relevance: ${(memory.relevanceScore * 100).toStringAsFixed(1)}%'),
        ],
      ),
    );
  }
}
