import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora_ui/pandora_ui.dart';
import 'ai_note_generator_screen.dart';
import 'voice_commands_screen.dart';
import 'mascot_interaction_screen.dart';
import 'mascot_guide_screen.dart';
import '../../../widgets/mascot_widget.dart';

class AiFeaturesOverviewScreen extends ConsumerWidget {
  const AiFeaturesOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Features'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(PTokens.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            PandoraCard(
              variant: PandoraCardVariant.elevated,
              child: Padding(
                padding: const EdgeInsets.all(PTokens.spacingLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          color: PandoraColors.primary500,
                          size: 32,
                        ),
                        const SizedBox(width: PTokens.spacingMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'AI Features Overview',
                                style: PTokens.typography.headlineSmall,
                              ),
                              const SizedBox(height: PTokens.spacingXs),
                              Text(
                                'Khám phá các tính năng AI nâng cao',
                                style: PTokens.typography.bodyMedium.copyWith(
                                  color: PandoraColors.neutral600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: PTokens.spacingLg),
            
            // Features grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: PTokens.spacingMd,
                mainAxisSpacing: PTokens.spacingMd,
                children: [
                  _buildFeatureCard(
                    context: context,
                    title: 'AI Note Generator',
                    description: 'Tạo ghi chú tự động từ mô tả',
                    icon: Icons.auto_awesome,
                    color: PandoraColors.primary500,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AiNoteGeneratorScreen(),
                        ),
                      );
                    },
                  ),
                  
                  _buildFeatureCard(
                    context: context,
                    title: 'Voice Commands',
                    description: 'Điều khiển bằng giọng nói',
                    icon: Icons.mic,
                    color: PandoraColors.secondary500,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const VoiceCommandsScreen(),
                        ),
                      );
                    },
                  ),
                  
                  _buildFeatureCard(
                    context: context,
                    title: 'Smart Reminders',
                    description: 'Nhắc nhở thông minh với AI',
                    icon: Icons.smart_toy,
                    color: PandoraColors.success500,
                    onTap: () {
                      // TODO: Navigate to smart reminders
                      PandoraSnackbar.show(
                        context,
                        message: 'Tính năng Smart Reminders có sẵn trong màn hình chi tiết ghi chú',
                        variant: PandoraSnackbarVariant.info,
                      );
                    },
                  ),
                  
                  _buildFeatureCard(
                    context: context,
                    title: 'Location Reminders',
                    description: 'Nhắc nhở theo vị trí',
                    icon: Icons.location_on,
                    color: PandoraColors.warning500,
                    onTap: () {
                      // TODO: Navigate to location reminders
                      PandoraSnackbar.show(
                        context,
                        message: 'Tính năng Location Reminders có sẵn trong màn hình chi tiết ghi chú',
                        variant: PandoraSnackbarVariant.info,
                      );
                    },
                  ),
                  
                  _buildFeatureCard(
                    context: context,
                    title: 'Auto Categorization',
                    description: 'Phân loại ghi chú tự động',
                    icon: Icons.category,
                    color: PandoraColors.info500,
                    onTap: () {
                      PandoraSnackbar.show(
                        context,
                        message: 'Tính năng Auto Categorization được tích hợp trong AI Note Generator',
                        variant: PandoraSnackbarVariant.info,
                      );
                    },
                  ),
                  
                  _buildFeatureCard(
                    context: context,
                    title: 'Smart Suggestions',
                    description: 'Đề xuất nội dung thông minh',
                    icon: Icons.lightbulb,
                    color: PandoraColors.error500,
                    onTap: () {
                      PandoraSnackbar.show(
                        context,
                        message: 'Tính năng Smart Suggestions được tích hợp trong AI Note Generator',
                        variant: PandoraSnackbarVariant.info,
                      );
                    },
                  ),
                  
                  _buildFeatureCard(
                    context: context,
                    title: 'Mascot Interaction',
                    description: 'Tương tác với mascot mèo',
                    icon: Icons.pets,
                    color: PandoraColors.secondary500,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MascotInteractionScreen(),
                        ),
                      );
                    },
                  ),
                  
                  _buildFeatureCard(
                    context: context,
                    title: 'Mascot Guide',
                    description: 'Hướng dẫn sử dụng mascot',
                    icon: Icons.help_outline,
                    color: PandoraColors.info500,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MascotGuideScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return PandoraCard(
      variant: PandoraCardVariant.elevated,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(PTokens.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: PandoraColors.neutral400,
                  size: 16,
                ),
              ],
            ),
            const SizedBox(height: PTokens.spacingMd),
            Text(
              title,
              style: PTokens.typography.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: PTokens.spacingXs),
            Text(
              description,
              style: PTokens.typography.bodySmall.copyWith(
                color: PandoraColors.neutral600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
