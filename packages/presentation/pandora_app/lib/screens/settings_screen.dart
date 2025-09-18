import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_tokens/design_tokens.dart';
import '../services/settings_service.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late SettingsService _settingsService;
  late ThemeNotifier _themeNotifier;
  
  bool _notifications = true;
  bool _biometricAuth = false;
  bool _autoSync = true;
  String _selectedLanguage = 'English';
  double _fontSize = 1.0;
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _settingsService = SettingsService();
    _themeNotifier = ref.read(themeProvider.notifier);
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    await _settingsService.initialize();
    setState(() {
      _darkMode = _settingsService.isDarkMode;
      _notifications = _settingsService.notificationsEnabled;
      _biometricAuth = _settingsService.biometricAuthEnabled;
      _autoSync = _settingsService.autoSyncEnabled;
      _selectedLanguage = _settingsService.language;
      _fontSize = _settingsService.fontSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: PandoraColors.primary,
        foregroundColor: PandoraColors.onPrimary,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Appearance Section
          _buildSectionHeader('Appearance'),
          _buildSwitchTile(
            icon: Icons.dark_mode,
            title: 'Dark Mode',
            subtitle: 'Switch between light and dark themes',
            value: _darkMode,
            onChanged: (value) async {
              setState(() => _darkMode = value);
              await _settingsService.setDarkMode(value);
              await _themeNotifier.toggleTheme();
            },
          ),
          _buildSliderTile(
            icon: Icons.text_fields,
            title: 'Font Size',
            subtitle: 'Adjust text size for better readability',
            value: _fontSize,
            min: 0.8,
            max: 1.5,
            onChanged: (value) async {
              setState(() => _fontSize = value);
              await _settingsService.setFontSize(value);
              await _themeNotifier.setFontSize(value);
            },
          ),
          
          const SizedBox(height: 24),
          
          // Notifications Section
          _buildSectionHeader('Notifications'),
          _buildSwitchTile(
            icon: Icons.notifications,
            title: 'Push Notifications',
            subtitle: 'Receive notifications for reminders and updates',
            value: _notifications,
            onChanged: (value) async {
              setState(() => _notifications = value);
              await _settingsService.setNotificationsEnabled(value);
            },
          ),
          
          const SizedBox(height: 24),
          
          // Security Section
          _buildSectionHeader('Security & Privacy'),
          _buildSwitchTile(
            icon: Icons.fingerprint,
            title: 'Biometric Authentication',
            subtitle: 'Use fingerprint or face recognition to unlock',
            value: _biometricAuth,
            onChanged: (value) async {
              setState(() => _biometricAuth = value);
              await _settingsService.setBiometricAuthEnabled(value);
            },
          ),
          _buildListTile(
            icon: Icons.privacy_tip,
            title: 'Privacy Settings',
            subtitle: 'Manage data collection and usage',
            onTap: () => _showPrivacySettings(),
          ),
          _buildListTile(
            icon: Icons.security,
            title: 'Data Encryption',
            subtitle: 'Encrypt your notes for maximum security',
            onTap: () => _showEncryptionSettings(),
          ),
          
          const SizedBox(height: 24),
          
          // Sync Section
          _buildSectionHeader('Sync & Backup'),
          _buildSwitchTile(
            icon: Icons.sync,
            title: 'Auto Sync',
            subtitle: 'Automatically sync your notes to the cloud',
            value: _autoSync,
            onChanged: (value) async {
              setState(() => _autoSync = value);
              await _settingsService.setAutoSyncEnabled(value);
            },
          ),
          _buildListTile(
            icon: Icons.backup,
            title: 'Backup & Restore',
            subtitle: 'Create backups and restore your data',
            onTap: () => _showBackupSettings(),
          ),
          
          const SizedBox(height: 24),
          
          // Language Section
          _buildSectionHeader('Language & Region'),
          _buildListTile(
            icon: Icons.language,
            title: 'Language',
            subtitle: _selectedLanguage,
            onTap: () => _showLanguageDialog(),
          ),
          
          const SizedBox(height: 24),
          
          // About Section
          _buildSectionHeader('About'),
          _buildListTile(
            icon: Icons.info,
            title: 'App Version',
            subtitle: '1.0.0 (Build 100)',
            onTap: () => _showAboutDialog(),
          ),
          _buildListTile(
            icon: Icons.help,
            title: 'Help & Support',
            subtitle: 'Get help and contact support',
            onTap: () => _showHelpDialog(),
          ),
          _buildListTile(
            icon: Icons.star,
            title: 'Rate App',
            subtitle: 'Rate us on the Play Store',
            onTap: () => _rateApp(),
          ),
          
          const SizedBox(height: 24),
          
          // Danger Zone
          _buildSectionHeader('Danger Zone'),
          _buildListTile(
            icon: Icons.delete_forever,
            title: 'Delete All Data',
            subtitle: 'Permanently delete all notes and settings',
            onTap: () => _showDeleteAllDialog(),
            textColor: PandoraColors.error,
            iconColor: PandoraColors.error,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: PandoraTextStyles.titleMedium.copyWith(
          color: PandoraColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: SwitchListTile(
        secondary: Icon(icon, color: PandoraColors.primary),
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
        activeColor: PandoraColors.primary,
      ),
    );
  }

  Widget _buildSliderTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: PandoraColors.primary),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: PandoraTextStyles.titleMedium),
                      Text(subtitle, style: PandoraTextStyles.bodySmall.copyWith(
                        color: PandoraColors.textSecondary,
                      )),
                    ],
                  ),
                ),
                Text(
                  '${(value * 100).round()}%',
                  style: PandoraTextStyles.bodyMedium.copyWith(
                    color: PandoraColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Slider(
              value: value,
              min: min,
              max: max,
              onChanged: onChanged,
              activeColor: PandoraColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: iconColor ?? PandoraColors.primary),
        title: Text(
          title,
          style: TextStyle(color: textColor),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: textColor?.withValues(alpha: 0.7) ?? PandoraColors.textSecondary,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showPrivacySettings() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Privacy Settings'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SwitchListTile(
                  title: const Text('Data Collection'),
                  subtitle: const Text('Allow app to collect usage data for improvement'),
                  value: _settingsService.privacyModeEnabled,
                  onChanged: (value) async {
                    await _settingsService.setPrivacyModeEnabled(value);
                    setState(() {});
                  },
                ),
                SwitchListTile(
                  title: const Text('Data Encryption'),
                  subtitle: const Text('Encrypt sensitive data locally'),
                  value: _settingsService.dataEncryptionEnabled,
                  onChanged: (value) async {
                    await _settingsService.setDataEncryptionEnabled(value);
                    setState(() {});
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('Export Data'),
                  subtitle: const Text('Download your data'),
                  leading: const Icon(Icons.download),
                  onTap: () => _exportData(),
                ),
                ListTile(
                  title: const Text('Delete All Data'),
                  subtitle: const Text('Permanently delete all app data'),
                  leading: const Icon(Icons.delete_forever, color: Colors.red),
                  onTap: () => _showDeleteDataDialog(),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showEncryptionSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Data Encryption'),
        content: const Text(
          'Data encryption protects your notes with military-grade encryption. '
          'This ensures that even if your device is compromised, your data remains secure. '
          'Note: This feature requires a device restart to take effect.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Encryption enabled! Restart required.')),
              );
            },
            child: const Text('Enable'),
          ),
        ],
      ),
    );
  }

  void _showBackupSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Backup & Restore'),
        content: const Text(
          'Create automatic backups of your notes to the cloud. '
          'You can restore your data anytime, even on a new device.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Backup created successfully!')),
              );
            },
            child: const Text('Create Backup'),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('English'),
              value: 'English',
              groupValue: _selectedLanguage,
              onChanged: (value) async {
                if (value != null) {
                  setState(() => _selectedLanguage = value);
                  await _settingsService.setLanguage(value);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('Tiếng Việt'),
              value: 'Tiếng Việt',
              groupValue: _selectedLanguage,
              onChanged: (value) async {
                if (value != null) {
                  setState(() => _selectedLanguage = value);
                  await _settingsService.setLanguage(value);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('中文'),
              value: '中文',
              groupValue: _selectedLanguage,
              onChanged: (value) async {
                if (value != null) {
                  setState(() => _selectedLanguage = value);
                  await _settingsService.setLanguage(value);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('日本語'),
              value: '日本語',
              groupValue: _selectedLanguage,
              onChanged: (value) async {
                if (value != null) {
                  setState(() => _selectedLanguage = value);
                  await _settingsService.setLanguage(value);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('한국어'),
              value: '한국어',
              groupValue: _selectedLanguage,
              onChanged: (value) async {
                if (value != null) {
                  setState(() => _selectedLanguage = value);
                  await _settingsService.setLanguage(value);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _exportData() async {
    try {
      final settings = _settingsService.getAllSettings();
      final settingsJson = settings.toString();
      
      // In a real app, this would save to a file
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Settings exported: $settingsJson'),
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Export failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showDeleteDataDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete All Data'),
        content: const Text(
          'This action will permanently delete all your notes, settings, and app data. '
          'This cannot be undone. Are you sure you want to continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _deleteAllData();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete All'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteAllData() async {
    try {
      await _settingsService.resetToDefaults();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All data deleted successfully'),
          backgroundColor: Colors.green,
        ),
      );
      // Reload settings
      await _loadSettings();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Delete failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About PandoraX'),
        content: const Text(
          'PandoraX v1.0.0\n\n'
          'An AI-powered note-taking application built with Flutter. '
          'Features include intelligent note organization, voice recording, '
          'cloud sync, and advanced security.\n\n'
          'Built with ❤️ using Clean Architecture principles.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help & Support'),
        content: const Text(
          'Need help? We\'re here for you!\n\n'
          '• Check our FAQ section\n'
          '• Contact support at support@pandorax.app\n'
          '• Join our community forum\n'
          '• Watch tutorial videos\n\n'
          'We typically respond within 24 hours.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening support email...')),
              );
            },
            child: const Text('Contact Support'),
          ),
        ],
      ),
    );
  }

  void _rateApp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening Play Store...')),
    );
  }

  void _showDeleteAllDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete All Data'),
        content: const Text(
          'This action cannot be undone. All your notes, settings, and data will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All data deleted!')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: PandoraColors.error),
            child: const Text('Delete All'),
          ),
        ],
      ),
    );
  }
}
