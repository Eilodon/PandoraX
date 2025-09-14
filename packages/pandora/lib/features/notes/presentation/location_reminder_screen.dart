import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora_ui/pandora_ui.dart';
import 'package:alarm_domain/alarm_domain.dart';

class LocationReminderScreen extends ConsumerStatefulWidget {
  final Note note;
  
  const LocationReminderScreen({
    super.key,
    required this.note,
  });

  @override
  ConsumerState<LocationReminderScreen> createState() => _LocationReminderScreenState();
}

class _LocationReminderScreenState extends ConsumerState<LocationReminderScreen> {
  String _selectedLocation = '';
  double _radius = 100.0; // meters
  bool _isEnabled = false;
  List<String> _savedLocations = [
    'Nhà',
    'Văn phòng',
    'Trường học',
    'Siêu thị',
    'Bệnh viện',
    'Ngân hàng',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Reminder'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          PandoraButton(
            onPressed: _saveLocationReminder,
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: PTokens.spacingLg),
            
            // Enable/Disable toggle
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Bật nhắc nhở theo vị trí',
                    style: PTokens.typography.labelLarge,
                  ),
                ),
                Switch(
                  value: _isEnabled,
                  onChanged: (value) {
                    setState(() => _isEnabled = value);
                  },
                ),
              ],
            ),
            
            if (_isEnabled) ...[
              const SizedBox(height: PTokens.spacingLg),
              
              // Location selection
              Text(
                'Chọn vị trí:',
                style: PTokens.typography.labelLarge,
              ),
              const SizedBox(height: PTokens.spacingSm),
              DropdownButtonFormField<String>(
                value: _selectedLocation.isEmpty ? null : _selectedLocation,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: PTokens.spacingMd,
                    vertical: PTokens.spacingSm,
                  ),
                ),
                hint: const Text('Chọn vị trí'),
                items: _savedLocations.map((location) {
                  return DropdownMenuItem(
                    value: location,
                    child: Text(location),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedLocation = value);
                  }
                },
              ),
              
              const SizedBox(height: PTokens.spacingLg),
              
              // Add new location
              PandoraButton(
                onPressed: _addNewLocation,
                variant: PandoraButtonVariant.outlined,
                fullWidth: true,
                icon: const Icon(Icons.add_location),
                child: const Text('Thêm vị trí mới'),
              ),
              
              const SizedBox(height: PTokens.spacingLg),
              
              // Radius selection
              Text(
                'Bán kính nhắc nhở: ${_radius.toInt()}m',
                style: PTokens.typography.labelLarge,
              ),
              const SizedBox(height: PTokens.spacingSm),
              Slider(
                value: _radius,
                min: 50.0,
                max: 1000.0,
                divisions: 19,
                label: '${_radius.toInt()}m',
                onChanged: (value) {
                  setState(() => _radius = value);
                },
              ),
              
              const SizedBox(height: PTokens.spacingLg),
              
              // Current location button
              PandoraButton(
                onPressed: _useCurrentLocation,
                variant: PandoraButtonVariant.primary,
                fullWidth: true,
                icon: const Icon(Icons.my_location),
                child: const Text('Sử dụng vị trí hiện tại'),
              ),
              
              const SizedBox(height: PTokens.spacingLg),
              
              // Info card
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
                            Icons.info_outline,
                            color: PandoraColors.info600,
                            size: 20,
                          ),
                          const SizedBox(width: PTokens.spacingSm),
                          Text(
                            'Thông tin',
                            style: PTokens.typography.labelLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: PandoraColors.info700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: PTokens.spacingSm),
                      Text(
                        'Bạn sẽ nhận được thông báo khi đến gần vị trí đã chọn trong bán kính ${_radius.toInt()}m.',
                        style: PTokens.typography.bodySmall.copyWith(
                          color: PandoraColors.info600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _addNewLocation() {
    showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: const Text('Thêm vị trí mới'),
          content: PandoraTextField(
            controller: controller,
            hint: 'Nhập tên vị trí',
            variant: PandoraTextFieldVariant.outlined,
          ),
          actions: [
            PandoraButton(
              onPressed: () => Navigator.of(context).pop(),
              variant: PandoraButtonVariant.outlined,
              child: const Text('Hủy'),
            ),
            PandoraButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  setState(() {
                    _savedLocations.add(controller.text.trim());
                    _selectedLocation = controller.text.trim();
                  });
                  Navigator.of(context).pop();
                }
              },
              variant: PandoraButtonVariant.primary,
              child: const Text('Thêm'),
            ),
          ],
        );
      },
    );
  }

  void _useCurrentLocation() {
    // TODO: Implement GPS location detection
    PandoraSnackbar.show(
      context,
      message: 'Tính năng vị trí hiện tại sẽ được triển khai trong phiên bản tiếp theo',
      variant: PandoraSnackbarVariant.info,
    );
  }

  Future<void> _saveLocationReminder() async {
    if (!_isEnabled) {
      PandoraSnackbar.show(
        context,
        message: 'Nhắc nhở theo vị trí đã được tắt',
        variant: PandoraSnackbarVariant.info,
      );
      Navigator.of(context).pop();
      return;
    }

    if (_selectedLocation.isEmpty) {
      PandoraSnackbar.show(
        context,
        message: 'Vui lòng chọn vị trí',
        variant: PandoraSnackbarVariant.warning,
      );
      return;
    }

    try {
      // TODO: Implement location-based reminder saving
      // This would integrate with a location service and notification system
      
      PandoraSnackbar.show(
        context,
        message: 'Nhắc nhở theo vị trí đã được lưu thành công!',
        variant: PandoraSnackbarVariant.success,
      );
      
      Navigator.of(context).pop();
    } catch (e) {
      PandoraSnackbar.show(
        context,
        message: 'Lỗi khi lưu nhắc nhở: $e',
        variant: PandoraSnackbarVariant.error,
      );
    }
  }
}
