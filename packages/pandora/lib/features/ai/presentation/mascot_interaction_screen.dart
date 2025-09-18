import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora_ui/pandora_ui.dart';
import '../../../widgets/mascot_widget.dart';
import '../../../services/mascot_service.dart';
import '../../../services/mascot_enums.dart';

class MascotInteractionScreen extends ConsumerStatefulWidget {
  const MascotInteractionScreen({super.key});

  @override
  ConsumerState<MascotInteractionScreen> createState() => _MascotInteractionScreenState();
}

class _MascotInteractionScreenState extends ConsumerState<MascotInteractionScreen> {
  @override
  Widget build(BuildContext context) {
    final mascotState = ref.watch(mascotServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mascot Interaction'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(mascotServiceProvider.notifier).handleUserAction(
                UserAction.idle,
              );
            },
            tooltip: 'Reset Mascot',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(PTokens.spacingLg),
        child: Column(
          children: [
            // Mascot Display
            Expanded(
              flex: 3,
              child: Center(
                child: MascotWidget(
                  size: MascotSize.large,
                  showMessage: true,
                ),
              ),
            ),
            
            // Interaction Buttons
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text(
                    'Tương tác với Mascot',
                    style: PTokens.typography.titleLarge,
                  ),
                  const SizedBox(height: PTokens.spacingLg),
                  
                  // Action Buttons
                  Wrap(
                    spacing: PTokens.spacingSm,
                    runSpacing: PTokens.spacingSm,
                    children: [
                      _buildActionButton(
                        'Tạo ghi chú',
                        Icons.note_add,
                        PandoraColors.primary500,
                        () => ref.read(mascotServiceProvider.notifier).handleUserAction(
                          UserAction.createNote,
                        ),
                      ),
                      _buildActionButton(
                        'Hoàn thành task',
                        Icons.check_circle,
                        PandoraColors.success500,
                        () => ref.read(mascotServiceProvider.notifier).handleUserAction(
                          UserAction.completeTask,
                        ),
                      ),
                      _buildActionButton(
                        'AI xử lý',
                        Icons.auto_awesome,
                        PandoraColors.info500,
                        () => ref.read(mascotServiceProvider.notifier).handleUserAction(
                          UserAction.aiProcessing,
                        ),
                      ),
                      _buildActionButton(
                        'Có lỗi',
                        Icons.error,
                        PandoraColors.error500,
                        () => ref.read(mascotServiceProvider.notifier).handleUserAction(
                          UserAction.error,
                        ),
                      ),
                      _buildActionButton(
                        'Đồng bộ',
                        Icons.sync,
                        PandoraColors.warning500,
                        () => ref.read(mascotServiceProvider.notifier).handleUserAction(
                          UserAction.sync,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: PTokens.spacingLg),
                  
                  // Interaction Buttons
                  Text(
                    'Tương tác trực tiếp',
                    style: PTokens.typography.titleMedium,
                  ),
                  const SizedBox(height: PTokens.spacingSm),
                  
                  Wrap(
                    spacing: PTokens.spacingSm,
                    runSpacing: PTokens.spacingSm,
                    children: [
                      _buildInteractionButton(
                        'Chạm',
                        Icons.touch_app,
                        () => ref.read(mascotServiceProvider.notifier).handleInteraction(
                          MascotInteraction.tap,
                        ),
                      ),
                      _buildInteractionButton(
                        'Nhấn giữ',
                        Icons.touch_app,
                        () => ref.read(mascotServiceProvider.notifier).handleInteraction(
                          MascotInteraction.longPress,
                        ),
                      ),
                      _buildInteractionButton(
                        'Chạm đôi',
                        Icons.touch_app,
                        () => ref.read(mascotServiceProvider.notifier).handleInteraction(
                          MascotInteraction.doubleTap,
                        ),
                      ),
                      _buildInteractionButton(
                        'Vuốt',
                        Icons.swipe,
                        () => ref.read(mascotServiceProvider.notifier).handleInteraction(
                          MascotInteraction.swipe,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Mascot Status
            PandoraCard(
              variant: PandoraCardVariant.outlined,
              child: Padding(
                padding: const EdgeInsets.all(PTokens.spacingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trạng thái Mascot',
                      style: PTokens.typography.labelLarge,
                    ),
                    const SizedBox(height: PTokens.spacingSm),
                    Row(
                      children: [
                        Text('Animation: '),
                        PandoraChip(
                          label: mascotState.currentAnimation.name,
                          variant: PandoraChipVariant.filled,
                          backgroundColor: PandoraColors.primary500,
                        ),
                      ],
                    ),
                    const SizedBox(height: PTokens.spacingXs),
                    Row(
                      children: [
                        Text('Mood: '),
                        PandoraChip(
                          label: mascotState.mood.name,
                          variant: PandoraChipVariant.outlined,
                        ),
                      ],
                    ),
                    if (mascotState.currentMessage != null && mascotState.currentMessage!.isNotEmpty) ...[
                      const SizedBox(height: PTokens.spacingSm),
                      Text(
                        'Message: ${mascotState.currentMessage}',
                        style: PTokens.typography.bodySmall,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return PandoraButton(
      onPressed: onPressed,
      variant: PandoraButtonVariant.outlined,
      icon: Icon(icon, color: color),
      child: Text(label),
    );
  }

  Widget _buildInteractionButton(
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return PandoraButton(
      onPressed: onPressed,
      variant: PandoraButtonVariant.primary,
      size: PandoraButtonSize.sm,
      icon: Icon(icon),
      child: Text(label),
    );
  }

  Color _getMoodColor(MascotMood mood) {
    switch (mood) {
      case MascotMood.neutral:
        return PandoraColors.neutral600;
      case MascotMood.happy:
        return PandoraColors.success600;
      case MascotMood.excited:
        return PandoraColors.primary600;
      case MascotMood.tired:
        return PandoraColors.warning600;
      case MascotMood.confused:
        return PandoraColors.error600;
      case MascotMood.proud:
        return PandoraColors.secondary600;
      case MascotMood.sad:
        return PandoraColors.error700;
      case MascotMood.thinking:
        return PandoraColors.info600;
      case MascotMood.welcoming:
        return PandoraColors.primary500;
      case MascotMood.celebrating:
        return PandoraColors.success500;
      case MascotMood.sleeping:
        return PandoraColors.neutral500;
      case MascotMood.idle:
        return PandoraColors.neutral400;
      case MascotMood.disappointed:
        return PandoraColors.error500;
      case MascotMood.playful:
        return PandoraColors.secondary500;
    }
  }
}
