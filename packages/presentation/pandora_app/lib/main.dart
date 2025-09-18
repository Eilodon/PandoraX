import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core_utils/core_utils.dart';
import 'package:design_tokens/design_tokens.dart';
import 'package:pandora_ui/pandora_ui.dart';
import 'screens/home_screen.dart';

/// PandoraX main application
///
/// This is the main entry point for the PandoraX application,
/// following Clean Architecture principles and "Thân Tâm Hợp Nhất" philosophy.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize core services
    await _initializeServices();

    // Run the app
    runApp(
      const ProviderScope(
        child: PandoraApp(),
      ),
    );
  } catch (e, stackTrace) {
    AppLogger.error('Failed to initialize PandoraX', e, stackTrace);

    // Show error screen
    runApp(
      MaterialApp(
        home: ErrorScreen(error: e.toString()),
      ),
    );
  }
}

/// Initialize all core services
Future<void> _initializeServices() async {
  AppLogger.info('🚀 Initializing PandoraX services...');

  // Initialize dependency injection
  await ServiceLocator.initialize();

  // Initialize other services here
  // await ServiceLocator.get<EncryptionService>().initialize();
  // await ServiceLocator.get<AiRepository>().initialize();

  AppLogger.success('PandoraX services initialized successfully');
}

/// Main PandoraX application widget
class PandoraApp extends StatelessWidget {
  const PandoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PandoraX',
      debugShowCheckedModeBanner: false,

      // Apply Pandora theme
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: ThemeMode.system,

      // Home screen
      home: const HomeScreen(),

      // Error handling
      builder: (context, child) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return ErrorScreen(
            error: errorDetails.exception.toString(),
            stackTrace: errorDetails.stack,
          );
        };
        return child!;
      },
    );
  }

  /// Build light theme
  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: PandoraColors.primary,
        brightness: Brightness.light,
      ),
      textTheme: _buildTextTheme(Brightness.light),
      appBarTheme: _buildAppBarTheme(Brightness.light),
      elevatedButtonTheme: _buildElevatedButtonTheme(Brightness.light),
      outlinedButtonTheme: _buildOutlinedButtonTheme(Brightness.light),
      textButtonTheme: _buildTextButtonTheme(Brightness.light),
      cardTheme: _buildCardThemeData(Brightness.light),
      inputDecorationTheme: _buildInputDecorationTheme(Brightness.light),
    );
  }

  /// Build dark theme
  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: PandoraColors.primary,
        brightness: Brightness.dark,
      ),
      textTheme: _buildTextTheme(Brightness.dark),
      appBarTheme: _buildAppBarTheme(Brightness.dark),
      elevatedButtonTheme: _buildElevatedButtonTheme(Brightness.dark),
      outlinedButtonTheme: _buildOutlinedButtonTheme(Brightness.dark),
      textButtonTheme: _buildTextButtonTheme(Brightness.dark),
      cardTheme: _buildCardThemeData(Brightness.dark),
      inputDecorationTheme: _buildInputDecorationTheme(Brightness.dark),
    );
  }

  /// Build text theme
  TextTheme _buildTextTheme(Brightness brightness) {
    return TextTheme(
      displayLarge: PandoraTypography.displayLarge,
      displayMedium: PandoraTypography.displayMedium,
      displaySmall: PandoraTypography.displaySmall,
      headlineLarge: PandoraTypography.headlineLarge,
      headlineMedium: PandoraTypography.headlineMedium,
      headlineSmall: PandoraTypography.headlineSmall,
      titleLarge: PandoraTypography.titleLarge,
      titleMedium: PandoraTypography.titleMedium,
      titleSmall: PandoraTypography.titleSmall,
      bodyLarge: PandoraTypography.bodyLarge,
      bodyMedium: PandoraTypography.bodyMedium,
      bodySmall: PandoraTypography.bodySmall,
      labelLarge: PandoraTypography.labelLarge,
      labelMedium: PandoraTypography.labelMedium,
      labelSmall: PandoraTypography.labelSmall,
    );
  }

  /// Build app bar theme
  AppBarTheme _buildAppBarTheme(Brightness brightness) {
    return AppBarTheme(
      backgroundColor: brightness == Brightness.light
          ? PandoraColors.surface
          : PandoraColors.darkSurface,
      foregroundColor: brightness == Brightness.light
          ? PandoraColors.onSurface
          : PandoraColors.darkOnSurface,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: PandoraTypography.titleLarge.copyWith(
        color: brightness == Brightness.light
            ? PandoraColors.onSurface
            : PandoraColors.darkOnSurface,
      ),
    );
  }

  /// Build elevated button theme
  ElevatedButtonThemeData _buildElevatedButtonTheme(Brightness brightness) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: PandoraColors.primary,
        foregroundColor: PandoraColors.onPrimary,
        elevation: 2,
        padding: PandoraSpacing.buttonPaddingEdgeInsets,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PandoraSpacing.radiusL),
        ),
      ),
    );
  }

  /// Build outlined button theme
  OutlinedButtonThemeData _buildOutlinedButtonTheme(Brightness brightness) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: PandoraColors.primary,
        side: BorderSide(color: PandoraColors.primary),
        padding: PandoraSpacing.buttonPaddingEdgeInsets,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PandoraSpacing.radiusL),
        ),
      ),
    );
  }

  /// Build text button theme
  TextButtonThemeData _buildTextButtonTheme(Brightness brightness) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: PandoraColors.primary,
        padding: PandoraSpacing.buttonPaddingEdgeInsets,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PandoraSpacing.radiusL),
        ),
      ),
    );
  }

  /// Build card theme
  CardThemeData _buildCardThemeData(Brightness brightness) {
    return CardThemeData(
      color: brightness == Brightness.light
          ? PandoraColors.surface
          : PandoraColors.darkSurface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PandoraSpacing.radiusL),
      ),
      margin: PandoraSpacing.cardPaddingEdgeInsets,
    );
  }

  /// Build input decoration theme
  InputDecorationTheme _buildInputDecorationTheme(Brightness brightness) {
    return InputDecorationTheme(
      filled: true,
      fillColor: brightness == Brightness.light
          ? PandoraColors.surfaceContainer
          : PandoraColors.darkSurfaceContainer,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(PandoraSpacing.radiusL),
        borderSide: BorderSide(color: PandoraColors.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(PandoraSpacing.radiusL),
        borderSide: BorderSide(color: PandoraColors.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(PandoraSpacing.radiusL),
        borderSide: BorderSide(color: PandoraColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(PandoraSpacing.radiusL),
        borderSide: BorderSide(color: PandoraColors.error),
      ),
      contentPadding: PandoraSpacing.inputPaddingEdgeInsets,
    );
  }
}

/// Error screen widget
class ErrorScreen extends StatelessWidget {
  final String error;
  final StackTrace? stackTrace;

  const ErrorScreen({
    super.key,
    required this.error,
    this.stackTrace,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PandoraColors.errorContainer,
      body: Center(
        child: Padding(
          padding: PandoraSpacing.screenPaddingEdgeInsets,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: PandoraColors.error,
              ),
              const SizedBox(height: 24),
              Text(
                'Oops! Something went wrong',
                style: PandoraTypography.headlineMedium.copyWith(
                  color: PandoraColors.error,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                error,
                style: PandoraTypography.bodyMedium.copyWith(
                  color: PandoraColors.onErrorContainer,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Restart the app
                  // You can implement app restart logic here
                },
                child: Text('Restart App'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
