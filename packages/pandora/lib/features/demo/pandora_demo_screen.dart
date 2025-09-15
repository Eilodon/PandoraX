import 'package:flutter/material.dart';
import 'package:pandora_ui/pandora_ui.dart';

/// Pandora 4 Demo Screen
/// 
/// A comprehensive demo screen showcasing all Pandora UI components
/// following the "Thân Tâm Hợp Nhất" philosophy.
class PandoraDemoScreen extends StatefulWidget {
  const PandoraDemoScreen({super.key});

  @override
  State<PandoraDemoScreen> createState() => _PandoraDemoScreenState();
}

class _PandoraDemoScreenState extends State<PandoraDemoScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
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
        title: const Text('Pandora 4 UI Demo'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Buttons', icon: Icon(Icons.touch_app)),
            Tab(text: 'Cards', icon: Icon(Icons.card_giftcard)),
            Tab(text: 'Inputs', icon: Icon(Icons.input)),
            Tab(text: 'Layout', icon: Icon(Icons.dashboard)),
            Tab(text: 'Tokens', icon: Icon(Icons.palette)),
            Tab(text: 'Theme', icon: Icon(Icons.color_lens)),
            Tab(text: 'Widgets', icon: Icon(Icons.widgets)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildButtonsTab(),
          _buildCardsTab(),
          _buildInputsTab(),
          _buildLayoutTab(),
          _buildTokensTab(),
          _buildThemeTab(),
          _buildWidgetsTab(),
        ],
      ),
    );
  }

  Widget _buildButtonsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Button Variants', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              PandoraButton(
                onPressed: () => _showSnackbar('Primary Button'),
                child: const Text('Primary'),
              ),
              PandoraButton(
                variant: PandoraButtonVariant.secondary,
                onPressed: () => _showSnackbar('Secondary Button'),
                child: const Text('Secondary'),
              ),
              PandoraButton(
                variant: PandoraButtonVariant.tertiary,
                onPressed: () => _showSnackbar('Tertiary Button'),
                child: const Text('Tertiary'),
              ),
              PandoraButton(
                variant: PandoraButtonVariant.ghost,
                onPressed: () => _showSnackbar('Ghost Button'),
                child: const Text('Ghost'),
              ),
              PandoraButton(
                variant: PandoraButtonVariant.link,
                onPressed: () => _showSnackbar('Link Button'),
                child: const Text('Link'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Button Sizes', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              PandoraButton(
                size: PandoraButtonSize.xs,
                onPressed: () => _showSnackbar('XS Button'),
                child: const Text('XS'),
              ),
              PandoraButton(
                size: PandoraButtonSize.sm,
                onPressed: () => _showSnackbar('SM Button'),
                child: const Text('SM'),
              ),
              PandoraButton(
                size: PandoraButtonSize.md,
                onPressed: () => _showSnackbar('MD Button'),
                child: const Text('MD'),
              ),
              PandoraButton(
                size: PandoraButtonSize.lg,
                onPressed: () => _showSnackbar('LG Button'),
                child: const Text('LG'),
              ),
              PandoraButton(
                size: PandoraButtonSize.xl,
                onPressed: () => _showSnackbar('XL Button'),
                child: const Text('XL'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Button States', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              PandoraButton(
                state: PandoraButtonState.enabled,
                onPressed: () => _showSnackbar('Enabled Button'),
                child: const Text('Enabled'),
              ),
              PandoraButton(
                state: PandoraButtonState.disabled,
                onPressed: null,
                child: const Text('Disabled'),
              ),
              PandoraButton(
                state: PandoraButtonState.loading,
                onPressed: null,
                child: const Text('Loading'),
              ),
              PandoraButton(
                state: PandoraButtonState.success,
                onPressed: () => _showSnackbar('Success Button'),
                child: const Text('Success'),
              ),
              PandoraButton(
                state: PandoraButtonState.error,
                onPressed: () => _showSnackbar('Error Button'),
                child: const Text('Error'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Button with Icons', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              PandoraButton(
                icon: const Icon(Icons.add),
                onPressed: () => _showSnackbar('Add Button'),
                child: const Text('Add'),
              ),
              PandoraButton(
                icon: const Icon(Icons.edit),
                iconPosition: IconPosition.end,
                onPressed: () => _showSnackbar('Edit Button'),
                child: const Text('Edit'),
              ),
              PandoraButton(
                fullWidth: true,
                icon: const Icon(Icons.save),
                onPressed: () => _showSnackbar('Save Button'),
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Card Variants', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              PandoraCard(
                variant: PandoraCardVariant.elevated,
                onTap: () => _showSnackbar('Elevated Card'),
                child: const Text('Elevated Card'),
              ),
              PandoraCard(
                variant: PandoraCardVariant.outlined,
                onTap: () => _showSnackbar('Outlined Card'),
                child: const Text('Outlined Card'),
              ),
              PandoraCard(
                variant: PandoraCardVariant.filled,
                onTap: () => _showSnackbar('Filled Card'),
                child: const Text('Filled Card'),
              ),
              PandoraCard(
                variant: PandoraCardVariant.flat,
                onTap: () => _showSnackbar('Flat Card'),
                child: const Text('Flat Card'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Card Sizes', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              PandoraCard(
                size: PandoraCardSize.xs,
                onTap: () => _showSnackbar('XS Card'),
                child: const Text('XS Card'),
              ),
              PandoraCard(
                size: PandoraCardSize.sm,
                onTap: () => _showSnackbar('SM Card'),
                child: const Text('SM Card'),
              ),
              PandoraCard(
                size: PandoraCardSize.md,
                onTap: () => _showSnackbar('MD Card'),
                child: const Text('MD Card'),
              ),
              PandoraCard(
                size: PandoraCardSize.lg,
                onTap: () => _showSnackbar('LG Card'),
                child: const Text('LG Card'),
              ),
              PandoraCard(
                size: PandoraCardSize.xl,
                onTap: () => _showSnackbar('XL Card'),
                child: const Text('XL Card'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Card Content', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          PandoraCard(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Card Title', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('This is a card with rich content. It can contain multiple lines of text and other widgets.'),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PandoraButton(
                      size: PandoraButtonSize.sm,
                      variant: PandoraButtonVariant.ghost,
                      onPressed: () => _showSnackbar('Cancel'),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    PandoraButton(
                      size: PandoraButtonSize.sm,
                      onPressed: () => _showSnackbar('Confirm'),
                      child: const Text('Confirm'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Text Field Variants', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          PandoraTextField(
            variant: PandoraTextFieldVariant.outlined,
            label: 'Outlined Text Field',
            hint: 'Enter your text here',
            controller: _textController,
          ),
          const SizedBox(height: 16),
          PandoraTextField(
            variant: PandoraTextFieldVariant.filled,
            label: 'Filled Text Field',
            hint: 'Enter your text here',
          ),
          const SizedBox(height: 16),
          PandoraTextField(
            variant: PandoraTextFieldVariant.underlined,
            label: 'Underlined Text Field',
            hint: 'Enter your text here',
          ),
          const SizedBox(height: 24),
          const Text('Text Field Sizes', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          PandoraTextField(
            size: PandoraTextFieldSize.xs,
            label: 'XS Text Field',
            hint: 'Small text field',
          ),
          const SizedBox(height: 16),
          PandoraTextField(
            size: PandoraTextFieldSize.sm,
            label: 'SM Text Field',
            hint: 'Small text field',
          ),
          const SizedBox(height: 16),
          PandoraTextField(
            size: PandoraTextFieldSize.md,
            label: 'MD Text Field',
            hint: 'Medium text field',
          ),
          const SizedBox(height: 16),
          PandoraTextField(
            size: PandoraTextFieldSize.lg,
            label: 'LG Text Field',
            hint: 'Large text field',
          ),
          const SizedBox(height: 16),
          PandoraTextField(
            size: PandoraTextFieldSize.xl,
            label: 'XL Text Field',
            hint: 'Extra large text field',
          ),
          const SizedBox(height: 24),
          const Text('Text Field States', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          PandoraTextField(
            state: PandoraTextFieldState.enabled,
            label: 'Enabled Text Field',
            hint: 'This field is enabled',
          ),
          const SizedBox(height: 16),
          PandoraTextField(
            state: PandoraTextFieldState.disabled,
            label: 'Disabled Text Field',
            hint: 'This field is disabled',
          ),
          const SizedBox(height: 16),
          PandoraTextField(
            state: PandoraTextFieldState.error,
            label: 'Error Text Field',
            hint: 'This field has an error',
            errorText: 'This field is required',
          ),
          const SizedBox(height: 16),
          PandoraTextField(
            state: PandoraTextFieldState.success,
            label: 'Success Text Field',
            hint: 'This field is valid',
          ),
          const SizedBox(height: 24),
          const Text('Text Field with Icons', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          PandoraTextField(
            label: 'Email',
            hint: 'Enter your email',
            prefixIcon: const Icon(Icons.email),
          ),
          const SizedBox(height: 16),
          PandoraTextField(
            label: 'Password',
            hint: 'Enter your password',
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: const Icon(Icons.visibility),
            obscureText: true,
          ),
          const SizedBox(height: 16),
          PandoraTextField(
            label: 'Search',
            hint: 'Search for something',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: const Icon(Icons.clear),
          ),
        ],
      ),
    );
  }

  Widget _buildLayoutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Container Variants', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              PandoraContainer(
                variant: PandoraContainerVariant.elevated,
                onTap: () => _showSnackbar('Elevated Container'),
                child: const Text('Elevated'),
              ),
              PandoraContainer(
                variant: PandoraContainerVariant.outlined,
                onTap: () => _showSnackbar('Outlined Container'),
                child: const Text('Outlined'),
              ),
              PandoraContainer(
                variant: PandoraContainerVariant.filled,
                onTap: () => _showSnackbar('Filled Container'),
                child: const Text('Filled'),
              ),
              PandoraContainer(
                variant: PandoraContainerVariant.flat,
                onTap: () => _showSnackbar('Flat Container'),
                child: const Text('Flat'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Container Sizes', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              PandoraContainer(
                size: PandoraContainerSize.xs,
                onTap: () => _showSnackbar('XS Container'),
                child: const Text('XS'),
              ),
              PandoraContainer(
                size: PandoraContainerSize.sm,
                onTap: () => _showSnackbar('SM Container'),
                child: const Text('SM'),
              ),
              PandoraContainer(
                size: PandoraContainerSize.md,
                onTap: () => _showSnackbar('MD Container'),
                child: const Text('MD'),
              ),
              PandoraContainer(
                size: PandoraContainerSize.lg,
                onTap: () => _showSnackbar('LG Container'),
                child: const Text('LG'),
              ),
              PandoraContainer(
                size: PandoraContainerSize.xl,
                onTap: () => _showSnackbar('XL Container'),
                child: const Text('XL'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Layout Examples', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          PandoraContainer(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Layout Container', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('This container demonstrates how Pandora UI components work together to create beautiful layouts.'),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: PandoraButton(
                        size: PandoraButtonSize.sm,
                        variant: PandoraButtonVariant.ghost,
                        onPressed: () => _showSnackbar('Left Action'),
                        child: const Text('Left'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: PandoraButton(
                        size: PandoraButtonSize.sm,
                        onPressed: () => _showSnackbar('Right Action'),
                        child: const Text('Right'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          PandoraContainer(
            width: double.infinity,
            gradient: LinearGradient(
              colors: [
                PandoraColors.primary500,
                PandoraColors.secondary500,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            child: const Column(
              children: [
                Icon(Icons.gradient, color: Colors.white, size: 48),
                SizedBox(height: 8),
                Text('Gradient Container', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('This container has a beautiful gradient background', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTokensTab() {
    return const TokensDemo();
  }

  Widget _buildThemeTab() {
    return const Center(child: Text('Theme Demo - Disabled'));
  }

  Widget _buildWidgetsTab() {
    return const Center(child: Text('Widgets Demo - Disabled'));
  }

  void _showSnackbar(String message) {
    PandoraSnackbar.show(
      context,
      message: message,
      variant: PandoraSnackbarVariant.info,
    );
  }
}
