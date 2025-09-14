import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora_ui/pandora_ui.dart';
import '../application/ai_enhanced_service.dart';
import '../../speech_recognition/application/speech_recognition_providers.dart';

class VoiceCommandsScreen extends ConsumerStatefulWidget {
  const VoiceCommandsScreen({super.key});

  @override
  ConsumerState<VoiceCommandsScreen> createState() => _VoiceCommandsScreenState();
}

class _VoiceCommandsScreenState extends ConsumerState<VoiceCommandsScreen> {
  final TextEditingController _commandController = TextEditingController();
  bool _isProcessing = false;
  String _lastCommand = '';
  String _lastResponse = '';

  @override
  void dispose() {
    _commandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final speechState = ref.watch(speechRecognitionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Commands'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(PTokens.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Voice status
            PandoraCard(
              variant: PandoraCardVariant.elevated,
              child: Padding(
                padding: const EdgeInsets.all(PTokens.spacingLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          speechState.isListening ? Icons.mic : Icons.mic_off,
                          color: speechState.isListening 
                              ? PandoraColors.success500 
                              : PandoraColors.neutral500,
                        ),
                        const SizedBox(width: PTokens.spacingSm),
                        Text(
                          speechState.isListening ? 'Đang nghe...' : 'Sẵn sàng',
                          style: PTokens.typography.titleMedium.copyWith(
                            color: speechState.isListening 
                                ? PandoraColors.success700 
                                : PandoraColors.neutral700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: PTokens.spacingSm),
                    Text(
                      speechState.hasError 
                          ? 'Lỗi: ${speechState.errorMessage}'
                          : 'Nhấn nút microphone để bắt đầu nói',
                      style: PTokens.typography.bodyMedium.copyWith(
                        color: speechState.hasError 
                            ? PandoraColors.error600 
                            : PandoraColors.neutral600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: PTokens.spacingLg),
            
            // Voice controls
            Row(
              children: [
                Expanded(
                  child: PandoraButton(
                    onPressed: speechState.isListening 
                        ? () => ref.read(speechRecognitionProvider.notifier).stopListening()
                        : () => ref.read(speechRecognitionProvider.notifier).startListening(),
                    variant: speechState.isListening 
                        ? PandoraButtonVariant.secondary 
                        : PandoraButtonVariant.primary,
                    icon: Icon(
                      speechState.isListening ? Icons.stop : Icons.mic,
                      color: Colors.white,
                    ),
                    child: Text(
                      speechState.isListening ? 'Dừng' : 'Bắt đầu nói',
                    ),
                  ),
                ),
                const SizedBox(width: PTokens.spacingSm),
                PandoraButton(
                  onPressed: speechState.isListening 
                      ? () => ref.read(speechRecognitionProvider.notifier).cancelListening()
                      : null,
                  variant: PandoraButtonVariant.outlined,
                  icon: const Icon(Icons.cancel),
                  child: const Text('Hủy'),
                ),
              ],
            ),
            
            const SizedBox(height: PTokens.spacingLg),
            
            // Recognized text
            if (speechState.recognizedText.isNotEmpty) ...[
              Text(
                'Văn bản đã nhận dạng:',
                style: PTokens.typography.labelLarge,
              ),
              const SizedBox(height: PTokens.spacingSm),
              PandoraContainer(
                variant: PandoraContainerVariant.filled,
                child: Padding(
                  padding: const EdgeInsets.all(PTokens.spacingMd),
                  child: Text(
                    speechState.recognizedText,
                    style: PTokens.typography.bodyMedium,
                  ),
                ),
              ),
              const SizedBox(height: PTokens.spacingMd),
              PandoraButton(
                onPressed: _processVoiceCommand,
                variant: PandoraButtonVariant.primary,
                fullWidth: true,
                icon: const Icon(Icons.auto_awesome),
                child: const Text('Xử lý lệnh bằng AI'),
              ),
            ],
            
            // Manual command input
            const SizedBox(height: PTokens.spacingLg),
            Text(
              'Hoặc nhập lệnh thủ công:',
              style: PTokens.typography.labelLarge,
            ),
            const SizedBox(height: PTokens.spacingSm),
            PandoraTextField(
              controller: _commandController,
              hint: 'Ví dụ: "Tạo ghi chú về cuộc họp ngày mai"',
              maxLines: 2,
              variant: PandoraTextFieldVariant.outlined,
            ),
            const SizedBox(height: PTokens.spacingSm),
            PandoraButton(
              onPressed: _processManualCommand,
              variant: PandoraButtonVariant.outlined,
              fullWidth: true,
              icon: const Icon(Icons.send),
              child: const Text('Gửi lệnh'),
            ),
            
            // AI Response
            if (_lastResponse.isNotEmpty) ...[
              const SizedBox(height: PTokens.spacingLg),
              Text(
                'Phản hồi từ AI:',
                style: PTokens.typography.labelLarge,
              ),
              const SizedBox(height: PTokens.spacingSm),
              PandoraContainer(
                variant: PandoraContainerVariant.filled,
                backgroundColor: PandoraColors.primary50,
                borderColor: PandoraColors.primary200,
                child: Padding(
                  padding: const EdgeInsets.all(PTokens.spacingMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            color: PandoraColors.primary600,
                            size: 20,
                          ),
                          const SizedBox(width: PTokens.spacingSm),
                          Text(
                            'AI Response',
                            style: PTokens.typography.labelLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: PandoraColors.primary700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: PTokens.spacingSm),
                      Text(
                        _lastResponse,
                        style: PTokens.typography.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
            
            // Loading indicator
            if (_isProcessing) ...[
              const SizedBox(height: PTokens.spacingLg),
              const Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _processVoiceCommand() async {
    final speechState = ref.read(speechRecognitionProvider);
    if (speechState.recognizedText.isEmpty) return;

    await _processCommand(speechState.recognizedText);
  }

  Future<void> _processManualCommand() async {
    if (_commandController.text.trim().isEmpty) {
      PandoraSnackbar.show(
        context,
        message: 'Vui lòng nhập lệnh',
        variant: PandoraSnackbarVariant.warning,
      );
      return;
    }

    await _processCommand(_commandController.text.trim());
    _commandController.clear();
  }

  Future<void> _processCommand(String command) async {
    setState(() {
      _isProcessing = true;
      _lastCommand = command;
      _lastResponse = '';
    });

    try {
      // TODO: Get API key from config
      final aiService = AiEnhancedService('your-api-key-here');
      
      // Process command with AI
      final response = await aiService.chatWithAIEnhanced(
        command,
        context: 'Bạn đang xử lý lệnh voice command cho ứng dụng ghi chú. Hãy trả lời một cách hữu ích và thực hiện các hành động phù hợp.',
      );

      setState(() {
        _lastResponse = response;
        _isProcessing = false;
      });

      // TODO: Implement actual command execution based on AI response
      // This could include creating notes, setting reminders, etc.

    } catch (e) {
      setState(() {
        _lastResponse = 'Lỗi khi xử lý lệnh: $e';
        _isProcessing = false;
      });
    }
  }
}
