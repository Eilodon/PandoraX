import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora_ui/pandora_ui.dart';
import 'package:alarm_domain/alarm_domain.dart';
import '../../services/notification_service.dart';

class ReminderFormScreen extends ConsumerStatefulWidget {
  final Note note;
  
  const ReminderFormScreen({
    super.key,
    required this.note,
  });

  @override
  ConsumerState<ReminderFormScreen> createState() => _ReminderFormScreenState();
}

class _ReminderFormScreenState extends ConsumerState<ReminderFormScreen> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  String _reminderType = 'once';
  int _repeatInterval = 1; // days
  String _repeatFrequency = 'daily';

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now().add(const Duration(days: 1));
    _selectedTime = const TimeOfDay(hour: 9, minute: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo nhắc nhở'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          PandoraButton(
            onPressed: _saveReminder,
            variant: PandoraButtonVariant.primary,
            size: PandoraButtonSize.sm,
            child: const Text('Lưu'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(PTokens.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thông tin ghi chú
            PandoraCard(
              variant: PandoraCardVariant.outlined,
              child: Padding(
                padding: const EdgeInsets.all(PTokens.spacingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ghi chú:',
                      style: PTokens.typography.labelLarge,
                    ),
                    const SizedBox(height: PTokens.spacingSm),
                    Text(
                      widget.note.title,
                      style: PTokens.typography.titleMedium,
                    ),
                    const SizedBox(height: PTokens.spacingXs),
                    Text(
                      widget.note.content,
                      style: PTokens.typography.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: PTokens.spacingLg),
            
            // Chọn ngày
            Text(
              'Ngày nhắc nhở:',
              style: PTokens.typography.labelLarge,
            ),
            const SizedBox(height: PTokens.spacingSm),
            PandoraButton(
              onPressed: _selectDate,
              variant: PandoraButtonVariant.outlined,
              fullWidth: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatDate(_selectedDate)),
                  const Icon(Icons.calendar_today),
                ],
              ),
            ),
            
            const SizedBox(height: PTokens.spacingLg),
            
            // Chọn giờ
            Text(
              'Giờ nhắc nhở:',
              style: PTokens.typography.labelLarge,
            ),
            const SizedBox(height: PTokens.spacingSm),
            PandoraButton(
              onPressed: _selectTime,
              variant: PandoraButtonVariant.outlined,
              fullWidth: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatTime(_selectedTime)),
                  const Icon(Icons.access_time),
                ],
              ),
            ),
            
            const SizedBox(height: PTokens.spacingLg),
            
            // Loại nhắc nhở
            Text(
              'Loại nhắc nhở:',
              style: PTokens.typography.labelLarge,
            ),
            const SizedBox(height: PTokens.spacingSm),
            Row(
              children: [
                Expanded(
                  child: PandoraButton(
                    onPressed: () => setState(() => _reminderType = 'once'),
                    variant: _reminderType == 'once' 
                        ? PandoraButtonVariant.primary 
                        : PandoraButtonVariant.outlined,
                    child: const Text('Một lần'),
                  ),
                ),
                const SizedBox(width: PTokens.spacingSm),
                Expanded(
                  child: PandoraButton(
                    onPressed: () => setState(() => _reminderType = 'repeat'),
                    variant: _reminderType == 'repeat' 
                        ? PandoraButtonVariant.primary 
                        : PandoraButtonVariant.outlined,
                    child: const Text('Lặp lại'),
                  ),
                ),
              ],
            ),
            
            if (_reminderType == 'repeat') ...[
              const SizedBox(height: PTokens.spacingLg),
              Text(
                'Tần suất lặp lại:',
                style: PTokens.typography.labelLarge,
              ),
              const SizedBox(height: PTokens.spacingSm),
              DropdownButtonFormField<String>(
                value: _repeatFrequency,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: PTokens.spacingMd,
                    vertical: PTokens.spacingSm,
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: 'daily', child: Text('Hàng ngày')),
                  DropdownMenuItem(value: 'weekly', child: Text('Hàng tuần')),
                  DropdownMenuItem(value: 'monthly', child: Text('Hàng tháng')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _repeatFrequency = value);
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _saveReminder() async {
    try {
      final reminderDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      await NotificationService.scheduleNoteReminder(
        noteId: int.parse(widget.note.id),
        title: widget.note.title,
        content: widget.note.content,
        reminderTime: reminderDateTime,
      );

      if (mounted) {
        PandoraSnackbar.show(
          context,
          message: 'Nhắc nhở đã được tạo thành công!',
          variant: PandoraSnackbarVariant.success,
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        PandoraSnackbar.show(
          context,
          message: 'Lỗi khi tạo nhắc nhở: $e',
          variant: PandoraSnackbarVariant.error,
        );
      }
    }
  }
}
