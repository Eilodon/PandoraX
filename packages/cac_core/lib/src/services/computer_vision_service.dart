/// Computer Vision Service for CAC Integration
/// 
/// This service provides computer vision capabilities integrated with CAC
/// memory system for intelligent image analysis and recognition.
library computer_vision_service;

import 'package:flutter/material.dart';
import 'package:cac_core/cac_core.dart';
import 'package:common_entities/common_entities.dart';

/// Computer Vision service integrated with CAC memory system
class ComputerVisionService {
  static ComputerVisionService? _instance;
  static ComputerVisionService get instance => _instance ??= ComputerVisionService._();
  
  ComputerVisionService._();
  
  final MemoryRepository _memoryRepository;
  final EventBusService _eventBusService;
  final VectorSearchInterface _vectorSearch;
  
  ComputerVisionService({
    required MemoryRepository memoryRepository,
    required EventBusService eventBusService,
    required VectorSearchInterface vectorSearch,
  }) : _memoryRepository = memoryRepository,
       _eventBusService = eventBusService,
       _vectorSearch = vectorSearch;
  
  // ============================================================================
  // IMAGE ANALYSIS
  // ============================================================================
  
  /// Analyze image and store as memory
  Future<Map<String, dynamic>> analyzeImage(
    String imagePath,
    String userId,
    {Map<String, dynamic>? metadata}
  ) async {
    try {
      // Simulate image analysis
      await Future.delayed(const Duration(milliseconds: 800));
      
      final analysis = _performImageAnalysis(imagePath);
      
      // Store as memory
      final memory = MemoryEntry(
        id: 'cv_${DateTime.now().millisecondsSinceEpoch}',
        timestamp: DateTime.now(),
        source: 'computer_vision',
        content: analysis['description'] ?? 'Image analysis',
        type: MemoryType.ai_generated,
        metadata: {
          'image_path': imagePath,
          'user_id': userId,
          'analysis_type': 'image_analysis',
          'objects_detected': analysis['objects'] ?? [],
          'confidence': analysis['confidence'] ?? 0.0,
          ...?metadata,
        },
      );
      
      await _memoryRepository.saveMemory(memory);
      
      // Publish event
      _eventBusService.publishEvent(
        CacEvent.memoryCreated(
          memoryId: memory.id,
          content: memory.content,
          source: memory.source,
          timestamp: memory.timestamp,
        ),
      );
      
      return analysis;
    } catch (e) {
      throw Exception('Failed to analyze image: $e');
    }
  }
  
  /// Detect objects in image
  Future<List<Map<String, dynamic>>> detectObjects(
    String imagePath,
    String userId,
  ) async {
    try {
      final analysis = await analyzeImage(imagePath, userId);
      final objects = analysis['objects'] as List<Map<String, dynamic>>? ?? [];
      
      // Store each object as separate memory
      for (final obj in objects) {
        final memory = MemoryEntry(
          id: 'obj_${DateTime.now().millisecondsSinceEpoch}_${obj['label']}',
          timestamp: DateTime.now(),
          source: 'computer_vision',
          content: 'Detected object: ${obj['label']}',
          type: MemoryType.ai_generated,
          metadata: {
            'image_path': imagePath,
            'user_id': userId,
            'object_label': obj['label'],
            'confidence': obj['confidence'],
            'bounding_box': obj['bounding_box'],
          },
        );
        
        await _memoryRepository.saveMemory(memory);
      }
      
      return objects;
    } catch (e) {
      throw Exception('Failed to detect objects: $e');
    }
  }
  
  /// Classify image
  Future<List<Map<String, dynamic>>> classifyImage(
    String imagePath,
    String userId,
  ) async {
    try {
      final analysis = await analyzeImage(imagePath, userId);
      final classifications = analysis['classifications'] as List<Map<String, dynamic>>? ?? [];
      
      // Store classification as memory
      final memory = MemoryEntry(
        id: 'cls_${DateTime.now().millisecondsSinceEpoch}',
        timestamp: DateTime.now(),
        source: 'computer_vision',
        content: 'Image classified as: ${classifications.map((c) => c['category']).join(', ')}',
        type: MemoryType.ai_generated,
        metadata: {
          'image_path': imagePath,
          'user_id': userId,
          'classifications': classifications,
        },
      );
      
      await _memoryRepository.saveMemory(memory);
      
      return classifications;
    } catch (e) {
      throw Exception('Failed to classify image: $e');
    }
  }
  
  /// Perform OCR on image
  Future<String> performOcr(
    String imagePath,
    String userId,
  ) async {
    try {
      final analysis = await analyzeImage(imagePath, userId);
      final text = analysis['ocr_text'] as String? ?? '';
      
      if (text.isNotEmpty) {
        // Store OCR result as memory
        final memory = MemoryEntry(
          id: 'ocr_${DateTime.now().millisecondsSinceEpoch}',
          timestamp: DateTime.now(),
          source: 'computer_vision',
          content: 'OCR extracted text: $text',
          type: MemoryType.ai_generated,
          metadata: {
            'image_path': imagePath,
            'user_id': userId,
            'ocr_text': text,
            'text_length': text.length,
          },
        );
        
        await _memoryRepository.saveMemory(memory);
      }
      
      return text;
    } catch (e) {
      throw Exception('Failed to perform OCR: $e');
    }
  }
  
  // ============================================================================
  // MEMORY INTEGRATION
  // ============================================================================
  
