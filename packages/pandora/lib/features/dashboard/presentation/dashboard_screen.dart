import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora_ui/pandora_ui.dart';
import '../providers/dashboard_providers.dart';
import '../../mascot/providers/mascot_state.dart';
import '../widgets/quest_panel.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_footer.dart';
import '../widgets/dynamic_background.dart';
import '../widgets/mascot_environment.dart';

/// 🏠 Dashboard Screen - "Trang trại Nhiệm vụ"
/// 
/// Đây là màn hình chính mới của PandoraX, được thiết kế theo phong cách
/// "Trang trại Nhiệm vụ" với 3 layers:
/// - Layer 1: Background động theo thời gian
/// - Layer 2: The Hub (Mascot + Quest Panel)
/// - Layer 3: HUD (Header + Footer)
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundAnimationController;
  late AnimationController _mascotAnimationController;
  late AnimationController _questPanelAnimationController;
  
  late Animation<double> _backgroundAnimation;
  late Animation<double> _mascotScaleAnimation;
  late Animation<Offset> _questPanelSlideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    // Background animation - slow, continuous
    _backgroundAnimationController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    );
    
    // Mascot animation - gentle breathing effect
    _mascotAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    
    // Quest panel animation - smooth slide
    _questPanelAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _backgroundAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _backgroundAnimationController,
      curve: Curves.easeInOut,
    ));

    _mascotScaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _mascotAnimationController,
      curve: Curves.easeInOut,
    ));

    _questPanelSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _questPanelAnimationController,
      curve: Curves.easeOutCubic,
    ));
  }

  void _startAnimations() {
    _backgroundAnimationController.repeat(reverse: true);
    _mascotAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _backgroundAnimationController.dispose();
    _mascotAnimationController.dispose();
    _questPanelAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardStateProvider);
    final mascotState = ref.watch(mascotStateProvider);

    return Scaffold(
      body: Stack(
        children: [
          // Layer 1: Dynamic Background
          _buildBackgroundLayer(dashboardState),
          
          // Layer 2: The Hub (Mascot + Quest Panel)
          _buildHubLayer(dashboardState, mascotState),
          
          // Layer 3: HUD (Header + Footer)
          _buildHudLayer(dashboardState),
        ],
      ),
    );
  }

  /// Layer 1: Dynamic Background - thay đổi theo thời gian trong ngày
  Widget _buildBackgroundLayer(DashboardState dashboardState) {
    return AnimatedBuilder(
      animation: _backgroundAnimation,
      builder: (context, child) {
        return DynamicBackground(
          timeOfDay: dashboardState.timeOfDay,
          animationValue: _backgroundAnimation.value,
        );
      },
    );
  }

  /// Layer 2: The Hub - khu vực tương tác chính
  Widget _buildHubLayer(DashboardState dashboardState, MascotState mascotState) {
    return SafeArea(
      child: Column(
        children: [
          // Phần trên (60% màn hình): Khu vực Mascot
          Expanded(
            flex: 6,
            child: _buildMascotArea(mascotState),
          ),
          
          // Phần dưới (40% màn hình): Quest Panel
          Expanded(
            flex: 4,
            child: _buildQuestPanelArea(dashboardState),
          ),
        ],
      ),
    );
  }

  /// Khu vực Mascot với môi trường tương tác
  Widget _buildMascotArea(MascotState mascotState) {
    return AnimatedBuilder(
      animation: _mascotScaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _mascotScaleAnimation.value,
          child: MascotEnvironment(
            mascotState: mascotState,
            onMascotTap: _handleMascotInteraction,
          ),
        );
      },
    );
  }

  /// Quest Panel có thể kéo lên/xuống
  Widget _buildQuestPanelArea(DashboardState dashboardState) {
    return SlideTransition(
      position: _questPanelSlideAnimation,
      child: QuestPanel(
        isExpanded: dashboardState.isQuestPanelExpanded,
        onToggle: _toggleQuestPanel,
        onQuestTap: _handleQuestTap,
      ),
    );
  }

  /// Layer 3: HUD - Header và Footer
  Widget _buildHudLayer(DashboardState dashboardState) {
    return SafeArea(
      child: Column(
        children: [
          // Header: User info, HP/XP, Gold/Gems
          DashboardHeader(
            userStats: dashboardState.userStats,
            onAvatarTap: _handleAvatarTap,
          ),
          
          const Spacer(),
          
          // Footer: Navigation bar
          DashboardFooter(
            currentIndex: dashboardState.currentTabIndex,
            onTabChanged: _handleTabChanged,
          ),
        ],
      ),
    );
  }

  /// Xử lý tương tác với Mascot
  void _handleMascotInteraction() {
    final mascotNotifier = ref.read(mascotStateProvider.notifier);
    
    // Trigger mascot interaction animation
    mascotNotifier.triggerInteraction();
    
    // Show mascot message
    _showMascotMessage();
    
    // Haptic feedback
    // HapticFeedback.lightImpact();
  }

  /// Hiển thị tin nhắn từ Mascot
  void _showMascotMessage() {
    final mascotState = ref.read(mascotStateProvider);
    final messages = mascotState.getGreetingMessages();
    final randomMessage = messages[DateTime.now().millisecond % messages.length];
    
    PandoraSnackbar.show(
      context,
      message: randomMessage,
      variant: PandoraSnackbarVariant.info,
      duration: const Duration(seconds: 3),
    );
  }

  /// Toggle Quest Panel
  void _toggleQuestPanel() {
    final dashboardNotifier = ref.read(dashboardStateProvider.notifier);
    final isExpanded = ref.read(dashboardStateProvider).isQuestPanelExpanded;
    
    dashboardNotifier.toggleQuestPanel();
    
    // Animate quest panel
    if (isExpanded) {
      _questPanelAnimationController.reverse();
    } else {
      _questPanelAnimationController.forward();
    }
  }

  /// Xử lý tap vào quest
  void _handleQuestTap(Quest quest) {
    // Navigate to quest details or start quest
    _navigateToQuest(quest);
  }

  /// Navigate to quest screen
  void _navigateToQuest(Quest quest) {
    // TODO: Implement quest navigation
    PandoraSnackbar.show(
      context,
      message: 'Starting quest: ${quest.title}',
      variant: PandoraSnackbarVariant.success,
    );
  }

  /// Xử lý tap vào avatar
  void _handleAvatarTap() {
    // Navigate to profile screen
    _navigateToProfile();
  }

  /// Navigate to profile screen
  void _navigateToProfile() {
    // TODO: Implement profile navigation
    PandoraSnackbar.show(
      context,
      message: 'Opening profile...',
      variant: PandoraSnackbarVariant.info,
    );
  }

  /// Xử lý thay đổi tab
  void _handleTabChanged(int index) {
    final dashboardNotifier = ref.read(dashboardStateProvider.notifier);
    dashboardNotifier.setCurrentTab(index);
    
    // Navigate to different screens based on tab
    switch (index) {
      case 0:
        // Already on Dashboard
        break;
      case 1:
        _navigateToJourney();
        break;
      case 2:
        _navigateToSocial();
        break;
    }
  }

  /// Navigate to Journey screen
  void _navigateToJourney() {
    // TODO: Implement journey navigation
    PandoraSnackbar.show(
      context,
      message: 'Opening Journey...',
      variant: PandoraSnackbarVariant.info,
    );
  }

  /// Navigate to Social screen
  void _navigateToSocial() {
    // TODO: Implement social navigation
    PandoraSnackbar.show(
      context,
      message: 'Opening Social...',
      variant: PandoraSnackbarVariant.info,
    );
  }
}

