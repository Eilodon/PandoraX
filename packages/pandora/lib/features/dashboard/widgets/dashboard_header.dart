import 'package:flutter/material.dart';
import 'package:pandora_ui/pandora_ui.dart';
import '../presentation/dashboard_screen.dart';

/// 🎮 Dashboard Header Widget
/// 
/// Hiển thị thông tin người dùng, thanh HP/XP, và số Gold/Gems
/// Tạo cảm giác như một game RPG với progression system
class DashboardHeader extends StatelessWidget {
  final UserStats userStats;
  final VoidCallback onAvatarTap;

  const DashboardHeader({
    super.key,
    required this.userStats,
    required this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: PTokens.spacingLg,
        vertical: PTokens.spacingMd,
      ),
      child: Row(
        children: [
          // User Avatar
          _buildUserAvatar(),
          
          const SizedBox(width: PTokens.spacingMd),
          
          // User Info & Stats
          Expanded(
            child: _buildUserInfo(),
          ),
          
          const SizedBox(width: PTokens.spacingMd),
          
          // Currency (Gold & Gems)
          _buildCurrency(),
        ],
      ),
    );
  }

  /// Build user avatar
  Widget _buildUserAvatar() {
    return GestureDetector(
      onTap: onAvatarTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              PandoraColors.primary400,
              PandoraColors.primary600,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: PandoraColors.primary200.withValues(alpha: 0.5),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Avatar background
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PandoraColors.primary100,
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 30,
              ),
            ),
            
            // Level badge
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amber,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    '${userStats.level}',
                    style: PTokens.typography.labelSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build user info section
  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Welcome message
        Text(
          _getGreeting(),
          style: PTokens.typography.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: PandoraColors.neutral700,
          ),
        ),
        
        const SizedBox(height: PTokens.spacingXs),
        
        // XP Progress Bar
        _buildXPProgressBar(),
        
        const SizedBox(height: PTokens.spacingXs),
        
        // HP Progress Bar
        _buildHPProgressBar(),
        
        const SizedBox(height: PTokens.spacingXs),
        
        // Streak info
        _buildStreakInfo(),
      ],
    );
  }

  /// Build XP progress bar
  Widget _buildXPProgressBar() {
    final xpProgress = userStats.maxExperience > 0 
        ? userStats.experience / userStats.maxExperience 
        : 0.0;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'XP',
              style: PTokens.typography.labelSmall.copyWith(
                fontWeight: FontWeight.w500,
                color: PandoraColors.neutral600,
              ),
            ),
            Text(
              '${userStats.experience}/${userStats.maxExperience}',
              style: PTokens.typography.labelSmall.copyWith(
                fontWeight: FontWeight.w500,
                color: PandoraColors.neutral600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        PandoraProgressBar(
          value: xpProgress,
          backgroundColor: PandoraColors.neutral200,
          valueColor: Colors.blue,
          height: 6,
        ),
      ],
    );
  }

  /// Build HP progress bar
  Widget _buildHPProgressBar() {
    final hpProgress = userStats.maxHealthPoints > 0 
        ? userStats.healthPoints / userStats.maxHealthPoints 
        : 0.0;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'HP',
              style: PTokens.typography.labelSmall.copyWith(
                fontWeight: FontWeight.w500,
                color: PandoraColors.neutral600,
              ),
            ),
            Text(
              '${userStats.healthPoints}/${userStats.maxHealthPoints}',
              style: PTokens.typography.labelSmall.copyWith(
                fontWeight: FontWeight.w500,
                color: PandoraColors.neutral600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        PandoraProgressBar(
          value: hpProgress,
          backgroundColor: PandoraColors.neutral200,
          valueColor: _getHPColor(hpProgress),
          height: 6,
        ),
      ],
    );
  }

  /// Build streak info
  Widget _buildStreakInfo() {
    return Row(
      children: [
        Icon(
          Icons.local_fire_department,
          color: Colors.orange,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          '${userStats.streakDays} day streak',
          style: PTokens.typography.bodySmall.copyWith(
            color: Colors.orange.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Build currency section
  Widget _buildCurrency() {
    return Column(
      children: [
        // Gold
        _buildCurrencyItem(
          icon: Icons.monetization_on,
          value: userStats.gold,
          color: Colors.yellow.shade600,
          label: 'Gold',
        ),
        
        const SizedBox(height: PTokens.spacingXs),
        
        // Gems
        _buildCurrencyItem(
          icon: Icons.diamond,
          value: userStats.gems,
          color: Colors.cyan,
          label: 'Gems',
        ),
      ],
    );
  }

  /// Build individual currency item
  Widget _buildCurrencyItem({
    required IconData icon,
    required int value,
    required Color color,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: PTokens.spacingSm,
        vertical: PTokens.spacingXs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            _formatCurrency(value),
            style: PTokens.typography.labelMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// Get greeting based on time of day
  String _getGreeting() {
    final hour = DateTime.now().hour;
    
    if (hour >= 5 && hour < 12) {
      return 'Good Morning! 🌅';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon! ☀️';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening! 🌆';
    } else {
      return 'Good Night! 🌙';
    }
  }

  /// Get HP color based on percentage
  Color _getHPColor(double progress) {
    if (progress > 0.6) {
      return Colors.green;
    } else if (progress > 0.3) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  /// Format currency value
  String _formatCurrency(int value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    } else {
      return value.toString();
    }
  }
}
