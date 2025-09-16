/// Pandora Package
/// 
/// A comprehensive Flutter package for AI-powered note-taking with living mascot

// Core Services
export 'services/mascot_service.dart';
export 'services/mascot_enums.dart';
export 'services/mascot_task_integration.dart';
export 'services/decoration_system.dart';
export 'services/mascot_thought_bubbles.dart';
export 'services/gold_reward_system.dart';
export 'services/xp_level_system.dart' hide AchievementType, sharedPreferencesProvider;
export 'services/celebration_overlay_controller.dart';
export 'services/sound_effects_service.dart';

// Widgets
export 'widgets/mascot_widget.dart';
export 'widgets/living_mascot_widget.dart';
export 'widgets/mascot_environment_widget.dart';
export 'widgets/enhanced_quest_card.dart';

// Features
export 'features/mascot/presentation/living_mascot_demo_screen.dart';
export 'features/mascot/presentation/mascot_environment_demo_screen.dart';
export 'features/mascot/presentation/celebration_demo_screen.dart';

// Main Entry Points
export 'main.dart' hide main, MyApp;
export 'main_demo.dart' hide main;
export 'main_production.dart' hide main;
