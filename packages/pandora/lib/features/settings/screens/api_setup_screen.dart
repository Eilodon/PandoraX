import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/api_config.dart';
import '../../../config/environment.dart';

/// Screen for API key configuration
class ApiSetupScreen extends StatefulWidget {
  const ApiSetupScreen({super.key});

  @override
  State<ApiSetupScreen> createState() => _ApiSetupScreenState();
}

class _ApiSetupScreenState extends State<ApiSetupScreen> {
  final _geminiController = TextEditingController();
  final _speechController = TextEditingController();
  final _firebaseController = TextEditingController();
  
  bool _isLoading = false;
  bool _geminiConfigured = false;
  bool _speechConfigured = false;
  bool _firebaseConfigured = false;
  
  @override
  void initState() {
    super.initState();
    _loadCurrentConfiguration();
  }

  @override
  void dispose() {
    _geminiController.dispose();
    _speechController.dispose();
    _firebaseController.dispose();
    super.dispose();
  }

  Future<void> _loadCurrentConfiguration() async {
    setState(() => _isLoading = true);
    
    try {
      _geminiConfigured = await ApiConfig.isGeminiApiKeyConfigured();
      
      // Load masked keys for display
      if (_geminiConfigured) {
        final key = await ApiConfig.getGeminiApiKey();
        _geminiController.text = _maskApiKey(key);
      }
      
      // Check other configurations
      _speechConfigured = (await ApiConfig.getSpeechApiKey()).isNotEmpty;
      _firebaseConfigured = (await ApiConfig.getFirebaseApiKey()).isNotEmpty;
      
    } catch (e) {
      _showError('Failed to load configuration: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  String _maskApiKey(String key) {
    if (key.length <= 8) return '***';
    return '${key.substring(0, 4)}${'*' * (key.length - 8)}${key.substring(key.length - 4)}';
  }

  Future<void> _saveGeminiApiKey() async {
    final key = _geminiController.text.trim();
    if (key.isEmpty || key.contains('*')) {
      _showError('Please enter a valid API key');
      return;
    }

    setState(() => _isLoading = true);
    
    try {
      await ApiConfig.setGeminiApiKey(key);
      setState(() => _geminiConfigured = true);
      _showSuccess('Gemini API key saved successfully');
      _geminiController.text = _maskApiKey(key);
    } catch (e) {
      _showError('Failed to save API key: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveFirebaseApiKey() async {
    final key = _firebaseController.text.trim();
    if (key.isEmpty || key.contains('*')) {
      _showError('Please enter a valid Firebase API key');
      return;
    }

    setState(() => _isLoading = true);
    
    try {
      await ApiConfig.setFirebaseApiKey(key);
      setState(() => _firebaseConfigured = true);
      _showSuccess('Firebase API key saved successfully');
      _firebaseController.text = _maskApiKey(key);
    } catch (e) {
      _showError('Failed to save Firebase API key: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _testConfiguration() async {
    setState(() => _isLoading = true);
    
    try {
      final errors = await ApiConfig.validateConfiguration();
      if (errors.isEmpty) {
        _showSuccess('All configurations are valid!');
      } else {
        _showError('Configuration issues:\n${errors.join('\n')}');
      }
    } catch (e) {
      _showError('Configuration test failed: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Configuration'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: _showHelpDialog,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildEnvironmentInfo(),
                  const SizedBox(height: 24),
                  _buildGeminiSection(),
                  const SizedBox(height: 24),
                  _buildFirebaseSection(),
                  const SizedBox(height: 24),
                  _buildSpeechSection(),
                  const SizedBox(height: 32),
                  _buildTestSection(),
                ],
              ),
            ),
    );
  }

  Widget _buildEnvironmentInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Environment',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text('Environment: ${Environment.current.name}'),
            Text('App Version: ${Environment.appVersion}'),
            Text('Build Number: ${Environment.buildNumber}'),
            if (Environment.isDebugMode)
              const Text(
                'Debug Mode: Enabled',
                style: TextStyle(color: Colors.orange),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeminiSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _geminiConfigured ? Icons.check_circle : Icons.warning,
                  color: _geminiConfigured ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 8),
                Text(
                  'Google Gemini AI',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Required for AI chat and content generation features.'),
            const SizedBox(height: 16),
            TextField(
              controller: _geminiController,
              decoration: InputDecoration(
                labelText: 'Gemini API Key',
                hintText: 'Enter your Google AI Studio API key',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.visibility),
                  onPressed: () {
                    // Toggle visibility or clear field for new entry
                    if (_geminiController.text.contains('*')) {
                      _geminiController.clear();
                    }
                  },
                ),
              ),
              obscureText: _geminiController.text.contains('*'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _saveGeminiApiKey,
                  child: const Text('Save'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: _showGeminiHelp,
                  child: const Text('How to get API key'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFirebaseSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _firebaseConfigured ? Icons.check_circle : Icons.info,
                  color: _firebaseConfigured ? Colors.green : Colors.blue,
                ),
                const SizedBox(width: 8),
                Text(
                  'Firebase Configuration',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Optional: For manual Firebase configuration.'),
            Text('Project ID: ${Environment.firebaseProjectId}'),
            if (Environment.isDebugMode) ...[
              const SizedBox(height: 16),
              TextField(
                controller: _firebaseController,
                decoration: const InputDecoration(
                  labelText: 'Firebase API Key (Optional)',
                  hintText: 'Manual Firebase API key override',
                ),
                obscureText: _firebaseController.text.contains('*'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveFirebaseApiKey,
                child: const Text('Save Firebase Key'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSpeechSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.mic, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Speech Recognition',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Uses on-device speech recognition. No API key required.'),
            if (_speechConfigured)
              const Text(
                'Cloud speech service configured',
                style: TextStyle(color: Colors.green),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Configuration Test',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const Text('Test your API configuration to ensure everything works correctly.'),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _testConfiguration,
                icon: const Icon(Icons.check),
                label: const Text('Test Configuration'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showGeminiHelp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('How to get Gemini API Key'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('1. Go to Google AI Studio:'),
              Text('   https://makersuite.google.com/app/apikey'),
              SizedBox(height: 8),
              Text('2. Sign in with your Google account'),
              SizedBox(height: 8),
              Text('3. Click "Create API key"'),
              SizedBox(height: 8),
              Text('4. Copy the generated API key'),
              SizedBox(height: 8),
              Text('5. Paste it in the field above'),
              SizedBox(height: 16),
              Text(
                'Note: Keep your API key secure and do not share it.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Clipboard.setData(const ClipboardData(text: 'https://makersuite.google.com/app/apikey'));
              Navigator.of(context).pop();
              _showSuccess('URL copied to clipboard');
            },
            child: const Text('Copy URL'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('API Configuration Help'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Required APIs:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• Gemini AI: For chat and content generation'),
              Text('• Firebase: For cloud sync and analytics'),
              Text('• Speech Recognition: Built-in, no key needed'),
              SizedBox(height: 16),
              Text(
                'Security:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• API keys are stored securely on device'),
              Text('• Keys are encrypted and never shared'),
              Text('• You can remove keys anytime in settings'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
