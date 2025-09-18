import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';
import 'package:pandora_ui/pandora_ui.dart';

// Configuration
import 'config/environment.dart';
import 'config/firebase_config.dart';

// Dependency Injection
import 'injection.dart';

// Features
import 'features/notes/presentation/notes_list_screen.dart';

// Services
import 'background_tasks/sync_task.dart';
import 'services/unified_sync_service.dart';
import 'services/notification_service.dart';

/// Production main entry point
void main() async {
  await _initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

/// Initialize the application with production configuration
Future<void> _initializeApp() async {
  try {
    // Ensure Flutter binding is initialized
    WidgetsFlutterBinding.ensureInitialized();
    
    // Lock orientation to portrait (optional)
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Initialize environment configuration
    await Environment.initialize(environment: EnvironmentType.production);
    
    // Initialize Firebase services
    await FirebaseConfig.initialize();
    
    // Configure dependency injection
    configureDependencies();
    
    // Initialize core services
    await _initializeCoreServices();
    
    print('✅ Application initialized successfully');
  } catch (e, stackTrace) {
    print('❌ Application initialization failed: $e');
    
    // Record error to Crashlytics if available
    FirebaseConfig.recordError(e, stackTrace, fatal: true);
    
    // In production, we might want to show a fallback UI
    // For now, re-throw to see the error
    rethrow;
  }
}

/// Initialize core application services
Future<void> _initializeCoreServices() async {
  try {
    // Initialize notification service
    final notificationService = NotificationService();
    await notificationService.initialize();
    
    // Initialize WorkManager for background tasks
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: Environment.isDebugMode,
    );
    
    // Initialize sync service
    final syncService = SyncService();
    await syncService.initialize();
    
    print('✅ Core services initialized');
  } catch (e) {
    print('❌ Core services initialization failed: $e');
    FirebaseConfig.recordError(e, null);
    // Don't rethrow - app can still function without some services
  }
}

/// Main application widget
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: Environment.get('APP_NAME', defaultValue: 'Pandora Notes'),
      debugShowCheckedModeBanner: !Environment.isProduction,
      
      // Theme configuration
      theme: createPandoraLightTheme(),
      darkTheme: createPandoraTheme(),
      themeMode: ThemeMode.system,
      
      // Navigation
      home: const NotesListScreen(),
      
      // Error handling
      builder: (context, child) {
        // Global error handling
        ErrorWidget.builder = (FlutterErrorDetails details) {
          // Log error to Crashlytics
          FirebaseConfig.recordError(
            details.exception,
            details.stack,
            fatal: false,
          );
          
          // Show user-friendly error in production
          if (Environment.isProduction) {
            return _buildErrorWidget(context);
          }
          
          // Show detailed error in development
          return ErrorWidget(details.exception);
        };
        
        return child ?? const SizedBox.shrink();
      },
      
      // Route handling
      onGenerateRoute: (settings) {
        // TODO: Implement proper route generation
        return null;
      },
      
      // Unknown route handling
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const NotesListScreen(),
        );
      },
    );
  }

  /// Build user-friendly error widget for production
  Widget _buildErrorWidget(BuildContext context) {
    return Material(
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  'Something went wrong',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'We apologize for the inconvenience. Please restart the app.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // In a real app, you might want to restart or navigate
                    // For now, just show the notes screen
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const NotesListScreen(),
                      ),
                    );
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
