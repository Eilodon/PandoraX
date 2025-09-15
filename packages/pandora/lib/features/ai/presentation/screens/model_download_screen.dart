import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_core/ai_core.dart';
import 'package:ai_llm/src/services/progressive_model_service.dart';
import 'package:ai_llm/src/services/device_capability_detector.dart';
import '../widgets/model_download_card.dart';
import '../widgets/download_progress_widget.dart';

/// Model Download Screen for managing AI model downloads
class ModelDownloadScreen extends ConsumerStatefulWidget {
  const ModelDownloadScreen({super.key});

  @override
  ConsumerState<ModelDownloadScreen> createState() => _ModelDownloadScreenState();
}

class _ModelDownloadScreenState extends ConsumerState<ModelDownloadScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize device capability detection
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(deviceCapabilityProvider.notifier).refreshCapability();
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceCapability = ref.watch(deviceCapabilityProvider);
    final downloadState = ref.watch(modelDownloadStateProvider);
    final selectedLevel = ref.watch(selectedModelLevelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Download AI Model'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(deviceCapabilityProvider.notifier).refreshCapability();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Device Capability Card
            _buildDeviceCapabilityCard(deviceCapability, context),
            const SizedBox(height: 24),

            // Model Selection
            _buildModelSelection(context),
            const SizedBox(height: 24),

            // Download Progress
            if (downloadState.isDownloading) _buildDownloadProgress(context),
            if (downloadState.isDownloading) const SizedBox(height: 24),

            // Download Button
            _buildDownloadButton(context),
            const SizedBox(height: 24),

            // Model Recommendations
            _buildModelRecommendations(context),
            const SizedBox(height: 24),

            // Download Statistics
            _buildDownloadStatistics(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceCapabilityCard(DeviceCapability capability, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.phone_android, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Device Capability',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildCapabilityRow('RAM', '${capability.ramGB} GB', context),
            _buildCapabilityRow('Storage', '${capability.storageGB} GB', context),
            _buildCapabilityRow('CPU Cores', '${capability.cpuCores}', context),
            _buildCapabilityRow('GPU', capability.hasGpu ? 'Available' : 'Not Available', context),
            _buildCapabilityRow('Max Model Size', '${(capability.maxModelSize / (1024 * 1024)).toStringAsFixed(0)} MB', context),
          ],
        ),
      ),
    );
  }

  Widget _buildCapabilityRow(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModelSelection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Model Level',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...ModelLevel.values.map((level) => ModelDownloadCard(
          level: level,
          isSelected: ref.watch(selectedModelLevelProvider) == level,
          onTap: () {
            ref.read(selectedModelLevelProvider.notifier).state = level;
          },
        )),
      ],
    );
  }

  Widget _buildDownloadProgress(BuildContext context) {
    final downloadState = ref.watch(modelDownloadStateProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Download Progress',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            DownloadProgressWidget(
              progress: downloadState.progress,
              level: downloadState.level,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadButton(BuildContext context) {
    final downloadState = ref.watch(modelDownloadStateProvider);
    final selectedLevel = ref.watch(selectedModelLevelProvider);
    final deviceCapability = ref.watch(deviceCapabilityProvider);

    final canDownload = !downloadState.isDownloading && 
                       selectedLevel != null &&
                       selectedLevel.sizeBytes <= deviceCapability.maxModelSize;

    return ElevatedButton.icon(
      onPressed: canDownload ? _startDownload : null,
      icon: downloadState.isDownloading 
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.download),
      label: Text(
        downloadState.isDownloading 
            ? 'Downloading...' 
            : 'Download Model',
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildModelRecommendations(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommendations',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...ref.watch(modelRecommendationsProvider).map((recommendation) => 
          _buildRecommendationCard(recommendation, context)
        ),
      ],
    );
  }

  Widget _buildRecommendationCard(ModelRecommendation recommendation, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          recommendation.isRecommended ? Icons.star : Icons.star_border,
          color: recommendation.isRecommended ? Colors.amber : Colors.grey,
        ),
        title: Text(
          recommendation.level.name.toUpperCase(),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(recommendation.reason),
        trailing: Text(
          '${(recommendation.level.sizeBytes / (1024 * 1024)).toStringAsFixed(0)} MB',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }

  Widget _buildDownloadStatistics(BuildContext context) {
    final stats = ref.watch(downloadStatisticsProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Download Statistics',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Total', stats.totalDownloads.toString(), context),
                _buildStatItem('Active', stats.activeDownloads.toString(), context),
                _buildStatItem('Completed', stats.completedDownloads.toString(), context),
                _buildStatItem('Failed', stats.failedDownloads.toString(), context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  void _startDownload() {
    final selectedLevel = ref.read(selectedModelLevelProvider);
    if (selectedLevel != null) {
      ref.read(modelDownloadStateProvider.notifier).startDownload(selectedLevel);
    }
  }
}

/// Device Capability Provider
final deviceCapabilityProvider = StateProvider<DeviceCapability>((ref) {
  return const DeviceCapability(
    ramGB: 4,
    storageGB: 8,
    cpuCores: 4,
    hasGpu: false,
    maxModelSize: 200000000,
  );
});

/// Selected Model Level Provider
final selectedModelLevelProvider = StateProvider<ModelLevel?>((ref) {
  return null;
});

/// Model Download State Provider
final modelDownloadStateProvider = StateNotifierProvider<ModelDownloadStateNotifier, ModelDownloadState>((ref) {
  return ModelDownloadStateNotifier();
});

/// Model Download State
class ModelDownloadState {
  final bool isDownloading;
  final ModelLevel? level;
  final double progress;
  final String? error;

  const ModelDownloadState({
    this.isDownloading = false,
    this.level,
    this.progress = 0.0,
    this.error,
  });
}

/// Model Download State Notifier
class ModelDownloadStateNotifier extends StateNotifier<ModelDownloadState> {
  ModelDownloadStateNotifier() : super(const ModelDownloadState());

  void startDownload(ModelLevel level) {
    state = ModelDownloadState(
      isDownloading: true,
      level: level,
      progress: 0.0,
    );
    
    // Simulate download progress
    _simulateDownload(level);
  }

  void _simulateDownload(ModelLevel level) async {
    const totalSteps = 100;
    const stepDuration = Duration(milliseconds: 100);
    
    for (int i = 0; i <= totalSteps; i++) {
      if (mounted) {
        state = ModelDownloadState(
          isDownloading: true,
          level: level,
          progress: i / totalSteps,
        );
      }
      
      await Future.delayed(stepDuration);
    }
    
    if (mounted) {
      state = const ModelDownloadState(
        isDownloading: false,
        progress: 1.0,
      );
    }
  }

  void cancelDownload() {
    state = const ModelDownloadState();
  }
}

/// Model Recommendations Provider
final modelRecommendationsProvider = Provider<List<ModelRecommendation>>((ref) {
  return [
    const ModelRecommendation(
      level: ModelLevel.tiny,
      isRecommended: true,
      reason: 'Fast and lightweight, suitable for basic tasks',
      priority: 2,
    ),
    const ModelRecommendation(
      level: ModelLevel.mini,
      isRecommended: true,
      reason: 'Balanced performance and size, recommended for most users',
      priority: 1,
    ),
    const ModelRecommendation(
      level: ModelLevel.full,
      isRecommended: false,
      reason: 'Best quality, requires more resources',
      priority: 3,
    ),
  ];
});

/// Download Statistics Provider
final downloadStatisticsProvider = Provider<DownloadStatistics>((ref) {
  return const DownloadStatistics(
    totalDownloads: 0,
    activeDownloads: 0,
    completedDownloads: 0,
    failedDownloads: 0,
  );
});
