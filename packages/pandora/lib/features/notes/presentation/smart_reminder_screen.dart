import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora_ui/pandora_ui.dart';
import 'package:alarm_domain/alarm_domain.dart';
import '../../services/notification_service.dart';
import '../../ai/application/ai_enhanced_service.dart';

class SmartReminderScreen extends ConsumerStatefulWidget {
  final Note note;
  
  const SmartReminderScreen({
    super.key,
    required this.note,
  });

  @override
  ConsumerState<SmartReminderScreen> createState() => _SmartReminderScreenState();
}

class _SmartReminderScreenState extends ConsumerState<SmartReminderScreen> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  bool _isGenerating = false;
  Map<String, dynamic>? _aiSuggestion;
  String _reminderType = 'once';
  int _repeatInterval = 1;
  String _repeatFrequency = 'daily';

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now().add(const Duration(days: 1));
    _selectedTime = const TimeOfDay(hour: 9, minute: 0);
    _generateAISuggestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Reminder'),
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
            // Note info
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
            
            // AI Suggestion
            if (_aiSuggestion != null) ...[
              Text(
                'Đề xuất từ AI:',
                style: PTokens.typography.labelLarge,
              ),
              const SizedBox(height: PTokens.spacingSm),
              PandoraContainer(
                variant: PandoraContainerVariant.filled,
                backgroundColor: PandoraColors.info50,
                borderColor: PandoraColors.info200,
                child: Padding(
                  padding: const EdgeInsets.all(PTokens.spacingMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            color: PandoraColors.info600,
                            size: 20,
                          ),
                          const SizedBox(width: PTokens.spacingSm),
                          Text(
                            'AI Suggestion',
                            style: PTokens.typography.labelLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: PandoraColors.info700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: PTokens.spacingSm),
                      Text(
                        'Thời gian đề xuất: ${_aiSuggestion!['suggestedTime']} ngày ${_aiSuggestion!['suggestedDate']}',
                        style: PTokens.typography.bodyMedium,
                      ),
                      const SizedBox(height: PTokens.spacingXs),
                      Text(
                        'Lý do: ${_aiSuggestion!['reason']}',
                        style: PTokens.typography.bodySmall.copyWith(
                          color: PandoraColors.info600,
                        ),
                      ),
                      const SizedBox(height: PTokens.spacingSm),
                      PandoraButton(
                        onPressed: _applyAISuggestion,
                        variant: PandoraButtonVariant.outlined,
                        size: PandoraButtonSize.sm,
                        child: const Text('Áp dụng đề xuất'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: PTokens.spacingLg),
            ],
            
            // Manual settings
            Text(
              'Cài đặt thủ công:',
              style: PTokens.typography.labelLarge,
            ),
            const SizedBox(height: PTokens.spacingSm),
            
            // Date picker
            PandoraButton(
              onPressed: _selectDate,
              variant: PandoraButtonVariant.outlined,
              fullWidth: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Ngày: ${_formatDate(_selectedDate)}'),
                  const Icon(Icons.calendar_today),
                ],
              ),
            ),
            
            const SizedBox(height: PTokens.spacingMd),
            
            // Time picker
            PandoraButton(
              onPressed: _selectTime,
              variant: PandoraButtonVariant.outlined,
              fullWidth: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Giờ: ${_formatTime(_selectedTime)}'),
                  const Icon(Icons.access_time),
                ],
              ),
            ),
            
            const SizedBox(height: PTokens.spacingLg),
            
            // Reminder type
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

  Future<void> _generateAISuggestion() async {
    setState(() => _isGenerating = true);

    try {
      // TODO: Get API key from config
      final aiService = AiEnhancedService('your-api-key-here');
      final suggestion = await aiService.generateSmartReminder(
        widget.note.title,
        widget.note.content,
      );

      setState(() {
        _aiSuggestion = suggestion;
        _isGenerating = false;
      });
    } catch (e) {
      setState(() => _isGenerating = false);
      // Continue without AI suggestion
    }
  }

  void _applyAISuggestion() {
    if (_aiSuggestion == null) return;

    try {
      final dateStr = _aiSuggestion!['suggestedDate'] as String;
      final timeStr = _aiSuggestion!['suggestedTime'] as String;
      
      final dateParts = dateStr.split('-');
      final timeParts = timeStr.split(':');
      
      final year = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final day = int.parse(dateParts[2]);
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      
      setState(() {
        _selectedDate = DateTime(year, month, day);
        _selectedTime = TimeOfDay(hour: hour, minute: minute);
      });

      PandoraSnackbar.show(
        context,
        message: 'Đã áp dụng đề xuất từ AI!',
        variant: PandoraSnackbarVariant.success,
      );
    } catch (e) {
      PandoraSnackbar.show(
        context,
        message: 'Lỗi khi áp dụng đề xuất: $e',
        variant: PandoraSnackbarVariant.error,
      );
    }
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
          message: 'Nhắc nhở thông minh đã được tạo thành công!',
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
