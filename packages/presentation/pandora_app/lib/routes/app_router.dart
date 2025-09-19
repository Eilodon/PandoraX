import 'package:flutter/material.dart';
import 'package:core_utils/core_utils.dart';
import '../screens/simple_home_screen_v3.dart';
import '../screens/enhanced_notes_screen.dart';
import '../screens/ai_chat_screen.dart';
import '../screens/voice_screen.dart';
import '../screens/settings_screen.dart';
import '../services/navigation_service.dart';

/// App router for managing all routes and navigation
class AppRouter {
  static const String home = '/';
  static const String notes = '/notes';
  static const String aiChat = '/ai-chat';
  static const String voice = '/voice';
  static const String settings = '/settings';

  /// Generate routes
  static Route<dynamic> generateRoute(RouteSettings settings) {
    AppLogger.info('🛣️ Generating route: ${settings.name}');
    
    switch (settings.name) {
      case home:
        return CustomPageRoute(
          child: const SimpleHomeScreenV3(),
          transitionType: PageTransitionType.fade,
        );
      
      case notes:
        return CustomPageRoute(
          child: const EnhancedNotesScreen(),
          transitionType: PageTransitionType.slideRight,
        );
      
      case aiChat:
        return CustomPageRoute(
          child: const AIChatScreen(),
          transitionType: PageTransitionType.slideUp,
        );
      
      case voice:
        return CustomPageRoute(
          child: const VoiceScreen(),
          transitionType: PageTransitionType.scale,
        );
      
      case '/settings':
        return CustomPageRoute(
          child: const SettingsScreen(),
          transitionType: PageTransitionType.slideLeft,
        );
      
      default:
        return CustomPageRoute(
          child: const NotFoundScreen(),
          transitionType: PageTransitionType.fade,
        );
    }
  }

  /// Get all routes
  static Map<String, WidgetBuilder> get routes => {
    home: (context) => const SimpleHomeScreenV3(),
    notes: (context) => const EnhancedNotesScreen(),
    aiChat: (context) => const AIChatScreen(),
    voice: (context) => const VoiceScreen(),
    settings: (context) => const SettingsScreen(),
  };
}

/// 404 Not Found Screen
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              '404',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Page Not Found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => NavigationService().goBack(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
