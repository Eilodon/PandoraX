import 'package:freezed_annotation/freezed_annotation.dart';

part 'voice_language.freezed.dart';
part 'voice_language.g.dart';

/// Voice language configuration for STT and TTS
@freezed
class VoiceLanguage with _$VoiceLanguage {
  const factory VoiceLanguage({
    required String code,
    required String name,
    required String nativeName,
    required String sttCode,
    required String ttsCode,
    @Default(false) bool isRTL,
    @Default(true) bool isSTTSupported,
    @Default(true) bool isTTSSupported,
    String? flag,
    @Default(0.5) double defaultSpeechRate,
    @Default(1.0) double defaultVolume,
    @Default(1.0) double defaultPitch,
  }) = _VoiceLanguage;

  const VoiceLanguage._();

  factory VoiceLanguage.fromJson(Map<String, dynamic> json) =>
      _$VoiceLanguageFromJson(json);

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
      case 'nl':
        return '🇳🇱';
      case 'sv':
        return '🇸🇪';
      case 'no':
        return '🇳🇴';
      case 'da':
        return '🇩🇰';
      case 'fi':
        return '🇫🇮';
      case 'pl':
        return '🇵🇱';
      case 'tr':
        return '🇹🇷';
      case 'he':
        return '🇮🇱';
      case 'cs':
        return '🇨🇿';
      case 'sk':
        return '🇸🇰';
      case 'hu':
        return '🇭🇺';
      case 'ro':
        return '🇷🇴';
      case 'bg':
        return '🇧🇬';
      case 'hr':
        return '🇭🇷';
      case 'sl':
        return '🇸🇮';
      case 'et':
        return '🇪🇪';
      case 'lv':
        return '🇱🇻';
      case 'lt':
        return '🇱🇹';
      case 'uk':
        return '🇺🇦';
      case 'be':
        return '🇧🇾';
      case 'ka':
        return '🇬🇪';
      case 'hy':
        return '🇦🇲';
      case 'az':
        return '🇦🇿';
      case 'kk':
        return '🇰🇿';
      case 'ky':
        return '🇰🇬';
      case 'uz':
        return '🇺🇿';
      case 'tg':
        return '🇹🇯';
      case 'mn':
        return '🇲🇳';
      case 'my':
        return '🇲🇲';
      case 'km':
        return '🇰🇭';
      case 'lo':
        return '🇱🇦';
      case 'si':
        return '🇱🇰';
      case 'ne':
        return '🇳🇵';
      case 'bn':
        return '🇧🇩';
      case 'ur':
        return '🇵🇰';
      case 'fa':
        return '🇮🇷';
      case 'ku':
        return '🇮🇶';
      case 'ps':
        return '🇦🇫';
      case 'sw':
        return '🇹🇿';
      case 'am':
        return '🇪🇹';
      case 'ha':
        return '🇳🇬';
      case 'yo':
        return '🇳🇬';
      case 'ig':
        return '🇳🇬';
      case 'zu':
        return '🇿🇦';
      case 'af':
        return '🇿🇦';
      case 'xh':
        return '🇿🇦';
      case 'st':
        return '🇿🇦';
      case 'tn':
        return '🇿🇦';
      case 'ss':
        return '🇿🇦';
      case 've':
        return '🇿🇦';
      case 'ts':
        return '🇿🇦';
      case 'nr':
        return '🇿🇦';
      case 'nso':
        return '🇿🇦';
      default:
        return '🌐';
    }
  }

  /// Check if language is RTL (Right-to-Left)
  bool get isRightToLeft => isRTL;

  /// Get language code for STT API
  String get sttApiCode => sttCode;

  /// Get language code for TTS API
  String get ttsApiCode => ttsCode;

  /// Check if both STT and TTS are supported
  bool get isFullySupported => isSTTSupported && isTTSSupported;

  /// Get voice configuration for TTS
  Map<String, dynamic> get ttsConfig => {
    'language': ttsCode,
    'speechRate': defaultSpeechRate,
    'volume': defaultVolume,
    'pitch': defaultPitch,
  };
}

