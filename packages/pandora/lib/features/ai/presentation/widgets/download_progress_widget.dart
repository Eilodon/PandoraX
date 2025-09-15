import 'package:flutter/material.dart';
import 'package:ai_core/ai_core.dart';

/// Download Progress Widget for showing download progress
class DownloadProgressWidget extends StatelessWidget {
  final double progress;
  final ModelLevel level;
  final String? status;
  final int? downloadedBytes;
  final int? totalBytes;
  final int? speed;
  final Duration? eta;

  const DownloadProgressWidget({
    super.key,
    required this.progress,
    required this.level,
    this.status,
    this.downloadedBytes,
    this.totalBytes,
    this.speed,
    this.eta,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        const SizedBox(height: 12),
        _buildProgressBar(context),
        const SizedBox(height: 8),
        _buildProgressDetails(context),
        if (speed != null || eta != null) ...[
          const SizedBox(height: 8),
          _buildSpeedAndEta(context),
        ],
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Icon(
          level.icon,
          color: level.color,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          'Downloading ${level.displayName}',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(
          '${(progress * 100).toStringAsFixed(0)}%',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(
            level.color,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressDetails(BuildContext context) {
    if (downloadedBytes != null && totalBytes != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _formatBytes(downloadedBytes!),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          Text(
            'of ${_formatBytes(totalBytes!)}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      );
    } else {
      return Text(
        status ?? 'Downloading...',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.grey[600],
        ),
      );
    }
  }

  Widget _buildSpeedAndEta(BuildContext context) {
    return Row(
      children: [
        if (speed != null) ...[
          Icon(
            Icons.speed,
            size: 16,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 4),
          Text(
            '${_formatBytes(speed!)}/s',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
        if (speed != null && eta != null) const SizedBox(width: 16),
        if (eta != null) ...[
          Icon(
            Icons.access_time,
            size: 16,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 4),
          Text(
            _formatDuration(eta!),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ],
    );
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }

  String _formatDuration(Duration duration) {
    if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes % 60}m';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m ${duration.inSeconds % 60}s';
    } else {
      return '${duration.inSeconds}s';
    }
  }
}

/// Circular Download Progress Widget
class CircularDownloadProgressWidget extends StatelessWidget {
  final double progress;
  final ModelLevel level;
  final String? status;
  final double size;

  const CircularDownloadProgressWidget({
    super.key,
    required this.progress,
    required this.level,
    this.status,
    this.size = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            children: [
              CircularProgressIndicator(
                value: progress,
                strokeWidth: 6,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(level.color),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      level.icon,
                      color: level.color,
                      size: 24,
                    ),
                    Text(
                      '${(progress * 100).toStringAsFixed(0)}%',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (status != null) ...[
          const SizedBox(height: 8),
          Text(
            status!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}

/// Download Status Indicator
class DownloadStatusIndicator extends StatelessWidget {
  final DownloadStatus status;
  final ModelLevel level;
  final String? error;

  const DownloadStatusIndicator({
    super.key,
    required this.status,
    required this.level,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _getStatusColor(status),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getStatusIcon(status),
            color: _getStatusColor(status),
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            _getStatusText(status),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: _getStatusColor(status),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(DownloadStatus status) {
    switch (status) {
      case DownloadStatus.starting:
        return Colors.blue;
      case DownloadStatus.downloading:
        return Colors.orange;
      case DownloadStatus.completed:
        return Colors.green;
      case DownloadStatus.failed:
        return Colors.red;
      case DownloadStatus.cancelled:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(DownloadStatus status) {
    switch (status) {
      case DownloadStatus.starting:
        return Icons.play_arrow;
      case DownloadStatus.downloading:
        return Icons.download;
      case DownloadStatus.completed:
        return Icons.check_circle;
      case DownloadStatus.failed:
        return Icons.error;
      case DownloadStatus.cancelled:
        return Icons.cancel;
    }
  }

  String _getStatusText(DownloadStatus status) {
    switch (status) {
      case DownloadStatus.starting:
        return 'Starting';
      case DownloadStatus.downloading:
        return 'Downloading';
      case DownloadStatus.completed:
        return 'Completed';
      case DownloadStatus.failed:
        return 'Failed';
      case DownloadStatus.cancelled:
        return 'Cancelled';
    }
  }
}

/// Download Status Enum
enum DownloadStatus {
  starting,
  downloading,
  completed,
  failed,
  cancelled,
}
