import 'package:flutter/material.dart';
import 'package:cac_core/cac_core.dart';

/// Memory Card Widget
/// 
/// Displays a memory entry in a card format with actions and metadata
class MemoryCard extends StatelessWidget {
  final MemoryEntry memory;
  final double? similarity;
  final VoidCallback? onTap;
  final VoidCallback? onPin;
  final VoidCallback? onArchive;
  final VoidCallback? onDelete;

  const MemoryCard({
    super.key,
    required this.memory,
    this.similarity,
    this.onTap,
    this.onPin,
    this.onArchive,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 8),
              _buildContent(context),
              const SizedBox(height: 12),
              _buildMetadata(context),
              if (similarity != null) ...[
                const SizedBox(height: 8),
                _buildSimilarityIndicator(context),
              ],
              const SizedBox(height: 12),
              _buildActions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    
    return Row(
      children: [
        _buildMemoryTypeIcon(),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getMemoryTypeDisplayName(),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _getMemoryTypeColor(),
                ),
              ),
              Text(
                _formatTimestamp(),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        if (memory.isPinned)
          Icon(
            Icons.push_pin,
            size: 16,
            color: Colors.orange[600],
          ),
        if (memory.isArchived)
          Icon(
            Icons.archive,
            size: 16,
            color: Colors.grey[600],
          ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);
    
    return Text(
      memory.content,
      style: theme.textTheme.bodyMedium,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildMetadata(BuildContext context) {
    final theme = Theme.of(context);
    
    return Row(
      children: [
        _buildSourceChip(),
        const SizedBox(width: 8),
        if (memory.causalLinks.isNotEmpty)
          _buildLinksChip(),
        const Spacer(),
        _buildRelevanceScore(),
      ],
    );
  }

  Widget _buildSimilarityIndicator(BuildContext context) {
    final theme = Theme.of(context);
    final similarityValue = similarity!;
    final similarityColor = _getSimilarityColor(similarityValue);
    
    return Row(
      children: [
        Icon(
          Icons.search,
          size: 16,
          color: similarityColor,
        ),
        const SizedBox(width: 4),
        Text(
          'Similarity: ${(similarityValue * 100).toStringAsFixed(1)}%',
          style: theme.textTheme.bodySmall?.copyWith(
            color: similarityColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: LinearProgressIndicator(
            value: similarityValue,
            backgroundColor: similarityColor.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(similarityColor),
          ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            memory.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
            color: memory.isPinned ? Colors.orange[600] : Colors.grey[600],
          ),
          onPressed: onPin,
          tooltip: memory.isPinned ? 'Unpin' : 'Pin',
        ),
        IconButton(
          icon: Icon(
            memory.isArchived ? Icons.unarchive : Icons.archive,
            color: memory.isArchived ? Colors.grey[600] : Colors.blue[600],
          ),
          onPressed: onArchive,
          tooltip: memory.isArchived ? 'Unarchive' : 'Archive',
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: onDelete,
          tooltip: 'Delete',
        ),
      ],
    );
  }

  Widget _buildMemoryTypeIcon() {
    final iconData = _getMemoryTypeIcon();
    final color = _getMemoryTypeColor();
    
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Icon(
        iconData,
        size: 20,
        color: color,
      ),
    );
  }

  Widget _buildSourceChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Text(
        memory.source.toUpperCase(),
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildLinksChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withOpacity(0.3)),
      ),
      child: Text(
        '${memory.causalLinks.length} links',
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget _buildRelevanceScore() {
    final relevance = memory.relevanceScore;
    final color = _getRelevanceColor(relevance);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        '${(relevance * 100).toStringAsFixed(0)}%',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  IconData _getMemoryTypeIcon() {
    switch (memory.type) {
      case MemoryType.explicit:
        return Icons.note;
      case MemoryType.implicit:
        return Icons.psychology;
      case MemoryType.emotional:
        return Icons.favorite;
      case MemoryType.temporal:
        return Icons.schedule;
      case MemoryType.spatial:
        return Icons.location_on;
      case MemoryType.social:
        return Icons.people;
    }
  }

  Color _getMemoryTypeColor() {
    switch (memory.type) {
      case MemoryType.explicit:
        return Colors.blue;
      case MemoryType.implicit:
        return Colors.purple;
      case MemoryType.emotional:
        return Colors.pink;
      case MemoryType.temporal:
        return Colors.orange;
      case MemoryType.spatial:
        return Colors.green;
      case MemoryType.social:
        return Colors.teal;
    }
  }

  String _getMemoryTypeDisplayName() {
    switch (memory.type) {
      case MemoryType.explicit:
        return 'Explicit Memory';
      case MemoryType.implicit:
        return 'Implicit Memory';
      case MemoryType.emotional:
        return 'Emotional Memory';
      case MemoryType.temporal:
        return 'Temporal Memory';
      case MemoryType.spatial:
        return 'Spatial Memory';
      case MemoryType.social:
        return 'Social Memory';
    }
  }

  String _formatTimestamp() {
    final now = DateTime.now();
    final difference = now.difference(memory.timestamp);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  Color _getSimilarityColor(double similarity) {
    if (similarity >= 0.8) return Colors.green;
    if (similarity >= 0.6) return Colors.orange;
    return Colors.red;
  }

  Color _getRelevanceColor(double relevance) {
    if (relevance >= 0.8) return Colors.green;
    if (relevance >= 0.6) return Colors.orange;
    return Colors.red;
  }
}
