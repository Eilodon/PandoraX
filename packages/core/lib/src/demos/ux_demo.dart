/// UX Demo for Phase 5 Advanced UX
/// 
/// This demo showcases all Phase 5 features including micro-interactions,
/// advanced animations, smart UX, and personalization.
library ux_demo;

import 'package:flutter/material.dart';
import 'package:core/core.dart';

/// UX demo screen showcasing Phase 5 features
class UXDemo extends StatefulWidget {
  const UXDemo({super.key});

  @override
  State<UXDemo> createState() => _UXDemoState();
}

class _UXDemoState extends State<UXDemo> with TickerProviderStateMixin {
  late AnimationController _demoController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  bool _isDarkMode = false;
  bool _hapticEnabled = true;
  bool _soundEnabled = true;
  bool _visualEnabled = true;
  
  final List<String> _demoItems = [
    'Micro-interactions',
    'Advanced Animations',
    'Smart UX Features',
    'Personalization',
    'Gesture System',
    'Animation Components',
  ];
  
  @override
  void initState() {
    super.initState();
    _demoController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _demoController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _demoController, curve: Curves.easeOut));
    
    _demoController.forward();
  }
  
  @override
  void dispose() {
    _demoController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phase 5: Advanced UX Demo'),
        backgroundColor: DesignTokens.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _toggleTheme,
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _demoController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(DesignTokens.spacing6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    _buildHeader(),
                    const SizedBox(height: DesignTokens.spacing8),
                    
                    // Micro-interactions Section
                    _buildMicroInteractionsSection(),
                    const SizedBox(height: DesignTokens.spacing8),
                    
                    // Advanced Animations Section
                    _buildAdvancedAnimationsSection(),
                    const SizedBox(height: DesignTokens.spacing8),
                    
                    // Smart UX Section
                    _buildSmartUXSection(),
                    const SizedBox(height: DesignTokens.spacing8),
                    
                    // Personalization Section
                    _buildPersonalizationSection(),
                    const SizedBox(height: DesignTokens.spacing8),
                    
                    // Gesture System Section
                    _buildGestureSystemSection(),
                    const SizedBox(height: DesignTokens.spacing8),
                    
                    // Animation Components Section
                    _buildAnimationComponentsSection(),
                    const SizedBox(height: DesignTokens.spacing8),
                    
                    // Settings Section
                    _buildSettingsSection(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [DesignTokens.primary, DesignTokens.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        boxShadow: DesignTokens.shadowLg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phase 5: Advanced UX',
            style: const TextStyle(
              fontSize: DesignTokens.fontSize3Xl,
              fontWeight: DesignTokens.fontWeightBold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing2),
          Text(
            'Experience the future of user interaction with micro-interactions, smart UX, and intelligent personalization.',
            style: const TextStyle(
              fontSize: DesignTokens.fontSizeLg,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMicroInteractionsSection() {
    return _buildSection(
      title: 'Micro-interactions',
      children: [
        _buildInfoCard(
          title: 'Haptic Feedback',
          content: 'Feel every interaction with precise haptic feedback',
          color: DesignTokens.primary,
          onTap: () => _testHapticFeedback(),
        ),
        _buildInfoCard(
          title: 'Sound Effects',
          content: 'Audio feedback for enhanced user experience',
          color: DesignTokens.secondary,
          onTap: () => _testSoundEffects(),
        ),
        _buildInfoCard(
          title: 'Visual Feedback',
          content: 'Ripple effects and visual responses',
          color: DesignTokens.info,
          onTap: () => _testVisualFeedback(),
        ),
      ],
    );
  }
  
  Widget _buildAdvancedAnimationsSection() {
    return _buildSection(
      title: 'Advanced Animations',
      children: [
        _buildInfoCard(
          title: 'Staggered Animations',
          content: 'Smooth sequential animations for lists',
          color: DesignTokens.primary,
          onTap: () => _testStaggeredAnimations(),
        ),
        _buildInfoCard(
          title: 'Morphing Effects',
          content: 'Dynamic shape and color transformations',
          color: DesignTokens.secondary,
          onTap: () => _testMorphingEffects(),
        ),
        _buildInfoCard(
          title: 'Spring Animations',
          content: 'Natural physics-based animations',
          color: DesignTokens.info,
          onTap: () => _testSpringAnimations(),
        ),
      ],
    );
  }
  
  Widget _buildSmartUXSection() {
    return _buildSection(
      title: 'Smart UX Features',
      children: [
        _buildInfoCard(
          title: 'Predictive Loading',
          content: 'Anticipate user needs and preload content',
          color: DesignTokens.primary,
          onTap: () => _testPredictiveLoading(),
        ),
        _buildInfoCard(
          title: 'Contextual Help',
          content: 'Smart help system that adapts to context',
          color: DesignTokens.secondary,
          onTap: () => _testContextualHelp(),
        ),
        _buildInfoCard(
          title: 'Smart Defaults',
          content: 'Intelligent default values based on usage',
          color: DesignTokens.info,
          onTap: () => _testSmartDefaults(),
        ),
      ],
    );
  }
  
  Widget _buildPersonalizationSection() {
    return _buildSection(
      title: 'Personalization',
      children: [
        _buildInfoCard(
          title: 'User Learning',
          content: 'AI learns from your behavior patterns',
          color: DesignTokens.primary,
          onTap: () => _testUserLearning(),
        ),
        _buildInfoCard(
          title: 'Smart Recommendations',
          content: 'Personalized suggestions and insights',
          color: DesignTokens.secondary,
          onTap: () => _testSmartRecommendations(),
        ),
        _buildInfoCard(
          title: 'Adaptive UI',
          content: 'Interface that adapts to your preferences',
          color: DesignTokens.info,
          onTap: () => _testAdaptiveUI(),
        ),
      ],
    );
  }
  
  Widget _buildGestureSystemSection() {
    return _buildSection(
      title: 'Gesture System',
      children: [
        _buildInfoCard(
          title: 'Swipe Gestures',
          content: 'Intuitive swipe interactions',
          color: DesignTokens.primary,
          onTap: () => _testSwipeGestures(),
        ),
        _buildInfoCard(
          title: 'Pinch Gestures',
          content: 'Zoom and scale with pinch gestures',
          color: DesignTokens.secondary,
          onTap: () => _testPinchGestures(),
        ),
        _buildInfoCard(
          title: 'Long Press',
          content: 'Context menus and advanced actions',
          color: DesignTokens.info,
          onTap: () => _testLongPress(),
        ),
      ],
    );
  }
  
  Widget _buildAnimationComponentsSection() {
    return _buildSection(
      title: 'Animation Components',
      children: [
        _buildInfoCard(
          title: 'Animated Buttons',
          content: 'Buttons with advanced animation effects',
          color: DesignTokens.primary,
          onTap: () => _testAnimatedButtons(),
        ),
        _buildInfoCard(
          title: 'Animated Cards',
          content: 'Cards with morphing and hover effects',
          color: DesignTokens.secondary,
          onTap: () => _testAnimatedCards(),
        ),
        _buildInfoCard(
          title: 'Animated Lists',
          content: 'Lists with staggered animations',
          color: DesignTokens.info,
          onTap: () => _testAnimatedLists(),
        ),
      ],
    );
  }
  
  Widget _buildSettingsSection() {
    return _buildSection(
      title: 'Settings',
      children: [
        _buildSettingCard(
          title: 'Haptic Feedback',
          subtitle: 'Enable haptic feedback for interactions',
          value: _hapticEnabled,
          onChanged: (value) => setState(() => _hapticEnabled = value),
        ),
        _buildSettingCard(
          title: 'Sound Effects',
          subtitle: 'Enable sound effects for interactions',
          value: _soundEnabled,
          onChanged: (value) => setState(() => _soundEnabled = value),
        ),
        _buildSettingCard(
          title: 'Visual Feedback',
          subtitle: 'Enable visual feedback for interactions',
          value: _visualEnabled,
          onChanged: (value) => setState(() => _visualEnabled = value),
        ),
      ],
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
    VoidCallback? onTap,
  }) {
    return AnimatedCard(
      onTap: onTap,
      hoverColor: color.withOpacity(0.1),
      pressColor: color.withOpacity(0.2),
      child: Container(
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
            if (onTap != null)
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: color,
              ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSettingCard({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing3),
      padding: const EdgeInsets.all(DesignTokens.spacing4),
      decoration: BoxDecoration(
        color: DesignTokens.neutral50,
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
        border: Border.all(color: DesignTokens.neutral200),
      ),
      child: Row(
        children: [
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
                  subtitle,
                  style: const TextStyle(
                    fontSize: DesignTokens.fontSizeSm,
                    color: DesignTokens.neutral600,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: DesignTokens.primary,
          ),
        ],
      ),
    );
  }
  
  // ============================================================================
  // TEST METHODS
  // ============================================================================
  
  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    MicroInteractionService.instance.toggleTheme();
  }
  
  void _testHapticFeedback() {
    MicroInteractionService.instance.successInteraction();
  }
  
  void _testSoundEffects() {
    MicroInteractionService.instance.playSuccessSound();
  }
  
  void _testVisualFeedback() {
    MicroInteractionService.instance.createRippleEffect(
      child: const SizedBox(),
      onTap: () {},
    );
  }
  
  void _testStaggeredAnimations() {
    // Test staggered animations
    _demoController.forward(from: 0.0);
  }
  
  void _testMorphingEffects() {
    // Test morphing effects
    setState(() {});
  }
  
  void _testSpringAnimations() {
    // Test spring animations
    _demoController.forward(from: 0.0);
  }
  
  void _testPredictiveLoading() {
    SmartUXService.instance.preloadNextScreen('ux_demo');
  }
  
  void _testContextualHelp() {
    SmartUXService.instance.showFeatureHelp('ux_demo', context);
  }
  
  void _testSmartDefaults() {
    final smartDefault = SmartUXService.instance.getSmartDefault('theme_mode', 'system');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Smart default: $smartDefault')),
    );
  }
  
  void _testUserLearning() {
    PersonalizationService.instance.learnFromUserBehavior('demo_interaction', {
      'feature': 'ux_demo',
      'timestamp': DateTime.now().toIso8601String(),
    });
  }
  
  void _testSmartRecommendations() {
    final recommendations = PersonalizationService.instance.getRecommendations('user123', 'note_categories');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Recommendations: ${recommendations.join(', ')}')),
    );
  }
  
  void _testAdaptiveUI() {
    final config = PersonalizationService.instance.getAdaptiveUIConfig('user123');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Adaptive UI: ${config['theme']}')),
    );
  }
  
  void _testSwipeGestures() {
    GestureSystem.instance.trackGestureUsage('swipe', {'direction': 'left'});
  }
  
  void _testPinchGestures() {
    GestureSystem.instance.trackGestureUsage('pinch', {'scale': 1.5});
  }
  
  void _testLongPress() {
    GestureSystem.instance.trackGestureUsage('long_press', {'duration': 500});
  }
  
  void _testAnimatedButtons() {
    // Test animated buttons
    setState(() {});
  }
  
  void _testAnimatedCards() {
    // Test animated cards
    setState(() {});
  }
  
  void _testAnimatedLists() {
    // Test animated lists
    setState(() {});
  }
}
