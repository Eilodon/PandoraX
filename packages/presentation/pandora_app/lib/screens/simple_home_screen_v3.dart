import 'package:flutter/material.dart';
import 'package:design_tokens/design_tokens.dart';
import 'package:pandora_ui/pandora_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'enhanced_notes_screen.dart';
import 'ai_chat_screen.dart';
import 'voice_screen.dart';
import 'settings_screen.dart';
import '../providers/theme_provider.dart';
import '../widgets/animated_bottom_nav_bar.dart';

class SimpleHomeScreenV3 extends ConsumerStatefulWidget {
  const SimpleHomeScreenV3({super.key});

  @override
  ConsumerState<SimpleHomeScreenV3> createState() => _SimpleHomeScreenV3State();
}

class _SimpleHomeScreenV3State extends ConsumerState<SimpleHomeScreenV3> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: PandoraColors.onPrimary,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: PandoraColors.shadow.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.auto_awesome, color: PandoraColors.primary, size: 20),
            ),
            const SizedBox(width: 12),
            const Text('PandoraX'),
            const Spacer(),
            Consumer(
              builder: (context, ref, child) {
                final themeNotifier = ref.watch(themeProvider.notifier);
                return IconButton(
                  icon: Icon(themeNotifier.isDarkMode ? Icons.light_mode : Icons.dark_mode),
                  onPressed: () => themeNotifier.toggleTheme(),
                );
              },
            ),
          ],
        ),
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
      bottomNavigationBar: AnimatedBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
          ),
          BottomNavItem(
            icon: Icons.note_outlined,
            activeIcon: Icons.note,
            label: 'Notes',
          ),
          BottomNavItem(
            icon: Icons.smart_toy_outlined,
            activeIcon: Icons.smart_toy,
            label: 'AI',
          ),
          BottomNavItem(
            icon: Icons.mic_outlined,
            activeIcon: Icons.mic,
            label: 'Voice',
          ),
          BottomNavItem(
            icon: Icons.settings_outlined,
            activeIcon: Icons.settings,
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
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: PandoraColors.onPrimary,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: PandoraColors.shadow.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.auto_awesome, color: PandoraColors.primary, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to PandoraX',
                          style: PandoraTextStyles.headlineLarge.copyWith(
                            color: PandoraColors.onPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Your AI-powered note-taking assistant',
                          style: PandoraTextStyles.bodyLarge.copyWith(
                            color: PandoraColors.onPrimary.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: PandoraColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: PandoraColors.outline.withValues(alpha: 0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: PandoraColors.shadow.withValues(alpha: 0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: PandoraColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: PandoraColors.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: Icon(
                  icon,
                  color: PandoraColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: PandoraTextStyles.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: PandoraColors.onSurface,
                      ),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: PandoraColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: PandoraColors.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  'Tap',
                  style: PandoraTextStyles.bodySmall.copyWith(
                    color: PandoraColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
