import 'package:flutter/material.dart';
import 'package:core_utils/core_utils.dart';
import '../screens/simple_home_screen_v3.dart';
import '../screens/pixel_art_homescreen.dart';
import '../screens/enhanced_notes_screen.dart';
import '../screens/ai_chat_screen.dart';
import '../screens/voice_screen.dart';
import '../screens/settings_screen.dart';

/// Simple app router for managing routes
class SimpleRouter {
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
        return MaterialPageRoute(
          builder: (context) => const PixelArtHomeScreen(),
          settings: settings,
        );
      
      case notes:
        return MaterialPageRoute(
          builder: (context) => const EnhancedNotesScreen(),
          settings: settings,
        );
      
      case aiChat:
        return MaterialPageRoute(
          builder: (context) => const AIChatScreen(),
          settings: settings,
        );
      
      case voice:
        return MaterialPageRoute(
          builder: (context) => const VoiceScreen(),
          settings: settings,
        );
      
      case '/settings':
        return MaterialPageRoute(
          builder: (context) => const SettingsScreen(),
          settings: settings,
        );
      
      default:
        return MaterialPageRoute(
          builder: (context) => const NotFoundScreen(),
          settings: settings,
        );
    }
  }

  /// Get all routes
  static Map<String, WidgetBuilder> get routes => {
    home: (context) => const PixelArtHomeScreen(),
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
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
