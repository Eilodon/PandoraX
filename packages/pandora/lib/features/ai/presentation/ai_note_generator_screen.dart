import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora_ui/pandora_ui.dart';
import '../application/ai_enhanced_service.dart';
import '../../../services/mascot_service.dart';
import '../../../services/mascot_enums.dart';

class AiNoteGeneratorScreen extends ConsumerStatefulWidget {
  const AiNoteGeneratorScreen({super.key});

  @override
  ConsumerState<AiNoteGeneratorScreen> createState() => _AiNoteGeneratorScreenState();
}

class _AiNoteGeneratorScreenState extends ConsumerState<AiNoteGeneratorScreen> {
  final TextEditingController _promptController = TextEditingController();
  bool _isGenerating = false;
  Map<String, String>? _generatedNote;
  List<String> _suggestions = [];

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Note Generator'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (_generatedNote != null)
            PandoraButton(
              onPressed: _saveNote,
              variant: PandoraButtonVariant.primary,
              size: PandoraButtonSize.sm,
              child: const Text('Lưu ghi chú'),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(PTokens.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Prompt input
            Text(
              'Mô tả ghi chú bạn muốn tạo:',
              style: PTokens.typography.labelLarge,
            ),
            const SizedBox(height: PTokens.spacingSm),
            PandoraTextField(
              controller: _promptController,
              hint: 'Ví dụ: Tạo ghi chú về kế hoạch học tiếng Anh trong 3 tháng tới',
              maxLines: 3,
              variant: PandoraTextFieldVariant.outlined,
            ),
            const SizedBox(height: PTokens.spacingLg),
            
            // Generate button
            PandoraButton(
              onPressed: _isGenerating ? null : _generateNote,
              variant: PandoraButtonVariant.primary,
              fullWidth: true,
              icon: _isGenerating 
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.auto_awesome),
              child: Text(_isGenerating ? 'Đang tạo...' : 'Tạo ghi chú với AI'),
            ),
            
            const SizedBox(height: PTokens.spacingLg),
            
            // Generated note preview
            if (_generatedNote != null) ...[
              Text(
                'Ghi chú đã tạo:',
                style: PTokens.typography.labelLarge,
              ),
              const SizedBox(height: PTokens.spacingSm),
              PandoraCard(
                variant: PandoraCardVariant.elevated,
                child: Padding(
                  padding: const EdgeInsets.all(PTokens.spacingLg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        _generatedNote!['title'] ?? 'Ghi chú mới',
                        style: PTokens.typography.titleLarge,
                      ),
                      const SizedBox(height: PTokens.spacingSm),
                      
                      // Category and tags
                      Row(
                        children: [
                          PandoraChip(
                            label: _generatedNote!['category'] ?? 'khác',
                            variant: PandoraChipVariant.filled,
                            backgroundColor: PandoraColors.primary500,
                          ),
                          const SizedBox(width: PTokens.spacingSm),
                          if (_generatedNote!['tags'] != null && _generatedNote!['tags']!.isNotEmpty)
                            PandoraChip(
                              label: 'Tags: ${_generatedNote!['tags']}',
                              variant: PandoraChipVariant.outlined,
                            ),
                        ],
                      ),
                      const SizedBox(height: PTokens.spacingMd),
                      
                      // Content
                      Text(
                        _generatedNote!['content'] ?? 'Nội dung ghi chú',
                        style: PTokens.typography.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
            
            // Suggestions
            if (_suggestions.isNotEmpty) ...[
              const SizedBox(height: PTokens.spacingLg),
              Text(
                'Đề xuất cải thiện:',
                style: PTokens.typography.labelLarge,
              ),
              const SizedBox(height: PTokens.spacingSm),
              ..._suggestions.map((suggestion) => Padding(
                padding: const EdgeInsets.only(bottom: PTokens.spacingSm),
                child: PandoraContainer(
                  variant: PandoraContainerVariant.filled,
                  backgroundColor: PandoraColors.info50,
                  child: Padding(
                    padding: const EdgeInsets.all(PTokens.spacingMd),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          color: PandoraColors.info600,
                          size: 20,
                        ),
                        const SizedBox(width: PTokens.spacingSm),
                        Expanded(
                          child: Text(
                            suggestion,
                            style: PTokens.typography.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _generateNote() async {
    if (_promptController.text.trim().isEmpty) {
      PandoraSnackbar.show(
        context,
        message: 'Vui lòng nhập mô tả ghi chú',
        variant: PandoraSnackbarVariant.warning,
      );
      return;
    }

    setState(() {
      _isGenerating = true;
      _generatedNote = null;
      _suggestions = [];
    });

    // Cập nhật trạng thái mascot
    ref.read(mascotServiceProvider.notifier).handleUserAction(
      UserAction.aiProcessing,
    );

    try {
      // TODO: Get API key from config
      final aiService = AiEnhancedService('your-api-key-here');
      
      // Generate note
      final note = await aiService.generateNoteFromPrompt(_promptController.text.trim());
      
      // Generate suggestions
      final suggestions = await aiService.generateContentSuggestions(
        note['title'] ?? '',
        note['content'] ?? '',
      );

      setState(() {
        _generatedNote = note;
        _suggestions = suggestions;
        _isGenerating = false;
      });

      // Cập nhật trạng thái mascot khi thành công
      ref.read(mascotServiceProvider.notifier).handleUserAction(
        UserAction.completeTask,
      );

      PandoraSnackbar.show(
        context,
        message: 'Ghi chú đã được tạo thành công!',
        variant: PandoraSnackbarVariant.success,
      );
    } catch (e) {
      setState(() {
        _isGenerating = false;
      });

      // Cập nhật trạng thái mascot khi có lỗi
      ref.read(mascotServiceProvider.notifier).handleUserAction(
        UserAction.error,
      );

      PandoraSnackbar.show(
        context,
        message: 'Lỗi khi tạo ghi chú: $e',
        variant: PandoraSnackbarVariant.error,
      );
    }
  }

  Future<void> _saveNote() async {
    if (_generatedNote == null) return;

    try {
      // TODO: Implement save note functionality
      // This would integrate with the note repository
      
      PandoraSnackbar.show(
        context,
        message: 'Ghi chú đã được lưu thành công!',
        variant: PandoraSnackbarVariant.success,
      );
      
      Navigator.of(context).pop();
    } catch (e) {
      PandoraSnackbar.show(
        context,
        message: 'Lỗi khi lưu ghi chú: $e',
        variant: PandoraSnackbarVariant.error,
      );
    }
  }
}
