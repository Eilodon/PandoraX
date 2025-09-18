import 'package:flutter/material.dart';
import 'package:design_tokens/design_tokens.dart';
import 'enhanced_notes_screen.dart';
import 'ai_chat_screen.dart';
import 'voice_screen.dart';
import 'settings_screen.dart';

class SimpleHomeScreenV3 extends StatefulWidget {
  const SimpleHomeScreenV3({super.key});

  @override
  State<SimpleHomeScreenV3> createState() => _SimpleHomeScreenV3State();
}

class _SimpleHomeScreenV3State extends State<SimpleHomeScreenV3> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PandoraX'),
        backgroundColor: PandoraColors.primary,
        foregroundColor: PandoraColors.onPrimary,
        elevation: 0,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeTab(),
          const EnhancedNotesScreen(),
          const AIChatScreen(),
          const VoiceScreen(),
          const SettingsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: PandoraColors.primary,
        unselectedItemColor: PandoraColors.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: 'AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            label: 'Voice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            PandoraColors.primary,
            PandoraColors.primary.withValues(alpha: 0.8),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to PandoraX',
                style: PandoraTextStyles.headlineLarge.copyWith(
                  color: PandoraColors.onPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your AI-powered note-taking assistant',
                style: PandoraTextStyles.bodyLarge.copyWith(
                  color: PandoraColors.onPrimary.withValues(alpha: 0.9),
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Column(
                  children: [
                    _buildFeatureCard(
                      icon: Icons.note_add,
                      title: 'Smart Notes',
                      description: 'Create and organize your notes with AI assistance',
                      onTap: () => setState(() => _selectedIndex = 1),
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureCard(
                      icon: Icons.smart_toy,
                      title: 'AI Assistant',
                      description: 'Get intelligent suggestions and help',
                      onTap: () => setState(() => _selectedIndex = 2),
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureCard(
                      icon: Icons.mic,
                      title: 'Voice Notes',
                      description: 'Record and transcribe voice notes',
                      onTap: () => setState(() => _selectedIndex = 3),
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureCard(
                      icon: Icons.settings,
                      title: 'Settings',
                      description: 'Customize your experience',
                      onTap: () => setState(() => _selectedIndex = 4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: PandoraColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: PandoraColors.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: PandoraTextStyles.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: PandoraTextStyles.bodyMedium.copyWith(
                        color: PandoraColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: PandoraColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
