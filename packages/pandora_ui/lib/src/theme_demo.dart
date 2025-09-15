// file: packages/pandora_ui/lib/src/theme_demo.dart
import 'package:flutter/material.dart';
import 'theme.dart';

/// Demo widget showcasing the Pandora 4 Theme System
/// 
/// This widget demonstrates the comprehensive theming system
/// with all Material Design components styled according to Pandora 4 design tokens.
class ThemeDemo extends StatefulWidget {
  const ThemeDemo({super.key});

  @override
  State<ThemeDemo> createState() => _ThemeDemoState();
}

class _ThemeDemoState extends State<ThemeDemo> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _switchValue = false;
  bool _checkboxValue = false;
  bool _radioValue = false;
  double _sliderValue = 0.5;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pandora 4 Theme Demo'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Buttons', icon: Icon(Icons.touch_app)),
            Tab(text: 'Inputs', icon: Icon(Icons.input)),
            Tab(text: 'Controls', icon: Icon(Icons.toggle_on)),
            Tab(text: 'Layout', icon: Icon(Icons.dashboard)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildButtonsTab(),
          _buildInputsTab(),
          _buildControlsTab(),
          _buildLayoutTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Floating Action Button pressed!'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildButtonsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Button Variants', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          
          // Elevated Buttons
          const Text('Elevated Buttons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Primary'),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                child: const Text('Secondary'),
              ),
              ElevatedButton(
                onPressed: null,
                child: const Text('Disabled'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Text Buttons
          const Text('Text Buttons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Text Button'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Text Button'),
              ),
              TextButton(
                onPressed: null,
                child: const Text('Disabled'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Outlined Buttons
          const Text('Outlined Buttons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              OutlinedButton(
                onPressed: () {},
                child: const Text('Outlined'),
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text('Outlined'),
              ),
              OutlinedButton(
                onPressed: null,
                child: const Text('Disabled'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Icon Buttons
          const Text('Icon Buttons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share),
              ),
              IconButton(
                onPressed: null,
                icon: const Icon(Icons.star),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Input Components', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          
          // Text Fields
          const Text('Text Fields', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            controller: _textController,
            decoration: const InputDecoration(
              labelText: 'Label',
              hintText: 'Hint text',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Enter password',
              prefixIcon: Icon(Icons.lock),
              suffixIcon: Icon(Icons.visibility),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Error State',
              hintText: 'This field has an error',
              errorText: 'This field is required',
              prefixIcon: Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 24),
          
          // Chips
          const Text('Chips', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Chip(
                label: const Text('Default'),
                onDeleted: () {},
                deleteIcon: const Icon(Icons.close, size: 18),
              ),
              Chip(
                label: const Text('Selected'),
                onDeleted: () {},
                deleteIcon: const Icon(Icons.close, size: 18),
              ),
              Chip(
                label: const Text('Disabled'),
                onDeleted: null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControlsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Control Components', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          
          // Switches
          const Text('Switches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('Switch Option'),
            subtitle: const Text('Toggle this switch'),
            value: _switchValue,
            onChanged: (value) {
              setState(() {
                _switchValue = value;
              });
            },
          ),
          const SizedBox(height: 24),
          
          // Checkboxes
          const Text('Checkboxes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          CheckboxListTile(
            title: const Text('Checkbox Option'),
            subtitle: const Text('Select this option'),
            value: _checkboxValue,
            onChanged: (value) {
              setState(() {
                _checkboxValue = value ?? false;
              });
            },
          ),
          const SizedBox(height: 24),
          
          // Radio Buttons
          const Text('Radio Buttons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          RadioListTile<bool>(
            title: const Text('Option 1'),
            value: true,
            groupValue: _radioValue,
            onChanged: (value) {
              setState(() {
                _radioValue = value ?? false;
              });
            },
          ),
          RadioListTile<bool>(
            title: const Text('Option 2'),
            value: false,
            groupValue: _radioValue,
            onChanged: (value) {
              setState(() {
                _radioValue = value ?? false;
              });
            },
          ),
          const SizedBox(height: 24),
          
          // Slider
          const Text('Slider', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Slider(
            value: _sliderValue,
            onChanged: (value) {
              setState(() {
                _sliderValue = value;
              });
            },
            label: '${(_sliderValue * 100).round()}%',
          ),
          const SizedBox(height: 24),
          
          // Progress Indicators
          const Text('Progress Indicators', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          const LinearProgressIndicator(),
          const SizedBox(height: 16),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildLayoutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Layout Components', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          
          // Cards
          const Text('Cards', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Card Title', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  const Text('This is a card with some content. It demonstrates the card theme styling.'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('CANCEL'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Dividers
          const Text('Dividers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          const Text('Content above divider'),
          const Divider(),
          const Text('Content below divider'),
          const SizedBox(height: 24),
          
          // Lists
          const Text('Lists', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('List Item 1'),
                  subtitle: const Text('Subtitle text'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('List Item 2'),
                  subtitle: const Text('Subtitle text'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text('List Item 3'),
                  subtitle: const Text('Subtitle text'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
