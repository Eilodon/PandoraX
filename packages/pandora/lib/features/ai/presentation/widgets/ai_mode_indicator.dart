import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// AI Mode Indicator widget that shows current AI mode and status
class AIModeIndicator extends ConsumerWidget {
  final VoidCallback? onTap;
  final bool showDetails;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  const AIModeIndicator({
    super.key,
    this.onTap,
    this.showDetails = false,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aiMode = ref.watch(aiModeProvider);
    final isAutoDetected = ref.watch(aiAutoDetectedProvider);
    final healthStatus = ref.watch(aiHealthStatusProvider);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _getBackgroundColor(aiMode.isOnDevice, healthStatus.isHealthy),
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
          border: Border.all(
            color: _getBorderColor(aiMode.isOnDevice, healthStatus.isHealthy),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _getShadowColor(aiMode.isOnDevice),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIcon(aiMode.isOnDevice, healthStatus.isHealthy),
            const SizedBox(width: 6),
            _buildText(aiMode, context),
            if (isAutoDetected) ...[
              const SizedBox(width: 4),
              _buildAutoIcon(),
            ],
            if (showDetails) ...[
              const SizedBox(width: 8),
              _buildDetailsIndicator(healthStatus),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(bool isOnDevice, bool isHealthy) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Icon(
        isOnDevice ? Icons.phone_android : Icons.cloud,
        size: 16,
        color: _getIconColor(isOnDevice, isHealthy),
      ),
    );
  }

  Widget _buildText(AIMode aiMode, BuildContext context) {
    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 300),
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: _getTextColor(aiMode.isOnDevice, context),
      ),
      child: Text(aiMode.displayName),
    );
  }

  Widget _buildAutoIcon() {
    return Icon(
      Icons.auto_awesome,
      size: 14,
      color: Colors.orange.shade600,
    );
  }

  Widget _buildDetailsIndicator(HealthStatus healthStatus) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: _getHealthColor(healthStatus.isHealthy),
        shape: BoxShape.circle,
      ),
    );
  }

  Color _getBackgroundColor(bool isOnDevice, bool isHealthy) {
    if (isOnDevice) {
      return isHealthy ? Colors.green.shade50 : Colors.orange.shade50;
    } else {
      return Colors.blue.shade50;
    }
  }

  Color _getBorderColor(bool isOnDevice, bool isHealthy) {
    if (isOnDevice) {
      return isHealthy ? Colors.green.shade300 : Colors.orange.shade300;
    } else {
      return Colors.blue.shade300;
    }
  }

  Color _getShadowColor(bool isOnDevice) {
    if (isOnDevice) {
      return Colors.green.shade200;
    } else {
      return Colors.blue.shade200;
    }
  }

  Color _getIconColor(bool isOnDevice, bool isHealthy) {
    if (isOnDevice) {
      return isHealthy ? Colors.green.shade600 : Colors.orange.shade600;
    } else {
      return Colors.blue.shade600;
    }
  }

  Color _getTextColor(bool isOnDevice, BuildContext context) {
    if (isOnDevice) {
      return Colors.green.shade700;
    } else {
      return Colors.blue.shade700;
    }
  }

  Color _getHealthColor(bool isHealthy) {
    return isHealthy ? Colors.green : Colors.red;
  }
}

/// AI Mode data class
class AIMode {
  final bool isOnDevice;
  final String modelName;
  final String status;
  final DateTime lastSwitch;

  const AIMode({
    required this.isOnDevice,
    required this.modelName,
    required this.status,
    required this.lastSwitch,
  });

  String get displayName {
    if (isOnDevice) {
      return 'On-Device ($modelName)';
    } else {
      return 'Cloud (Gemini)';
    }
  }
}

/// Health Status data class
class HealthStatus {
  final bool isHealthy;
  final double successRate;
  final int averageLatencyMs;
  final String recommendation;

  const HealthStatus({
    required this.isHealthy,
    required this.successRate,
    required this.averageLatencyMs,
    required this.recommendation,
  });
}

/// AI Mode Provider
final aiModeProvider = StateProvider<AIMode>((ref) {
  return const AIMode(
    isOnDevice: false,
    modelName: 'None',
    status: 'Initializing',
    lastSwitch: null,
  );
});

/// AI Auto Detected Provider
final aiAutoDetectedProvider = StateProvider<bool>((ref) {
  return false;
});

/// AI Health Status Provider
final aiHealthStatusProvider = StateProvider<HealthStatus>((ref) {
  return const HealthStatus(
    isHealthy: true,
    successRate: 1.0,
    averageLatencyMs: 0,
    recommendation: 'All systems optimal',
  );
});

/// AI Mode Indicator with detailed status
class DetailedAIModeIndicator extends ConsumerWidget {
  final VoidCallback? onTap;

  const DetailedAIModeIndicator({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aiMode = ref.watch(aiModeProvider);
    final healthStatus = ref.watch(aiHealthStatusProvider);
    final isAutoDetected = ref.watch(aiAutoDetectedProvider);

    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    aiMode.isOnDevice ? Icons.phone_android : Icons.cloud,
                    color: aiMode.isOnDevice ? Colors.green : Colors.blue,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          aiMode.displayName,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          aiMode.status,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isAutoDetected)
                    Icon(
                      Icons.auto_awesome,
                      color: Colors.orange,
                      size: 20,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              _buildHealthIndicator(healthStatus, context),
              const SizedBox(height: 8),
              _buildPerformanceMetrics(healthStatus, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHealthIndicator(HealthStatus healthStatus, BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: healthStatus.isHealthy ? Colors.green : Colors.red,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          healthStatus.isHealthy ? 'Healthy' : 'Issues Detected',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: healthStatus.isHealthy ? Colors.green : Colors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceMetrics(HealthStatus healthStatus, BuildContext context) {
    return Row(
      children: [
        _buildMetric(
          'Success Rate',
          '${(healthStatus.successRate * 100).toStringAsFixed(1)}%',
          context,
        ),
        const SizedBox(width: 16),
        _buildMetric(
          'Latency',
          '${healthStatus.averageLatencyMs}ms',
          context,
        ),
      ],
    );
  }

  Widget _buildMetric(String label, String value, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
