import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/health_status.dart';

class AIHealthStatusWidget extends ConsumerWidget {
  final HealthStatus healthStatus;
  final VoidCallback? onRefresh;

  const AIHealthStatusWidget({
    super.key,
    required this.healthStatus,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'AI Health Status',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                if (onRefresh != null)
                  IconButton(
                    onPressed: onRefresh,
                    icon: const Icon(Icons.refresh),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            _buildStatusIndicator(context),
            const SizedBox(height: 16),
            _buildMetrics(context),
            const SizedBox(height: 16),
            _buildRecommendations(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(BuildContext context) {
    final isHealthy = healthStatus.isHealthy;
    final color = isHealthy ? Colors.green : Colors.red;
    final icon = isHealthy ? Icons.check_circle : Icons.error;
    
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 8),
        Text(
          isHealthy ? 'Healthy' : 'Issues Detected',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildMetrics(BuildContext context) {
    return Column(
      children: [
        _buildMetricRow(
          context,
          'Success Rate',
          '${(healthStatus.successRate * 100).toStringAsFixed(1)}%',
          healthStatus.successRate,
        ),
        const SizedBox(height: 8),
        _buildMetricRow(
          context,
          'Average Latency',
          '${healthStatus.averageLatencyMs}ms',
          _getLatencyScore(healthStatus.averageLatencyMs),
        ),
      ],
    );
  }

  Widget _buildMetricRow(
    BuildContext context,
    String label,
    String value,
    double score,
  ) {
    final color = _getScoreColor(score);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Row(
          children: [
            Container(
              width: 100,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: score,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecommendations(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommendations',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          healthStatus.recommendation,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  double _getLatencyScore(int latencyMs) {
    if (latencyMs < 100) return 1.0;
    if (latencyMs < 500) return 0.8;
    if (latencyMs < 1000) return 0.6;
    if (latencyMs < 2000) return 0.4;
    return 0.2;
  }

  Color _getScoreColor(double score) {
    if (score >= 0.8) return Colors.green;
    if (score >= 0.6) return Colors.orange;
    return Colors.red;
  }
}

class HealthReportWidget extends StatelessWidget {
  final HealthReport report;

  const HealthReportWidget({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Health Report',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            AIHealthStatusWidget(healthStatus: report.status),
            const SizedBox(height: 16),
            _buildTrendIndicator(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendIndicator(BuildContext context) {
    return Row(
      children: [
        Icon(
          _getTrendIcon(report.trend),
          color: _getTrendColor(report.trend),
        ),
        const SizedBox(width: 8),
        Text(
          'Trend: ${_getTrendText(report.trend)}',
          style: TextStyle(
            color: _getTrendColor(report.trend),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  IconData _getTrendIcon(PerformanceTrend trend) {
    return trend.when(
      improving: () => Icons.trending_up,
      stable: () => Icons.trending_flat,
      declining: () => Icons.trending_down,
      volatile: () => Icons.trending_up,
      unknown: () => Icons.help_outline,
    );
  }

  Color _getTrendColor(PerformanceTrend trend) {
    return trend.when(
      improving: () => Colors.green,
      stable: () => Colors.blue,
      declining: () => Colors.red,
      volatile: () => Colors.orange,
      unknown: () => Colors.grey,
    );
  }

  String _getTrendText(PerformanceTrend trend) {
    return trend.when(
      improving: () => 'Improving',
      stable: () => 'Stable',
      declining: () => 'Declining',
      volatile: () => 'Volatile',
      unknown: () => 'Unknown',
    );
  }
}
