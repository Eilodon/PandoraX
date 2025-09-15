import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_core/ai_core.dart';
import '../widgets/ai_mode_indicator.dart';
import '../widgets/ai_health_status_widget.dart';

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
            const DetailedAIModeIndicator(),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ref.read(aiModeProvider.notifier).state = const AIMode(
                        isOnDevice: true,
                        modelName: 'phi-3-mini',
                        status: 'Ready',
                        lastSwitch: null,
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
                      ref.read(aiModeProvider.notifier).state = const AIMode(
                        isOnDevice: false,
                        modelName: 'Gemini',
                        status: 'Ready',
                        lastSwitch: null,
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

  Widget _buildHealthStatusSection(HealthStatus healthStatus, BuildContext context) {
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
            const AIHealthStatusWidget(showDetails: true),
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
              settings.autoDownloadModels,
              (value) {
                ref.read(aiSettingsProvider.notifier).updateAutoDownload(value);
              },
              context,
            ),
            _buildSettingTile(
              'Use GPU Acceleration',
              'Use GPU for faster model execution',
              settings.useGpuAcceleration,
              (value) {
                ref.read(aiSettingsProvider.notifier).updateUseGpu(value);
              },
              context,
            ),
            _buildSettingTile(
              'Model Caching',
              'Cache models for faster loading',
              settings.enableModelCaching,
              (value) {
                ref.read(aiSettingsProvider.notifier).updateModelCaching(value);
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
              settings.autoSwitchOnNetworkChange,
              (value) {
                ref.read(aiSettingsProvider.notifier).updateAutoSwitch(value);
              },
              context,
            ),
            _buildSettingTile(
              'Use Mobile Data',
              'Allow AI operations on mobile data',
              settings.allowMobileData,
              (value) {
                ref.read(aiSettingsProvider.notifier).updateMobileData(value);
              },
              context,
            ),
            _buildSettingTile(
              'Compress Responses',
              'Compress AI responses to save bandwidth',
              settings.compressResponses,
              (value) {
                ref.read(aiSettingsProvider.notifier).updateCompressResponses(value);
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
              settings.responseTimeoutSeconds,
              5.0,
              60.0,
              (value) {
                ref.read(aiSettingsProvider.notifier).updateResponseTimeout(value);
              },
              context,
            ),
            _buildSliderSetting(
              'Max Retry Attempts',
              settings.maxRetryAttempts.toDouble(),
              1.0,
              5.0,
              (value) {
                ref.read(aiSettingsProvider.notifier).updateMaxRetry(value.round());
              },
              context,
            ),
            _buildSliderSetting(
              'Health Check Interval (minutes)',
              settings.healthCheckIntervalMinutes.toDouble(),
              1.0,
              60.0,
              (value) {
                ref.read(aiSettingsProvider.notifier).updateHealthCheckInterval(value.round());
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
        content: const AIHealthStatusWidget(showDetails: true),
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
              ref.read(aiSettingsProvider.notifier).resetToDefaults();
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

/// AI Settings data class
class AISettings {
  final bool autoDownloadModels;
  final bool useGpuAcceleration;
  final bool enableModelCaching;
  final bool autoSwitchOnNetworkChange;
  final bool allowMobileData;
  final bool compressResponses;
  final double responseTimeoutSeconds;
  final int maxRetryAttempts;
  final int healthCheckIntervalMinutes;

  const AISettings({
    this.autoDownloadModels = true,
    this.useGpuAcceleration = true,
    this.enableModelCaching = true,
    this.autoSwitchOnNetworkChange = true,
    this.allowMobileData = false,
    this.compressResponses = true,
    this.responseTimeoutSeconds = 30.0,
    this.maxRetryAttempts = 3,
    this.healthCheckIntervalMinutes = 5,
  });

  AISettings copyWith({
    bool? autoDownloadModels,
    bool? useGpuAcceleration,
    bool? enableModelCaching,
    bool? autoSwitchOnNetworkChange,
    bool? allowMobileData,
    bool? compressResponses,
    double? responseTimeoutSeconds,
    int? maxRetryAttempts,
    int? healthCheckIntervalMinutes,
  }) {
    return AISettings(
      autoDownloadModels: autoDownloadModels ?? this.autoDownloadModels,
      useGpuAcceleration: useGpuAcceleration ?? this.useGpuAcceleration,
      enableModelCaching: enableModelCaching ?? this.enableModelCaching,
      autoSwitchOnNetworkChange: autoSwitchOnNetworkChange ?? this.autoSwitchOnNetworkChange,
      allowMobileData: allowMobileData ?? this.allowMobileData,
      compressResponses: compressResponses ?? this.compressResponses,
      responseTimeoutSeconds: responseTimeoutSeconds ?? this.responseTimeoutSeconds,
      maxRetryAttempts: maxRetryAttempts ?? this.maxRetryAttempts,
      healthCheckIntervalMinutes: healthCheckIntervalMinutes ?? this.healthCheckIntervalMinutes,
    );
  }
}

/// AI Settings Provider
final aiSettingsProvider = StateNotifierProvider<AISettingsNotifier, AISettings>((ref) {
  return AISettingsNotifier();
});

/// AI Settings Notifier
class AISettingsNotifier extends StateNotifier<AISettings> {
  AISettingsNotifier() : super(const AISettings());

  void updateAutoDownload(bool value) {
    state = state.copyWith(autoDownloadModels: value);
  }

  void updateUseGpu(bool value) {
    state = state.copyWith(useGpuAcceleration: value);
  }

  void updateModelCaching(bool value) {
    state = state.copyWith(enableModelCaching: value);
  }

  void updateAutoSwitch(bool value) {
    state = state.copyWith(autoSwitchOnNetworkChange: value);
  }

  void updateMobileData(bool value) {
    state = state.copyWith(allowMobileData: value);
  }

  void updateCompressResponses(bool value) {
    state = state.copyWith(compressResponses: value);
  }

  void updateResponseTimeout(double value) {
    state = state.copyWith(responseTimeoutSeconds: value);
  }

  void updateMaxRetry(int value) {
    state = state.copyWith(maxRetryAttempts: value);
  }

  void updateHealthCheckInterval(int value) {
    state = state.copyWith(healthCheckIntervalMinutes: value);
  }

  void resetToDefaults() {
    state = const AISettings();
  }
}
