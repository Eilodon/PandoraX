import 'package:flutter/material.dart';

/// Demo Data Generator
/// 
/// Generates demo data for testing and demonstration purposes
class DemoDataGenerator {
  static final DemoDataGenerator _instance = DemoDataGenerator._internal();
  factory DemoDataGenerator() => _instance;
  DemoDataGenerator._internal();

  /// Generate demo notes
  List<Map<String, dynamic>> generateDemoNotes() {
    return [
      {
        'id': '1',
        'title': 'Demo Note 1',
        'content': 'This is a demo note for testing purposes.',
        'createdAt': DateTime.now().subtract(const Duration(days: 1)),
        'updatedAt': DateTime.now().subtract(const Duration(hours: 2)),
      },
      {
        'id': '2',
        'title': 'Demo Note 2',
        'content': 'Another demo note with more content.',
        'createdAt': DateTime.now().subtract(const Duration(days: 2)),
        'updatedAt': DateTime.now().subtract(const Duration(hours: 5)),
      },
    ];
  }

  /// Generate demo memories
  List<Map<String, dynamic>> generateDemoMemories() {
    return [
      {
        'id': '1',
        'title': 'Demo Memory 1',
        'content': 'This is a demo memory.',
        'type': 'text',
        'createdAt': DateTime.now().subtract(const Duration(days: 1)),
      },
      {
        'id': '2',
        'title': 'Demo Memory 2',
        'content': 'Another demo memory.',
        'type': 'image',
        'createdAt': DateTime.now().subtract(const Duration(days: 2)),
      },
    ];
  }

  /// Generate demo mascot data
  Map<String, dynamic> generateDemoMascotData() {
    return {
      'mood': 'happy',
      'happiness': 85,
      'energy': 70,
      'affection': 90,
      'lastInteraction': DateTime.now().subtract(const Duration(minutes: 30)),
    };
  }
}
