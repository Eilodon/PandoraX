import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Demo Mode Provider
/// 
/// Manages the demo mode state for testing and demonstration purposes
final demoModeProvider = StateProvider<bool>((ref) => false);

/// Demo Mode Manager
/// 
/// Manages demo mode functionality
class DemoModeManager {
  static final DemoModeManager _instance = DemoModeManager._internal();
  factory DemoModeManager() => _instance;
  DemoModeManager._internal();

  bool _isDemoMode = false;

  bool get isDemoMode => _isDemoMode;

  void enableDemoMode() {
    _isDemoMode = true;
  }

  void disableDemoMode() {
    _isDemoMode = false;
  }

  void toggleDemoMode() {
    _isDemoMode = !_isDemoMode;
  }
}

/// Demo Mode Toggle Widget
/// 
/// A widget that allows toggling demo mode on/off
class DemoModeToggle extends ConsumerWidget {
  const DemoModeToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDemoMode = ref.watch(demoModeProvider);
    
    return Switch(
      value: isDemoMode,
      onChanged: (value) {
        ref.read(demoModeProvider.notifier).state = value;
      },
    );
  }
}
