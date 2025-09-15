import 'package:flutter/material.dart';
import 'package:ai_core/ai_core.dart';

/// Model Download Card widget for displaying model information
class ModelDownloadCard extends StatelessWidget {
  final ModelLevel level;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool isDownloaded;
  final bool isDownloading;
  final double? progress;

  const ModelDownloadCard({
    super.key,
    required this.level,
    required this.isSelected,
    this.onTap,
    this.isDownloaded = false,
    this.isDownloading = false,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          width: 2,
        ),
      ),
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
                  _buildModelIcon(),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          level.name.toUpperCase(),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Theme.of(context).primaryColor : null,
                          ),
                        ),
                        Text(
                          level.description,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusIndicator(),
                ],
              ),
              const SizedBox(height: 12),
              _buildModelInfo(context),
              if (isDownloading && progress != null) ...[
                const SizedBox(height: 12),
                _buildProgressBar(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModelIcon() {
    IconData iconData;
    Color iconColor;

    switch (level.name) {
      case 'tiny':
        iconData = Icons.speed;
        iconColor = Colors.green;
        break;
      case 'mini':
        iconData = Icons.balance;
        iconColor = Colors.blue;
        break;
      case 'full':
        iconData = Icons.star;
        iconColor = Colors.amber;
        break;
      default:
        iconData = Icons.help;
        iconColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 24,
      ),
    );
  }

  Widget _buildStatusIndicator() {
    if (isDownloading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    } else if (isDownloaded) {
      return Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 20,
      );
    } else {
      return Icon(
        Icons.download,
        color: Colors.grey[400],
        size: 20,
      );
    }
  }

  Widget _buildModelInfo(BuildContext context) {
    return Row(
      children: [
        _buildInfoItem(
          'Size',
          '${(level.sizeBytes / (1024 * 1024)).toStringAsFixed(0)} MB',
          context,
        ),
        const SizedBox(width: 16),
        _buildInfoItem(
          'Type',
          level.modelId,
          context,
        ),
        const Spacer(),
        if (isSelected)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'SELECTED',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value, BuildContext context) {
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
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Downloading...',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            Text(
              '${(progress! * 100).toStringAsFixed(0)}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}

/// Model Level Extension for additional properties
extension ModelLevelExtension on ModelLevel {
  String get displayName {
    switch (name) {
      case 'tiny':
        return 'Tiny Model';
      case 'mini':
        return 'Mini Model';
      case 'full':
        return 'Full Model';
      default:
        return 'Unknown Model';
    }
  }

  String get description {
    switch (name) {
      case 'tiny':
        return 'Fast and lightweight, suitable for basic tasks';
      case 'mini':
        return 'Balanced performance and size, recommended for most users';
      case 'full':
        return 'Best quality, requires more resources';
      default:
        return 'Unknown model type';
    }
  }

  Color get color {
    switch (name) {
      case 'tiny':
        return Colors.green;
      case 'mini':
        return Colors.blue;
      case 'full':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  IconData get icon {
    switch (name) {
      case 'tiny':
        return Icons.speed;
      case 'mini':
        return Icons.balance;
      case 'full':
        return Icons.star;
      default:
        return Icons.help;
    }
  }
}
