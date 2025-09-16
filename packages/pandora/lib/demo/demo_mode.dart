class DemoModeManager {
  static bool _isDemoMode = false;
  
  static bool get isDemoMode => _isDemoMode;
  
  static Future<void> enableDemoMode() async {
    _isDemoMode = true;
  }
  
  static Future<void> disableDemoMode() async {
    _isDemoMode = false;
  }
}

class DemoDataGenerator {
  static List<Map<String, dynamic>> generateDemoNotes() {
    return [
      {
        'id': '1',
        'title': 'Demo Note 1',
        'content': 'This is a demo note for testing',
        'timestamp': DateTime.now().toIso8601String(),
        'tags': ['demo', 'test'],
      },
      {
        'id': '2',
        'title': 'Demo Note 2',
        'content': 'Another demo note',
        'timestamp': DateTime.now().toIso8601String(),
        'tags': ['demo', 'sample'],
      },
    ];
  }
}
