import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Health Status enum for AI system
enum HealthStatus {
  healthy,
  warning,
  critical,
  offline,
}

/// Health Sample class for AI system
class HealthSample {
  final DateTime timestamp;
  final double value;
  final String metric;
  
  const HealthSample({
    required this.timestamp,
    required this.value,
    required this.metric,
  });
}

/// AI Health Status Widget for displaying AI system health
class AIHealthStatusWidget extends ConsumerWidget {
  final bool showDetails;
  final VoidCallback? onTap;

  const AIHealthStatusWidget({
    super.key,
    this.showDetails = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthStatus = ref.watch(aiHealthStatusProvider);
    final healthReport = ref.watch(aiHealthReportProvider);

    if (showDetails) {
      return _buildDetailedHealthStatus(healthStatus, healthReport, context);
    } else {
      return _buildCompactHealthStatus(healthStatus, context);
    }
  }

  Widget _buildCompactHealthStatus(HealthStatus healthStatus, BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: _getHealthColor(healthStatus.isHealthy).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _getHealthColor(healthStatus.isHealthy),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getHealthIcon(healthStatus.isHealthy),
              size: 16,
              color: _getHealthColor(healthStatus.isHealthy),
            ),
            const SizedBox(width: 6),
            Text(
              _getHealthText(healthStatus.isHealthy),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _getHealthColor(healthStatus.isHealthy),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedHealthStatus(
    HealthStatus healthStatus,
    HealthReport healthReport,
    BuildContext context,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHealthHeader(healthStatus, context),
            const SizedBox(height: 16),
            _buildHealthMetrics(healthStatus, context),
            const SizedBox(height: 16),
            _buildPerformanceTrend(healthReport, context),
            if (healthReport.recommendations.isNotEmpty) ...[
              const SizedBox(height: 16),
              _buildRecommendations(healthReport, context),
            ],
            if (healthReport.recentErrors.isNotEmpty) ...[
              const SizedBox(height: 16),
              _buildRecentErrors(healthReport, context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHealthHeader(HealthStatus healthStatus, BuildContext context) {
    return Row(
      children: [
        Icon(
          _getHealthIcon(healthStatus.isHealthy),
          color: _getHealthColor(healthStatus.isHealthy),
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getHealthText(healthStatus.isHealthy),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _getHealthColor(healthStatus.isHealthy),
                ),
              ),
              Text(
                healthStatus.recommendation,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHealthMetrics(HealthStatus healthStatus, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            'Success Rate',
            '${(healthStatus.successRate * 100).toStringAsFixed(1)}%',
            _getSuccessRateColor(healthStatus.successRate),
            context,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMetricCard(
            'Avg Latency',
            '${healthStatus.averageLatencyMs}ms',
            _getLatencyColor(healthStatus.averageLatencyMs),
            context,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(String label, String value, Color color, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceTrend(HealthReport healthReport, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Performance Trend',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              _getTrendIcon(healthReport.trend),
              color: _getTrendColor(healthReport.trend),
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              _getTrendText(healthReport.trend),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: _getTrendColor(healthReport.trend),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecommendations(HealthReport healthReport, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommendations',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...healthReport.recommendations.map((recommendation) => 
          _buildRecommendationItem(recommendation, context)
        ),
      ],
    );
  }

  Widget _buildRecommendationItem(String recommendation, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lightbulb_outline,
            size: 16,
            color: Colors.amber[600],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              recommendation,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentErrors(HealthReport healthReport, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Errors',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.red[600],
          ),
        ),
        const SizedBox(height: 8),
        ...healthReport.recentErrors.take(3).map((error) => 
          _buildErrorItem(error, context)
        ),
      ],
    );
  }

  Widget _buildErrorItem(HealthSample error, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            size: 16,
            color: Colors.red[600],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              error.error ?? 'Unknown error',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.red[600],
              ),
            ),
          ),
          Text(
            _formatTimestamp(error.timestamp),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Color _getHealthColor(bool isHealthy) {
    return isHealthy ? Colors.green : Colors.red;
  }

  IconData _getHealthIcon(bool isHealthy) {
    return isHealthy ? Icons.check_circle : Icons.error;
  }

  String _getHealthText(bool isHealthy) {
    return isHealthy ? 'Healthy' : 'Issues Detected';
  }

  Color _getSuccessRateColor(double successRate) {
    if (successRate >= 0.9) return Colors.green;
    if (successRate >= 0.7) return Colors.orange;
    return Colors.red;
  }

  Color _getLatencyColor(int latencyMs) {
    if (latencyMs <= 1000) return Colors.green;
    if (latencyMs <= 3000) return Colors.orange;
    return Colors.red;
  }

  IconData _getTrendIcon(PerformanceTrend trend) {
    switch (trend) {
      case PerformanceTrend.improving:
        return Icons.trending_up;
      case PerformanceTrend.declining:
        return Icons.trending_down;
      case PerformanceTrend.speeding:
        return Icons.speed;
      case PerformanceTrend.slowing:
        return Icons.slow_motion_video;
      case PerformanceTrend.stable:
        return Icons.trending_flat;
    }
  }

  Color _getTrendColor(PerformanceTrend trend) {
    switch (trend) {
      case PerformanceTrend.improving:
      case PerformanceTrend.speeding:
        return Colors.green;
      case PerformanceTrend.declining:
      case PerformanceTrend.slowing:
        return Colors.red;
      case PerformanceTrend.stable:
        return Colors.blue;
    }
  }

  String _getTrendText(PerformanceTrend trend) {
    switch (trend) {
      case PerformanceTrend.improving:
        return 'Performance is improving';
      case PerformanceTrend.declining:
        return 'Performance is declining';
      case PerformanceTrend.speeding:
        return 'Response times are improving';
      case PerformanceTrend.slowing:
        return 'Response times are increasing';
      case PerformanceTrend.stable:
        return 'Performance is stable';
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}

/// Health Status Provider
final aiHealthStatusProvider = StateProvider<HealthStatus>((ref) {
  return const HealthStatus(
    isHealthy: true,
    successRate: 0.95,
    averageLatencyMs: 150,
    recommendation: 'All systems optimal',
  );
});

/// Health Report Provider
final aiHealthReportProvider = Provider<HealthReport>((ref) {
  return HealthReport(
    snapshot: const HealthSnapshot(
      successRate: 0.95,
      p50LatencyMs: 150,
      p95LatencyMs: 300,
      totalSamples: 100,
      isHealthy: true,
    ),
    trend: PerformanceTrend.stable,
    recentErrors: [],
    recommendations: [
      'Performance is stable',
      'No immediate action needed',
    ],
  );
});
