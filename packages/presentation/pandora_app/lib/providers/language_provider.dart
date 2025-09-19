import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core_utils/core_utils.dart';
import '../services/settings_service.dart';

/// Language Provider for managing app language
class LanguageNotifier extends StateNotifier<Locale> {
  LanguageNotifier() : super(const Locale('en', 'US')) {
    _loadLanguage();
  }

  final SettingsService _settingsService = SettingsService();

  /// Load saved language from settings
  Future<void> _loadLanguage() async {
    try {
      await _settingsService.initialize();
      final savedLanguage = _settingsService.language;
      final locale = _getLocaleFromLanguage(savedLanguage);
      state = locale;
      AppLogger.info('🌍 Language loaded: $savedLanguage');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to load language', e, stackTrace);
    }
  }

  /// Change language and save to settings
  Future<void> changeLanguage(String language) async {
    try {
      final locale = _getLocaleFromLanguage(language);
      state = locale;
      await _settingsService.setLanguage(language);
      AppLogger.success('🌍 Language changed to: $language');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to change language', e, stackTrace);
      rethrow;
    }
  }

  /// Get locale from language string
  Locale _getLocaleFromLanguage(String language) {
    switch (language) {
      case 'Tiếng Việt':
        return const Locale('vi', 'VN');
      case '中文':
        return const Locale('zh', 'CN');
      case '日本語':
        return const Locale('ja', 'JP');
      case '한국어':
        return const Locale('ko', 'KR');
      case 'English':
      default:
        return const Locale('en', 'US');
    }
  }

  /// Get current language display name
  String get currentLanguageDisplayName {
    switch (state.languageCode) {
      case 'vi':
        return 'Tiếng Việt';
      case 'zh':
        return '中文';
      case 'ja':
        return '日本語';
      case 'ko':
        return '한국어';
      case 'en':
      default:
        return 'English';
    }
  }

  /// Get supported languages
  List<String> get supportedLanguages => [
    'English',
    'Tiếng Việt',
    '中文',
    '日本語',
    '한국어',
  ];
}

/// Language provider
final languageProvider = StateNotifierProvider<LanguageNotifier, Locale>((ref) {
  return LanguageNotifier();
});

/// Current language display name provider
final currentLanguageProvider = Provider<String>((ref) {
  final languageNotifier = ref.watch(languageProvider.notifier);
  return languageNotifier.currentLanguageDisplayName;
});

/// Supported languages provider
final supportedLanguagesProvider = Provider<List<String>>((ref) {
  final languageNotifier = ref.watch(languageProvider.notifier);
  return languageNotifier.supportedLanguages;
});
