import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Sound Effects Service
/// 
/// Manages sound effects for the gamification system
class SoundEffectsService {
  static const MethodChannel _channel = MethodChannel('sound_effects');
  
  bool _isEnabled = true;
  double _volume = 1.0;
  final Map<String, String> _soundPaths = {
    'task_completion': 'sounds/task_completion.wav',
    'level_up': 'sounds/level_up.wav',
    'achievement': 'sounds/achievement.wav',
    'streak': 'sounds/streak.wav',
    'celebration': 'sounds/celebration.wav',
    'notification': 'sounds/notification.wav',
    'error': 'sounds/error.wav',
    'success': 'sounds/success.wav',
    'click': 'sounds/click.wav',
    'hover': 'sounds/hover.wav',
  };

  /// Play a sound effect
  Future<void> playSound(String soundKey) async {
    if (!_isEnabled) return;
    
    try {
      await _channel.invokeMethod('playSound', {
        'soundKey': soundKey,
        'volume': _volume,
      });
    } catch (e) {
      // Fallback to system sound if custom sound fails
      _playSystemSound(soundKey);
    }
  }

  /// Play system sound as fallback
  void _playSystemSound(String soundKey) {
    switch (soundKey) {
      case 'task_completion':
      case 'success':
        HapticFeedback.lightImpact();
        break;
      case 'level_up':
      case 'achievement':
        HapticFeedback.mediumImpact();
        break;
      case 'celebration':
        HapticFeedback.heavyImpact();
        break;
      case 'error':
        HapticFeedback.vibrate();
        break;
      case 'click':
        HapticFeedback.selectionClick();
        break;
      default:
        HapticFeedback.lightImpact();
    }
  }

  /// Play task completion sound
  Future<void> playTaskCompletion() async {
    await playSound('task_completion');
  }

  /// Play level up sound
  Future<void> playLevelUp() async {
    await playSound('level_up');
  }

  /// Play achievement sound
  Future<void> playAchievement() async {
    await playSound('achievement');
  }

  /// Play streak sound
  Future<void> playStreak() async {
    await playSound('streak');
  }

  /// Play celebration sound
  Future<void> playCelebration() async {
    await playSound('celebration');
  }

  /// Play notification sound
  Future<void> playNotification() async {
    await playSound('notification');
  }

  /// Play error sound
  Future<void> playError() async {
    await playSound('error');
  }

  /// Play success sound
  Future<void> playSuccess() async {
    await playSound('success');
  }

  /// Play click sound
  Future<void> playClick() async {
    await playSound('click');
  }

  /// Play hover sound
  Future<void> playHover() async {
    await playSound('hover');
  }

  /// Set sound enabled/disabled
  void setEnabled(bool enabled) {
    _isEnabled = enabled;
  }

  /// Set volume (0.0 to 1.0)
  void setVolume(double volume) {
    _volume = volume.clamp(0.0, 1.0);
  }

  /// Get current volume
  double getVolume() => _volume;

  /// Check if sound is enabled
  bool isEnabled() => _isEnabled;

  /// Play sound sequence for celebration
  Future<void> playCelebrationSequence() async {
    if (!_isEnabled) return;
    
    // Play celebration sound
    await playCelebration();
    
    // Wait a bit
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Play success sound
    await playSuccess();
    
    // Wait a bit
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Play achievement sound
    await playAchievement();
  }

  /// Play sound sequence for level up
  Future<void> playLevelUpSequence() async {
    if (!_isEnabled) return;
    
    // Play level up sound
    await playLevelUp();
    
    // Wait a bit
    await Future.delayed(const Duration(milliseconds: 400));
    
    // Play achievement sound
    await playAchievement();
    
    // Wait a bit
    await Future.delayed(const Duration(milliseconds: 200));
    
    // Play celebration sound
    await playCelebration();
  }

  /// Play sound sequence for task completion
  Future<void> playTaskCompletionSequence() async {
    if (!_isEnabled) return;
    
    // Play task completion sound
    await playTaskCompletion();
    
    // Wait a bit
    await Future.delayed(const Duration(milliseconds: 200));
    
    // Play success sound
    await playSuccess();
  }

