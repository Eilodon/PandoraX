import 'package:flutter/material.dart';
import '../services/mobile_optimization_service.dart';
import '../services/responsive_service.dart';
import '../components/mobile/mobile_first_card.dart';
import '../components/mobile/mobile_first_text_field.dart';
import '../components/mobile/mobile_first_navigation.dart';
import '../tokens/color_tokens.dart';
import '../tokens/typography_tokens.dart';
import '../tokens/spacing_tokens.dart';

/// Mobile-First Demo
/// 
/// Comprehensive demo showcasing Phase 2 mobile-first features
/// including responsive design, touch optimization, and mobile UX enhancements
class MobileFirstDemo extends StatefulWidget {
  const MobileFirstDemo({super.key});

  @override
  State<MobileFirstDemo> createState() => _MobileFirstDemoState();
}

class _MobileFirstDemoState extends State<MobileFirstDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  final TextEditingController _textController = TextEditingController();
  int _selectedIndex = 0;
  MobileBreakpoint _currentBreakpoint = MobileBreakpoint.mobile;
  MobileSize _currentSize = MobileSize.regular;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    _currentBreakpoint = MobileOptimizationService.getMobileBreakpoint(screenWidth);
    
    return Scaffold(
      backgroundColor: PandoraColors.neutral50,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildContent(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildBreakpointInfo(),
          const SizedBox(height: 24),
          _buildSizeSelector(),
          const SizedBox(height: 24),
          _buildCardsSection(),
          const SizedBox(height: 24),
          _buildTextFieldsSection(),
          const SizedBox(height: 24),
          _buildNavigationSection(),
          const SizedBox(height: 24),
          _buildPerformanceInfo(),
          const SizedBox(height: 100), // Space for bottom navigation
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mobile-First Demo',
          style: PandoraTypography.headlineLarge.copyWith(
            color: PandoraColors.neutral900,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Phase 2: Advanced Mobile-First & Responsive Design',
          style: PandoraTypography.titleMedium.copyWith(
            color: PandoraColors.neutral600,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: PandoraColors.primary50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: PandoraColors.primary200),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: PandoraColors.primary600,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'This demo showcases advanced mobile-first features including responsive design, touch optimization, and mobile UX enhancements.',
                  style: PandoraTypography.bodyMedium.copyWith(
                    color: PandoraColors.primary700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBreakpointInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PandoraColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: PandoraColors.neutral200.withValues(alpha:(0.5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Breakpoint',
            style: PandoraTypography.titleMedium.copyWith(
              color: PandoraColors.neutral900,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                _getBreakpointIcon(_currentBreakpoint),
                color: _getBreakpointColor(_currentBreakpoint),
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                _getBreakpointName(_currentBreakpoint),
                style: PandoraTypography.titleSmall.copyWith(
                  color: _getBreakpointColor(_currentBreakpoint),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getBreakpointColor(_currentBreakpoint).withValues(alpha:(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${MediaQuery.of(context).size.width.toInt()}px',
                  style: PandoraTypography.labelSmall.copyWith(
                    color: _getBreakpointColor(_currentBreakpoint),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSizeSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PandoraColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: PandoraColors.neutral200.withValues(alpha:(0.5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Size Selector',
            style: PandoraTypography.titleMedium.copyWith(
              color: PandoraColors.neutral900,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: MobileSize.values.map((size) {
              final isSelected = _currentSize == size;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentSize = size;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? PandoraColors.primary500 : PandoraColors.neutral100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? PandoraColors.primary500 : PandoraColors.neutral300,
                    ),
                  ),
                  child: Text(
                    size.name.toUpperCase(),
                    style: PandoraTypography.labelSmall.copyWith(
                      color: isSelected ? PandoraColors.white : PandoraColors.neutral700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mobile-First Cards',
          style: PandoraTypography.titleLarge.copyWith(
            color: PandoraColors.neutral900,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildCardsGrid(),
      ],
    );
  }

  Widget _buildCardsGrid() {
    final cards = [
      {
        'title': 'Elevated Card',
        'subtitle': 'With touch feedback',
        'variant': MobileCardVariant.elevated,
        'icon': Icons.card_giftcard,
      },
      {
        'title': 'Filled Card',
        'subtitle': 'With haptic feedback',
        'variant': MobileCardVariant.filled,
        'icon': Icons.inbox,
      },
      {
        'title': 'Primary Card',
        'subtitle': 'With ripple effect',
        'variant': MobileCardVariant.primary,
        'icon': Icons.star,
      },
      {
        'title': 'Secondary Card',
        'subtitle': 'With scale animation',
        'variant': MobileCardVariant.secondary,
        'icon': Icons.favorite,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getGridColumns(),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: _getCardAspectRatio(),
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return MobileFirstCard(
          variant: card['variant'] as MobileCardVariant,
          size: _getCardSize(),
          breakpoint: _currentBreakpoint,
          mobileSize: _currentSize,
          tabletSize: _currentSize,
          desktopSize: _currentSize,
          largeDesktopSize: _currentSize,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${card['title']} tapped!'),
                backgroundColor: PandoraColors.primary500,
              ),
            );
          },
          leading: Icon(
            card['icon'] as IconData,
            color: PandoraColors.white,
            size: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                card['title'] as String,
                style: PandoraTypography.titleMedium.copyWith(
                  color: PandoraColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                card['subtitle'] as String,
                style: PandoraTypography.bodySmall.copyWith(
                  color: PandoraColors.white.withValues(alpha:(0.8),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextFieldsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mobile-First Text Fields',
          style: PandoraTypography.titleLarge.copyWith(
            color: PandoraColors.neutral900,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildTextFieldsGrid(),
      ],
    );
  }

  Widget _buildTextFieldsGrid() {
    return Column(
      children: [
        MobileFirstTextField(
          variant: MobileTextFieldVariant.outlined,
          size: _getTextFieldSize(),
          breakpoint: _currentBreakpoint,
          mobileSize: _currentSize,
          tabletSize: _currentSize,
          desktopSize: _currentSize,
          largeDesktopSize: _currentSize,
          label: 'Outlined Text Field',
          hint: 'Enter your text here',
          controller: _textController,
          prefixIcon: const Icon(Icons.edit),
        ),
        const SizedBox(height: 16),
        MobileFirstTextField(
          variant: MobileTextFieldVariant.filled,
          size: _getTextFieldSize(),
          breakpoint: _currentBreakpoint,
          mobileSize: _currentSize,
          tabletSize: _currentSize,
          desktopSize: _currentSize,
          largeDesktopSize: _currentSize,
          label: 'Filled Text Field',
          hint: 'With haptic feedback',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: const Icon(Icons.clear),
        ),
        const SizedBox(height: 16),
        MobileFirstTextField(
          variant: MobileTextFieldVariant.primary,
          size: _getTextFieldSize(),
          breakpoint: _currentBreakpoint,
          mobileSize: _currentSize,
          tabletSize: _currentSize,
          desktopSize: _currentSize,
          largeDesktopSize: _currentSize,
          label: 'Primary Text Field',
          hint: 'With ripple effect',
          prefixIcon: const Icon(Icons.person),
          suffixIcon: const Icon(Icons.visibility),
        ),
      ],
    );
  }

  Widget _buildNavigationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mobile-First Navigation',
          style: PandoraTypography.titleLarge.copyWith(
            color: PandoraColors.neutral900,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        MobileFirstNavigation(
          type: MobileNavigationType.bottom,
          variant: MobileNavigationVariant.elevated,
          size: _getNavigationSize(),
          breakpoint: _currentBreakpoint,
          mobileSize: _currentSize,
          tabletSize: _currentSize,
          desktopSize: _currentSize,
          largeDesktopSize: _currentSize,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            MobileNavigationItem(
              icon: Icons.home,
              label: 'Home',
            ),
            MobileNavigationItem(
              icon: Icons.search,
              label: 'Search',
            ),
            MobileNavigationItem(
              icon: Icons.favorite,
              label: 'Favorites',
            ),
            MobileNavigationItem(
              icon: Icons.person,
              label: 'Profile',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPerformanceInfo() {
    final performanceSettings = MobileOptimizationService.getMobilePerformanceSettings(
      _currentBreakpoint,
      size: _currentSize,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PandoraColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: PandoraColors.neutral200.withValues(alpha:(0.5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance Settings',
            style: PandoraTypography.titleMedium.copyWith(
              color: PandoraColors.neutral900,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildPerformanceItem('Animations', performanceSettings.enableAnimations),
          _buildPerformanceItem('Haptic Feedback', performanceSettings.enableHapticFeedback),
          _buildPerformanceItem('Ripple Effects', performanceSettings.enableRippleEffects),
          _buildPerformanceItem('Scale Animations', performanceSettings.enableScaleAnimations),
          _buildPerformanceItem('Parallax', performanceSettings.enableParallax),
          _buildPerformanceItem('Blur Effects', performanceSettings.enableBlurEffects),
          _buildPerformanceItem('Shadows', performanceSettings.enableShadows),
          _buildPerformanceItem('Gradients', performanceSettings.enableGradients),
          _buildPerformanceItem('Lazy Loading', performanceSettings.enableLazyLoading),
          _buildPerformanceItem('Virtualization', performanceSettings.enableVirtualization),
          const SizedBox(height: 8),
          Text(
            'Max Widgets: ${performanceSettings.maxWidgetsPerScreen}',
            style: PandoraTypography.bodySmall.copyWith(
              color: PandoraColors.neutral600,
            ),
          ),
          Text(
            'Animation Duration: ${performanceSettings.animationDuration.inMilliseconds}ms',
            style: PandoraTypography.bodySmall.copyWith(
              color: PandoraColors.neutral600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceItem(String label, bool enabled) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            enabled ? Icons.check_circle : Icons.cancel,
            color: enabled ? PandoraColors.success500 : PandoraColors.error500,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: PandoraTypography.bodySmall.copyWith(
              color: PandoraColors.neutral700,
            ),
          ),
        ],
      ),
    );
  }

  int _getGridColumns() {
    switch (_currentBreakpoint) {
      case MobileBreakpoint.mobile:
        return 1;
      case MobileBreakpoint.tablet:
        return 2;
      case MobileBreakpoint.desktop:
        return 3;
      case MobileBreakpoint.largeDesktop:
        return 4;
    }
  }

  double _getCardAspectRatio() {
    switch (_currentBreakpoint) {
      case MobileBreakpoint.mobile:
        return 1.5;
      case MobileBreakpoint.tablet:
        return 1.3;
      case MobileBreakpoint.desktop:
        return 1.2;
      case MobileBreakpoint.largeDesktop:
        return 1.1;
    }
  }

  MobileCardSize _getCardSize() {
    switch (_currentSize) {
      case MobileSize.compact:
        return MobileCardSize.small;
      case MobileSize.regular:
        return MobileCardSize.medium;
      case MobileSize.comfortable:
        return MobileCardSize.large;
      case MobileSize.spacious:
        return MobileCardSize.extraLarge;
    }
  }

  MobileTextFieldSize _getTextFieldSize() {
    switch (_currentSize) {
      case MobileSize.compact:
        return MobileTextFieldSize.small;
      case MobileSize.regular:
        return MobileTextFieldSize.medium;
      case MobileSize.comfortable:
        return MobileTextFieldSize.large;
      case MobileSize.spacious:
        return MobileTextFieldSize.extraLarge;
    }
  }

  MobileNavigationSize _getNavigationSize() {
    switch (_currentSize) {
      case MobileSize.compact:
        return MobileNavigationSize.small;
      case MobileSize.regular:
        return MobileNavigationSize.medium;
      case MobileSize.comfortable:
        return MobileNavigationSize.large;
      case MobileSize.spacious:
        return MobileNavigationSize.extraLarge;
    }
  }

  IconData _getBreakpointIcon(MobileBreakpoint breakpoint) {
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        return Icons.phone_android;
      case MobileBreakpoint.tablet:
        return Icons.tablet;
      case MobileBreakpoint.desktop:
        return Icons.desktop_windows;
      case MobileBreakpoint.largeDesktop:
        return Icons.desktop_mac;
    }
  }

  Color _getBreakpointColor(MobileBreakpoint breakpoint) {
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        return PandoraColors.primary500;
      case MobileBreakpoint.tablet:
        return PandoraColors.secondary500;
      case MobileBreakpoint.desktop:
        return PandoraColors.success500;
      case MobileBreakpoint.largeDesktop:
        return PandoraColors.warning500;
    }
  }

  String _getBreakpointName(MobileBreakpoint breakpoint) {
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        return 'Mobile';
      case MobileBreakpoint.tablet:
        return 'Tablet';
      case MobileBreakpoint.desktop:
        return 'Desktop';
      case MobileBreakpoint.largeDesktop:
        return 'Large Desktop';
    }
  }
}
