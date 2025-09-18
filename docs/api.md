# 📚 API Documentation

## Overview

This document provides comprehensive API documentation for Pandora Rebuilt, covering all services, repositories, and use cases.

## Table of Contents

- [AI Services](#ai-services)
- [Note Services](#note-services)
- [Voice Services](#voice-services)
- [Security Services](#security-services)
- [Performance Services](#performance-services)
- [Analytics Services](#analytics-services)
- [Collaboration Services](#collaboration-services)
- [Machine Learning Services](#machine-learning-services)

## AI Services

### AiRepository

The main repository for AI operations.

#### Methods

##### `generateResponse(AiRequest request)`
Generates an AI response from a request.

**Parameters:**
- `request` (AiRequest): The AI request object

**Returns:** `Future<AiResponse>`

**Example:**
```dart
final request = AiRequest(
  query: "Summarize this text",
  type: AiRequestType.summarization,
);
final response = await aiRepository.generateResponse(request);
```

##### `generateText(String prompt, {String? context, double? temperature, int? maxTokens})`
Generates text from a prompt.

**Parameters:**
- `prompt` (String): The input prompt
- `context` (String?, optional): Additional context
- `temperature` (double?, optional): Response creativity (0.0-1.0)
- `maxTokens` (int?, optional): Maximum tokens to generate

**Returns:** `Future<AiResponse>`

**Example:**
```dart
final response = await aiRepository.generateText(
  "Write a poem about AI",
  temperature: 0.7,
  maxTokens: 500,
);
```

##### `summarizeText(String text, {int? maxLength, String? style, SummarizationStyle? summarizationStyle})`
Summarizes text content.

**Parameters:**
- `text` (String): Text to summarize
- `maxLength` (int?, optional): Maximum summary length
- `style` (String?, optional): Summary style
- `summarizationStyle` (SummarizationStyle?, optional): Advanced style options

**Returns:** `Future<AiResponse>`

**Example:**
```dart
final response = await aiRepository.summarizeText(
  "Long text content...",
  summarizationStyle: SummarizationStyle.bulletPoints,
);
```

##### `translateText(String text, String targetLanguage, {String? sourceLanguage, bool preserveFormatting, Map<String, dynamic>? culturalContext})`
Translates text to target language.

**Parameters:**
- `text` (String): Text to translate
- `targetLanguage` (String): Target language code
- `sourceLanguage` (String?, optional): Source language code
- `preserveFormatting` (bool, optional): Preserve original formatting
- `culturalContext` (Map<String, dynamic>?, optional): Cultural context

**Returns:** `Future<AiResponse>`

**Example:**
```dart
final response = await aiRepository.translateText(
  "Hello world",
  "es",
  sourceLanguage: "en",
  preserveFormatting: true,
);
```

##### `generateFromTemplate(ContentTemplate template, {Map<String, dynamic>? parameters, String? context})`
Generates content from a template.

**Parameters:**
- `template` (ContentTemplate): Content template
- `parameters` (Map<String, dynamic>?, optional): Template parameters
- `context` (String?, optional): Additional context

**Returns:** `Future<AiResponse>`

**Example:**
```dart
final template = ContentTemplate(
  name: "Meeting Notes",
  content: "Meeting: {{meeting_name}}\nDate: {{date}}\nAttendees: {{attendees}}",
);
final response = await aiRepository.generateFromTemplate(
  template,
  parameters: {
    "meeting_name": "Weekly Standup",
    "date": "2024-01-15",
    "attendees": "John, Jane, Bob",
  },
);
```

### AiService

Service for AI operations.

#### Methods

##### `initialize()`
Initializes the AI service.

**Returns:** `Future<bool>`

**Example:**
```dart
final success = await aiService.initialize();
if (success) {
  print("AI service initialized successfully");
}
```

##### `isAvailable()`
Checks if AI service is available.

**Returns:** `Future<bool>`

**Example:**
```dart
final available = await aiService.isAvailable();
if (available) {
  // Use AI features
}
```

##### `getStatus()`
Gets AI service status.

**Returns:** `Future<AiServiceStatus>`

**Example:**
```dart
final status = await aiService.getStatus();
print("AI service status: $status");
```

## Note Services

### NoteRepository

Repository for note operations.

#### Methods

##### `createNote(Note note)`
Creates a new note.

**Parameters:**
- `note` (Note): Note to create

**Returns:** `Future<Note>`

**Example:**
```dart
final note = Note(
  title: "My Note",
  content: "Note content",
  createdAt: DateTime.now(),
);
final createdNote = await noteRepository.createNote(note);
```

##### `updateNote(Note note)`
Updates an existing note.

**Parameters:**
- `note` (Note): Note to update

**Returns:** `Future<Note>`

**Example:**
```dart
note.content = "Updated content";
final updatedNote = await noteRepository.updateNote(note);
```

##### `deleteNote(String noteId)`
Deletes a note.

**Parameters:**
- `noteId` (String): ID of note to delete

**Returns:** `Future<void>`

**Example:**
```dart
await noteRepository.deleteNote("note_123");
```

##### `getNote(String noteId)`
Gets a note by ID.

**Parameters:**
- `noteId` (String): ID of note to get

**Returns:** `Future<Note?>`

**Example:**
```dart
final note = await noteRepository.getNote("note_123");
if (note != null) {
  print("Note title: ${note.title}");
}
```

##### `getNotes({String? searchQuery, List<String>? tags, DateTime? fromDate, DateTime? toDate, int? limit, int? offset})`
Gets notes with filters.

**Parameters:**
- `searchQuery` (String?, optional): Search query
- `tags` (List<String>?, optional): Filter by tags
- `fromDate` (DateTime?, optional): Filter from date
- `toDate` (DateTime?, optional): Filter to date
- `limit` (int?, optional): Maximum number of notes
- `offset` (int?, optional): Offset for pagination

**Returns:** `Future<List<Note>>`

**Example:**
```dart
final notes = await noteRepository.getNotes(
  searchQuery: "meeting",
  tags: ["work", "important"],
  limit: 10,
);
```

## Voice Services

### VoiceService

Service for voice recognition and text-to-speech.

#### Methods

##### `initialize()`
Initializes voice services.

**Returns:** `Future<bool>`

**Example:**
```dart
final success = await voiceService.initialize();
if (success) {
  print("Voice service initialized");
}
```

##### `startListening({required Function(String) onResult, Function(String)? onError, String localeId = 'vi_VN'})`
Starts listening for speech input.

**Parameters:**
- `onResult` (Function(String)): Callback for speech results
- `onError` (Function(String)?, optional): Callback for errors
- `localeId` (String, optional): Locale ID for speech recognition

**Returns:** `Future<void>`

**Example:**
```dart
await voiceService.startListening(
  onResult: (text) {
    print("Recognized: $text");
  },
  onError: (error) {
    print("Error: $error");
  },
);
```

##### `stopListening()`
Stops listening for speech input.

**Returns:** `Future<void>`

**Example:**
```dart
await voiceService.stopListening();
```

##### `speak(String text)`
Speaks text using text-to-speech.

**Parameters:**
- `text` (String): Text to speak

**Returns:** `Future<void>`

**Example:**
```dart
await voiceService.speak("Hello, how are you?");
```

##### `setLanguage(VoiceLanguage language)`
Sets the voice language.

**Parameters:**
- `language` (VoiceLanguage): Voice language to set

**Returns:** `Future<void>`

**Example:**
```dart
await voiceService.setLanguage(VoiceLanguages.english);
```

##### `getSupportedLanguages()`
Gets supported voice languages.

**Returns:** `List<VoiceLanguage>`

**Example:**
```dart
final languages = voiceService.getSupportedLanguages();
for (final language in languages) {
  print("${language.displayName} (${language.code})");
}
```

## Security Services

### SecurityService

Service for security operations.

#### Methods

##### `initialize()`
Initializes security services.

**Returns:** `Future<bool>`

**Example:**
```dart
final success = await securityService.initialize();
if (success) {
  print("Security service initialized");
}
```

##### `encryptData(String data, String password)`
Encrypts data with password.

**Parameters:**
- `data` (String): Data to encrypt
- `password` (String): Encryption password

**Returns:** `Future<String>`

**Example:**
```dart
final encrypted = await securityService.encryptData(
  "Sensitive data",
  "my_password",
);
```

##### `decryptData(String encryptedData, String password)`
Decrypts data with password.

**Parameters:**
- `encryptedData` (String): Encrypted data
- `password` (String): Decryption password

**Returns:** `Future<String>`

**Example:**
```dart
final decrypted = await securityService.decryptData(
  encrypted,
  "my_password",
);
```

##### `enableBiometricAuth()`
Enables biometric authentication.

**Returns:** `Future<bool>`

**Example:**
```dart
final success = await securityService.enableBiometricAuth();
if (success) {
  print("Biometric authentication enabled");
}
```

##### `authenticateWithBiometric()`
Authenticates using biometric.

**Returns:** `Future<bool>`

**Example:**
```dart
final authenticated = await securityService.authenticateWithBiometric();
if (authenticated) {
  print("Biometric authentication successful");
}
```

## Performance Services

### PerformanceOptimizationService

Service for performance optimization.

#### Methods

##### `initialize()`
Initializes performance optimization service.

**Returns:** `Future<bool>`

**Example:**
```dart
final success = await performanceService.initialize();
if (success) {
  print("Performance service initialized");
}
```

##### `getPerformanceMetrics({PerformanceMetricType? type, DateTime? since, int? limit})`
Gets performance metrics.

**Parameters:**
- `type` (PerformanceMetricType?, optional): Filter by metric type
- `since` (DateTime?, optional): Filter since date
- `limit` (int?, optional): Maximum number of metrics

**Returns:** `List<PerformanceMetric>`

**Example:**
```dart
final metrics = performanceService.getPerformanceMetrics(
  type: PerformanceMetricType.frameRate,
  since: DateTime.now().subtract(Duration(hours: 1)),
  limit: 10,
);
```

##### `getPerformanceAlerts({PerformanceAlertType? type, PerformanceAlertSeverity? severity, bool? isResolved})`
Gets performance alerts.

**Parameters:**
- `type` (PerformanceAlertType?, optional): Filter by alert type
- `severity` (PerformanceAlertSeverity?, optional): Filter by severity
- `isResolved` (bool?, optional): Filter by resolution status

**Returns:** `List<PerformanceAlert>`

**Example:**
```dart
final alerts = performanceService.getPerformanceAlerts(
  severity: PerformanceAlertSeverity.high,
  isResolved: false,
);
```

##### `applyOptimization(PerformanceOptimizationType type)`
Applies performance optimization.

**Parameters:**
- `type` (PerformanceOptimizationType): Type of optimization to apply

**Returns:** `Future<bool>`

**Example:**
```dart
final success = await performanceService.applyOptimization(
  PerformanceOptimizationType.memoryUsage,
);
if (success) {
  print("Memory optimization applied");
}
```

## Analytics Services

### AdvancedAnalyticsService

Service for advanced analytics.

#### Methods

##### `initialize()`
Initializes analytics service.

**Returns:** `Future<bool>`

**Example:**
```dart
final success = await analyticsService.initialize();
if (success) {
  print("Analytics service initialized");
}
```

##### `trackEvent(AnalyticsEvent event)`
Tracks an analytics event.

**Parameters:**
- `event` (AnalyticsEvent): Event to track

**Returns:** `void`

**Example:**
```dart
final event = AnalyticsEvent(
  id: "event_123",
  type: AnalyticsEventType.userAction,
  name: "note_created",
  properties: {"note_type": "text"},
  timestamp: DateTime.now(),
);
analyticsService.trackEvent(event);
```

##### `getAnalyticsDashboard()`
Gets analytics dashboard data.

**Returns:** `AnalyticsDashboard`

**Example:**
```dart
final dashboard = analyticsService.getAnalyticsDashboard();
print("Total events: ${dashboard.totalEvents}");
print("Key metrics: ${dashboard.keyMetrics}");
```

##### `getAnalyticsStatistics()`
Gets analytics statistics.

**Returns:** `AnalyticsStatistics`

**Example:**
```dart
final stats = analyticsService.getAnalyticsStatistics();
print("Total events processed: ${stats.totalEventsProcessed}");
print("Uptime: ${stats.uptime}");
```

## Collaboration Services

### RealTimeCollaborationService

Service for real-time collaboration.

#### Methods

##### `initialize()`
Initializes collaboration service.

**Returns:** `Future<bool>`

**Example:**
```dart
final success = await collaborationService.initialize();
if (success) {
  print("Collaboration service initialized");
}
```

##### `createSession({required String name, required String description, required List<String> participantIds, CollaborationSessionType type = CollaborationSessionType.document})`
Creates a collaboration session.

**Parameters:**
- `name` (String): Session name
- `description` (String): Session description
- `participantIds` (List<String>): Participant user IDs
- `type` (CollaborationSessionType, optional): Session type

**Returns:** `Future<String>`

**Example:**
```dart
final sessionId = await collaborationService.createSession(
  name: "Project Meeting",
  description: "Weekly project discussion",
  participantIds: ["user1", "user2", "user3"],
  type: CollaborationSessionType.meeting,
);
```

##### `joinSession(String sessionId, String userId)`
Joins a collaboration session.

**Parameters:**
- `sessionId` (String): Session ID to join
- `userId` (String): User ID joining the session

**Returns:** `Future<bool>`

**Example:**
```dart
final success = await collaborationService.joinSession(
  "session_123",
  "user_456",
);
if (success) {
  print("Joined session successfully");
}
```

##### `sendMessage({required String sessionId, required String senderId, required String content, CollaborationMessageType type = CollaborationMessageType.text})`
Sends a message to a session.

**Parameters:**
- `sessionId` (String): Session ID
- `senderId` (String): Sender user ID
- `content` (String): Message content
- `type` (CollaborationMessageType, optional): Message type

**Returns:** `Future<String>`

**Example:**
```dart
final messageId = await collaborationService.sendMessage(
  sessionId: "session_123",
  senderId: "user_456",
  content: "Hello everyone!",
  type: CollaborationMessageType.text,
);
```

##### `shareDocument({required String sessionId, required String documentId, required String title, required String content, required String sharedBy})`
Shares a document in a session.

**Parameters:**
- `sessionId` (String): Session ID
- `documentId` (String): Document ID
- `title` (String): Document title
- `content` (String): Document content
- `sharedBy` (String): User ID who shared the document

**Returns:** `Future<String>`

**Example:**
```dart
final documentId = await collaborationService.shareDocument(
  sessionId: "session_123",
  documentId: "doc_789",
  title: "Project Requirements",
  content: "Document content...",
  sharedBy: "user_456",
);
```

## Machine Learning Services

### MachineLearningService

Service for machine learning operations.

#### Methods

##### `initialize()`
Initializes machine learning service.

**Returns:** `Future<bool>`

**Example:**
```dart
final success = await mlService.initialize();
if (success) {
  print("ML service initialized");
}
```

##### `getMLModels({MLModelStatus? status})`
Gets machine learning models.

**Parameters:**
- `status` (MLModelStatus?, optional): Filter by model status

**Returns:** `List<MLModel>`

**Example:**
```dart
final models = mlService.getMLModels(
  status: MLModelStatus.ready,
);
for (final model in models) {
  print("Model: ${model.name} (${model.accuracy})");
}
```

##### `getMLPredictions({MLPredictionType? type, DateTime? since, int? limit})`
Gets machine learning predictions.

**Parameters:**
- `type` (MLPredictionType?, optional): Filter by prediction type
- `since` (DateTime?, optional): Filter since date
- `limit` (int?, optional): Maximum number of predictions

**Returns:** `List<MLPrediction>`

**Example:**
```dart
final predictions = mlService.getMLPredictions(
  type: MLPredictionType.predictiveAnalytics,
  since: DateTime.now().subtract(Duration(hours: 1)),
  limit: 5,
);
```

##### `getMLInsights({MLInsightType? type, MLInsightSeverity? severity, DateTime? since, int? limit})`
Gets machine learning insights.

**Parameters:**
- `type` (MLInsightType?, optional): Filter by insight type
- `severity` (MLInsightSeverity?, optional): Filter by severity
- `since` (DateTime?, optional): Filter since date
- `limit` (int?, optional): Maximum number of insights

**Returns:** `List<MLInsight>`

**Example:**
```dart
final insights = mlService.getMLInsights(
  type: MLInsightType.userBehavior,
  severity: MLInsightSeverity.medium,
  limit: 10,
);
```

##### `trainModel(String modelId, MLTrainingData trainingData)`
Trains a machine learning model.

**Parameters:**
- `modelId` (String): Model ID to train
- `trainingData` (MLTrainingData): Training data

**Returns:** `Future<void>`

**Example:**
```dart
final trainingData = MLTrainingData(
  features: [
    {"feature1": 1.0, "feature2": 2.0},
    {"feature1": 3.0, "feature2": 4.0},
  ],
  targets: [0, 1],
);
await mlService.trainModel("model_123", trainingData);
```

## Error Handling

All services include comprehensive error handling with detailed error messages and logging.

### Common Error Types

- **ServiceNotInitializedError**: Service not initialized
- **InvalidParameterError**: Invalid parameter provided
- **NetworkError**: Network connectivity issues
- **AuthenticationError**: Authentication failed
- **PermissionError**: Insufficient permissions
- **DataError**: Data processing error

### Error Handling Example

```dart
try {
  final response = await aiService.generateText("Hello");
  print("Response: ${response.response}");
} on ServiceNotInitializedError {
  print("AI service not initialized");
} on NetworkError catch (e) {
  print("Network error: ${e.message}");
} catch (e) {
  print("Unexpected error: $e");
}
```

## Rate Limiting

Some services implement rate limiting to prevent abuse:

- **AI Services**: 100 requests per minute
- **Voice Services**: 50 requests per minute
- **Analytics Services**: 1000 events per hour
- **Collaboration Services**: 200 messages per minute

## Authentication

Most services require authentication:

1. **Initialize** the service
2. **Authenticate** with credentials
3. **Use** the service methods

## Best Practices

1. **Always check** if service is initialized
2. **Handle errors** appropriately
3. **Use appropriate** data types
4. **Follow** naming conventions
5. **Test** your implementation
6. **Monitor** performance
7. **Log** important events
8. **Update** dependencies regularly

## Support

For API support and questions:

- **Documentation**: [docs/api.md](api.md)
- **Issues**: [GitHub Issues](https://github.com/your-username/pandora_rebuilt/issues)
- **Discussions**: [GitHub Discussions](https://github.com/your-username/pandora_rebuilt/discussions)
- **Email**: support@pandora-rebuilt.com
