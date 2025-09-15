// file: packages/pandora_ui/lib/src/widgets_demo.dart
import 'package:flutter/material.dart';
import 'package:pandora_ui/src/tokens.dart';
import 'widgets/widgets.dart';
import 'package:pandora_ui/pandora_ui.dart';

/// Demo widget showcasing all Pandora 4 Widget Components
/// 
/// This widget demonstrates the "Đúc Kiếm" (Sword Forging) phase
/// where core components are built and ready for use.
class WidgetsDemo extends StatefulWidget {
  const WidgetsDemo({super.key});

  @override
  State<WidgetsDemo> createState() => _WidgetsDemoState();
}

class _WidgetsDemoState extends State<WidgetsDemo> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double _progressValue = 0.3;
  bool _chipSelected = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Pandora 4 - Widget Components'),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.onSurface,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Security', icon: Icon(Icons.security)),
            Tab(text: 'Badges', icon: Icon(Icons.label)),
            Tab(text: 'Avatars', icon: Icon(Icons.person)),
            Tab(text: 'Controls', icon: Icon(Icons.toggle_on)),
            Tab(text: 'Results', icon: Icon(Icons.article)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSecurityTab(),
          _buildBadgesTab(),
          _buildAvatarsTab(),
          _buildControlsTab(),
          _buildResultsTab(),
        ],
      ),
    );
  }

  Widget _buildSecurityTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Security Cues', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Text('Different security levels with appropriate colors and icons'),
          const SizedBox(height: 24),
          
          // Security Cues
          const Text('Security Levels', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SecurityCue(level: SecurityLevel.onDevice),
              SecurityCue(level: SecurityLevel.hybrid),
              SecurityCue(level: SecurityLevel.cloud),
            ],
          ),
          const SizedBox(height: 24),
          
          // Usage Examples
          const Text('Usage Examples', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Note Security', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  const Text('This note is stored securely on your device.'),
                  const SizedBox(height: 12),
                  SecurityCue(level: SecurityLevel.onDevice),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Cloud Sync', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  const Text('This data is synced to the cloud with encryption.'),
                  const SizedBox(height: 12),
                  SecurityCue(level: SecurityLevel.cloud),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Pandora Badges', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Text('Versatile badge components for status, categories, and labels'),
          const SizedBox(height: 24),
          
          // Badge Variants
          const Text('Badge Variants', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              PandoraBadge(text: 'Primary', variant: PandoraBadgeVariant.primary),
              PandoraBadge(text: 'Secondary', variant: PandoraBadgeVariant.secondary),
              PandoraBadge(text: 'Success', variant: PandoraBadgeVariant.success),
              PandoraBadge(text: 'Warning', variant: PandoraBadgeVariant.warning),
              PandoraBadge(text: 'Error', variant: PandoraBadgeVariant.error),
              PandoraBadge(text: 'Info', variant: PandoraBadgeVariant.info),
            ],
          ),
          const SizedBox(height: 24),
          
          // Badge Sizes
          const Text('Badge Sizes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              PandoraBadge(text: 'Small', size: PandoraBadgeSize.small),
              PandoraBadge(text: 'Medium', size: PandoraBadgeSize.medium),
              PandoraBadge(text: 'Large', size: PandoraBadgeSize.large),
            ],
          ),
          const SizedBox(height: 24),
          
          // Badges with Icons
          const Text('Badges with Icons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              PandoraBadge(
                text: 'New',
                variant: PandoraBadgeVariant.success,
                icon: Icons.new_releases,
              ),
              PandoraBadge(
                text: 'Updated',
                variant: PandoraBadgeVariant.info,
                icon: Icons.update,
              ),
              PandoraBadge(
                text: 'Important',
                variant: PandoraBadgeVariant.warning,
                icon: Icons.priority_high,
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Interactive Badges
          const Text('Interactive Badges', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              PandoraBadge(
                text: 'Clickable',
                variant: PandoraBadgeVariant.primary,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Badge tapped!')),
                  );
                },
              ),
              PandoraBadge(
                text: 'Disabled',
                variant: PandoraBadgeVariant.secondary,
                enabled: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Pandora Avatars', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Text('User avatar components with multiple display options'),
          const SizedBox(height: 24),
          
          // Avatar Sizes
          const Text('Avatar Sizes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Row(
            children: [
              PandoraAvatar(
                initials: 'JD',
                size: PandoraAvatarSize.small,
              ),
              const SizedBox(width: 16),
              PandoraAvatar(
                initials: 'JD',
                size: PandoraAvatarSize.medium,
              ),
              const SizedBox(width: 16),
              PandoraAvatar(
                initials: 'JD',
                size: PandoraAvatarSize.large,
              ),
              const SizedBox(width: 16),
              PandoraAvatar(
                initials: 'JD',
                size: PandoraAvatarSize.extraLarge,
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Avatar Types
          const Text('Avatar Types', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Row(
            children: [
              PandoraAvatar(
                initials: 'AB',
                backgroundColor: AppColors.primary,
              ),
              const SizedBox(width: 16),
              PandoraAvatar(
                icon: Icons.person,
                backgroundColor: AppColors.accent,
              ),
              const SizedBox(width: 16),
              PandoraAvatar(
                imageUrl: 'https://via.placeholder.com/100',
                backgroundColor: AppColors.secureOnDevice,
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Avatars with Borders
          const Text('Avatars with Borders', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Row(
            children: [
              PandoraAvatar(
                initials: 'AB',
                showBorder: true,
                borderColor: AppColors.primary,
              ),
              const SizedBox(width: 16),
              PandoraAvatar(
                initials: 'CD',
                showBorder: true,
                borderColor: AppColors.accent,
                borderWidth: 3,
              ),
              const SizedBox(width: 16),
              PandoraAvatar(
                initials: 'EF',
                showBorder: true,
                borderColor: AppColors.secureOnDevice,
                borderWidth: 2,
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Interactive Avatars
          const Text('Interactive Avatars', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Row(
            children: [
              PandoraAvatar(
                initials: 'AB',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Avatar tapped!')),
                  );
                },
              ),
              const SizedBox(width: 16),
              PandoraAvatar(
                icon: Icons.add,
                backgroundColor: AppColors.primary,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Add avatar tapped!')),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControlsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Control Components', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Text('Interactive control components for user input and feedback'),
          const SizedBox(height: 24),
          
          // Chips
          const Text('Pandora Chips', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              PandoraChip(
                label: 'Default',
                onTap: () {},
              ),
              PandoraChip(
                label: 'Selected',
                selected: _chipSelected,
                onTap: () {
                  setState(() {
                    _chipSelected = !_chipSelected;
                  });
                },
              ),
              PandoraChip(
                label: 'With Icon',
                leadingIcon: Icons.star,
                onTap: () {},
              ),
              PandoraChip(
                label: 'Outlined',
                variant: PandoraChipVariant.outlined,
                onTap: () {},
              ),
              PandoraChip(
                label: 'Elevated',
                variant: PandoraChipVariant.elevated,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Dividers
          const Text('Pandora Dividers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          const Text('Content above divider'),
          PandoraDivider(),
          const Text('Content below divider'),
          const SizedBox(height: 16),
          const Text('Divider with text'),
          PandoraDivider(text: 'OR'),
          const SizedBox(height: 16),
          const Text('Vertical divider'),
          Row(
            children: [
              const Text('Left'),
              PandoraDivider(type: PandoraDividerType.vertical),
              const Text('Right'),
            ],
          ),
          const SizedBox(height: 24),
          
          // Progress Bars
          const Text('Progress Bars', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          PandoraProgressBar(
            value: _progressValue,
            label: 'Linear Progress',
            showPercentage: true,
          ),
          const SizedBox(height: 16),
          PandoraProgressBar(
            value: _progressValue,
            variant: PandoraProgressBarVariant.circular,
            label: 'Circular Progress',
            showPercentage: true,
          ),
          const SizedBox(height: 16),
          Slider(
            value: _progressValue,
            onChanged: (value) {
              setState(() {
                _progressValue = value;
              });
            },
          ),
          const SizedBox(height: 24),
          
          // Tooltips
          const Text('Tooltips', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Row(
            children: [
              PandoraTooltip(
                message: 'This is a tooltip',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Hover me'),
                ),
              ),
              const SizedBox(width: 16),
              PandoraTooltip(
                message: 'Tooltip on the right',
                position: PandoraTooltipPosition.right,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.help),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Result Cards', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Text('Dynamic result cards with loading states and security indicators'),
          const SizedBox(height: 24),
          
          // Loading State
          const Text('Loading State', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          const Text('Shimmer loading animation while content is being fetched'),
          const SizedBox(height: 8),
          ShimmerResultCard(),
          const SizedBox(height: 24),
          
          // Basic Result Card
          const Text('Basic Result Card', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          ResultCard(
            title: 'AI Generated Summary',
            subtitle: 'This is a comprehensive summary of your document with key insights and main points highlighted for easy understanding.',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Result card tapped!')),
              );
            },
          ),
          const SizedBox(height: 16),
          
          // Result Card with Security Cue
          const Text('Result Card with Security', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          ResultCard(
            title: 'Secure Document Analysis',
            subtitle: 'Your document has been analyzed using on-device processing to ensure maximum privacy and security.',
            securityCue: SecurityCue(level: SecurityLevel.onDevice),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Secure result card tapped!')),
              );
            },
          ),
          const SizedBox(height: 16),
          
          // Result Card with Cancel Option
          const Text('Streaming Result Card', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          ResultCard(
            title: 'Live AI Response',
            subtitle: 'AI is currently generating a response. This may take a few moments to complete.',
            securityCue: SecurityCue(level: SecurityLevel.hybrid),
            onCancel: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Streaming cancelled!')),
              );
            },
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Streaming result tapped!')),
              );
            },
          ),
          const SizedBox(height: 16),
          
          // Cloud Result Card
          ResultCard(
            title: 'Cloud Processed Data',
            subtitle: 'This result was processed using cloud-based AI services with enterprise-grade security.',
            securityCue: SecurityCue(level: SecurityLevel.cloud),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cloud result tapped!')),
              );
            },
          ),
          const SizedBox(height: 24),
          
          // Usage Examples
          const Text('Usage Examples', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Code Example', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: PTokens.radius.chip,
                    ),
                    child: const Text(
                      '''ResultCard(
  title: 'AI Summary',
  subtitle: 'Generated summary text...',
  securityCue: SecurityCue(level: SecurityLevel.onDevice),
  onTap: () => handleTap(),
)''',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
