import 'package:flutter/material.dart';
import 'package:design_tokens/design_tokens.dart';
import 'package:common_entities/common_entities.dart';
import '../services/reminder_service.dart';
import 'reminder_dialog.dart';

class NoteCard extends StatefulWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onPin;
  final VoidCallback onArchive;
  final VoidCallback onDelete;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
    required this.onPin,
    required this.onArchive,
    required this.onDelete,
  });

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  List<Reminder> _reminders = [];
  final ReminderService _reminderService = ReminderService();

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    final reminders = _reminderService.getRemindersForNote(widget.note.id);
    setState(() {
      _reminders = reminders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and actions
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.note.title,
                      style: PandoraTextStyles.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (widget.note.isPinned)
                    Icon(
                      Icons.push_pin,
                      size: 16,
                      color: PandoraColors.primary,
                    ),
                  const SizedBox(width: 8),
                  PopupMenuButton<String>(
                    onSelected: (value) => _handleMenuAction(value),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'pin',
                        child: Row(
                          children: [
                            Icon(
                              widget.note.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(widget.note.isPinned ? 'Unpin' : 'Pin'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'reminder',
                        child: Row(
                          children: [
                            Icon(Icons.alarm, size: 16),
                            const SizedBox(width: 8),
                            Text('Set Reminder'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'archive',
                        child: Row(
                          children: [
                            Icon(
                              widget.note.isArchived ? Icons.unarchive : Icons.archive,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(widget.note.isArchived ? 'Unarchive' : 'Archive'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 16, color: PandoraColors.error),
                            const SizedBox(width: 8),
                            Text('Delete', style: TextStyle(color: PandoraColors.error)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              // Content preview
              if (widget.note.content.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  widget.note.preview,
                  style: PandoraTextStyles.bodyMedium.copyWith(
                    color: PandoraColors.textSecondary,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              
              // Tags
              if (widget.note.hasTags) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: widget.note.tags.take(3).map((tag) => Chip(
                    label: Text(
                      tag,
                      style: PandoraTextStyles.labelSmall,
                    ),
                    backgroundColor: PandoraColors.primary.withValues(alpha: 0.1),
                    labelStyle: TextStyle(color: PandoraColors.primary),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  )).toList(),
                ),
              ],
              
              // Reminders section
              if (_reminders.isNotEmpty) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: PandoraColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.alarm,
                        size: 14,
                        color: PandoraColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${_reminders.length} reminder${_reminders.length > 1 ? 's' : ''}',
                        style: PandoraTextStyles.labelSmall.copyWith(
                          color: PandoraColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              
              // Footer with metadata
              const SizedBox(height: 12),
              Row(
                children: [
                  if (widget.note.category != null) ...[
                    Icon(
                      Icons.folder_outlined,
                      size: 14,
                      color: PandoraColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.note.category!,
                      style: PandoraTextStyles.labelSmall.copyWith(
                        color: PandoraColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                  Icon(
                    Icons.access_time,
                    size: 14,
                    color: PandoraColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(widget.note.updatedAt),
                    style: PandoraTextStyles.labelSmall.copyWith(
                      color: PandoraColors.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  if (widget.note.priority > 0) ...[
                    Icon(
                      Icons.flag,
                      size: 14,
                      color: _getPriorityColor(widget.note.priority),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Priority ${widget.note.priority}',
                      style: PandoraTextStyles.labelSmall.copyWith(
                        color: _getPriorityColor(widget.note.priority),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'pin':
        widget.onPin();
        break;
      case 'reminder':
        _showReminderDialog();
        break;
      case 'archive':
        widget.onArchive();
        break;
      case 'delete':
        widget.onDelete();
        break;
    }
  }

  Future<void> _showReminderDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ReminderDialog(
        noteId: widget.note.id,
        noteTitle: widget.note.title,
      ),
    );
    
    if (result == true) {
      await _loadReminders();
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return PandoraColors.error;
      case 2:
        return PandoraColors.warning;
      case 3:
        return PandoraColors.info;
      default:
        return PandoraColors.textSecondary;
    }
  }
}
