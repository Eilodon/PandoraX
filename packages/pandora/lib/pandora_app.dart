import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

import 'config/firebase_config.dart';
import 'config/dependency_injection.dart';
import 'features/dashboard/presentation/dashboard_screen.dart';
import 'features/ai/presentation/screens/enhanced_ai_chat_screen.dart';

class PandoraApp extends ConsumerWidget {
  const PandoraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Pandora AI Assistant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      home: const DashboardScreen(),
      routes: {
        '/dashboard': (context) => const DashboardScreen(),
        '/ai-chat': (context) => const EnhancedAIChatScreen(),
      },
    );
  }
}

class PandoraAppInitializer {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    
    // Initialize Firebase
    await Firebase.initializeApp();
    await FirebaseConfig.initialize();
    
    // Initialize dependency injection
    await DependencyInjection.setup();
    
    // Initialize other services
    await _initializeServices();
  }

  static Future<void> _initializeServices() async {
    // Initialize monitoring services
    final monitoringService = GetIt.instance<ProductionMonitoringService>();
    await monitoringService.initialize();
    
    // Initialize sync service
    final syncService = GetIt.instance<SyncServiceProduction>();
    await syncService.initialize();
    
    // Initialize other core services
    // Add more service initializations as needed
  }
}

// Mock services for testing
class MockSpeechRecognitionService {
  Future<void> initialize() async {
    // Mock implementation
  }
}

class MockSyncService {
  Future<void> initialize() async {
    // Mock implementation
  }
}

class MockNotificationService {
  Future<void> initialize() async {
    // Mock implementation
  }
}

class TestScenariosManager {
  void dispose() {
    // Mock implementation
  }
}
