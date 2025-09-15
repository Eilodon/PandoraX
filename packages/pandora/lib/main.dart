import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora_ui/pandora_ui.dart';
import 'package:firebase_core/firebase_core.dart';

// Dependency Injection
import 'injection.dart';

// Features
import 'features/notes/presentation/notes_list_screen.dart';
import 'features/ai/presentation/ai_chat_screen.dart';
import 'features/speech_recognition/presentation/voice_recording_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDemo_Firebase_API_Key_For_Development_Only',
      appId: '1:123456789012:android:abcdef123456789012345678',
      messagingSenderId: '123456789012',
      projectId: 'pandora-notes-demo',
      storageBucket: 'pandora-notes-demo.appspot.com',
    ),
  );
  
  await configureDependencies();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pandora Notes - Full Production',
      debugShowCheckedModeBanner: false,
      
      // Theme configuration
      theme: createPandoraLightTheme(),
      darkTheme: createPandoraTheme(),
      themeMode: ThemeMode.system,
      
      // Navigation
      home: const PandoraHomeScreen(),
      
      // Routes
      routes: {
        '/notes': (context) => const NotesListScreen(),
        '/ai-chat': (context) => const AiChatScreen(),
        '/voice': (context) => const VoiceRecordingScreen(),
      },
    );
  }
}

class PandoraHomeScreen extends StatefulWidget {
  const PandoraHomeScreen({super.key});

  @override
  State<PandoraHomeScreen> createState() => _PandoraHomeScreenState();
}

class _PandoraHomeScreenState extends State<PandoraHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const NotesListScreen(),
    const AiChatScreen(),
    const VoiceRecordingScreen(),
  ];

  final List<String> _titles = [
    'Notes',
    'AI Chat',
    'Voice Commands',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _showSettingsDialog();
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.notes),
            selectedIcon: Icon(Icons.notes),
            label: 'Notes',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat),
            selectedIcon: Icon(Icons.chat),
            label: 'AI Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.mic),
            selectedIcon: Icon(Icons.mic),
            label: 'Voice',
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Settings'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.palette),
              title: Text('Theme'),
              subtitle: Text('Light/Dark mode'),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              subtitle: Text('Manage notifications'),
            ),
            ListTile(
              leading: Icon(Icons.cloud_sync),
              title: Text('Sync'),
              subtitle: Text('Cloud synchronization'),
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Security'),
              subtitle: Text('Privacy & security'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}