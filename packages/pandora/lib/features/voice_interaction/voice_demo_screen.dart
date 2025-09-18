import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora_ui/pandora_ui.dart';
import 'providers/voice_interaction_providers.dart';
import '../../services/voice_commands_service.dart';

/// Voice Interaction Demo Screen
/// Comprehensive demo of all voice features
class VoiceDemoScreen extends ConsumerStatefulWidget {
  const VoiceDemoScreen({super.key});

  @override
  ConsumerState<VoiceDemoScreen> createState() => _VoiceDemoScreenState();
}

class _VoiceDemoScreenState extends ConsumerState<VoiceDemoScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _waveController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _waveController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    _waveAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _waveController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final voiceState = ref.watch(voiceInteractionStateProvider);
    final ttsState = ref.watch(ttsStateProvider);
    final phoWhisperState = ref.watch(phoWhisperStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎤 Voice Features Demo'),
        backgroundColor: PandoraColors.primary600,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => _showVoiceSettings(context),
            icon: const Icon(Icons.settings_voice),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(PTokens.spacingLg),
        child: Column(
          children: [
            // Voice status overview
            _buildVoiceStatusOverview(voiceState, ttsState, phoWhisperState),
            const SizedBox(height: PTokens.spacingLg),
            
            // Main voice interaction area
            _buildVoiceInteractionArea(voiceState),
            const SizedBox(height: PTokens.spacingLg),
            
            // Voice commands demo
            _buildVoiceCommandsDemo(),
            const SizedBox(height: PTokens.spacingLg),
            
            // TTS demo
            _buildTtsDemo(ttsState),
            const SizedBox(height: PTokens.spacingLg),
            
            // PhoWhisper demo
            _buildPhoWhisperDemo(phoWhisperState),
            const SizedBox(height: PTokens.spacingLg),
            
            // Quick actions
            _buildQuickActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildVoiceStatusOverview(
    VoiceInteractionState voiceState,
    TtsState ttsState,
    PhoWhisperState phoWhisperState,
  ) {
    return PandoraCard(
      variant: PandoraCardVariant.filled,
      child: Padding(
        padding: const EdgeInsets.all(PTokens.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🎯 Voice System Status',
              style: PTokens.typography.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: PTokens.spacingMd),
            
            Row(
              children: [
                Expanded(
                  child: _buildStatusItem(
                    'STT',
                    voiceState.isInitialized ? 'Ready' : 'Not Ready',
                    voiceState.isInitialized ? Colors.green : Colors.red,
                  ),
                ),
                Expanded(
                  child: _buildStatusItem(
                    'TTS',
                    ttsState.isSpeaking ? 'Speaking' : 'Ready',
                    ttsState.isSpeaking ? Colors.blue : Colors.green,
                  ),
                ),
                Expanded(
                  child: _buildStatusItem(
                    'PhoWhisper',
                    phoWhisperState.isModelLoaded ? 'Loaded' : 'Not Loaded',
                    phoWhisperState.isModelLoaded ? Colors.green : Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusItem(String title, String status, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: PTokens.typography.labelMedium,
        ),
        const SizedBox(height: PTokens.spacingXs),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: PTokens.spacingSm,
            vertical: PTokens.spacingXs,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(PTokens.radiusSm),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Text(
            status,
            style: PTokens.typography.bodySmall.copyWith(color: color),
          ),
        ),
      ],
    );
  }

  Widget _buildVoiceInteractionArea(VoiceInteractionState voiceState) {
    return PandoraCard(
      variant: PandoraCardVariant.outlined,
      child: Padding(
        padding: const EdgeInsets.all(PTokens.spacingLg),
        child: Column(
          children: [
            Text(
              '🎤 Voice Interaction',
              style: PTokens.typography.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: PTokens.spacingLg),
            
            // Voice visualization
            _buildVoiceVisualization(voiceState),
            const SizedBox(height: PTokens.spacingLg),
            
            // Voice controls
            _buildVoiceControls(voiceState),
            const SizedBox(height: PTokens.spacingMd),
            
            // Recognized text
            if (voiceState.recognizedText.isNotEmpty) ...[
              _buildRecognizedText(voiceState.recognizedText),
              const SizedBox(height: PTokens.spacingMd),
            ],
            
            // AI response
            if (voiceState.lastResponse.isNotEmpty) ...[
              _buildAiResponse(voiceState.lastResponse),
              const SizedBox(height: PTokens.spacingMd),
            ],
            
            // Error display
            if (voiceState.error != null) ...[
              _buildErrorDisplay(voiceState.error!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildVoiceVisualization(VoiceInteractionState voiceState) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: voiceState.isListening
            ? PandoraColors.primary100
            : PandoraColors.neutral100,
        border: Border.all(
          color: voiceState.isListening
              ? PandoraColors.primary600
              : PandoraColors.neutral300,
          width: 2,
        ),
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: voiceState.isListening ? _pulseAnimation : _waveAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: voiceState.isListening ? _pulseAnimation.value : 1.0,
              child: Icon(
                voiceState.isListening ? Icons.mic : Icons.mic_none,
                size: 48,
                color: voiceState.isListening
                    ? PandoraColors.primary600
                    : PandoraColors.neutral500,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildVoiceControls(VoiceInteractionState voiceState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PandoraButton(
          onPressed: voiceState.isListening
              ? () => ref.read(voiceInteractionStateProvider.notifier).stopListening()
              : () => ref.read(voiceInteractionStateProvider.notifier).startListening(),
          variant: voiceState.isListening
              ? PandoraButtonVariant.secondary
              : PandoraButtonVariant.primary,
          icon: Icon(
            voiceState.isListening ? Icons.stop : Icons.mic,
            color: Colors.white,
          ),
          child: Text(
            voiceState.isListening ? 'Stop' : 'Start',
          ),
        ),
        
        if (voiceState.isSpeaking)
          PandoraButton(
            onPressed: () => ref.read(ttsStateProvider.notifier).stopSpeaking(),
            variant: PandoraButtonVariant.outlined,
            icon: const Icon(Icons.stop),
            child: const Text('Stop Speaking'),
          ),
      ],
    );
  }

  Widget _buildRecognizedText(String text) {
    return PandoraContainer(
      variant: PandoraContainerVariant.filled,
      child: Padding(
        padding: const EdgeInsets.all(PTokens.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recognized Text:',
              style: PTokens.typography.labelMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: PTokens.spacingSm),
            Text(
              text,
              style: PTokens.typography.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAiResponse(String response) {
    return PandoraContainer(
      variant: PandoraContainerVariant.outlined,
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
                  'AI Response:',
                  style: PTokens.typography.labelMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: PandoraColors.primary700,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => ref.read(voiceInteractionStateProvider.notifier)
                      .speakResponse(response),
                  icon: Icon(
                    Icons.volume_up,
                    color: PandoraColors.primary600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: PTokens.spacingSm),
            Text(
              response,
              style: PTokens.typography.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorDisplay(String error) {
    return PandoraContainer(
      variant: PandoraContainerVariant.outlined,
      borderColor: PandoraColors.error300,
      child: Padding(
        padding: const EdgeInsets.all(PTokens.spacingMd),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: PandoraColors.error600,
              size: 20,
            ),
            const SizedBox(width: PTokens.spacingSm),
            Expanded(
              child: Text(
                error,
                style: PTokens.typography.bodyMedium.copyWith(
                  color: PandoraColors.error700,
                ),
              ),
            ),
            IconButton(
              onPressed: () => ref.read(voiceInteractionStateProvider.notifier)
                  .clearError(),
              icon: Icon(
                Icons.close,
                color: PandoraColors.error600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoiceCommandsDemo() {
    final sampleCommands = [
      'Tạo ghi chú mới',
      'Tìm ghi chú về dự án',
      'Đặt nhắc nhở lúc 3 giờ',
      'Trò chuyện với AI',
      'Mở màn hình chính',
    ];

    return PandoraCard(
      variant: PandoraCardVariant.filled,
      child: Padding(
        padding: const EdgeInsets.all(PTokens.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🗣️ Voice Commands Demo',
              style: PTokens.typography.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: PTokens.spacingSm),
            Text(
              'Try these voice commands:',
              style: PTokens.typography.bodyMedium.copyWith(
                color: PandoraColors.neutral600,
              ),
            ),
            const SizedBox(height: PTokens.spacingMd),
            Wrap(
              spacing: PTokens.spacingSm,
              runSpacing: PTokens.spacingSm,
              children: sampleCommands.map((command) {
                return PandoraChip(
                  label: command,
                  onPressed: () => _testVoiceCommand(command),
                  variant: PandoraChipVariant.outlined,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTtsDemo(TtsState ttsState) {
    final sampleTexts = [
      'Xin chào! Tôi là AI assistant của PandoraX.',
      'Tôi có thể giúp bạn tạo ghi chú, tìm kiếm và quản lý công việc.',
      'Hãy thử nói với tôi: "Tạo ghi chú mới".',
    ];

    return PandoraCard(
      variant: PandoraCardVariant.outlined,
      child: Padding(
        padding: const EdgeInsets.all(PTokens.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🔊 Text-to-Speech Demo',
              style: PTokens.typography.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: PTokens.spacingSm),
            Text(
              'Listen to different voices:',
              style: PTokens.typography.bodyMedium.copyWith(
                color: PandoraColors.neutral600,
              ),
            ),
            const SizedBox(height: PTokens.spacingMd),
            
            ...sampleTexts.map((text) {
              return Padding(
                padding: const EdgeInsets.only(bottom: PTokens.spacingSm),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        text,
                        style: PTokens.typography.bodySmall,
                      ),
                    ),
                    IconButton(
                      onPressed: ttsState.isSpeaking
                          ? null
                          : () => ref.read(ttsStateProvider.notifier).speakText(text),
                      icon: Icon(
                        ttsState.isSpeaking ? Icons.stop : Icons.play_arrow,
                        color: ttsState.isSpeaking
                            ? PandoraColors.neutral400
                            : PandoraColors.primary600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoWhisperDemo(PhoWhisperState phoWhisperState) {
    return PandoraCard(
      variant: PandoraCardVariant.outlined,
      child: Padding(
        padding: const EdgeInsets.all(PTokens.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🧠 PhoWhisper Offline STT',
              style: PTokens.typography.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: PTokens.spacingSm),
            
            if (!phoWhisperState.isModelAvailable) ...[
              Text(
                'PhoWhisper model is not available. Download it for offline speech recognition.',
                style: PTokens.typography.bodyMedium.copyWith(
                  color: PandoraColors.neutral600,
                ),
              ),
              const SizedBox(height: PTokens.spacingMd),
              PandoraButton(
                onPressed: phoWhisperState.isDownloading
                    ? null
                    : () => _downloadPhoWhisperModel(),
                variant: PandoraButtonVariant.primary,
                fullWidth: true,
                child: Text(
                  phoWhisperState.isDownloading
                      ? 'Downloading...'
                      : 'Download PhoWhisper Model (1.5GB)',
                ),
              ),
            ] else if (!phoWhisperState.isModelLoaded) ...[
              Text(
                'PhoWhisper model is downloaded but not loaded.',
                style: PTokens.typography.bodyMedium.copyWith(
                  color: PandoraColors.neutral600,
                ),
              ),
              const SizedBox(height: PTokens.spacingMd),
              PandoraButton(
                onPressed: phoWhisperState.isLoading
                    ? null
                    : () => _loadPhoWhisperModel(),
                variant: PandoraButtonVariant.primary,
                fullWidth: true,
                child: Text(
                  phoWhisperState.isLoading ? 'Loading...' : 'Load Model',
                ),
              ),
            ] else ...[
              Text(
                'PhoWhisper is ready for offline speech recognition!',
                style: PTokens.typography.bodyMedium.copyWith(
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: PTokens.spacingMd),
              PandoraButton(
                onPressed: () => _testPhoWhisper(),
                variant: PandoraButtonVariant.outlined,
                fullWidth: true,
                child: const Text('Test PhoWhisper'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: PandoraButton(
            onPressed: () => ref.read(voiceInteractionStateProvider.notifier)
                .clearHistory(),
            variant: PandoraButtonVariant.outlined,
            child: const Text('Clear History'),
          ),
        ),
        const SizedBox(width: PTokens.spacingSm),
        Expanded(
          child: PandoraButton(
            onPressed: () => _showVoiceSettings(context),
            variant: PandoraButtonVariant.outlined,
            child: const Text('Settings'),
          ),
        ),
      ],
    );
  }

  void _testVoiceCommand(String command) {
    ref.read(voiceInteractionStateProvider.notifier)
        .speakResponse('Testing command: $command');
  }

  void _downloadPhoWhisperModel() {
    ref.read(phoWhisperStateProvider.notifier).downloadModel(
      onProgress: (progress) {
        // TODO: Show progress
      },
      onStatus: (status) {
        // TODO: Show status
      },
    );
  }

  void _loadPhoWhisperModel() {
    ref.read(phoWhisperStateProvider.notifier).loadModel();
  }

  void _testPhoWhisper() {
    // TODO: Implement PhoWhisper test
    ref.read(voiceInteractionStateProvider.notifier)
        .speakResponse('PhoWhisper test functionality coming soon!');
  }

  void _showVoiceSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildVoiceSettingsSheet(),
    );
  }

  Widget _buildVoiceSettingsSheet() {
    return Container(
      padding: const EdgeInsets.all(PTokens.spacingLg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Voice Settings',
            style: PTokens.typography.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: PTokens.spacingLg),
          
          // Voice selection
          Text(
            'Select Voice:',
            style: PTokens.typography.labelLarge,
          ),
          const SizedBox(height: PTokens.spacingSm),
          
          // TODO: Add voice selection UI
          
          const SizedBox(height: PTokens.spacingLg),
          
          // Speed and volume controls
          Text(
            'Speech Speed:',
            style: PTokens.typography.labelLarge,
          ),
          // TODO: Add speed slider
          
          const SizedBox(height: PTokens.spacingLg),
          
          Text(
            'Volume:',
            style: PTokens.typography.labelLarge,
          ),
          // TODO: Add volume slider
          
          const SizedBox(height: PTokens.spacingLg),
          
          PandoraButton(
            onPressed: () => Navigator.pop(context),
            variant: PandoraButtonVariant.primary,
            fullWidth: true,
            child: const Text('Save Settings'),
          ),
        ],
      ),
    );
  }
}
