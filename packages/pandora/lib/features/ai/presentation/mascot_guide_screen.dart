import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora_ui/pandora_ui.dart';

class MascotGuideScreen extends ConsumerWidget {
  const MascotGuideScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mascot Guide'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
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
                          Icons.pets,
                          color: PandoraColors.primary500,
                          size: 32,
                        ),
                        const SizedBox(width: PTokens.spacingMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mascot Mèo Thông Minh',
                                style: PTokens.typography.headlineSmall,
                              ),
                              const SizedBox(height: PTokens.spacingXs),
                              Text(
                                'Bạn đồng hành AI trong ứng dụng ghi chú',
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
            
            // Features
            Text(
              'Tính năng chính',
              style: PTokens.typography.titleLarge,
            ),
            const SizedBox(height: PTokens.spacingMd),
            
            _buildFeatureItem(
              icon: Icons.auto_awesome,
              title: 'Tương tác thông minh',
              description: 'Mascot phản ứng khác nhau dựa trên hành động của bạn',
              color: PandoraColors.primary500,
            ),
            
            _buildFeatureItem(
              icon: Icons.psychology,
              title: 'Trạng thái cảm xúc',
              description: 'Mascot có các trạng thái cảm xúc: vui, buồn, hào hứng, mệt mỏi...',
              color: PandoraColors.success500,
            ),
            
            _buildFeatureItem(
              icon: Icons.touch_app,
              title: 'Tương tác đa dạng',
              description: 'Chạm, nhấn giữ, chạm đôi, vuốt để tương tác với mascot',
              color: PandoraColors.info500,
            ),
            
            _buildFeatureItem(
              icon: Icons.notifications,
              title: 'Thông báo thân thiện',
              description: 'Mascot hiển thị thông báo vui vẻ và hữu ích',
              color: PandoraColors.warning500,
            ),
            
            const SizedBox(height: PTokens.spacingLg),
            
            // Interactions
            Text(
              'Cách tương tác',
              style: PTokens.typography.titleLarge,
            ),
            const SizedBox(height: PTokens.spacingMd),
            
            _buildInteractionItem(
              'Chạm nhẹ',
              'Mascot sẽ vẫy tay chào và đưa ra lời khuyên hữu ích',
              Icons.touch_app,
            ),
            
            _buildInteractionItem(
              'Nhấn giữ',
              'Mascot sẽ ăn và cảm ơn bạn',
              Icons.touch_app,
            ),
            
            _buildInteractionItem(
              'Chạm đôi',
              'Mascot sẽ ăn mừng và tỏ ra rất vui',
              Icons.touch_app,
            ),
            
            _buildInteractionItem(
              'Vuốt',
              'Mascot sẽ tỏ ra hào hứng với cú vuốt của bạn',
              Icons.swipe,
            ),
            
            const SizedBox(height: PTokens.spacingLg),
            
            // States
            Text(
              'Trạng thái mascot',
              style: PTokens.typography.titleLarge,
            ),
            const SizedBox(height: PTokens.spacingMd),
            
            _buildStateItem(
              'Nghỉ ngơi',
              'Khi không có hoạt động trong 30 giây',
              Icons.bedtime,
              PandoraColors.neutral500,
            ),
            
            _buildStateItem(
              'Vui vẻ',
              'Khi bạn tạo ghi chú mới hoặc hoàn thành task',
              Icons.sentiment_very_satisfied,
              PandoraColors.success500,
            ),
            
            _buildStateItem(
              'Suy nghĩ',
              'Khi AI đang xử lý yêu cầu của bạn',
              Icons.psychology,
              PandoraColors.info500,
            ),
            
            _buildStateItem(
              'Hào hứng',
              'Khi bạn có nhiều ghi chú (20+ ghi chú)',
              Icons.celebration,
              PandoraColors.primary500,
            ),
            
            _buildStateItem(
              'Bối rối',
              'Khi có lỗi xảy ra trong ứng dụng',
              Icons.help_outline,
              PandoraColors.error500,
            ),
            
            const SizedBox(height: PTokens.spacingLg),
            
            // Tips
            PandoraCard(
              variant: PandoraCardVariant.filled,
              backgroundColor: PandoraColors.info50,
              borderColor: PandoraColors.info200,
              child: Padding(
                padding: const EdgeInsets.all(PTokens.spacingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb,
                          color: PandoraColors.info600,
                          size: 20,
                        ),
                        const SizedBox(width: PTokens.spacingSm),
                        Text(
                          'Mẹo sử dụng',
                          style: PTokens.typography.labelLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: PandoraColors.info700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: PTokens.spacingSm),
                    Text(
                      '• Mascot sẽ thay đổi trạng thái dựa trên số lượng ghi chú của bạn\n'
                      '• Tương tác thường xuyên để giữ mascot vui vẻ\n'
                      '• Mascot sẽ đưa ra lời khuyên hữu ích khi bạn cần\n'
                      '• Mỗi lần tương tác sẽ reset timer nghỉ ngơi',
                      style: PTokens.typography.bodySmall.copyWith(
                        color: PandoraColors.info600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PTokens.spacingMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(PTokens.spacingSm),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: PTokens.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: PTokens.typography.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: PTokens.spacingXs),
                Text(
                  description,
                  style: PTokens.typography.bodyMedium.copyWith(
                    color: PandoraColors.neutral600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionItem(
    String title,
    String description,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PTokens.spacingSm),
      child: Row(
        children: [
          Icon(
            icon,
            color: PandoraColors.primary500,
            size: 20,
          ),
          const SizedBox(width: PTokens.spacingSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: PTokens.typography.labelLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: PTokens.typography.bodySmall.copyWith(
                    color: PandoraColors.neutral600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStateItem(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PTokens.spacingSm),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(width: PTokens.spacingSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: PTokens.typography.labelLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  description,
                  style: PTokens.typography.bodySmall.copyWith(
                    color: PandoraColors.neutral600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
