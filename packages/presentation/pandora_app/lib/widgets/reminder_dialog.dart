import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_tokens/design_tokens.dart';
import 'package:common_entities/common_entities.dart';
import '../services/reminder_service.dart';

/// Dialog for creating and editing reminders
class ReminderDialog extends ConsumerStatefulWidget {
  final String noteId;
  final String noteTitle;
  final Reminder? existingReminder;

  const ReminderDialog({
    super.key,
    required this.noteId,
    required this.noteTitle,
    this.existingReminder,
  });

  @override
  ConsumerState<ReminderDialog> createState() => _ReminderDialogState();
}

class _ReminderDialogState extends ConsumerState<ReminderDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _customMessageController;
  
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  ReminderType _selectedType = const ReminderType.notification();
  List<ReminderRepeat> _selectedRepeats = [];
  bool _isActive = true;
  bool _enableSound = true;
  bool _enableVibration = true;
  String _selectedSound = 'default';
  int _vibrationPattern = 0;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.existingReminder?.title ?? widget.noteTitle);
    _descriptionController = TextEditingController(text: widget.existingReminder?.description ?? '');
    _customMessageController = TextEditingController(text: widget.existingReminder?.customMessage ?? '');
    
    if (widget.existingReminder != null) {
      _selectedDate = widget.existingReminder!.scheduledTime;
      _selectedTime = TimeOfDay.fromDateTime(widget.existingReminder!.scheduledTime);
      _selectedType = widget.existingReminder!.type;
      _selectedRepeats = widget.existingReminder!.repeatDays;
      _isActive = widget.existingReminder!.isActive;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _customMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existingReminder != null ? 'Edit Reminder' : 'Create Reminder'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            
            // Description
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            
            // Date and Time
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Date'),
                    subtitle: Text(_formatDate(_selectedDate)),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: _selectDate,
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Time'),
                    subtitle: Text(_selectedTime.format(context)),
                    trailing: const Icon(Icons.access_time),
                    onTap: _selectTime,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Reminder Type
            const Text('Reminder Type', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                _buildTypeChip('Notification', const ReminderType.notification()),
                _buildTypeChip('Alarm', const ReminderType.alarm()),
                _buildTypeChip('Email', const ReminderType.email()),
                _buildTypeChip('SMS', const ReminderType.sms()),
              ],
            ),
            const SizedBox(height: 16),
            
            // Repeat Options
            const Text('Repeat', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                _buildRepeatChip('Daily', const ReminderRepeat.daily()),
                _buildRepeatChip('Weekly', const ReminderRepeat.weekly()),
                _buildRepeatChip('Monthly', const ReminderRepeat.monthly()),
                _buildRepeatChip('Yearly', const ReminderRepeat.yearly()),
              ],
            ),
            const SizedBox(height: 16),
            
            // Custom Repeat (Days of Week)
            if (_selectedRepeats.any((r) => r is CustomRepeat))
              _buildCustomRepeatDays(),
            
            // Notification Settings
            ExpansionTile(
              title: const Text('Notification Settings'),
              children: [
                SwitchListTile(
                  title: const Text('Enable Sound'),
                  value: _enableSound,
                  onChanged: (value) => setState(() => _enableSound = value),
                ),
                SwitchListTile(
                  title: const Text('Enable Vibration'),
                  value: _enableVibration,
                  onChanged: (value) => setState(() => _enableVibration = value),
                ),
                ListTile(
                  title: const Text('Sound'),
                  subtitle: Text(_selectedSound),
                  trailing: const Icon(Icons.arrow_drop_down),
                  onTap: _selectSound,
                ),
                ListTile(
                  title: const Text('Vibration Pattern'),
                  subtitle: Text('Pattern $_vibrationPattern'),
                  trailing: const Icon(Icons.arrow_drop_down),
                  onTap: _selectVibrationPattern,
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Custom Message
            TextField(
              controller: _customMessageController,
              decoration: const InputDecoration(
                labelText: 'Custom Message (Optional)',
                border: OutlineInputBorder(),
                hintText: 'Add a personal message to your reminder',
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            
            // Active Status
            SwitchListTile(
              title: const Text('Active'),
              subtitle: const Text('Enable this reminder'),
              value: _isActive,
              onChanged: (value) => setState(() => _isActive = value),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveReminder,
          child: Text(widget.existingReminder != null ? 'Update' : 'Create'),
        ),
      ],
    );
  }

  Widget _buildTypeChip(String label, ReminderType type) {
    final isSelected = _selectedType == type;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() => _selectedType = type);
        }
      },
    );
  }

  Widget _buildRepeatChip(String label, ReminderRepeat repeat) {
    final isSelected = _selectedRepeats.any((r) => r.runtimeType == repeat.runtimeType);
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          if (selected) {
            _selectedRepeats.add(repeat);
          } else {
            _selectedRepeats.removeWhere((r) => r.runtimeType == repeat.runtimeType);
          }
        });
      },
    );
  }

  Widget _buildCustomRepeatDays() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Days of Week', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            for (int i = 0; i < 7; i++)
              FilterChip(
                label: Text(_getDayName(i)),
                selected: _selectedRepeats.any((r) => 
                  r is CustomRepeat && r.daysOfWeek.contains(i)),
                onSelected: (selected) {
                  setState(() {
                    final customRepeat = _selectedRepeats.firstWhere(
                      (r) => r is CustomRepeat,
                      orElse: () => const ReminderRepeat.custom(daysOfWeek: []),
                    ) as CustomRepeat;
                    
                    if (selected) {
                      final newDays = List<int>.from(customRepeat.daysOfWeek)..add(i);
                      _selectedRepeats.removeWhere((r) => r is CustomRepeat);
                      _selectedRepeats.add(ReminderRepeat.custom(daysOfWeek: newDays));
                    } else {
                      final newDays = List<int>.from(customRepeat.daysOfWeek)..remove(i);
                      _selectedRepeats.removeWhere((r) => r is CustomRepeat);
                      if (newDays.isNotEmpty) {
                        _selectedRepeats.add(ReminderRepeat.custom(daysOfWeek: newDays));
                      }
                    }
                  });
                },
              ),
          ],
        ),
      ],
    );
  }

  String _getDayName(int dayIndex) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[dayIndex];
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  Future<void> _selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    
    if (time != null) {
      setState(() => _selectedTime = time);
    }
  }

  void _selectSound() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Sound'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSoundOption('Default', 'default'),
            _buildSoundOption('Chime', 'chime'),
            _buildSoundOption('Bell', 'bell'),
            _buildSoundOption('Alarm', 'alarm'),
          ],
        ),
      ),
    );
  }

  Widget _buildSoundOption(String name, String value) {
    return ListTile(
      title: Text(name),
      trailing: _selectedSound == value ? const Icon(Icons.check) : null,
      onTap: () {
        setState(() => _selectedSound = value);
        Navigator.pop(context);
      },
    );
  }

  void _selectVibrationPattern() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Vibration Pattern'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < 5; i++)
              ListTile(
                title: Text('Pattern ${i + 1}'),
                trailing: _vibrationPattern == i ? const Icon(Icons.check) : null,
                onTap: () {
                  setState(() => _vibrationPattern = i);
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveReminder() async {
    try {
      final scheduledTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      final reminder = Reminder(
        id: widget.existingReminder?.id ?? '',
        noteId: widget.noteId,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        scheduledTime: scheduledTime,
        type: _selectedType,
        status: const ReminderStatus.pending(),
        repeatDays: _selectedRepeats,
        isActive: _isActive,
        createdAt: widget.existingReminder?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
        customMessage: _customMessageController.text.trim().isEmpty 
            ? null 
            : _customMessageController.text.trim(),
      );

      final reminderService = ReminderService();
      
      if (widget.existingReminder != null) {
        await reminderService.updateReminder(reminder);
      } else {
        await reminderService.createReminder(reminder);
      }

      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.existingReminder != null 
                ? 'Reminder updated successfully' 
                : 'Reminder created successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save reminder: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
