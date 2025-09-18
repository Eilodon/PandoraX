import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/mascot_service.dart';
import '../../../services/mascot_enums.dart';
import '../../../services/mascot_task_integration.dart';
import '../../../widgets/living_mascot_widget.dart';
import 'package:pandora_ui/pandora_ui.dart';

/// Living Mascot Demo Screen
/// 
/// Demonstrates the "living creature" behavior of the mascot
class LivingMascotDemoScreen extends ConsumerStatefulWidget {
  const LivingMascotDemoScreen({super.key});

  @override
  ConsumerState<LivingMascotDemoScreen> createState() => _LivingMascotDemoScreenState();
}

class _LivingMascotDemoScreenState extends ConsumerState<LivingMascotDemoScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize mascot when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(mascotBehaviorControllerProvider).initializeMascot();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mascotState = ref.watch(mascotServiceProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Living Mascot Demo'),
        backgroundColor: PandoraColors.primary500,
        foregroundColor: PandoraColors.white,
      ),
      body: Stack(
        children: [
          // Main content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mascot Status Card
                _buildMascotStatusCard(mascotState),
                const SizedBox(height: 20),
                
                // Demo Controls
                _buildDemoControls(),
                const SizedBox(height: 20),
                
                // Mascot Info
                _buildMascotInfo(mascotState),
              ],
            ),
          ),
          
          // Living Mascot
          LivingMascotWithCloudWidget(
            size: MascotSize.large,
            position: MascotPosition.floating,
            showMessage: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMascotStatusCard(MascotState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mascot Status',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  _getMoodIcon(state.mood),
                  color: _getMoodColor(state.mood),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Mood: ${_getMoodText(state.mood)}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Animation: ${_getAnimationText(state.currentAnimation)}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Interactions: ${state.interactionCount}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Idle Time: ${_formatDuration(state.idleTime)}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (state.isSleeping) ...[
              const SizedBox(height: 8),
              Text(
                '😴 Sleeping',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: PandoraColors.neutral600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDemoControls() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Demo Controls',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildActionButton(
                  'Open App',
                  Icons.open_in_new,
                  () => ref.read(mascotBehaviorControllerProvider).initializeMascot(),
                ),
                _buildActionButton(
                  'Complete Task',
                  Icons.check_circle,
                  () => ref.read(mascotBehaviorControllerProvider).handleTaskEvent(TaskEvent.completed),
                ),
                _buildActionButton(
                  'Create Task',
                  Icons.add_circle,
                  () => ref.read(mascotBehaviorControllerProvider).handleTaskEvent(TaskEvent.created),
                ),
                _buildActionButton(
                  'Miss Deadline',
                  Icons.schedule,
                  () => ref.read(mascotBehaviorControllerProvider).handleTaskEvent(TaskEvent.missedDeadline),
                ),
                _buildActionButton(
                  'AI Processing',
                  Icons.psychology,
                  () => ref.read(mascotBehaviorControllerProvider).handleAIEvent(AIEvent.processing),
                ),
                _buildActionButton(
                  'Error',
                  Icons.error,
                  () => ref.read(mascotBehaviorControllerProvider).handleAIEvent(AIEvent.error),
                ),
                _buildActionButton(
                  'Sync',
                  Icons.sync,
                  () => ref.read(mascotBehaviorControllerProvider).handleSyncEvent(),
                ),
                _buildActionButton(
                  'Touch Mascot',
                  Icons.touch_app,
                  () => ref.read(mascotBehaviorControllerProvider).handleMascotInteraction(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: PandoraColors.primary500,
        foregroundColor: PandoraColors.white,
      ),
    );
  }

  Widget _buildMascotInfo(MascotState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Living Mascot Features',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            const Text(
              '🎭 This mascot behaves like a living creature:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('• Welcomes you when you open the app'),
            const Text('• Celebrates when you complete tasks'),
            const Text('• Gets sad when you miss deadlines'),
            const Text('• Goes to sleep when idle for too long'),
            const Text('• Responds to direct touch interactions'),
            const Text('• Shows different emotions and animations'),
            const SizedBox(height: 12),
            if (state.currentMessage != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: PandoraColors.primary50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: PandoraColors.primary200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.chat_bubble, color: PandoraColors.primary500),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        state.currentMessage!,
                        style: TextStyle(color: PandoraColors.primary700),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getMoodIcon(MascotMood mood) {
    switch (mood) {
      case MascotMood.welcoming:
        return Icons.waving_hand;
      case MascotMood.celebrating:
        return Icons.celebration;
      case MascotMood.sleeping:
        return Icons.bedtime;
      case MascotMood.disappointed:
        return Icons.sentiment_dissatisfied;
      case MascotMood.playful:
        return Icons.sports_esports;
      case MascotMood.happy:
        return Icons.sentiment_very_satisfied;
      case MascotMood.excited:
        return Icons.celebration;
      case MascotMood.thinking:
        return Icons.psychology;
      case MascotMood.sad:
        return Icons.sentiment_dissatisfied;
      case MascotMood.idle:
        return Icons.sentiment_neutral;
      default:
        return Icons.sentiment_neutral;
    }
  }

  Color _getMoodColor(MascotMood mood) {
    switch (mood) {
      case MascotMood.welcoming:
        return PandoraColors.success400;
      case MascotMood.celebrating:
        return PandoraColors.warning400;
      case MascotMood.sleeping:
        return PandoraColors.neutral600;
      case MascotMood.disappointed:
        return PandoraColors.error600;
      case MascotMood.playful:
        return PandoraColors.primary400;
      case MascotMood.happy:
        return PandoraColors.success500;
      case MascotMood.excited:
        return PandoraColors.warning500;
      case MascotMood.thinking:
        return PandoraColors.info500;
      case MascotMood.sad:
        return PandoraColors.error700;
      case MascotMood.idle:
        return PandoraColors.neutral400;
      default:
        return PandoraColors.primary400;
    }
  }

  String _getMoodText(MascotMood mood) {
    switch (mood) {
      case MascotMood.welcoming:
        return 'Welcoming';
      case MascotMood.celebrating:
        return 'Celebrating';
      case MascotMood.sleeping:
        return 'Sleeping';
      case MascotMood.disappointed:
        return 'Disappointed';
      case MascotMood.playful:
        return 'Playful';
      case MascotMood.happy:
        return 'Happy';
      case MascotMood.excited:
        return 'Excited';
      case MascotMood.thinking:
        return 'Thinking';
      case MascotMood.sad:
        return 'Sad';
      case MascotMood.idle:
        return 'Idle';
      default:
        return 'Neutral';
    }
  }

  String _getAnimationText(MascotAnimation animation) {
    switch (animation) {
      case MascotAnimation.celebration:
        return 'Celebration';
      case MascotAnimation.sleep:
        return 'Sleep';
      case MascotAnimation.wake:
        return 'Wake';
      case MascotAnimation.sad:
        return 'Sad';
      case MascotAnimation.cloud:
        return 'Cloud';
      case MascotAnimation.random:
        return 'Random';
      case MascotAnimation.wave:
        return 'Wave';
      case MascotAnimation.jump:
        return 'Jump';
      case MascotAnimation.spin:
        return 'Spin';
      case MascotAnimation.bounce:
        return 'Bounce';
      case MascotAnimation.fade:
        return 'Fade';
      case MascotAnimation.scale:
        return 'Scale';
      case MascotAnimation.slide:
        return 'Slide';
      case MascotAnimation.idle:
        return 'Idle';
    }
  }

  String _formatDuration(Duration duration) {
    if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m ${duration.inSeconds % 60}s';
    } else {
      return '${duration.inSeconds}s';
    }
  }
}
