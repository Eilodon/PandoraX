import 'package:flutter/material.dart';
import 'package:design_tokens/design_tokens.dart';
import 'package:common_entities/common_entities.dart';
import '../services/reminder_service.dart';

class NoteEditorDialog extends StatefulWidget {
  final Note? note;
  final Function(Note) onSave;

  const NoteEditorDialog({
    super.key,
    this.note,
    required this.onSave,
  });

  @override
  State<NoteEditorDialog> createState() => _NoteEditorDialogState();
}

class _NoteEditorDialogState extends State<NoteEditorDialog> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _categoryController;
  late TextEditingController _tagsController;
  
  int _priority = 0;
  String? _color;
  String? _icon;
  bool _isPinned = false;
  bool _isArchived = false;
  
  // Reminder fields
  DateTime? _reminderDate;
  TimeOfDay? _reminderTime;
  String _reminderType = 'once';
  int _repeatInterval = 1;
  String _repeatFrequency = 'daily';
  bool _hasReminder = false;

  @override
  void initState() {
    super.initState();
    
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
    _categoryController = TextEditingController(text: widget.note?.category ?? '');
    _tagsController = TextEditingController(text: widget.note?.tags.join(', ') ?? '');
    
    if (widget.note != null) {
      _priority = widget.note!.priority;
      _color = widget.note!.color;
      _icon = widget.note!.icon;
      _isPinned = widget.note!.isPinned;
      _isArchived = widget.note!.isArchived;
      
      // Initialize reminder fields
      if (widget.note!.reminderTime != null) {
        _hasReminder = true;
        _reminderDate = widget.note!.reminderTime!;
        _reminderTime = TimeOfDay.fromDateTime(widget.note!.reminderTime!);
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _categoryController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                Text(
                  widget.note == null ? 'Create Note' : 'Edit Note',
                  style: PandoraTextStyles.headlineSmall,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Form
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                        hintText: 'Enter note title...',
                      ),
                      style: PandoraTextStyles.titleMedium,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Content
                    TextField(
                      controller: _contentController,
                      decoration: const InputDecoration(
                        labelText: 'Content',
                        border: OutlineInputBorder(),
                        hintText: 'Enter note content...',
                        alignLabelWithHint: true,
                      ),
                      maxLines: 10,
                      style: PandoraTextStyles.bodyMedium,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Category and Tags Row
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _categoryController,
                            decoration: const InputDecoration(
                              labelText: 'Category',
                              border: OutlineInputBorder(),
                              hintText: 'e.g., Work, Personal',
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _tagsController,
                            decoration: const InputDecoration(
                              labelText: 'Tags',
                              border: OutlineInputBorder(),
                              hintText: 'tag1, tag2, tag3',
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Priority and Options
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: _priority,
                            decoration: const InputDecoration(
                              labelText: 'Priority',
                              border: OutlineInputBorder(),
                            ),
                            items: const [
                              DropdownMenuItem(value: 0, child: Text('None')),
                              DropdownMenuItem(value: 1, child: Text('High')),
                              DropdownMenuItem(value: 2, child: Text('Medium')),
                              DropdownMenuItem(value: 3, child: Text('Low')),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _priority = value ?? 0;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _color,
                            decoration: const InputDecoration(
                              labelText: 'Color',
                              border: OutlineInputBorder(),
                            ),
                            items: const [
                              DropdownMenuItem(value: null, child: Text('Default')),
                              DropdownMenuItem(value: 'red', child: Text('Red')),
                              DropdownMenuItem(value: 'blue', child: Text('Blue')),
                              DropdownMenuItem(value: 'green', child: Text('Green')),
                              DropdownMenuItem(value: 'yellow', child: Text('Yellow')),
                              DropdownMenuItem(value: 'purple', child: Text('Purple')),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _color = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Reminder Section
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.alarm, color: PandoraColors.primary),
                                const SizedBox(width: 8),
                                Text(
                                  'Reminder',
                                  style: PandoraTextStyles.titleMedium,
                                ),
                                const Spacer(),
                                Switch(
                                  value: _hasReminder,
                                  onChanged: (value) {
                                    setState(() {
                                      _hasReminder = value;
                                      if (!value) {
                                        _reminderDate = null;
                                        _reminderTime = null;
                                      } else {
                                        _reminderDate = DateTime.now().add(const Duration(days: 1));
                                        _reminderTime = const TimeOfDay(hour: 9, minute: 0);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            
                            if (_hasReminder) ...[
                              const SizedBox(height: 16),
                              
                              // Date and Time Selection
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: _selectReminderDate,
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: PandoraColors.outline),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.calendar_today, size: 20),
                                            const SizedBox(width: 8),
                                            Text(
                                              _reminderDate != null
                                                  ? '${_reminderDate!.day}/${_reminderDate!.month}/${_reminderDate!.year}'
                                                  : 'Select Date',
                                              style: PandoraTextStyles.bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: InkWell(
                                      onTap: _selectReminderTime,
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: PandoraColors.outline),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.access_time, size: 20),
                                            const SizedBox(width: 8),
                                            Text(
                                              _reminderTime != null
                                                  ? '${_reminderTime!.hour.toString().padLeft(2, '0')}:${_reminderTime!.minute.toString().padLeft(2, '0')}'
                                                  : 'Select Time',
                                              style: PandoraTextStyles.bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 16),
                              
                              // Reminder Type
                              DropdownButtonFormField<String>(
                                value: _reminderType,
                                decoration: const InputDecoration(
                                  labelText: 'Reminder Type',
                                  border: OutlineInputBorder(),
                                ),
                                items: const [
                                  DropdownMenuItem(value: 'once', child: Text('Once')),
                                  DropdownMenuItem(value: 'daily', child: Text('Daily')),
                                  DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
                                  DropdownMenuItem(value: 'monthly', child: Text('Monthly')),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _reminderType = value ?? 'once';
                                  });
                                },
                              ),
                              
                              if (_reminderType != 'once') ...[
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        initialValue: _repeatInterval.toString(),
                                        decoration: const InputDecoration(
                                          labelText: 'Repeat Every',
                                          border: OutlineInputBorder(),
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          _repeatInterval = int.tryParse(value) ?? 1;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: DropdownButtonFormField<String>(
                                        value: _repeatFrequency,
                                        decoration: const InputDecoration(
                                          labelText: 'Frequency',
                                          border: OutlineInputBorder(),
                                        ),
                                        items: const [
                                          DropdownMenuItem(value: 'daily', child: Text('Days')),
                                          DropdownMenuItem(value: 'weekly', child: Text('Weeks')),
                                          DropdownMenuItem(value: 'monthly', child: Text('Months')),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            _repeatFrequency = value ?? 'daily';
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Options
                    Row(
                      children: [
                        Checkbox(
                          value: _isPinned,
                          onChanged: (value) {
                            setState(() {
                              _isPinned = value ?? false;
                            });
                          },
                        ),
                        const Text('Pin to top'),
                        const SizedBox(width: 24),
                        Checkbox(
                          value: _isArchived,
                          onChanged: (value) {
                            setState(() {
                              _isArchived = value ?? false;
                            });
                          },
                        ),
                        const Text('Archive'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _saveNote,
                  child: Text(widget.note == null ? 'Create' : 'Update'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveNote() async {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title')),
      );
      return;
    }

    final tags = _tagsController.text
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();

    DateTime? reminderDateTime;
    if (_hasReminder && _reminderDate != null && _reminderTime != null) {
      reminderDateTime = DateTime(
        _reminderDate!.year,
        _reminderDate!.month,
        _reminderDate!.day,
        _reminderTime!.hour,
        _reminderTime!.minute,
      );
    }

    final note = Note(
      id: widget.note?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      category: _categoryController.text.trim().isEmpty ? null : _categoryController.text.trim(),
      tags: tags,
      priority: _priority,
      color: _color,
      icon: _icon,
      isPinned: _isPinned,
      isArchived: _isArchived,
      reminderTime: reminderDateTime,
      createdAt: widget.note?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Save reminder if enabled
    if (_hasReminder && reminderDateTime != null) {
      await _saveReminder(note, reminderDateTime);
    }

    widget.onSave(note);
    Navigator.pop(context);
  }

  Future<void> _selectReminderDate() async {
    final now = DateTime.now();
    final firstDate = now.subtract(const Duration(days: 1));
    final lastDate = now.add(const Duration(days: 365));

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _reminderDate ?? now.add(const Duration(days: 1)),
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate != null && mounted) {
      setState(() {
        _reminderDate = selectedDate;
      });
    }
  }

  Future<void> _selectReminderTime() async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: _reminderTime ?? const TimeOfDay(hour: 9, minute: 0),
    );

    if (selectedTime != null && mounted) {
      setState(() {
        _reminderTime = selectedTime;
      });
    }
  }

  Future<void> _saveReminder(Note note, DateTime reminderDateTime) async {
    try {
      final reminderService = ReminderService();
      await reminderService.initialize();
      
      // Convert repeat frequency to ReminderRepeat
      ReminderRepeat repeatDays;
      switch (_reminderType) {
        case 'daily':
          repeatDays = const ReminderRepeat.daily();
          break;
        case 'weekly':
          repeatDays = const ReminderRepeat.weekly();
          break;
        case 'monthly':
          repeatDays = const ReminderRepeat.monthly();
          break;
        default:
          repeatDays = const ReminderRepeat.daily();
      }
      
      final reminder = Reminder(
        id: note.id,
        noteId: note.id,
        title: note.title,
        description: note.content,
        scheduledTime: reminderDateTime,
        type: const ReminderType.notification(),
        status: const ReminderStatus.pending(),
        repeatDays: _reminderType == 'once' ? [] : [repeatDays],
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await reminderService.addReminder(reminder);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Reminder set for ${_reminderDate!.day}/${_reminderDate!.month}/${_reminderDate!.year} at ${_reminderTime!.hour.toString().padLeft(2, '0')}:${_reminderTime!.minute.toString().padLeft(2, '0')}'),
            backgroundColor: PandoraColors.primary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error setting reminder: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