/// Dashboard State
class DashboardState {
  final TimeOfDay timeOfDay;
  final bool isQuestPanelExpanded;
  final int currentTabIndex;
  final UserStats userStats;
  final List<Quest> todaysQuests;

  const DashboardState({
    required this.timeOfDay,
    this.isQuestPanelExpanded = false,
    this.currentTabIndex = 0,
    required this.userStats,
    required this.todaysQuests,
  });

  DashboardState copyWith({
    TimeOfDay? timeOfDay,
    bool? isQuestPanelExpanded,
    int? currentTabIndex,
    UserStats? userStats,
    List<Quest>? todaysQuests,
  }) {
    return DashboardState(
      timeOfDay: timeOfDay ?? this.timeOfDay,
      isQuestPanelExpanded: isQuestPanelExpanded ?? this.isQuestPanelExpanded,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      userStats: userStats ?? this.userStats,
      todaysQuests: todaysQuests ?? this.todaysQuests,
    );
  }
}

/// User Stats for gamification
class UserStats {
  final int level;
  final int experience;
  final int maxExperience;
  final int healthPoints;
  final int maxHealthPoints;
  final int gold;
  final int gems;
  final int streakDays;

  const UserStats({
    this.level = 1,
    this.experience = 0,
    this.maxExperience = 100,
    this.healthPoints = 100,
    this.maxHealthPoints = 100,
    this.gold = 0,
    this.gems = 0,
    this.streakDays = 0,
  });

  UserStats copyWith({
    int? level,
    int? experience,
    int? maxExperience,
    int? healthPoints,
    int? maxHealthPoints,
    int? gold,
    int? gems,
    int? streakDays,
  }) {
    return UserStats(
      level: level ?? this.level,
      experience: experience ?? this.experience,
      maxExperience: maxExperience ?? this.maxExperience,
      healthPoints: healthPoints ?? this.healthPoints,
      maxHealthPoints: maxHealthPoints ?? this.maxHealthPoints,
      gold: gold ?? this.gold,
      gems: gems ?? this.gems,
      streakDays: streakDays ?? this.streakDays,
    );
  }
}

/// Quest system
class Quest {
  final String id;
  final String title;
  final String description;
  final QuestType type;
  final QuestStatus status;
  final int experienceReward;
  final int goldReward;
  final int gemsReward;
  final DateTime? deadline;
  final List<QuestStep> steps;

  const Quest({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    this.status = QuestStatus.available,
    this.experienceReward = 10,
    this.goldReward = 5,
    this.gemsReward = 0,
    this.deadline,
    this.steps = const [],
  });
}

enum QuestType {
  daily,
  weekly,
  story,
  achievement,
  social,
}

enum QuestStatus {
  available,
  inProgress,
  completed,
  expired,
}

class QuestStep {
  final String id;
  final String description;
  final bool isCompleted;

  const QuestStep({
    required this.id,
    required this.description,
    this.isCompleted = false,
  });
}
