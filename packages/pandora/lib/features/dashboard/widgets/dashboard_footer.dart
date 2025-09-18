import 'package:flutter/material.dart';
import 'package:pandora_ui/pandora_ui.dart';

/// 🧭 Dashboard Footer Widget
/// 
/// Navigation bar tối giản với 3 mục chính:
/// - Dashboard (màn hình chính)
/// - Hành trình (bản đồ phiêu lưu/lịch)
/// - Xã hội (Hiệp ước/Guilds)
class DashboardFooter extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChanged;

  const DashboardFooter({
    super.key,
    required this.currentIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(PTokens.spacingMd),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: PTokens.spacingMd,
          vertical: PTokens.spacingSm,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home, 'Dashboard', '🏠'),
            _buildNavItem(1, Icons.map, 'Journey', '🗺️'),
            _buildNavItem(2, Icons.people, 'Social', '👥'),
          ],
        ),
      ),
    );
  }

  /// Build navigation item
  Widget _buildNavItem(int index, IconData icon, String label, String emoji) {
    final isSelected = currentIndex == index;
    
    return GestureDetector(
      onTap: () => onTabChanged(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: PTokens.spacingMd,
          vertical: PTokens.spacingSm,
        ),
        decoration: BoxDecoration(
          color: isSelected 
              ? PandoraColors.primary100.withValues(alpha: 0.8)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon with emoji
            Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? PandoraColors.primary600
                        : PandoraColors.neutral300,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.white : PandoraColors.neutral600,
                    size: 18,
                  ),
                ),
                // Emoji overlay
                Positioned(
                  top: -2,
                  right: -2,
                  child: Text(
                    emoji,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 4),
            
            // Label
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: PTokens.typography.bodySmall.copyWith(
                color: isSelected 
                    ? PandoraColors.primary700
                    : PandoraColors.neutral500,
                fontWeight: isSelected 
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}

/// Navigation items data
class NavigationItem {
  final int index;
  final IconData icon;
  final String label;
  final String emoji;
  final String route;

  const NavigationItem({
    required this.index,
    required this.icon,
    required this.label,
    required this.emoji,
    required this.route,
  });
}

/// Navigation items configuration
class NavigationConfig {
  static const List<NavigationItem> items = [
    NavigationItem(
      index: 0,
      icon: Icons.home,
      label: 'Dashboard',
      emoji: '🏠',
      route: '/dashboard',
    ),
    NavigationItem(
      index: 1,
      icon: Icons.map,
      label: 'Journey',
      emoji: '🗺️',
      route: '/journey',
    ),
    NavigationItem(
      index: 2,
      icon: Icons.people,
      label: 'Social',
      emoji: '👥',
      route: '/social',
    ),
  ];
}
