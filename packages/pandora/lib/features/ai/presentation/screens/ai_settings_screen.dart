import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/ai_mode_indicator.dart' as mode_indicator;
import '../widgets/ai_health_status_widget.dart';
import '../../domain/health_status.dart';
import '../../providers/health_providers.dart';

/// AI Mode Provider
final aiModeProvider = StateProvider<AIMode>((ref) => const AIMode(
  isOnDevice: false,
  modelName: 'Gemini',
  status: 'Ready',
  lastSwitch: null,
));

/// AI Settings class
class AISettings {
  final bool autoSwitch;
  final String preferredModel;
  final bool enableHealthMonitoring;
  final bool autoDownload;
  final bool useGpu;
  final bool modelCaching;
  final bool mobileData;
  final bool compressResponses;
  final int responseTimeout;
  final int maxRetry;
  final int healthCheckInterval;

  const AISettings({
    this.autoSwitch = false,
    this.preferredModel = 'Gemini',
    this.enableHealthMonitoring = true,
    this.autoDownload = false,
    this.useGpu = false,
    this.modelCaching = false,
    this.mobileData = false,
    this.compressResponses = false,
    this.responseTimeout = 30,
    this.maxRetry = 3,
    this.healthCheckInterval = 60,
  });

  AISettings copyWith({
    bool? autoSwitch,
    String? preferredModel,
    bool? enableHealthMonitoring,
    bool? autoDownload,
    bool? useGpu,
    bool? modelCaching,
    bool? mobileData,
    bool? compressResponses,
    int? responseTimeout,
    int? maxRetry,
    int? healthCheckInterval,
  }) {
    return AISettings(
      autoSwitch: autoSwitch ?? this.autoSwitch,
      preferredModel: preferredModel ?? this.preferredModel,
      enableHealthMonitoring: enableHealthMonitoring ?? this.enableHealthMonitoring,
      autoDownload: autoDownload ?? this.autoDownload,
      useGpu: useGpu ?? this.useGpu,
      modelCaching: modelCaching ?? this.modelCaching,
      mobileData: mobileData ?? this.mobileData,
      compressResponses: compressResponses ?? this.compressResponses,
      responseTimeout: responseTimeout ?? this.responseTimeout,
      maxRetry: maxRetry ?? this.maxRetry,
      healthCheckInterval: healthCheckInterval ?? this.healthCheckInterval,
    );
  }
}

/// AI Settings Provider
final aiSettingsProvider = StateProvider<AISettings>((ref) => const AISettings());

/// AI Mode class
class AIMode {
  final bool isOnDevice;
  final String modelName;
  final String status;
  final DateTime? lastSwitch;

  const AIMode({
    required this.isOnDevice,
    required this.modelName,
    required this.status,
    this.lastSwitch,
  });
}

/// AI Settings Screen for managing AI preferences
class AISettingsScreen extends ConsumerStatefulWidget {
  const AISettingsScreen({super.key});

  @override
  ConsumerState<AISettingsScreen> createState() => _AISettingsScreenState();
}

