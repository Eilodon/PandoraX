import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dashboard/presentation/dashboard_screen.dart';
import '../journey/presentation/journey_screen.dart';
import '../social/presentation/social_screen.dart';
import '../dashboard/providers/dashboard_providers.dart';

/// 🧭 Main Navigation Widget
/// 
/// Handles navigation between main screens:
/// - Dashboard (Home)
/// - Journey (Adventure Map/Calendar)
/// - Social (Guilds/Community)
class MainNavigation extends ConsumerWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(dashboardStateProvider).currentTabIndex;

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          DashboardScreen(),
          JourneyScreen(),
          SocialScreen(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context, ref, currentIndex),
    );
  }

  /// Build bottom navigation bar
  Widget _buildBottomNavigationBar(
    BuildContext context,
    WidgetRef ref,
    int currentIndex,
  ) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => _onTabTapped(context, ref, index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              activeIcon: Icon(Icons.map),
              label: 'Journey',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              activeIcon: Icon(Icons.people),
              label: 'Social',
            ),
          ],
        ),
      ),
    );
  }

  /// Handle tab tap
  void _onTabTapped(BuildContext context, WidgetRef ref, int index) {
    final dashboardNotifier = ref.read(dashboardStateProvider.notifier);
    dashboardNotifier.setCurrentTab(index);

    // Add haptic feedback
    // HapticFeedback.lightImpact();

    // Navigate to specific screen if needed
    switch (index) {
      case 0:
        // Dashboard - already handled by IndexedStack
        break;
      case 1:
        // Journey
        _navigateToJourney(context);
        break;
      case 2:
        // Social
        _navigateToSocial(context);
        break;
    }
  }

  /// Navigate to Journey screen
  void _navigateToJourney(BuildContext context) {
    // Additional navigation logic for Journey screen
    // For example, show a specific journey state
  }

  /// Navigate to Social screen
  void _navigateToSocial(BuildContext context) {
    // Additional navigation logic for Social screen
    // For example, show notifications or messages
  }
}

/// Navigation Service
/// 
/// Centralized navigation management for the app
class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = 
      GlobalKey<NavigatorState>();

  static NavigatorState? get navigator => navigatorKey.currentState;

  /// Navigate to a named route
  static Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigator!.pushNamed(routeName, arguments: arguments);
  }

  /// Navigate and replace current route
  static Future<dynamic> navigateAndReplace(String routeName, {Object? arguments}) {
    return navigator!.pushReplacementNamed(routeName, arguments: arguments);
  }

  /// Navigate and clear stack
  static Future<dynamic> navigateAndClearStack(String routeName, {Object? arguments}) {
    return navigator!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Go back
  static void goBack([dynamic result]) {
    navigator!.pop(result);
  }

  /// Check if can go back
  static bool canGoBack() {
    return navigator!.canPop();
  }
}

/// Route Generator
/// 
/// Handles route generation and navigation
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const MainNavigation(),
        );
      
      case '/dashboard':
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        );
      
      case '/journey':
        return MaterialPageRoute(
          builder: (_) => const JourneyScreen(),
        );
      
      case '/social':
        return MaterialPageRoute(
          builder: (_) => const SocialScreen(),
        );
      
      case '/notes':
        return MaterialPageRoute(
          builder: (_) => const NotesScreen(),
        );
      
      case '/voice':
        return MaterialPageRoute(
          builder: (_) => const VoiceInteractionScreen(),
        );
      
      case '/settings':
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );
      
      default:
        return MaterialPageRoute(
          builder: (_) => const NotFoundScreen(),
        );
    }
  }
}

/// Placeholder screens for navigation
class JourneyScreen extends StatelessWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🗺️ Journey'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Journey Screen\n(Adventure Map & Calendar)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('👥 Social'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Social Screen\n(Guilds & Community)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📝 Notes'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Notes Screen\n(Note Management)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class VoiceInteractionScreen extends StatelessWidget {
  const VoiceInteractionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎤 Voice'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Voice Interaction Screen\n(Voice Commands & TTS)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('⚙️ Settings'),
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Settings Screen\n(App Configuration)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('404 - Not Found'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Page Not Found\n\nThe requested page could not be found.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
