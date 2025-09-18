import 'package:isar/isar.dart';
import 'package:common_entities/common_entities.dart';
import 'package:ai_domain/ai_domain.dart';
import 'package:core_utils/core_utils.dart';

/// Local data source for AI operations using Isar database
class AiLocalDataSource {
  Isar? _isar;

  /// Initialize the local database
  Future<void> initialize() async {
    try {
      AppLogger.info('🤖 Initializing AI local data source...');

      _isar = await Isar.open([
        AiResponseSchema,
        AiRequestSchema,
      ]);

      AppLogger.success('AI local data source initialized successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to initialize AI local data source', e, stackTrace);
      rethrow;
    }
  }

  /// Save AI response locally
  Future<void> saveResponse(AiResponse response) async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      await _isar!.writeTxn(() async {
        await _isar!.aiResponses.put(response);
      });

      AppLogger.info('AI response saved locally: ${response.id}');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to save AI response locally', e, stackTrace);
      rethrow;
    }
  }

  /// Get AI response by ID
  Future<AiResponse?> getResponse(String id) async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      return await _isar!.aiResponses.get(id);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get AI response', e, stackTrace);
      return null;
    }
  }

  /// Get all AI responses
  Future<List<AiResponse>> getAllResponses() async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      return await _isar!.aiResponses.where().findAll();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get all AI responses', e, stackTrace);
      return [];
    }
  }

  /// Get responses by type
  Future<List<AiResponse>> getResponsesByType(AiResponseType type) async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      return await _isar!.aiResponses
          .filter()
          .typeEqualTo(type)
          .findAll();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get responses by type', e, stackTrace);
      return [];
    }
  }

  /// Get recent responses
  Future<List<AiResponse>> getRecentResponses({int limit = 10}) async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      return await _isar!.aiResponses
          .where()
          .sortByTimestampDesc()
          .limit(limit)
          .findAll();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get recent responses', e, stackTrace);
      return [];
    }
  }

  /// Delete AI response
  Future<void> deleteResponse(String id) async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      await _isar!.writeTxn(() async {
        await _isar!.aiResponses.delete(id);
      });

      AppLogger.info('AI response deleted: $id');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to delete AI response', e, stackTrace);
      rethrow;
    }
  }

  /// Clear all responses
  Future<void> clearAllResponses() async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      await _isar!.writeTxn(() async {
        await _isar!.aiResponses.clear();
      });

      AppLogger.info('All AI responses cleared');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to clear all responses', e, stackTrace);
      rethrow;
    }
  }

  /// Get response count
  Future<int> getResponseCount() async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      return await _isar!.aiResponses.count();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get response count', e, stackTrace);
      return 0;
    }
  }

  /// Search responses
  Future<List<AiResponse>> searchResponses(String query) async {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }

    try {
      return await _isar!.aiResponses
          .filter()
          .contentContains(query, caseSensitive: false)
          .findAll();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to search responses', e, stackTrace);
      return [];
    }
  }

  /// Dispose resources
  Future<void> dispose() async {
    await _isar?.close();
    _isar = null;
  }
}

/// Isar schema for AI responses
@collection
class AiResponseSchema {
  @Id()
  String id = '';

  @Index()
  String content = '';

  @Index()
  int type = 0;

  @Index()
  DateTime timestamp = DateTime.now();

  String? model;

  double confidence = 0.0;

  String? source;

  @Index()
  List<String> tags = [];

  Map<String, dynamic>? metadata;

  // Convert from AiResponse
  static AiResponseSchema fromAiResponse(AiResponse response) {
    return AiResponseSchema()
      ..id = response.id
      ..content = response.content
      ..type = response.type.index
      ..timestamp = response.timestamp
      ..model = response.model
      ..confidence = response.confidence
      ..source = response.source
      ..tags = response.tags ?? []
      ..metadata = response.metadata;
  }

  // Convert to AiResponse
  AiResponse toAiResponse() {
    return AiResponse(
      id: id,
      content: content,
      type: AiResponseType.values[type],
      timestamp: timestamp,
      model: model,
      confidence: confidence,
      source: source,
      tags: tags,
      metadata: metadata,
    );
  }
}

/// Isar schema for AI requests
@collection
class AiRequestSchema {
  @Id()
  String id = '';

  @Index()
  String prompt = '';

  @Index()
  int type = 0;

  @Index()
  DateTime timestamp = DateTime.now();

  String? context;

  double temperature = 0.7;

  int maxTokens = 2048;

  String? conversationId;

  @Index()
  List<String> attachments = [];

  bool isStreaming = false;

  Map<String, dynamic>? parameters;

  // Convert from AiRequest
  static AiRequestSchema fromAiRequest(AiRequest request) {
    return AiRequestSchema()
      ..id = request.id
      ..prompt = request.prompt
      ..type = request.type.index
      ..timestamp = request.timestamp
      ..context = request.context
      ..temperature = request.temperature
      ..maxTokens = request.maxTokens
      ..conversationId = request.conversationId
      ..attachments = request.attachments ?? []
      ..isStreaming = request.isStreaming
      ..parameters = request.parameters;
  }

  // Convert to AiRequest
  AiRequest toAiRequest() {
    return AiRequest(
      id: id,
      prompt: prompt,
      type: AiRequestType.values[type],
      timestamp: timestamp,
      context: context,
      temperature: temperature,
      maxTokens: maxTokens,
      conversationId: conversationId,
      attachments: attachments,
      isStreaming: isStreaming,
      parameters: parameters,
    );
  }
}
