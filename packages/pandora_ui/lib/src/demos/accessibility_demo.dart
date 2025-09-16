import 'package:flutter/material.dart';
import 'package:pandora_ui/pandora_ui.dart';

/// Accessibility Demo Screen
/// 
/// Demonstrates all accessibility features and components
class AccessibilityDemoScreen extends StatefulWidget {
  const AccessibilityDemoScreen({super.key});

  @override
  State<AccessibilityDemoScreen> createState() => _AccessibilityDemoScreenState();
}

class _AccessibilityDemoScreenState extends State<AccessibilityDemoScreen> {
  bool _isDarkMode = false;
  bool _isHighContrast = false;
  double _textScale = 1.0;
  bool _isLoading = false;
  String _selectedOption = 'Option 1';
  bool _isChecked = false;
  double _sliderValue = 50.0;

  @override
  void initState() {
    super.initState();
    // Register common keyboard shortcuts
    for (final shortcut in CommonKeyboardShortcuts.shortcuts) {
      KeyboardNavigationService.registerShortcut(shortcut);
    }
  }

  @override
  void dispose() {
    KeyboardNavigationService.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? createPandoraTheme() : createPandoraLightTheme(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Accessibility Demo'),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
                AccessibilityService.announceChange(
                  _isDarkMode ? 'Dark mode enabled' : 'Light mode enabled'
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Accessibility Settings'),
              _buildAccessibilitySettings(),
              
              const SizedBox(height: 32),
              _buildSectionTitle('Button Components'),
              _buildButtonDemo(),
              
              const SizedBox(height: 32),
              _buildSectionTitle('Form Components'),
              _buildFormDemo(),
              
              const SizedBox(height: 32),
              _buildSectionTitle('Interactive Components'),
              _buildInteractiveDemo(),
              
              const SizedBox(height: 32),
              _buildSectionTitle('Focus Management'),
              _buildFocusDemo(),
              
              const SizedBox(height: 32),
              _buildSectionTitle('Color Contrast'),
              _buildColorContrastDemo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAccessibilitySettings() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('High Contrast Mode'),
              subtitle: const Text('Increases contrast for better visibility'),
              value: _isHighContrast,
              onChanged: (value) {
                setState(() {
                  _isHighContrast = value;
                });
                AccessibilityService.announceChange(
                  value ? 'High contrast enabled' : 'High contrast disabled'
                );
              },
            ),
            ListTile(
              title: const Text('Text Scale'),
              subtitle: Text('${(_textScale * 100).round()}%'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        _textScale = (_textScale - 0.1).clamp(0.8, 2.0);
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _textScale = (_textScale + 0.1).clamp(0.8, 2.0);
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Accessible Buttons with different states:'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                AccessiblePandoraButton(
                  onPressed: () {
                    AccessibilityService.announceCompletion('Primary button pressed');
                  },
                  accessibilityId: 'primary-btn',
                  focusOrder: 1,
                  child: const Text('Primary'),
                ),
                AccessiblePandoraButton(
                  onPressed: () {
                    AccessibilityService.announceCompletion('Secondary button pressed');
                  },
                  variant: PandoraButtonVariant.secondary,
                  accessibilityId: 'secondary-btn',
                  focusOrder: 2,
                  child: const Text('Secondary'),
                ),
                AccessiblePandoraButton(
                  onPressed: null,
                  accessibilityId: 'disabled-btn',
                  focusOrder: 3,
                  state: PandoraButtonState.disabled,
                  child: const Text('Disabled'),
                ),
                AccessiblePandoraButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    await Future.delayed(const Duration(seconds: 2));
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  accessibilityId: 'loading-btn',
                  focusOrder: 4,
                  state: _isLoading ? PandoraButtonState.loading : PandoraButtonState.enabled,
                  child: const Text('Loading'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Form Components with accessibility:'),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email Address',
                hintText: 'Enter your email',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                AccessibilityService.announceChange('Email field updated');
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedOption,
              decoration: const InputDecoration(
                labelText: 'Select Option',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
                DropdownMenuItem(value: 'Option 2', child: Text('Option 2')),
                DropdownMenuItem(value: 'Option 3', child: Text('Option 3')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
                AccessibilityService.announceChange('Selected $value');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Interactive Components:'),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('Enable notifications'),
              value: _isChecked,
              onChanged: (value) {
                setState(() {
                  _isChecked = value!;
                });
                AccessibilityService.announceChange(
                  value ? 'Notifications enabled' : 'Notifications disabled'
                );
              },
            ),
            const SizedBox(height: 16),
            Text('Slider Value: ${_sliderValue.round()}'),
            Slider(
              value: _sliderValue,
              min: 0,
              max: 100,
              divisions: 10,
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
                AccessibilityService.announceChange('Slider value: ${value.round()}');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFocusDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Focus Management Demo:'),
            const SizedBox(height: 16),
            const Text('Use Tab to navigate between buttons, or arrow keys for directional navigation.'),
            const SizedBox(height: 16),
            Row(
              children: [
                AccessiblePandoraButton(
                  onPressed: () {
                    FocusManagementService.moveToNext();
                  },
                  accessibilityId: 'focus-next',
                  focusOrder: 10,
                  child: const Text('Next Focus'),
                ),
                const SizedBox(width: 8),
                AccessiblePandoraButton(
                  onPressed: () {
                    FocusManagementService.moveToPrevious();
                  },
                  accessibilityId: 'focus-prev',
                  focusOrder: 11,
                  child: const Text('Previous Focus'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorContrastDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Color Contrast Validation:'),
            const SizedBox(height: 16),
            _buildContrastExample('High Contrast', Colors.black, Colors.white),
            const SizedBox(height: 8),
            _buildContrastExample('Medium Contrast', Colors.grey.shade600, Colors.grey.shade300),
            const SizedBox(height: 8),
            _buildContrastExample('Low Contrast', Colors.grey.shade500, Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  Widget _buildContrastExample(String label, Color foreground, Color background) {
    final contrast = AccessibilityColors.calculateContrast(foreground, background);
    final isAccessible = AccessibilityColors.isAccessibleContrast(foreground, background);
    
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: background,
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: foreground),
            ),
          ),
          Text(
            'Contrast: ${contrast.toStringAsFixed(1)}',
            style: TextStyle(color: foreground),
          ),
          const SizedBox(width: 8),
          Icon(
            isAccessible ? Icons.check_circle : Icons.warning,
            color: isAccessible ? Colors.green : Colors.red,
          ),
        ],
      ),
    );
  }
}
