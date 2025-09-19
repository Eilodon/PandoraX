import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/simple_home_screen_v3.dart';
import 'screens/pixel_art_homescreen.dart';
import 'providers/theme_provider.dart';
import 'providers/language_provider.dart';
import 'services/settings_service.dart';
import 'services/reminder_service.dart';
import 'services/ai_service.dart';
import 'services/voice_service.dart';
import 'services/simple_navigation_service.dart';
import 'routes/simple_router.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize only essential services
  await SettingsService().initialize();
  await ReminderService().initialize();
  await AIService().initialize();
  await VoiceService().initialize();

  runApp(const ProviderScope(child: PandoraApp()));
}

class PandoraApp extends ConsumerWidget {
  const PandoraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final locale = ref.watch(languageProvider);
    
    return MaterialApp(
      title: 'PandoraX - AI Note Assistant',
      debugShowCheckedModeBanner: false,
      theme: theme,
      locale: locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('vi', 'VN'),
        Locale('zh', 'CN'),
        Locale('ja', 'JP'),
        Locale('ko', 'KR'),
      ],
      navigatorKey: SimpleNavigationService().navigatorKey,
      onGenerateRoute: SimpleRouter.generateRoute,
      initialRoute: SimpleRouter.home,
      routes: SimpleRouter.routes,
    );
  }
}
