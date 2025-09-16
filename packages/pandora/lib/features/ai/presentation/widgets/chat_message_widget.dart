import 'package:flutter/material.dart';
import 'package:ai_core/ai_core.dart';

/// Chat Message Widget for displaying chat messages
class ChatMessageWidget extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback? onRetry;
  final bool showTimestamp;
  final bool showModelInfo;

  const ChatMessageWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.showTimestamp = true,
    this.showModelInfo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message.isUser) const Spacer(),
          Flexible(
            child: _buildMessageBubble(context),
          ),
          if (message.isAssistant) const Spacer(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
      ),
      child: Column(
        crossAxisAlignment: message.isUser 
            ? CrossAxisAlignment.end 
            : CrossAxisAlignment.start,
        children: [
          _buildBubble(context),
          if (showTimestamp) ...[
            const SizedBox(height: 4),
            _buildTimestamp(context),
          ],
          if (showModelInfo && message.isAssistant) ...[
            const SizedBox(height: 4),
            _buildModelInfo(context),
          ],
        ],
      ),
    );
  }

  Widget _buildBubble(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: message.isUser 
            ? Theme.of(context).primaryColor
            : Colors.grey[100],
        borderRadius: BorderRadius.circular(18).copyWith(
          bottomLeft: message.isUser 
              ? const Radius.circular(18)
              : const Radius.circular(4),
          bottomRight: message.isUser 
              ? const Radius.circular(4)
              : const Radius.circular(18),
        ),
        border: message.isAssistant && message.hasError
            ? Border.all(color: Colors.red.shade300, width: 1)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMessageContent(context),
          if (message.hasError && onRetry != null) ...[
            const SizedBox(height: 8),
            _buildRetryButton(context),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageContent(BuildContext context) {
    return Text(
      message.content,
      style: TextStyle(
        color: message.isUser 
            ? Colors.white
            : Colors.black87,
        fontSize: 16,
        height: 1.4,
      ),
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.refresh,
          size: 16,
          color: Colors.red.shade600,
        ),
        const SizedBox(width: 4),
        TextButton(
          onPressed: onRetry,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Retry',
            style: TextStyle(
              color: Colors.red.shade600,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimestamp(BuildContext context) {
    return Text(
      _formatTimestamp(message.timestamp),
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Colors.grey[500],
      ),
    );
  }

  Widget _buildModelInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.phone_android,
            size: 12,
            color: Colors.blue.shade600,
          ),
          const SizedBox(width: 4),
          Text(
            'On-Device AI',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.blue.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
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

/// Typing Indicator Widget
class TypingIndicator extends StatefulWidget {
  final String? message;
  final Color? color;

  const TypingIndicator({
    super.key,
    this.message,
    this.color,
  });

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(18).copyWith(
          bottomLeft: const Radius.circular(4),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.message != null) ...[
            Text(
              widget.message!,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 8),
          ],
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Row(
                children: List.generate(3, (index) {
                  final delay = index * 0.2;
                  final value = (_animation.value - delay).clamp(0.0, 1.0);
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: (widget.color ?? Colors.grey[400])?.withValues(alpha: value),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Message Status Indicator
class MessageStatusIndicator extends StatelessWidget {
  final MessageStatus status;
  final DateTime timestamp;

  const MessageStatusIndicator({
    super.key,
    required this.status,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          _getStatusIcon(status),
          size: 12,
          color: _getStatusColor(status),
        ),
        const SizedBox(width: 4),
        Text(
          _getStatusText(status),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: _getStatusColor(status),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  IconData _getStatusIcon(MessageStatus status) {
    switch (status) {
      case MessageStatus.sending:
        return Icons.schedule;
      case MessageStatus.sent:
        return Icons.check;
      case MessageStatus.delivered:
        return Icons.done_all;
      case MessageStatus.read:
        return Icons.done_all;
      case MessageStatus.failed:
        return Icons.error;
    }
  }

  Color _getStatusColor(MessageStatus status) {
    switch (status) {
      case MessageStatus.sending:
        return Colors.grey;
      case MessageStatus.sent:
        return Colors.grey;
      case MessageStatus.delivered:
        return Colors.blue;
      case MessageStatus.read:
        return Colors.green;
      case MessageStatus.failed:
        return Colors.red;
    }
  }

  String _getStatusText(MessageStatus status) {
    switch (status) {
      case MessageStatus.sending:
        return 'Sending...';
      case MessageStatus.sent:
        return 'Sent';
      case MessageStatus.delivered:
        return 'Delivered';
      case MessageStatus.read:
        return 'Read';
      case MessageStatus.failed:
        return 'Failed';
    }
  }
}

/// Message Status Enum
enum MessageStatus {
  sending,
  sent,
  delivered,
  read,
  failed,
}
