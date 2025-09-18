import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/simple_home_screen_v3.dart';
import 'providers/theme_provider.dart';
import 'services/settings_service.dart';
import 'services/reminder_service.dart';
import 'services/ai_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  await SettingsService().initialize();
  await ReminderService().initialize();
  await AIService().initialize();

  runApp(const ProviderScope(child: PandoraApp()));
}

class PandoraApp extends ConsumerWidget {
  const PandoraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return MaterialApp(
      title: 'PandoraX - AI Note Assistant',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const SimpleHomeScreenV3(),
    );
  }
}
