import 'package:flutter/material.dart';

/// App Localizations for multi-language support
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  // Common
  String get appName => _localizedValues[locale.languageCode]!['appName']!;
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  String get cancel => _localizedValues[locale.languageCode]!['cancel']!;
  String get save => _localizedValues[locale.languageCode]!['save']!;
  String get delete => _localizedValues[locale.languageCode]!['delete']!;
  String get edit => _localizedValues[locale.languageCode]!['edit']!;
  String get add => _localizedValues[locale.languageCode]!['add']!;
  String get close => _localizedValues[locale.languageCode]!['close']!;
  String get ok => _localizedValues[locale.languageCode]!['ok']!;
  String get yes => _localizedValues[locale.languageCode]!['yes']!;
  String get no => _localizedValues[locale.languageCode]!['no']!;

  // Home Screen
  String get welcome => _localizedValues[locale.languageCode]!['welcome']!;
  String get newNote => _localizedValues[locale.languageCode]!['newNote']!;
  String get voiceNote => _localizedValues[locale.languageCode]!['voiceNote']!;
  String get aiAssistant => _localizedValues[locale.languageCode]!['aiAssistant']!;
  String get myNotes => _localizedValues[locale.languageCode]!['myNotes']!;

  // Settings Screen
  String get appearance => _localizedValues[locale.languageCode]!['appearance']!;
  String get darkMode => _localizedValues[locale.languageCode]!['darkMode']!;
  String get darkModeSubtitle => _localizedValues[locale.languageCode]!['darkModeSubtitle']!;
  String get fontSize => _localizedValues[locale.languageCode]!['fontSize']!;
  String get fontSizeSubtitle => _localizedValues[locale.languageCode]!['fontSizeSubtitle']!;
  String get notifications => _localizedValues[locale.languageCode]!['notifications']!;
  String get pushNotifications => _localizedValues[locale.languageCode]!['pushNotifications']!;
  String get pushNotificationsSubtitle => _localizedValues[locale.languageCode]!['pushNotificationsSubtitle']!;
  String get securityPrivacy => _localizedValues[locale.languageCode]!['securityPrivacy']!;
  String get biometricAuth => _localizedValues[locale.languageCode]!['biometricAuth']!;
  String get biometricAuthSubtitle => _localizedValues[locale.languageCode]!['biometricAuthSubtitle']!;
  String get privacySettings => _localizedValues[locale.languageCode]!['privacySettings']!;
  String get privacySettingsSubtitle => _localizedValues[locale.languageCode]!['privacySettingsSubtitle']!;
  String get dataEncryption => _localizedValues[locale.languageCode]!['dataEncryption']!;
  String get dataEncryptionSubtitle => _localizedValues[locale.languageCode]!['dataEncryptionSubtitle']!;
  String get syncBackup => _localizedValues[locale.languageCode]!['syncBackup']!;
  String get autoSync => _localizedValues[locale.languageCode]!['autoSync']!;
  String get autoSyncSubtitle => _localizedValues[locale.languageCode]!['autoSyncSubtitle']!;
  String get backupRestore => _localizedValues[locale.languageCode]!['backupRestore']!;
  String get backupRestoreSubtitle => _localizedValues[locale.languageCode]!['backupRestoreSubtitle']!;
  String get languageRegion => _localizedValues[locale.languageCode]!['languageRegion']!;
  String get language => _localizedValues[locale.languageCode]!['language']!;
  String get about => _localizedValues[locale.languageCode]!['about']!;
  String get appVersion => _localizedValues[locale.languageCode]!['appVersion']!;
  String get helpSupport => _localizedValues[locale.languageCode]!['helpSupport']!;
  String get helpSupportSubtitle => _localizedValues[locale.languageCode]!['helpSupportSubtitle']!;
  String get rateApp => _localizedValues[locale.languageCode]!['rateApp']!;
  String get rateAppSubtitle => _localizedValues[locale.languageCode]!['rateAppSubtitle']!;
  String get dangerZone => _localizedValues[locale.languageCode]!['dangerZone']!;
  String get deleteAllData => _localizedValues[locale.languageCode]!['deleteAllData']!;
  String get deleteAllDataSubtitle => _localizedValues[locale.languageCode]!['deleteAllDataSubtitle']!;

  // Language Dialog
  String get selectLanguage => _localizedValues[locale.languageCode]!['selectLanguage']!;

  // Note Editor
  String get title => _localizedValues[locale.languageCode]!['title']!;
  String get content => _localizedValues[locale.languageCode]!['content']!;
  String get tags => _localizedValues[locale.languageCode]!['tags']!;
  String get category => _localizedValues[locale.languageCode]!['category']!;
  String get reminder => _localizedValues[locale.languageCode]!['reminder']!;
  String get reminderDate => _localizedValues[locale.languageCode]!['reminderDate']!;
  String get reminderTime => _localizedValues[locale.languageCode]!['reminderTime']!;
  String get reminderType => _localizedValues[locale.languageCode]!['reminderType']!;
  String get repeatFrequency => _localizedValues[locale.languageCode]!['repeatFrequency']!;

  // AI Chat
  String get aiChat => _localizedValues[locale.languageCode]!['aiChat']!;
  String get typeMessage => _localizedValues[locale.languageCode]!['typeMessage']!;
  String get send => _localizedValues[locale.languageCode]!['send']!;

  // Voice Screen
  String get voice => _localizedValues[locale.languageCode]!['voice']!;
  String get tapToSpeak => _localizedValues[locale.languageCode]!['tapToSpeak']!;
  String get listening => _localizedValues[locale.languageCode]!['listening']!;
  String get processing => _localizedValues[locale.languageCode]!['processing']!;

  // Error Messages
  String get error => _localizedValues[locale.languageCode]!['error']!;
  String get success => _localizedValues[locale.languageCode]!['success']!;
  String get warning => _localizedValues[locale.languageCode]!['warning']!;
  String get info => _localizedValues[locale.languageCode]!['info']!;

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appName': 'PandoraX',
      'settings': 'Settings',
      'cancel': 'Cancel',
      'save': 'Save',
      'delete': 'Delete',
      'edit': 'Edit',
      'add': 'Add',
      'close': 'Close',
      'ok': 'OK',
      'yes': 'Yes',
      'no': 'No',
      'welcome': 'Welcome to PandoraX',
      'newNote': 'New Note',
      'voiceNote': 'Voice Note',
      'aiAssistant': 'AI Assistant',
      'myNotes': 'My Notes',
      'appearance': 'Appearance',
      'darkMode': 'Dark Mode',
      'darkModeSubtitle': 'Switch between light and dark themes',
      'fontSize': 'Font Size',
      'fontSizeSubtitle': 'Adjust text size for better readability',
      'notifications': 'Notifications',
      'pushNotifications': 'Push Notifications',
      'pushNotificationsSubtitle': 'Receive notifications for reminders and updates',
      'securityPrivacy': 'Security & Privacy',
      'biometricAuth': 'Biometric Authentication',
      'biometricAuthSubtitle': 'Use fingerprint or face recognition to unlock',
      'privacySettings': 'Privacy Settings',
      'privacySettingsSubtitle': 'Manage data collection and usage',
      'dataEncryption': 'Data Encryption',
      'dataEncryptionSubtitle': 'Encrypt your notes for maximum security',
      'syncBackup': 'Sync & Backup',
      'autoSync': 'Auto Sync',
      'autoSyncSubtitle': 'Automatically sync your notes to the cloud',
      'backupRestore': 'Backup & Restore',
      'backupRestoreSubtitle': 'Create backups and restore your data',
      'languageRegion': 'Language & Region',
      'language': 'Language',
      'about': 'About',
      'appVersion': 'App Version',
      'helpSupport': 'Help & Support',
      'helpSupportSubtitle': 'Get help and contact support',
      'rateApp': 'Rate App',
      'rateAppSubtitle': 'Rate us on the Play Store',
      'dangerZone': 'Danger Zone',
      'deleteAllData': 'Delete All Data',
      'deleteAllDataSubtitle': 'Permanently delete all notes and settings',
      'selectLanguage': 'Select Language',
      'title': 'Title',
      'content': 'Content',
      'tags': 'Tags',
      'category': 'Category',
      'reminder': 'Reminder',
      'reminderDate': 'Reminder Date',
      'reminderTime': 'Reminder Time',
      'reminderType': 'Reminder Type',
      'repeatFrequency': 'Repeat Frequency',
      'aiChat': 'AI Chat',
      'typeMessage': 'Type a message...',
      'send': 'Send',
      'voice': 'Voice',
      'tapToSpeak': 'Tap to Speak',
      'listening': 'Listening...',
      'processing': 'Processing...',
      'error': 'Error',
      'success': 'Success',
      'warning': 'Warning',
      'info': 'Info',
    },
    'vi': {
      'appName': 'PandoraX',
      'settings': 'Cài đặt',
      'cancel': 'Hủy',
      'save': 'Lưu',
      'delete': 'Xóa',
      'edit': 'Chỉnh sửa',
      'add': 'Thêm',
      'close': 'Đóng',
      'ok': 'OK',
      'yes': 'Có',
      'no': 'Không',
      'welcome': 'Chào mừng đến với PandoraX',
      'newNote': 'Ghi chú mới',
      'voiceNote': 'Ghi chú giọng nói',
      'aiAssistant': 'Trợ lý AI',
      'myNotes': 'Ghi chú của tôi',
      'appearance': 'Giao diện',
      'darkMode': 'Chế độ tối',
      'darkModeSubtitle': 'Chuyển đổi giữa chế độ sáng và tối',
      'fontSize': 'Kích thước chữ',
      'fontSizeSubtitle': 'Điều chỉnh kích thước chữ để dễ đọc hơn',
      'notifications': 'Thông báo',
      'pushNotifications': 'Thông báo đẩy',
      'pushNotificationsSubtitle': 'Nhận thông báo cho lời nhắc và cập nhật',
      'securityPrivacy': 'Bảo mật & Quyền riêng tư',
      'biometricAuth': 'Xác thực sinh trắc học',
      'biometricAuthSubtitle': 'Sử dụng vân tay hoặc nhận dạng khuôn mặt để mở khóa',
      'privacySettings': 'Cài đặt quyền riêng tư',
      'privacySettingsSubtitle': 'Quản lý thu thập và sử dụng dữ liệu',
      'dataEncryption': 'Mã hóa dữ liệu',
      'dataEncryptionSubtitle': 'Mã hóa ghi chú của bạn để bảo mật tối đa',
      'syncBackup': 'Đồng bộ & Sao lưu',
      'autoSync': 'Tự động đồng bộ',
      'autoSyncSubtitle': 'Tự động đồng bộ ghi chú lên đám mây',
      'backupRestore': 'Sao lưu & Khôi phục',
      'backupRestoreSubtitle': 'Tạo sao lưu và khôi phục dữ liệu',
      'languageRegion': 'Ngôn ngữ & Vùng',
      'language': 'Ngôn ngữ',
      'about': 'Giới thiệu',
      'appVersion': 'Phiên bản ứng dụng',
      'helpSupport': 'Trợ giúp & Hỗ trợ',
      'helpSupportSubtitle': 'Nhận trợ giúp và liên hệ hỗ trợ',
      'rateApp': 'Đánh giá ứng dụng',
      'rateAppSubtitle': 'Đánh giá chúng tôi trên Play Store',
      'dangerZone': 'Vùng nguy hiểm',
      'deleteAllData': 'Xóa tất cả dữ liệu',
      'deleteAllDataSubtitle': 'Xóa vĩnh viễn tất cả ghi chú và cài đặt',
      'selectLanguage': 'Chọn ngôn ngữ',
      'title': 'Tiêu đề',
      'content': 'Nội dung',
      'tags': 'Thẻ',
      'category': 'Danh mục',
      'reminder': 'Lời nhắc',
      'reminderDate': 'Ngày nhắc',
      'reminderTime': 'Giờ nhắc',
      'reminderType': 'Loại nhắc',
      'repeatFrequency': 'Tần suất lặp lại',
      'aiChat': 'Trò chuyện AI',
      'typeMessage': 'Nhập tin nhắn...',
      'send': 'Gửi',
      'voice': 'Giọng nói',
      'tapToSpeak': 'Chạm để nói',
      'listening': 'Đang nghe...',
      'processing': 'Đang xử lý...',
      'error': 'Lỗi',
      'success': 'Thành công',
      'warning': 'Cảnh báo',
      'info': 'Thông tin',
    },
    'zh': {
      'appName': 'PandoraX',
      'settings': '设置',
      'cancel': '取消',
      'save': '保存',
      'delete': '删除',
      'edit': '编辑',
      'add': '添加',
      'close': '关闭',
      'ok': '确定',
      'yes': '是',
      'no': '否',
      'welcome': '欢迎使用 PandoraX',
      'newNote': '新笔记',
      'voiceNote': '语音笔记',
      'aiAssistant': 'AI 助手',
      'myNotes': '我的笔记',
      'appearance': '外观',
      'darkMode': '深色模式',
      'darkModeSubtitle': '在浅色和深色主题之间切换',
      'fontSize': '字体大小',
      'fontSizeSubtitle': '调整文字大小以提高可读性',
      'notifications': '通知',
      'pushNotifications': '推送通知',
      'pushNotificationsSubtitle': '接收提醒和更新的通知',
      'securityPrivacy': '安全与隐私',
      'biometricAuth': '生物识别认证',
      'biometricAuthSubtitle': '使用指纹或面部识别解锁',
      'privacySettings': '隐私设置',
      'privacySettingsSubtitle': '管理数据收集和使用',
      'dataEncryption': '数据加密',
      'dataEncryptionSubtitle': '加密您的笔记以确保最大安全性',
      'syncBackup': '同步与备份',
      'autoSync': '自动同步',
      'autoSyncSubtitle': '自动将笔记同步到云端',
      'backupRestore': '备份与恢复',
      'backupRestoreSubtitle': '创建备份并恢复数据',
      'languageRegion': '语言与地区',
      'language': '语言',
      'about': '关于',
      'appVersion': '应用版本',
      'helpSupport': '帮助与支持',
      'helpSupportSubtitle': '获取帮助并联系支持',
      'rateApp': '评价应用',
      'rateAppSubtitle': '在 Play Store 上评价我们',
      'dangerZone': '危险区域',
      'deleteAllData': '删除所有数据',
      'deleteAllDataSubtitle': '永久删除所有笔记和设置',
      'selectLanguage': '选择语言',
      'title': '标题',
      'content': '内容',
      'tags': '标签',
      'category': '分类',
      'reminder': '提醒',
      'reminderDate': '提醒日期',
      'reminderTime': '提醒时间',
      'reminderType': '提醒类型',
      'repeatFrequency': '重复频率',
      'aiChat': 'AI 聊天',
      'typeMessage': '输入消息...',
      'send': '发送',
      'voice': '语音',
      'tapToSpeak': '点击说话',
      'listening': '正在聆听...',
      'processing': '正在处理...',
      'error': '错误',
      'success': '成功',
      'warning': '警告',
      'info': '信息',
    },
    'ja': {
      'appName': 'PandoraX',
      'settings': '設定',
      'cancel': 'キャンセル',
      'save': '保存',
      'delete': '削除',
      'edit': '編集',
      'add': '追加',
      'close': '閉じる',
      'ok': 'OK',
      'yes': 'はい',
      'no': 'いいえ',
      'welcome': 'PandoraX へようこそ',
      'newNote': '新しいノート',
      'voiceNote': '音声ノート',
      'aiAssistant': 'AI アシスタント',
      'myNotes': 'マイノート',
      'appearance': '外観',
      'darkMode': 'ダークモード',
      'darkModeSubtitle': 'ライトテーマとダークテーマを切り替え',
      'fontSize': 'フォントサイズ',
      'fontSizeSubtitle': '読みやすさのためにテキストサイズを調整',
      'notifications': '通知',
      'pushNotifications': 'プッシュ通知',
      'pushNotificationsSubtitle': 'リマインダーと更新の通知を受信',
      'securityPrivacy': 'セキュリティとプライバシー',
      'biometricAuth': '生体認証',
      'biometricAuthSubtitle': '指紋または顔認証でロック解除',
      'privacySettings': 'プライバシー設定',
      'privacySettingsSubtitle': 'データ収集と使用を管理',
      'dataEncryption': 'データ暗号化',
      'dataEncryptionSubtitle': '最大のセキュリティのためにノートを暗号化',
      'syncBackup': '同期とバックアップ',
      'autoSync': '自動同期',
      'autoSyncSubtitle': 'ノートをクラウドに自動同期',
      'backupRestore': 'バックアップと復元',
      'backupRestoreSubtitle': 'バックアップを作成し、データを復元',
      'languageRegion': '言語と地域',
      'language': '言語',
      'about': 'について',
      'appVersion': 'アプリバージョン',
      'helpSupport': 'ヘルプとサポート',
      'helpSupportSubtitle': 'ヘルプを取得し、サポートに連絡',
      'rateApp': 'アプリを評価',
      'rateAppSubtitle': 'Play Store で評価',
      'dangerZone': '危険ゾーン',
      'deleteAllData': 'すべてのデータを削除',
      'deleteAllDataSubtitle': 'すべてのノートと設定を永続的に削除',
      'selectLanguage': '言語を選択',
      'title': 'タイトル',
      'content': 'コンテンツ',
      'tags': 'タグ',
      'category': 'カテゴリ',
      'reminder': 'リマインダー',
      'reminderDate': 'リマインダー日付',
      'reminderTime': 'リマインダー時間',
      'reminderType': 'リマインダータイプ',
      'repeatFrequency': '繰り返し頻度',
      'aiChat': 'AI チャット',
      'typeMessage': 'メッセージを入力...',
      'send': '送信',
      'voice': '音声',
      'tapToSpeak': 'タップして話す',
      'listening': '聞いています...',
      'processing': '処理中...',
      'error': 'エラー',
      'success': '成功',
      'warning': '警告',
      'info': '情報',
    },
    'ko': {
      'appName': 'PandoraX',
      'settings': '설정',
      'cancel': '취소',
      'save': '저장',
      'delete': '삭제',
      'edit': '편집',
      'add': '추가',
      'close': '닫기',
      'ok': '확인',
      'yes': '예',
      'no': '아니오',
      'welcome': 'PandoraX에 오신 것을 환영합니다',
      'newNote': '새 노트',
      'voiceNote': '음성 노트',
      'aiAssistant': 'AI 어시스턴트',
      'myNotes': '내 노트',
      'appearance': '외관',
      'darkMode': '다크 모드',
      'darkModeSubtitle': '라이트 테마와 다크 테마 간 전환',
      'fontSize': '글꼴 크기',
      'fontSizeSubtitle': '가독성을 위해 텍스트 크기 조정',
      'notifications': '알림',
      'pushNotifications': '푸시 알림',
      'pushNotificationsSubtitle': '리마인더 및 업데이트 알림 수신',
      'securityPrivacy': '보안 및 개인정보',
      'biometricAuth': '생체 인증',
      'biometricAuthSubtitle': '지문 또는 얼굴 인식으로 잠금 해제',
      'privacySettings': '개인정보 설정',
      'privacySettingsSubtitle': '데이터 수집 및 사용 관리',
      'dataEncryption': '데이터 암호화',
      'dataEncryptionSubtitle': '최대 보안을 위해 노트 암호화',
      'syncBackup': '동기화 및 백업',
      'autoSync': '자동 동기화',
      'autoSyncSubtitle': '노트를 클라우드에 자동 동기화',
      'backupRestore': '백업 및 복원',
      'backupRestoreSubtitle': '백업 생성 및 데이터 복원',
      'languageRegion': '언어 및 지역',
      'language': '언어',
      'about': '정보',
      'appVersion': '앱 버전',
      'helpSupport': '도움말 및 지원',
      'helpSupportSubtitle': '도움말을 받고 지원에 문의',
      'rateApp': '앱 평가',
      'rateAppSubtitle': 'Play Store에서 평가',
      'dangerZone': '위험 구역',
      'deleteAllData': '모든 데이터 삭제',
      'deleteAllDataSubtitle': '모든 노트와 설정을 영구적으로 삭제',
      'selectLanguage': '언어 선택',
      'title': '제목',
      'content': '내용',
      'tags': '태그',
      'category': '카테고리',
      'reminder': '리마인더',
      'reminderDate': '리마인더 날짜',
      'reminderTime': '리마인더 시간',
      'reminderType': '리마인더 유형',
      'repeatFrequency': '반복 빈도',
      'aiChat': 'AI 채팅',
      'typeMessage': '메시지 입력...',
      'send': '보내기',
      'voice': '음성',
      'tapToSpeak': '탭하여 말하기',
      'listening': '듣는 중...',
      'processing': '처리 중...',
      'error': '오류',
      'success': '성공',
      'warning': '경고',
      'info': '정보',
    },
  };
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'vi', 'zh', 'ja', 'ko'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