/// Predefined voice languages
class VoiceLanguages {
  static const VoiceLanguage english = VoiceLanguage(
    code: 'en',
    name: 'English',
    nativeName: 'English',
    sttCode: 'en_US',
    ttsCode: 'en-US',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage vietnamese = VoiceLanguage(
    code: 'vi',
    name: 'Vietnamese',
    nativeName: 'Tiếng Việt',
    sttCode: 'vi_VN',
    ttsCode: 'vi-VN',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage spanish = VoiceLanguage(
    code: 'es',
    name: 'Spanish',
    nativeName: 'Español',
    sttCode: 'es_ES',
    ttsCode: 'es-ES',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage french = VoiceLanguage(
    code: 'fr',
    name: 'French',
    nativeName: 'Français',
    sttCode: 'fr_FR',
    ttsCode: 'fr-FR',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage german = VoiceLanguage(
    code: 'de',
    name: 'German',
    nativeName: 'Deutsch',
    sttCode: 'de_DE',
    ttsCode: 'de-DE',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage japanese = VoiceLanguage(
    code: 'ja',
    name: 'Japanese',
    nativeName: '日本語',
    sttCode: 'ja_JP',
    ttsCode: 'ja-JP',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.4,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage korean = VoiceLanguage(
    code: 'ko',
    name: 'Korean',
    nativeName: '한국어',
    sttCode: 'ko_KR',
    ttsCode: 'ko-KR',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage chinese = VoiceLanguage(
    code: 'zh',
    name: 'Chinese',
    nativeName: '中文',
    sttCode: 'zh_CN',
    ttsCode: 'zh-CN',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage arabic = VoiceLanguage(
    code: 'ar',
    name: 'Arabic',
    nativeName: 'العربية',
    sttCode: 'ar_SA',
    ttsCode: 'ar-SA',
    isRTL: true,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage hindi = VoiceLanguage(
    code: 'hi',
    name: 'Hindi',
    nativeName: 'हिन्दी',
    sttCode: 'hi_IN',
    ttsCode: 'hi-IN',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage portuguese = VoiceLanguage(
    code: 'pt',
    name: 'Portuguese',
    nativeName: 'Português',
    sttCode: 'pt_BR',
    ttsCode: 'pt-BR',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage italian = VoiceLanguage(
    code: 'it',
    name: 'Italian',
    nativeName: 'Italiano',
    sttCode: 'it_IT',
    ttsCode: 'it-IT',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage russian = VoiceLanguage(
    code: 'ru',
    name: 'Russian',
    nativeName: 'Русский',
    sttCode: 'ru_RU',
    ttsCode: 'ru-RU',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage thai = VoiceLanguage(
    code: 'th',
    name: 'Thai',
    nativeName: 'ไทย',
    sttCode: 'th_TH',
    ttsCode: 'th-TH',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage indonesian = VoiceLanguage(
    code: 'id',
    name: 'Indonesian',
    nativeName: 'Bahasa Indonesia',
    sttCode: 'id_ID',
    ttsCode: 'id-ID',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage malay = VoiceLanguage(
    code: 'ms',
    name: 'Malay',
    nativeName: 'Bahasa Melayu',
    sttCode: 'ms_MY',
    ttsCode: 'ms-MY',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage filipino = VoiceLanguage(
    code: 'tl',
    name: 'Filipino',
    nativeName: 'Filipino',
    sttCode: 'tl_PH',
    ttsCode: 'tl-PH',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage dutch = VoiceLanguage(
    code: 'nl',
    name: 'Dutch',
    nativeName: 'Nederlands',
    sttCode: 'nl_NL',
    ttsCode: 'nl-NL',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage swedish = VoiceLanguage(
    code: 'sv',
    name: 'Swedish',
    nativeName: 'Svenska',
    sttCode: 'sv_SE',
    ttsCode: 'sv-SE',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage norwegian = VoiceLanguage(
    code: 'no',
    name: 'Norwegian',
    nativeName: 'Norsk',
    sttCode: 'no_NO',
    ttsCode: 'no-NO',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage danish = VoiceLanguage(
    code: 'da',
    name: 'Danish',
    nativeName: 'Dansk',
    sttCode: 'da_DK',
    ttsCode: 'da-DK',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage finnish = VoiceLanguage(
    code: 'fi',
    name: 'Finnish',
    nativeName: 'Suomi',
    sttCode: 'fi_FI',
    ttsCode: 'fi-FI',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage polish = VoiceLanguage(
    code: 'pl',
    name: 'Polish',
    nativeName: 'Polski',
    sttCode: 'pl_PL',
    ttsCode: 'pl-PL',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage turkish = VoiceLanguage(
    code: 'tr',
    name: 'Turkish',
    nativeName: 'Türkçe',
    sttCode: 'tr_TR',
    ttsCode: 'tr-TR',
    isRTL: false,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  static const VoiceLanguage hebrew = VoiceLanguage(
    code: 'he',
    name: 'Hebrew',
    nativeName: 'עברית',
    sttCode: 'he_IL',
    ttsCode: 'he-IL',
    isRTL: true,
    isSTTSupported: true,
    isTTSSupported: true,
    defaultSpeechRate: 0.5,
    defaultVolume: 1.0,
    defaultPitch: 1.0,
  );

  /// Get all supported voice languages
  static List<VoiceLanguage> get all => [
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
    dutch,
    swedish,
    norwegian,
    danish,
    finnish,
    polish,
    turkish,
    hebrew,
  ];

  /// Get languages by region
  static List<VoiceLanguage> getByRegion(String region) {
    switch (region.toLowerCase()) {
      case 'asia':
        return [vietnamese, japanese, korean, chinese, thai, indonesian, malay, filipino, hindi];
      case 'europe':
        return [english, spanish, french, german, italian, russian, portuguese, dutch, swedish, norwegian, danish, finnish, polish, turkish, hebrew];
      case 'americas':
        return [english, spanish, portuguese];
      case 'middle_east':
        return [arabic, hebrew, english];
      case 'africa':
        return [english, french, arabic];
      default:
        return all;
    }
  }

  /// Get language by code
  static VoiceLanguage? getByCode(String code) {
    try {
      return all.firstWhere((lang) => lang.code.toLowerCase() == code.toLowerCase());
    } catch (e) {
      return null;
    }
  }

  /// Get RTL languages
  static List<VoiceLanguage> get rtlLanguages {
    return all.where((lang) => lang.isRTL).toList();
  }

  /// Get LTR languages
  static List<VoiceLanguage> get ltrLanguages {
    return all.where((lang) => !lang.isRTL).toList();
  }

  /// Get popular languages (most commonly used)
  static List<VoiceLanguage> get popular {
    return [
      english,
      chinese,
      spanish,
      hindi,
      arabic,
      portuguese,
      russian,
      japanese,
      vietnamese,
      french,
    ];
  }

  /// Get STT supported languages
  static List<VoiceLanguage> get sttSupported {
    return all.where((lang) => lang.isSTTSupported).toList();
  }

  /// Get TTS supported languages
  static List<VoiceLanguage> get ttsSupported {
    return all.where((lang) => lang.isTTSSupported).toList();
  }

  /// Get fully supported languages (both STT and TTS)
  static List<VoiceLanguage> get fullySupported {
    return all.where((lang) => lang.isFullySupported).toList();
  }
}
