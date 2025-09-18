import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora_ui/pandora_ui.dart';
import '../../services/voice_interaction_service.dart';
import '../../services/voice_commands_service.dart';

/// Advanced Voice Interaction Screen
/// Provides seamless voice interaction with AI assistant
class VoiceInteractionScreen extends ConsumerStatefulWidget {
  const VoiceInteractionScreen({super.key});

  @override
  ConsumerState<VoiceInteractionScreen> createState() => _VoiceInteractionScreenState();
}

class _VoiceInteractionScreenState extends ConsumerState<VoiceInteractionScreen> {
  final TextEditingController _textController = TextEditingController();
  String _lastCommand = '';
  String _lastResponse = '';
  bool _isProcessing = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎤 Tương tác bằng giọng nói'),
        backgroundColor: PandoraColors.primary600,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(PTokens.spacingLg),
        child: Column(
          children: [
            // Voice interaction status
            _buildVoiceStatusCard(),
            const SizedBox(height: PTokens.spacingLg),
            
            // Voice controls
            _buildVoiceControls(),
            const SizedBox(height: PTokens.spacingLg),
            
            // Command input
            _buildCommandInput(),
            const SizedBox(height: PTokens.spacingLg),
            
            // Results
            if (_lastCommand.isNotEmpty || _lastResponse.isNotEmpty)
              _buildResultsSection(),
            
            const Spacer(),
            
            // Quick commands
            _buildQuickCommands(),
          ],
        ),
      ),
    );
  }

  Widget _buildVoiceStatusCard() {
    return PandoraCard(
      variant: PandoraCardVariant.filled,
      child: Padding(
        padding: const EdgeInsets.all(PTokens.spacingMd),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.mic,
                  color: PandoraColors.primary600,
                  size: 24,
                ),
                const SizedBox(width: PTokens.spacingSm),
                Text(
                  'Trạng thái giọng nói',
                  style: PTokens.typography.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: PTokens.spacingSm),
            Text(
              'Nhấn nút microphone để bắt đầu nói chuyện với AI',
              style: PTokens.typography.bodyMedium.copyWith(
                color: PandoraColors.neutral600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoiceControls() {
    return Row(
      children: [
        Expanded(
          child: PandoraButton(
            onPressed: _isProcessing ? null : _startListening,
            variant: PandoraButtonVariant.primary,
            icon: const Icon(Icons.mic, color: Colors.white),
            child: const Text('Bắt đầu nói'),
          ),
        ),
        const SizedBox(width: PTokens.spacingSm),
        Expanded(
          child: PandoraButton(
            onPressed: _isProcessing ? null : _stopListening,
            variant: PandoraButtonVariant.secondary,
            icon: const Icon(Icons.stop, color: Colors.white),
            child: const Text('Dừng'),
          ),
        ),
      ],
    );
  }

  Widget _buildCommandInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hoặc nhập lệnh bằng text:',
          style: PTokens.typography.labelLarge,
        ),
        const SizedBox(height: PTokens.spacingSm),
        PandoraTextField(
          controller: _textController,
          hint: 'Ví dụ: "Tạo ghi chú về cuộc họp ngày mai"',
          maxLines: 3,
          variant: PandoraTextFieldVariant.outlined,
        ),
        const SizedBox(height: PTokens.spacingSm),
        PandoraButton(
          onPressed: _isProcessing ? null : _processTextCommand,
          variant: PandoraButtonVariant.outlined,
          fullWidth: true,
          child: const Text('Xử lý lệnh'),
        ),
      ],
    );
  }

  Widget _buildResultsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_lastCommand.isNotEmpty) ...[
          Text(
            'Lệnh đã nhận:',
            style: PTokens.typography.labelLarge,
          ),
          const SizedBox(height: PTokens.spacingSm),
          PandoraContainer(
            variant: PandoraContainerVariant.filled,
            child: Padding(
              padding: const EdgeInsets.all(PTokens.spacingMd),
              child: Text(
                _lastCommand,
                style: PTokens.typography.bodyMedium,
              ),
            ),
          ),
          const SizedBox(height: PTokens.spacingMd),
        ],
        
        if (_lastResponse.isNotEmpty) ...[
          Text(
            'Phản hồi từ AI:',
            style: PTokens.typography.labelLarge,
          ),
          const SizedBox(height: PTokens.spacingSm),
          PandoraContainer(
            variant: PandoraContainerVariant.outlined,
            borderColor: PandoraColors.primary200,
            child: Padding(
              padding: const EdgeInsets.all(PTokens.spacingMd),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _lastResponse,
                      style: PTokens.typography.bodyMedium,
                    ),
                  ),
                  const SizedBox(width: PTokens.spacingSm),
                  IconButton(
                    onPressed: _speakResponse,
                    icon: Icon(
                      Icons.volume_up,
                      color: PandoraColors.primary600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildQuickCommands() {
    final quickCommands = [
      'Tạo ghi chú mới',
      'Tìm ghi chú',
      'Đặt nhắc nhở',
      'Trò chuyện với AI',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lệnh nhanh:',
          style: PTokens.typography.labelLarge,
        ),
        const SizedBox(height: PTokens.spacingSm),
        Wrap(
          spacing: PTokens.spacingSm,
          runSpacing: PTokens.spacingSm,
          children: quickCommands.map((command) {
            return PandoraChip(
              label: command,
              onPressed: () => _processQuickCommand(command),
              variant: PandoraChipVariant.outlined,
            );
          }).toList(),
        ),
      ],
    );
  }

  Future<void> _startListening() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      // TODO: Implement voice interaction service
      // This would start listening and process voice commands
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() {
        _lastCommand = 'Đây là lệnh mẫu từ giọng nói';
        _lastResponse = 'Tôi đã hiểu lệnh của bạn và sẽ thực hiện ngay.';
        _isProcessing = false;
      });
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      
      PandoraSnackbar.show(
        context,
        message: 'Lỗi khi xử lý giọng nói: $e',
        variant: PandoraSnackbarVariant.error,
      );
    }
  }

  Future<void> _stopListening() async {
    setState(() {
      _isProcessing = false;
    });
    
    // TODO: Stop voice interaction service
  }

  Future<void> _processTextCommand() async {
    if (_textController.text.trim().isEmpty) {
      PandoraSnackbar.show(
        context,
        message: 'Vui lòng nhập lệnh',
        variant: PandoraSnackbarVariant.warning,
      );
      return;
    }

    setState(() {
      _isProcessing = true;
      _lastCommand = _textController.text.trim();
    });

    try {
      // TODO: Process command with AI
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() {
        _lastResponse = 'Tôi đã xử lý lệnh: "${_lastCommand}" và sẽ thực hiện ngay.';
        _isProcessing = false;
      });
      
      _textController.clear();
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      
      PandoraSnackbar.show(
        context,
        message: 'Lỗi khi xử lý lệnh: $e',
        variant: PandoraSnackbarVariant.error,
      );
    }
  }

  Future<void> _processQuickCommand(String command) async {
    setState(() {
      _isProcessing = true;
      _lastCommand = command;
    });

    try {
      // TODO: Process quick command
      await Future.delayed(const Duration(seconds: 1));
      
      setState(() {
        _lastResponse = 'Đã thực hiện lệnh: $command';
        _isProcessing = false;
      });
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      
      PandoraSnackbar.show(
        context,
        message: 'Lỗi khi xử lý lệnh nhanh: $e',
        variant: PandoraSnackbarVariant.error,
      );
    }
  }

  Future<void> _speakResponse() async {
    if (_lastResponse.isEmpty) return;
    
    try {
      // TODO: Use TTS service to speak the response
      PandoraSnackbar.show(
        context,
        message: 'Đang phát âm phản hồi...',
        variant: PandoraSnackbarVariant.info,
      );
    } catch (e) {
      PandoraSnackbar.show(
        context,
        message: 'Lỗi khi phát âm: $e',
        variant: PandoraSnackbarVariant.error,
      );
    }
  }
}
