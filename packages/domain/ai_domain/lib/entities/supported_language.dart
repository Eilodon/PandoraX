import 'package:freezed_annotation/freezed_annotation.dart';

part 'supported_language.freezed.dart';
part 'supported_language.g.dart';

/// Supported language for AI operations
@freezed
class SupportedLanguage with _$SupportedLanguage {
  const factory SupportedLanguage({
    required String code,
    required String name,
    required String nativeName,
    @Default(false) bool isRTL,
    @Default(true) bool isSupported,
    String? flag,
  }) = _SupportedLanguage;

  const SupportedLanguage._();

  factory SupportedLanguage.fromJson(Map<String, dynamic> json) =>
      _$SupportedLanguageFromJson(json);

  /// Get display name for UI
  String get displayName => '$nativeName ($name)';

  /// Get flag emoji for UI
  String get flagEmoji {
    if (flag != null) return flag!;
    
    // Default flag mapping
    switch (code.toLowerCase()) {
      case 'en':
        return '🇺🇸';
      case 'vi':
        return '🇻🇳';
      case 'es':
        return '🇪🇸';
      case 'fr':
        return '🇫🇷';
      case 'de':
        return '🇩🇪';
      case 'ja':
        return '🇯🇵';
      case 'ko':
        return '🇰🇷';
      case 'zh':
        return '🇨🇳';
      case 'ar':
        return '🇸🇦';
      case 'hi':
        return '🇮🇳';
      case 'pt':
        return '🇵🇹';
      case 'it':
        return '🇮🇹';
      case 'ru':
        return '🇷🇺';
      case 'th':
        return '🇹🇭';
      case 'id':
        return '🇮🇩';
      case 'ms':
        return '🇲🇾';
      case 'tl':
        return '🇵🇭';
      default:
        return '🌐';
    }
  }

  /// Check if language is RTL (Right-to-Left)
  bool get isRightToLeft => isRTL;

  /// Get language code for API calls
  String get apiCode => code;

  /// Get language code for locale
  String get localeCode {
    switch (code.toLowerCase()) {
      case 'zh':
        return 'zh-CN';
      case 'pt':
        return 'pt-BR';
      case 'es':
        return 'es-ES';
      default:
        return code;
    }
  }
}

/// Predefined supported languages
class SupportedLanguages {
  static const SupportedLanguage english = SupportedLanguage(
    code: 'en',
    name: 'English',
    nativeName: 'English',
    isRTL: false,
    isSupported: true,
  );

  static const SupportedLanguage vietnamese = SupportedLanguage(
    code: 'vi',
    name: 'Vietnamese',
    nativeName: 'Tiếng Việt',
    isRTL: false,
    isSupported: true,
  );

  static const SupportedLanguage spanish = SupportedLanguage(
    code: 'es',
    name: 'Spanish',
    nativeName: 'Español',
    isRTL: false,
    isSupported: true,
  );

  static const SupportedLanguage french = SupportedLanguage(
    code: 'fr',
    name: 'French',
    nativeName: 'Français',
    isRTL: false,
    isSupported: true,
  );

  static const SupportedLanguage german = SupportedLanguage(
    code: 'de',
    name: 'German',
    nativeName: 'Deutsch',
    isRTL: false,
    isSupported: true,
  );

  static const SupportedLanguage japanese = SupportedLanguage(
    code: 'ja',
    name: 'Japanese',
    nativeName: '日本語',
    isRTL: false,
    isSupported: true,
  );

  static const SupportedLanguage korean = SupportedLanguage(
    code: 'ko',
    name: 'Korean',
    nativeName: '한국어',
    isRTL: false,
    isSupported: true,
  );

  static const SupportedLanguage chinese = SupportedLanguage(
    code: 'zh',
    name: 'Chinese',
    nativeName: '中文',
    isRTL: false,
    isSupported: true,
  );

  static const SupportedLanguage arabic = SupportedLanguage(
    code: 'ar',
    name: 'Arabic',
    nativeName: 'العربية',
    isRTL: true,
    isSupported: true,
  );

  static const SupportedLanguage hindi = SupportedLanguage(
    code: 'hi',
    name: 'Hindi',
    nativeName: 'हिन्दी',
    isRTL: false,
    isSupported: true,
  );

  static const SupportedLanguage portuguese = SupportedLanguage(
    code: 'pt',
    name: 'Portuguese',
    nativeName: 'Português',
    isRTL: false,
    isSupported: true,
  );

  static const SupportedLanguage italian = SupportedLanguage(
    code: 'it',
    name: 'Italian',
    nativeName: 'Italiano',
    isRTL: false,
    isSupported: true,
  );

  static const SupportedLanguage russian = SupportedLanguage(
    code: 'ru',
    name: 'Russian',
    nativeName: 'Русский',
    isRTL: false,
    isSupported: true,
  );

  static const SupportedLanguage thai = SupportedLanguage(
    code: 'th',
    name: 'Thai',
    nativeName: 'ไทย',
    isRTL: false,
    isSupported: true,
  );

  static const SupportedLanguage indonesian = SupportedLanguage(
    code: 'id',
    name: 'Indonesian',
    nativeName: 'Bahasa Indonesia',
    isRTL: false,
    isSupported: true,
  );

  static const SupportedLanguage malay = SupportedLanguage(
    code: 'ms',
    name: 'Malay',
    nativeName: 'Bahasa Melayu',
    isRTL: false,
    isSupported: true,
  );

  static const SupportedLanguage filipino = SupportedLanguage(
    code: 'tl',
    name: 'Filipino',
    nativeName: 'Filipino',
    isRTL: false,
    isSupported: true,
  );

  /// Get all supported languages
  static List<SupportedLanguage> get all => [
    english,
    vietnamese,
    spanish,
    french,
    german,
    japanese,
    korean,
    chinese,
    arabic,
    hindi,
    portuguese,
    italian,
    russian,
    thai,
    indonesian,
    malay,
    filipino,
  ];

  /// Get languages by region
  static List<SupportedLanguage> getByRegion(String region) {
    switch (region.toLowerCase()) {
      case 'asia':
        return [vietnamese, japanese, korean, chinese, thai, indonesian, malay, filipino, hindi];
      case 'europe':
        return [english, spanish, french, german, italian, russian, portuguese];
      case 'americas':
        return [english, spanish, portuguese];
      case 'middle_east':
        return [arabic, english];
      case 'africa':
        return [english, french, arabic];
      default:
        return all;
    }
  }

  /// Get language by code
  static SupportedLanguage? getByCode(String code) {
    try {
      return all.firstWhere((lang) => lang.code.toLowerCase() == code.toLowerCase());
    } catch (e) {
      return null;
    }
  }

  /// Get RTL languages
  static List<SupportedLanguage> get rtlLanguages {
    return all.where((lang) => lang.isRTL).toList();
  }

  /// Get LTR languages
  static List<SupportedLanguage> get ltrLanguages {
    return all.where((lang) => !lang.isRTL).toList();
  }

  /// Get popular languages (most commonly used)
  static List<SupportedLanguage> get popular {
    return [
      english,
      chinese,
      spanish,
      hindi,
      arabic,
      portuguese,
      bengali,
      russian,
      japanese,
      vietnamese,
    ];
  }

  /// Bengali language (added for completeness)
  static const SupportedLanguage bengali = SupportedLanguage(
    code: 'bn',
    name: 'Bengali',
    nativeName: 'বাংলা',
    isRTL: false,
    isSupported: true,
  );
}
