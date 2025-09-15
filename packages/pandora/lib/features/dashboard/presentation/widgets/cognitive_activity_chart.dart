import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// Cognitive Activity Chart Widget
/// 
/// Displays cognitive activity over time using charts
class CognitiveActivityChart extends StatelessWidget {
  final CognitiveAnalytics analytics;

  const CognitiveActivityChart({
    super.key,
    required this.analytics,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.timeline,
                  color: theme.primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Cognitive Activity',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                _buildTimeRangeSelector(),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: _buildActivityChart(),
            ),
            const SizedBox(height: 16),
            _buildChartLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeRangeSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: const Text(
        'Last 7 days',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildActivityChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 1,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey[300]!,
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Colors.grey[300]!,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                if (value.toInt() >= 0 && value.toInt() < days.length) {
                  return Text(
                    days[value.toInt()],
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );
              },
              reservedSize: 40,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey[300]!),
        ),
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 10,
        lineBarsData: [
          _buildMemoryLine(),
          _buildAIResponseLine(),
          _buildSearchLine(),
        ],
      ),
    );
  }

  LineChartBarData _buildMemoryLine() {
    return LineChartBarData(
      spots: _getMemorySpots(),
      isCurved: true,
      color: Colors.blue,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            radius: 4,
            color: Colors.blue,
            strokeWidth: 2,
            strokeColor: Colors.white,
          );
        },
      ),
      belowBarData: BarAreaData(
        show: true,
        color: Colors.blue.withOpacity(0.1),
      ),
    );
  }

  LineChartBarData _buildAIResponseLine() {
    return LineChartBarData(
      spots: _getAIResponseSpots(),
      isCurved: true,
      color: Colors.green,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            radius: 4,
            color: Colors.green,
            strokeWidth: 2,
            strokeColor: Colors.white,
          );
        },
      ),
      belowBarData: BarAreaData(
        show: true,
        color: Colors.green.withOpacity(0.1),
      ),
    );
  }

  LineChartBarData _buildSearchLine() {
    return LineChartBarData(
      spots: _getSearchSpots(),
      isCurved: true,
      color: Colors.orange,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            radius: 4,
            color: Colors.orange,
            strokeWidth: 2,
            strokeColor: Colors.white,
          );
        },
      ),
      belowBarData: BarAreaData(
        show: true,
        color: Colors.orange.withOpacity(0.1),
      ),
    );
  }

  List<FlSpot> _getMemorySpots() {
    // Mock data - in real implementation, this would come from analytics
    return [
      const FlSpot(0, 3),
      const FlSpot(1, 5),
      const FlSpot(2, 4),
      const FlSpot(3, 7),
      const FlSpot(4, 6),
      const FlSpot(5, 8),
      const FlSpot(6, 5),
    ];
  }

  List<FlSpot> _getAIResponseSpots() {
    // Mock data - in real implementation, this would come from analytics
    return [
      const FlSpot(0, 2),
      const FlSpot(1, 4),
      const FlSpot(2, 3),
      const FlSpot(3, 5),
      const FlSpot(4, 4),
      const FlSpot(5, 6),
      const FlSpot(6, 3),
    ];
  }

  List<FlSpot> _getSearchSpots() {
    // Mock data - in real implementation, this would come from analytics
    return [
      const FlSpot(0, 1),
      const FlSpot(1, 3),
      const FlSpot(2, 2),
      const FlSpot(3, 4),
      const FlSpot(4, 3),
      const FlSpot(5, 5),
      const FlSpot(6, 2),
    ];
  }

  Widget _buildChartLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem('Memories', Colors.blue),
        const SizedBox(width: 24),
        _buildLegendItem('AI Responses', Colors.green),
        const SizedBox(width: 24),
        _buildLegendItem('Searches', Colors.orange),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
