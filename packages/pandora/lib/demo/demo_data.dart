
class DemoData {
  static const List<String> sampleNotes = [
    'Meeting with team at 2 PM',
    'Buy groceries for dinner',
    'Review project proposal',
    'Call dentist for appointment',
    'Finish quarterly report',
  ];

  static const List<String> sampleTags = [
    'work',
    'personal',
    'urgent',
    'meeting',
    'shopping',
  ];

  static const List<Map<String, dynamic>> sampleMemories = [
    {
      'id': '1',
      'title': 'Team Meeting',
      'content': 'Discussed project timeline and deliverables',
      'tags': ['work', 'meeting'],
      'timestamp': '2024-01-15T10:00:00Z',
    },
    {
      'id': '2',
      'title': 'Grocery List',
      'content': 'Milk, bread, eggs, vegetables',
      'tags': ['personal', 'shopping'],
      'timestamp': '2024-01-15T14:30:00Z',
    },
  ];

  static const List<String> sampleVoiceCommands = [
    'Create a new note',
    'Search for meeting notes',
    'Set reminder for tomorrow',
    'What\'s my schedule today?',
    'Add to shopping list',
  ];

  static const Map<String, dynamic> sampleUserProfile = {
    'name': 'Demo User',
    'email': 'demo@example.com',
    'preferences': {
      'theme': 'light',
      'notifications': true,
      'voiceEnabled': true,
    },
  };

  static const List<Map<String, dynamic>> sampleAIResponses = [
    {
      'query': 'What should I do today?',
      'response': 'Based on your notes, you have a team meeting at 2 PM and need to buy groceries. Would you like me to set reminders for these tasks?',
      'confidence': 0.95,
    },
    {
      'query': 'Help me organize my notes',
      'response': 'I can help you organize your notes by tags, dates, or topics. What organization method would you prefer?',
      'confidence': 0.88,
    },
  ];
}

class DemoMode {
  static bool isEnabled = false;
  
  static void enable() {
    isEnabled = true;
  }
  
  static void disable() {
    isEnabled = false;
  }
  
  static bool get isDemoMode => isEnabled;
}