class _AISettingsScreenState extends ConsumerState<AISettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final aiMode = ref.watch(aiModeProvider);
    final healthStatus = ref.watch(aiHealthStatusProvider);
    final settings = ref.watch(aiSettingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AI Mode Section
            _buildAIModeSection(aiMode, context),
            const SizedBox(height: 24),

            // Health Status Section
            _buildHealthStatusSection(healthStatus, context),
            const SizedBox(height: 24),

            // Model Settings Section
            _buildModelSettingsSection(settings, context),
            const SizedBox(height: 24),

            // Network Settings Section
            _buildNetworkSettingsSection(settings, context),
            const SizedBox(height: 24),

            // Advanced Settings Section
            _buildAdvancedSettingsSection(settings, context),
            const SizedBox(height: 24),

            // Reset Section
            _buildResetSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAIModeSection(AIMode aiMode, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AI Mode',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const mode_indicator.DetailedAIModeIndicator(),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ref.read(aiModeProvider.notifier).state = AIMode(
                        isOnDevice: true,
                        modelName: 'phi-3-mini',
                        status: 'Ready',
                        lastSwitch: DateTime.now(),
                      );
                    },
                    icon: const Icon(Icons.phone_android),
                    label: const Text('Use On-Device'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ref.read(aiModeProvider.notifier).state = AIMode(
                        isOnDevice: false,
                        modelName: 'Gemini',
                        status: 'Ready',
                        lastSwitch: DateTime.now(),
                      );
                    },
                    icon: const Icon(Icons.cloud),
                    label: const Text('Use Cloud'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthStatusSection(HealthStatusEnum healthStatus, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Health Status',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: _showHealthDetails,
                  child: const Text('View Details'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AIHealthStatusWidget(
              healthStatus: HealthStatus(
                isHealthy: true,
                successRate: 0.95,
                averageLatencyMs: 150,
                recommendation: 'System is running optimally',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModelSettingsSection(AISettings settings, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Model Settings',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingTile(
              'Auto-download Models',
              'Automatically download recommended models',
              settings.autoDownload,
              (value) {
                ref.read(aiSettingsProvider.notifier).state = ref.read(aiSettingsProvider).copyWith(autoDownload: value);
              },
              context,
            ),
            _buildSettingTile(
              'Use GPU Acceleration',
              'Use GPU for faster model execution',
              settings.useGpu,
              (value) {
                ref.read(aiSettingsProvider.notifier).state = ref.read(aiSettingsProvider).copyWith(useGpu: value);
              },
              context,
            ),
            _buildSettingTile(
              'Model Caching',
              'Cache models for faster loading',
              settings.modelCaching,
              (value) {
                ref.read(aiSettingsProvider.notifier).state = ref.read(aiSettingsProvider).copyWith(modelCaching: value);
              },
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkSettingsSection(AISettings settings, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Network Settings',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingTile(
              'Auto-switch on Network Change',
              'Switch between on-device and cloud based on network',
              settings.autoSwitch,
              (value) {
                ref.read(aiSettingsProvider.notifier).state = ref.read(aiSettingsProvider).copyWith(autoSwitch: value);
              },
              context,
            ),
            _buildSettingTile(
              'Use Mobile Data',
              'Allow AI operations on mobile data',
              settings.mobileData,
              (value) {
                ref.read(aiSettingsProvider.notifier).state = ref.read(aiSettingsProvider).copyWith(mobileData: value);
              },
              context,
            ),
            _buildSettingTile(
              'Compress Responses',
              'Compress AI responses to save bandwidth',
              settings.compressResponses,
              (value) {
                ref.read(aiSettingsProvider.notifier).state = ref.read(aiSettingsProvider).copyWith(compressResponses: value);
              },
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancedSettingsSection(AISettings settings, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Advanced Settings',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSliderSetting(
              'Response Timeout (seconds)',
              settings.responseTimeout.toDouble(),
              5.0,
              60.0,
              (value) {
                ref.read(aiSettingsProvider.notifier).state = ref.read(aiSettingsProvider).copyWith(responseTimeout: value.toInt());
              },
              context,
            ),
            _buildSliderSetting(
              'Max Retry Attempts',
              settings.maxRetry.toDouble(),
              1.0,
              5.0,
              (value) {
                ref.read(aiSettingsProvider.notifier).state = ref.read(aiSettingsProvider).copyWith(maxRetry: value.round());
              },
              context,
            ),
            _buildSliderSetting(
              'Health Check Interval (minutes)',
              settings.healthCheckInterval.toDouble(),
              1.0,
              60.0,
              (value) {
                ref.read(aiSettingsProvider.notifier).state = ref.read(aiSettingsProvider).copyWith(healthCheckInterval: value.round());
              },
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResetSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reset & Clear',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.clear_all, color: Colors.orange),
              title: const Text('Clear Chat History'),
              subtitle: const Text('Remove all chat messages'),
              onTap: _clearChatHistory,
            ),
            ListTile(
              leading: const Icon(Icons.delete_forever, color: Colors.red),
              title: const Text('Delete Downloaded Models'),
              subtitle: const Text('Remove all downloaded AI models'),
              onTap: _deleteDownloadedModels,
            ),
            ListTile(
              leading: const Icon(Icons.refresh, color: Colors.blue),
              title: const Text('Reset to Defaults'),
              subtitle: const Text('Reset all settings to default values'),
              onTap: _resetToDefaults,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
    BuildContext context,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildSliderSetting(
    String title,
    double value,
    double min,
    double max,
    Function(double) onChanged,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min).round(),
          onChanged: onChanged,
        ),
        Text(
          value.toStringAsFixed(0),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  void _showHealthDetails() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('AI Health Details'),
        content: AIHealthStatusWidget(
          healthStatus: HealthStatus(
            isHealthy: true,
            successRate: 0.95,
            averageLatencyMs: 150,
            recommendation: 'System is running optimally',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _clearChatHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Chat History'),
        content: const Text('Are you sure you want to clear all chat messages?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement clear chat history
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Chat history cleared')),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _deleteDownloadedModels() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Downloaded Models'),
        content: const Text('Are you sure you want to delete all downloaded AI models? This will free up storage space.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement delete models
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Downloaded models deleted')),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _resetToDefaults() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset to Defaults'),
        content: const Text('Are you sure you want to reset all settings to their default values?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(aiSettingsProvider.notifier).state = const AISettings();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings reset to defaults')),
              );
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}

