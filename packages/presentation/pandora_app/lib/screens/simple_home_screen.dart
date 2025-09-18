import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_tokens/design_tokens.dart';
import 'package:pandora_ui/pandora_ui.dart';
import 'package:core_utils/core_utils.dart';
import 'package:common_entities/common_entities.dart';
import '../providers/note_provider.dart';

// Mock data for demonstration
final notesProvider = StateNotifierProvider<NotesNotifier, List<Note>>((ref) {
  return NotesNotifier();
});

class NotesNotifier extends StateNotifier<List<Note>> {
  NotesNotifier() : super([]);
  
  void addNote(Note note) {
    state = [...state, note];
  }
  
  void removeNote(String id) {
    state = state.where((note) => note.id != id).toList();
  }
}

/// Simple Home screen for PandoraX with working features
///
/// This is a simplified version that focuses on core functionality
/// without complex AI features that require code generation.
class SimpleHomeScreen extends ConsumerStatefulWidget {
  const SimpleHomeScreen({super.key});

  @override
  ConsumerState<SimpleHomeScreen> createState() => _SimpleHomeScreenState();
}

class _SimpleHomeScreenState extends ConsumerState<SimpleHomeScreen> {
  int _selectedIndex = 0;
  bool _isVoiceListening = false;
  String _voiceText = '';