  /// Play sound sequence for achievement
  Future<void> playAchievementSequence() async {
    if (!_isEnabled) return;
    
    // Play achievement sound
    await playAchievement();
    
    // Wait a bit
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Play celebration sound
    await playCelebration();
  }

  /// Play sound sequence for streak
  Future<void> playStreakSequence() async {
    if (!_isEnabled) return;
    
    // Play streak sound
    await playStreak();
    
    // Wait a bit
    await Future.delayed(const Duration(milliseconds: 400));
    
    // Play celebration sound
    await playCelebration();
  }
}

/// Sound Effects Service State
class SoundEffectsState {
  final bool isEnabled;
  final double volume;
  final bool isLoading;

  const SoundEffectsState({
    this.isEnabled = true,
    this.volume = 1.0,
    this.isLoading = false,
  });

  SoundEffectsState copyWith({
    bool? isEnabled,
    double? volume,
    bool? isLoading,
  }) {
    return SoundEffectsState(
      isEnabled: isEnabled ?? this.isEnabled,
      volume: volume ?? this.volume,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// Sound Effects Service Provider
final soundEffectsServiceProvider = Provider<SoundEffectsService>((ref) {
  return SoundEffectsService();
});

/// Sound Effects State Provider
final soundEffectsStateProvider = StateNotifierProvider<SoundEffectsStateNotifier, SoundEffectsState>((ref) {
  return SoundEffectsStateNotifier();
});

/// Sound Effects State Notifier
class SoundEffectsStateNotifier extends StateNotifier<SoundEffectsState> {
  SoundEffectsStateNotifier() : super(const SoundEffectsState());

  void setEnabled(bool enabled) {
    state = state.copyWith(isEnabled: enabled);
  }

  void setVolume(double volume) {
    state = state.copyWith(volume: volume.clamp(0.0, 1.0));
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }
}

/// Sound Effects Widget
class SoundEffectsWidget extends ConsumerWidget {
  final Widget child;

  const SoundEffectsWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final soundState = ref.watch(soundEffectsStateProvider);
    final soundService = ref.read(soundEffectsServiceProvider);

    // Update sound service settings
    soundService.setEnabled(soundState.isEnabled);
    soundService.setVolume(soundState.volume);

    return child;
  }
}

/// Sound Settings Widget
class SoundSettingsWidget extends ConsumerWidget {
  const SoundSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final soundState = ref.watch(soundEffectsStateProvider);
    final soundNotifier = ref.read(soundEffectsStateProvider.notifier);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sound Settings',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            
            // Sound enabled toggle
            Row(
              children: [
                const Icon(Icons.volume_up),
                const SizedBox(width: 8),
                const Text('Enable Sound Effects'),
                const Spacer(),
                Switch(
                  value: soundState.isEnabled,
                  onChanged: (value) {
                    soundNotifier.setEnabled(value);
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Volume slider
            Row(
              children: [
                const Icon(Icons.volume_down),
                const SizedBox(width: 8),
                Expanded(
                  child: Slider(
                    value: soundState.volume,
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                    label: '${(soundState.volume * 100).round()}%',
                    onChanged: soundState.isEnabled
                        ? (value) {
                            soundNotifier.setVolume(value);
                          }
                        : null,
                  ),
                ),
                const Icon(Icons.volume_up),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Test sounds
            if (soundState.isEnabled) ...[
              Text(
                'Test Sounds',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildTestButton(
                    'Task Completion',
                    Icons.check_circle,
                    () => ref.read(soundEffectsServiceProvider).playTaskCompletion(),
                  ),
                  _buildTestButton(
                    'Level Up',
                    Icons.star,
                    () => ref.read(soundEffectsServiceProvider).playLevelUp(),
                  ),
                  _buildTestButton(
                    'Achievement',
                    Icons.emoji_events,
                    () => ref.read(soundEffectsServiceProvider).playAchievement(),
                  ),
                  _buildTestButton(
                    'Celebration',
                    Icons.celebration,
                    () => ref.read(soundEffectsServiceProvider).playCelebration(),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTestButton(String label, IconData icon, VoidCallback onPressed) {
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
}