  /// Search images by content
  Future<List<MemoryEntry>> searchImagesByContent(
    String query,
    String userId,
  ) async {
    try {
      // Search memories with computer vision metadata
      final memories = await _memoryRepository.getMemories(
        source: 'computer_vision',
        limit: 100,
      );
      
      // Filter by user and content
      final userMemories = memories.where((m) => 
        m.metadata['user_id'] == userId &&
        m.content.toLowerCase().contains(query.toLowerCase())
      ).toList();
      
      return userMemories;
    } catch (e) {
      throw Exception('Failed to search images: $e');
    }
  }
  
  /// Get image analysis history
  Future<List<MemoryEntry>> getImageAnalysisHistory(
    String userId,
    {int limit = 50}
  ) async {
    try {
      return await _memoryRepository.getMemories(
        source: 'computer_vision',
        limit: limit,
      );
    } catch (e) {
      throw Exception('Failed to get image history: $e');
    }
  }
  
  /// Get objects detected by user
  Future<List<String>> getDetectedObjects(String userId) async {
    try {
      final memories = await _memoryRepository.getMemories(
        source: 'computer_vision',
        limit: 1000,
      );
      
      final objects = <String>{};
      for (final memory in memories) {
        if (memory.metadata['user_id'] == userId) {
          final objectLabel = memory.metadata['object_label'] as String?;
          if (objectLabel != null) {
            objects.add(objectLabel);
          }
        }
      }
      
      return objects.toList();
    } catch (e) {
      throw Exception('Failed to get detected objects: $e');
    }
  }
  
  // ============================================================================
  // PATTERN RECOGNITION
  // ============================================================================
  
  /// Analyze visual patterns
  Future<List<Map<String, dynamic>>> analyzeVisualPatterns(
    String userId,
  ) async {
    try {
      final memories = await getImageAnalysisHistory(userId);
      
      // Analyze patterns in image data
      final patterns = <Map<String, dynamic>>[];
      
      // Group by object types
      final objectCounts = <String, int>{};
      final timePatterns = <String, List<DateTime>>{};
      
      for (final memory in memories) {
        final objectLabel = memory.metadata['object_label'] as String?;
        if (objectLabel != null) {
          objectCounts[objectLabel] = (objectCounts[objectLabel] ?? 0) + 1;
          
          final timeKey = _getTimePattern(memory.timestamp);
          timePatterns.putIfAbsent(timeKey, () => []).add(memory.timestamp);
        }
      }
      
      // Generate insights
      if (objectCounts.isNotEmpty) {
        final mostCommon = objectCounts.entries
            .reduce((a, b) => a.value > b.value ? a : b);
        
        patterns.add({
          'type': 'most_common_object',
          'object': mostCommon.key,
          'count': mostCommon.value,
          'confidence': 0.8,
        });
      }
      
      if (timePatterns.isNotEmpty) {
        final mostActiveTime = timePatterns.entries
            .reduce((a, b) => a.value.length > b.value.length ? a : b);
        
        patterns.add({
          'type': 'most_active_time',
          'time_period': mostActiveTime.key,
          'activity_count': mostActiveTime.value.length,
          'confidence': 0.7,
        });
      }
      
      return patterns;
    } catch (e) {
      throw Exception('Failed to analyze visual patterns: $e');
    }
  }
  
  /// Generate visual insights
  Future<List<Map<String, dynamic>>> generateVisualInsights(
    String userId,
  ) async {
    try {
      final patterns = await analyzeVisualPatterns(userId);
      final insights = <Map<String, dynamic>>[];
      
      for (final pattern in patterns) {
        String insight;
        switch (pattern['type']) {
          case 'most_common_object':
            insight = 'You frequently take photos of ${pattern['object']} (${pattern['count']} times)';
            break;
          case 'most_active_time':
            insight = 'You are most active with camera during ${pattern['time_period']}';
            break;
          default:
            insight = 'Visual pattern detected: ${pattern['type']}';
        }
        
        insights.add({
          'insight': insight,
          'confidence': pattern['confidence'],
          'type': 'visual_pattern',
          'timestamp': DateTime.now(),
        });
      }
      
      return insights;
    } catch (e) {
      throw Exception('Failed to generate visual insights: $e');
    }
  }
  
  // ============================================================================
  // PRIVATE METHODS
  // ============================================================================
  
  /// Perform image analysis
  Map<String, dynamic> _performImageAnalysis(String imagePath) {
    // Simulate image analysis
    final objects = [
      {'label': 'person', 'confidence': 0.95, 'bounding_box': {'x': 10, 'y': 20, 'width': 100, 'height': 150}},
      {'label': 'car', 'confidence': 0.87, 'bounding_box': {'x': 200, 'y': 50, 'width': 150, 'height': 80}},
    ];
    
    final classifications = [
      {'category': 'outdoor', 'confidence': 0.92},
      {'category': 'urban', 'confidence': 0.78},
    ];
    
    return {
      'description': 'Image contains ${objects.length} objects and is classified as ${classifications.map((c) => c['category']).join(', ')}',
      'objects': objects,
      'classifications': classifications,
      'confidence': 0.89,
      'ocr_text': imagePath.contains('document') ? 'Sample document text' : '',
    };
  }
  
  /// Get time pattern from timestamp
  String _getTimePattern(DateTime timestamp) {
    final hour = timestamp.hour;
    if (hour >= 6 && hour < 12) return 'morning';
    if (hour >= 12 && hour < 18) return 'afternoon';
    if (hour >= 18 && hour < 22) return 'evening';
    return 'night';
  }
}