  @override
  void initState() {
    super.initState();
    AppLogger.info('🏠 Simple Home screen initialized');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  /// Build app bar with new features
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('PandoraX - AI Powered'),
      actions: [
        // Voice button
        IconButton(
          icon: Icon(_isVoiceListening ? Icons.mic : Icons.mic_none),
          onPressed: _onVoicePressed,
        ),
        // AI features button
        IconButton(
          icon: const Icon(Icons.psychology),
          onPressed: _onAIFeaturesPressed,
        ),
        // Security button
        IconButton(
          icon: const Icon(Icons.security),
          onPressed: _onSecurityPressed,
        ),
        // Settings button
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: _onSettingsPressed,
        ),
      ],
    );
  }

  /// Build main body
  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildNotesTab();
      case 1:
        return _buildAITab();
      case 2:
        return _buildVoiceTab();
      case 3:
        return _buildCollaborationTab();
      case 4:
        return _buildAnalyticsTab();
      default:
        return _buildNotesTab();
    }
  }

  /// Build notes tab
  Widget _buildNotesTab() {
    return Consumer(
      builder: (context, ref, child) {
        final notesAsync = ref.watch(notesProvider);
        
        return _buildNotesList(notesAsync);
      },
    );
  }

  /// Build notes list
  Widget _buildNotesList(List<Note> notes) {
    if (notes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.note_add,
              size: 64,
              color: PandoraColors.primary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No notes yet',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the + button to create your first note',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            title: Text(note.title),
            subtitle: Text(note.content),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
                const PopupMenuItem(
                  value: 'ai_summarize',
                  child: Text('AI Summarize'),
                ),
                const PopupMenuItem(
                  value: 'ai_translate',
                  child: Text('AI Translate'),
                ),
              ],
              onSelected: (value) => _onNoteAction(value, note),
            ),
            onTap: () => _onNoteTapped(note),
          ),
        );
      },
    );
  }

  /// Build AI features tab
  Widget _buildAITab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AI Features',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildFeatureCard(
                  icon: Icons.auto_awesome,
                  title: 'Smart Summarization',
                  subtitle: '4 styles available',
                  onTap: _onSmartSummarizationPressed,
                ),
                _buildFeatureCard(
                  icon: Icons.create,
                  title: 'Content Generation',
                  subtitle: 'Template-based',
                  onTap: _onContentGenerationPressed,
                ),
                _buildFeatureCard(
                  icon: Icons.translate,
                  title: 'Multi-language Translation',
                  subtitle: '17+ languages',
                  onTap: _onTranslationPressed,
                ),
                _buildFeatureCard(
                  icon: Icons.psychology,
                  title: 'Machine Learning',
                  subtitle: '9 ML features',
                  onTap: _onMLFeaturesPressed,
                ),
                _buildFeatureCard(
                  icon: Icons.analytics,
                  title: 'Predictive Analytics',
                  subtitle: 'AI insights',
                  onTap: _onPredictiveAnalyticsPressed,
                ),
                _buildFeatureCard(
                  icon: Icons.person,
                  title: 'Personalization',
                  subtitle: 'AI-powered',
                  onTap: _onPersonalizationPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build voice features tab
  Widget _buildVoiceTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Voice Features',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          if (_voiceText.isNotEmpty) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Voice Input:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(_voiceText),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildFeatureCard(
                  icon: Icons.mic,
                  title: 'Speech-to-Text',
                  subtitle: '25+ languages',
                  onTap: _onSpeechToTextPressed,
                ),
                _buildFeatureCard(
                  icon: Icons.volume_up,
                  title: 'Text-to-Speech',
                  subtitle: 'Natural voice',
                  onTap: _onTextToSpeechPressed,
                ),
                _buildFeatureCard(
                  icon: Icons.record_voice_over,
                  title: 'Voice Commands',
                  subtitle: 'Hands-free control',
                  onTap: _onVoiceCommandsPressed,
                ),
                _buildFeatureCard(
                  icon: Icons.language,
                  title: 'Multi-language Voice',
                  subtitle: '25+ languages',
                  onTap: _onMultiLanguageVoicePressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build collaboration tab
  Widget _buildCollaborationTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Real-time Collaboration',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildFeatureCard(
                  icon: Icons.people,
                  title: 'Live Sessions',
                  subtitle: 'Real-time editing',
                  onTap: _onLiveSessionsPressed,
                ),
                _buildFeatureCard(
                  icon: Icons.share,
                  title: 'Document Sharing',
                  subtitle: 'Secure sharing',
                  onTap: _onDocumentSharingPressed,
                ),
                _buildFeatureCard(
                  icon: Icons.comment,
                  title: 'Comments & Annotations',
                  subtitle: 'Collaborative feedback',
                  onTap: _onCommentsPressed,
                ),
                _buildFeatureCard(
                  icon: Icons.history,
                  title: 'Version Control',
                  subtitle: 'Document versioning',
                  onTap: _onVersionControlPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build analytics tab
  Widget _buildAnalyticsTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Analytics & Performance',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildFeatureCard(
                  icon: Icons.analytics,
                  title: 'Usage Analytics',
                  subtitle: 'Comprehensive insights',
                  onTap: _onUsageAnalyticsPressed,
                ),
                _buildFeatureCard(
                  icon: Icons.speed,
                  title: 'Performance Monitoring',
                  subtitle: 'Real-time metrics',
                  onTap: _onPerformanceMonitoringPressed,
                ),
                _buildFeatureCard(
                  icon: Icons.trending_up,
                  title: 'Business Intelligence',
                  subtitle: 'Executive dashboards',
                  onTap: _onBusinessIntelligencePressed,
                ),
                _buildFeatureCard(
                  icon: Icons.insights,
                  title: 'ML Insights',
                  subtitle: 'AI-powered insights',
                  onTap: _onMLInsightsPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build feature card
  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: PandoraColors.primary,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build bottom navigation bar
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (index) => setState(() => _selectedIndex = index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.note),
          label: 'Notes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.psychology),
          label: 'AI',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mic),
          label: 'Voice',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Collaborate',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics),
          label: 'Analytics',
        ),
      ],
    );
  }

  /// Build floating action button
  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _onCreateNotePressed,
      child: const Icon(Icons.add),
    );
  }

  // Event handlers
  void _onVoicePressed() async {
    setState(() => _isVoiceListening = !_isVoiceListening);
    
    if (_isVoiceListening) {
      // Simulate voice input
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _voiceText = 'Hello, this is a simulated voice input!';
        _isVoiceListening = false;
      });
    }
  }

  void _onAIFeaturesPressed() {
    setState(() => _selectedIndex = 1);
  }

  void _onSecurityPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Security Features'),
        content: const Text('AES-256 encryption, Biometric authentication, Privacy features available'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onSettingsPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Settings'),
        content: const Text('Theme, Performance, Security, Privacy settings available'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onNoteAction(String action, Note note) {
    switch (action) {
      case 'edit':
        // TODO: Implement edit note
        break;
      case 'delete':
        // TODO: Implement delete note
        break;
      case 'ai_summarize':
        _onSmartSummarizationPressed();
        break;
      case 'ai_translate':
        _onTranslationPressed();
        break;
    }
  }

  void _onNoteTapped(Note note) {
    // TODO: Implement note details
  }

  void _onCreateNotePressed() {
    // TODO: Implement create note
  }

  void _onSmartSummarizationPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Smart Summarization'),
        content: const Text('4 styles: Bullet Points, Executive Summary, Detailed Analysis, Custom'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onContentGenerationPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Content Generation'),
        content: const Text('Template-based content generation with context awareness'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onTranslationPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Multi-language Translation'),
        content: const Text('17+ languages with cultural context and formatting preservation'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onMLFeaturesPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Machine Learning Features'),
        content: const Text('9 ML features: Predictive Analytics, Personalization, Recommendation Engine, Anomaly Detection, Pattern Recognition, NLP, Computer Vision, Speech Recognition, Sentiment Analysis'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onPredictiveAnalyticsPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Predictive Analytics'),
        content: const Text('AI-powered predictions and trend analysis'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onPersonalizationPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Personalization'),
        content: const Text('AI-powered personalization and customization'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onSpeechToTextPressed() {
    _onVoicePressed();
  }

  void _onTextToSpeechPressed() {
    if (_voiceText.isNotEmpty) {
      // Simulate TTS
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Speaking: $_voiceText')),
      );
    }
  }

  void _onVoiceCommandsPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Voice Commands'),
        content: const Text('Hands-free control with 25+ language support'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onMultiLanguageVoicePressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Multi-language Voice'),
        content: const Text('25+ languages with native voice recognition and synthesis'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onLiveSessionsPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Live Sessions'),
        content: const Text('Real-time collaboration with live editing and synchronization'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onDocumentSharingPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Document Sharing'),
        content: const Text('Secure document sharing with encryption and access control'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onCommentsPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Comments & Annotations'),
        content: const Text('Collaborative feedback with comments and annotations'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onVersionControlPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Version Control'),
        content: const Text('Document versioning with change tracking and history'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onUsageAnalyticsPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Usage Analytics'),
        content: const Text('Comprehensive usage analytics and insights'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onPerformanceMonitoringPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Performance Monitoring'),
        content: const Text('Real-time performance metrics and optimization'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onBusinessIntelligencePressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Business Intelligence'),
        content: const Text('Executive dashboards and business insights'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onMLInsightsPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ML Insights'),
        content: const Text('AI-powered insights and recommendations'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
