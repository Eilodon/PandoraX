import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_domain/note_domain.dart';
import '../application/note_form/note_form_providers.dart';
import '../application/note_form/note_form_state.dart';
import '../../../../services/notification_service.dart';

class NoteFormScreen extends ConsumerStatefulWidget {
  final Note? note; // null for create, non-null for edit
  final String? initialContent; // Nội dung ban đầu cho ghi chú mới

  const NoteFormScreen({super.key, this.note, this.initialContent});

  @override
  ConsumerState<NoteFormScreen> createState() => _NoteFormScreenState();
}

class _NoteFormScreenState extends ConsumerState<NoteFormScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? _reminderTime;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      ref.read(editNoteProvider)(widget.note!);
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
      _reminderTime = widget.note!.reminderTime;
    } else {
      ref.read(createNoteProvider)();
      if (widget.initialContent != null) {
        _contentController.text = widget.initialContent!;
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(noteFormProvider);
    final formNotifier = ref.read(noteFormProvider.notifier);

    // Update controllers when state changes
    if (formState.title != _titleController.text) {
      _titleController.text = formState.title;
    }
    if (formState.content != _contentController.text) {
      _contentController.text = formState.content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(formState.isEditing ? 'Edit Note' : 'New Note'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (formState.isEditing)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: formState.isSubmitting ? null : _showDeleteDialog,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Title field
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter note title',
                  errorText: formState.titleError,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.title),
                ),
                onChanged: formNotifier.titleChanged,
                textInputAction: TextInputAction.next,
                maxLength: 100,
              ),
              const SizedBox(height: 16),

              // Pinned toggle
              SwitchListTile(
                title: const Text('Pin this note'),
                subtitle: const Text('Pinned notes appear at the top'),
                value: formState.pinned,
                onChanged: formNotifier.pinnedChanged,
                secondary: const Icon(Icons.push_pin),
              ),
              const SizedBox(height: 16),

              // Reminder section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.alarm),
                          const SizedBox(width: 8),
                          const Text(
                            'Nhắc nhở',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Reminder time display
                      if (_reminderTime != null) ...[
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blue[200]!),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.schedule, color: Colors.blue[700]),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Nhắc nhở lúc: ${_formatDateTime(_reminderTime!)}',
                                  style: TextStyle(
                                    color: Colors.blue[700],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    _reminderTime = null;
                                  });
                                },
                                color: Colors.blue[700],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                      
                      // Set reminder button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _selectReminderTime,
                          icon: const Icon(Icons.add_alarm),
                          label: Text(_reminderTime == null ? 'Thiết lập nhắc nhở' : 'Thay đổi nhắc nhở'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _reminderTime == null ? Colors.blue : Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Content field
              Expanded(
                child: TextFormField(
                  controller: _contentController,
                  decoration: InputDecoration(
                    labelText: 'Content',
                    hintText: 'Write your note content here...',
                    errorText: formState.contentError,
                    border: const OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  onChanged: formNotifier.contentChanged,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),
              const SizedBox(height: 16),

              // Error message
              if (formState.errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    border: Border.all(color: Colors.red.shade200),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error, color: Colors.red.shade700),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          formState.errorMessage!,
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: formNotifier.clearError,
                        color: Colors.red.shade700,
                      ),
                    ],
                  ),
                ),

              // Save button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: formState.isSubmitting ? null : _saveNote,
                  icon: formState.isSubmitting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save),
                  label: Text(
                    formState.isSubmitting
                        ? 'Saving...'
                        : formState.isEditing
                            ? 'Update Note'
                            : 'Create Note',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveNote() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref.read(noteFormProvider.notifier).saveNote();
    
    if (mounted) {
      if (success) {
        // Lập lịch thông báo nếu có nhắc nhở
        if (_reminderTime != null) {
          try {
            await NotificationService().scheduleNoteReminder(
              id: widget.note?.id.hashCode ?? DateTime.now().millisecondsSinceEpoch,
              title: _titleController.text,
              body: _contentController.text,
              scheduledDate: _reminderTime!,
            );
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Lỗi khi thiết lập nhắc nhở: $e'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        }
        
        Navigator.of(context).pop(true); // Return true to indicate success
      }
    }
  }

  Future<void> _selectReminderTime() async {
    final now = DateTime.now();
    final firstDate = now.subtract(const Duration(days: 1));
    final lastDate = now.add(const Duration(days: 365));

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _reminderTime ?? now.add(const Duration(hours: 1)),
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate != null && mounted) {
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_reminderTime ?? now.add(const Duration(hours: 1))),
      );

      if (selectedTime != null) {
        setState(() {
          _reminderTime = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
        });
      }
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _showDeleteDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await ref.read(noteFormProvider.notifier).deleteNote();
      Navigator.of(context).pop(true); // Return true to indicate deletion
    }
  }
}
