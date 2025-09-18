/// Architecture Demo for Phase 4
/// 
/// This file demonstrates the simplified architecture with
/// state management, service locator, and design system.
library architecture_demo;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_domain/note_domain.dart';
import '../design_system/design_tokens.dart';
import '../design_system/theme_manager.dart';
import '../utils/common_utils.dart';

/// Architecture demo screen
class ArchitectureDemo extends ConsumerWidget {
  const ArchitectureDemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final themeManager = ThemeManager.instance;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phase 4: Architecture Demo'),
        backgroundColor: DesignTokens.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DesignTokens.spacing6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // State Management Section
            _buildSection(
              title: 'State Management',
              children: [
                _buildInfoCard(
                  title: 'App State',
                  content: 'Current state: ${appState.currentScreen}',
                  color: DesignTokens.primary,
                ),
                _buildInfoCard(
                  title: 'User',
                  content: appState.user?.name ?? 'Not logged in',
                  color: DesignTokens.secondary,
                ),
                _buildInfoCard(
                  title: 'Notes Count',
                  content: '${appState.notes.length} notes',
                  color: DesignTokens.info,
                ),
                _buildInfoCard(
                  title: 'Theme Mode',
                  content: appState.isDarkMode ? 'Dark' : 'Light',
                  color: DesignTokens.warning,
                ),
              ],
            ),
            
            const SizedBox(height: DesignTokens.spacing8),
            
            // Service Locator Section
            _buildSection(
              title: 'Service Locator',
              children: [
                _buildInfoCard(
                  title: 'Theme Service',
                  content: 'Theme mode: ${themeManager.isDarkMode ? 'Dark' : 'Light'}',
                  color: DesignTokens.primary,
                ),
                _buildInfoCard(
                  title: 'AI Service',
                  content: 'Available for AI operations',
                  color: DesignTokens.secondary,
                ),
                _buildInfoCard(
                  title: 'Analytics Service',
                  content: 'Tracking user behavior',
                  color: DesignTokens.info,
                ),
              ],
            ),
            
            const SizedBox(height: DesignTokens.spacing8),
            
            // Design System Section
            _buildSection(
              title: 'Design System',
              children: [
                _buildInfoCard(
                  title: 'Design Tokens',
                  content: 'Consistent colors, spacing, typography',
                  color: DesignTokens.primary,
                ),
                _buildInfoCard(
                  title: 'Theme Manager',
                  content: 'Centralized theme management',
                  color: DesignTokens.secondary,
                ),
                _buildInfoCard(
                  title: 'Common Utils',
                  content: '${CommonUtils.generateId().substring(0, 8)}...',
                  color: DesignTokens.info,
                ),
              ],
            ),
            
            const SizedBox(height: DesignTokens.spacing8),
            
            // Actions Section
            _buildSection(
              title: 'Actions',
              children: [
                _buildActionButton(
                  title: 'Toggle Theme',
                  onPressed: () {
                    themeManager.toggleTheme();
                    ref.read(appStateProvider.notifier).toggleDarkMode();
                  },
                  color: DesignTokens.primary,
                ),
                _buildActionButton(
                  title: 'Add Sample Note',
                  onPressed: () {
                    final note = Note(
                      id: CommonUtils.generateId(),
                      title: 'Sample Note ${appState.notes.length + 1}',
                      content: 'This is a sample note created in Phase 4 demo.',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    );
                    ref.read(appStateProvider.notifier).addNote(note);
                  },
                  color: DesignTokens.secondary,
                ),
                _buildActionButton(
                  title: 'Clear Notes',
                  onPressed: () {
                    ref.read(appStateProvider.notifier).reset();
                  },
                  color: DesignTokens.error,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: DesignTokens.fontSize2Xl,
            fontWeight: DesignTokens.fontWeightBold,
            color: DesignTokens.neutral900,
          ),
        ),
        const SizedBox(height: DesignTokens.spacing4),
        ...children,
      ],
    );
  }
  
  Widget _buildInfoCard({
    required String title,
    required String content,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing3),
      padding: const EdgeInsets.all(DesignTokens.spacing4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: DesignTokens.spacing4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: DesignTokens.fontSizeBase,
                    fontWeight: DesignTokens.fontWeightSemiBold,
                    color: DesignTokens.neutral900,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing1),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: DesignTokens.fontSizeSm,
                    color: DesignTokens.neutral600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionButton({
    required String title,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing3),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spacing6,
            vertical: DesignTokens.spacing3,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: DesignTokens.fontSizeBase,
            fontWeight: DesignTokens.fontWeightMedium,
          ),
        ),
      ),
    );
  }
}
