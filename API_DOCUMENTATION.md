# 📚 PandoraX API Documentation

## Overview

This document provides comprehensive API documentation for PandoraX, covering all services, repositories, and use cases.

## Table of Contents

- [Core Services](#core-services)
- [AI Services](#ai-services)
- [Note Services](#note-services)
- [Security Services](#security-services)
- [Analytics Services](#analytics-services)
- [Firebase Services](#firebase-services)
- [Voice Services](#voice-services)

## Core Services

### Logger Service

The `AppLogger` service provides centralized logging functionality.

```dart
// Usage
AppLogger.info('Information message');
AppLogger.success('Success message');
AppLogger.warning('Warning message');
AppLogger.error('Error message', error, stackTrace);
```

**Methods:**
- `info(String message)` - Log info level message
- `success(String message)` - Log success message
- `warning(String message)` - Log warning message
- `error(String message, dynamic error, StackTrace? stackTrace)` - Log error message

### Dependency Injection Service

The `ServiceLocator` manages dependency injection throughout the app.

```dart
// Register service
ServiceLocator.registerLazySingleton<MyService>(() => MyService());

// Get service
final service = ServiceLocator.get<MyService>();

// Initialize all services
await ServiceLocator.initialize();
```

## AI Services

### AI Remote Data Source

Handles AI operations using Google Generative AI.

```dart
final aiDataSource = AiRemoteDataSource();

// Initialize
await aiDataSource.initialize();

// Generate text
final response = await aiDataSource.generateText(AiRequest(
  query: 'Write a summary about Flutter',
  type: AiRequestType.text,
  context: 'development',
  attachments: [],
));

// Summarize text
final summary = await aiDataSource.summarizeText(AiRequest(
  query: 'Long text to summarize...',
  type: AiRequestType.summarize,
  context: 'notes',
  attachments: [],
));

// Chat with AI
final chatResponse = await aiDataSource.chat([
  ChatMessage(content: 'Hello', type: ChatMessageType.user),
  ChatMessage(content: 'Hi! How can I help?', type: ChatMessageType.assistant),
]);
```

**Methods:**
- `initialize()` - Initialize AI service
- `generateText(AiRequest request)` - Generate text using AI
- `summarizeText(AiRequest request)` - Summarize text using AI
- `chat(List<ChatMessage> messages)` - Chat with AI
- `checkServiceStatus()` - Check if AI service is available

### AI Request Types

```dart
enum AiRequestType {
  text,
  summarize,
  chat,
  translate,
  analyze,
  generate,
  rewrite,
  explain,
  answer,
  help,
}
```

### AI Response Types

```dart
enum AiResponseType {
  text,
  image,
  audio,
  video,
  file,
}
```

## Note Services

### Note Remote Data Source

Handles note operations with Firestore.

```dart
final noteDataSource = NoteRemoteDataSource();

// Initialize with user ID
await noteDataSource.initialize('user123');

// Get all notes
final notes = await noteDataSource.getAllNotes();

// Get note by ID
final note = await noteDataSource.getNoteById('note123');

// Create note
final noteId = await noteDataSource.createNote(Note(
  id: 'note123',
  title: 'My Note',
  content: 'Note content...',
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
));

// Update note
await noteDataSource.updateNote(updatedNote);

// Delete note
await noteDataSource.deleteNote('note123');

// Search notes
final searchResults = await noteDataSource.searchNotes('flutter');

// Get notes by category
final categoryNotes = await noteDataSource.getNotesByCategory('work');

// Get notes by tags
final taggedNotes = await noteDataSource.getNotesByTags(['important', 'urgent']);

// Listen to real-time updates
noteDataSource.listenToNotes().listen((notes) {
  // Handle note updates
});
```

**Methods:**
- `initialize(String userId)` - Initialize with user ID
- `getAllNotes()` - Get all notes
- `getNoteById(String id)` - Get note by ID
- `createNote(Note note)` - Create new note
- `updateNote(Note note)` - Update existing note
- `deleteNote(String id)` - Delete note
- `searchNotes(String query)` - Search notes
- `getNotesByCategory(String category)` - Get notes by category
- `getNotesByTags(List<String> tags)` - Get notes by tags
- `syncNotes(List<Note> localNotes)` - Sync notes with cloud
- `listenToNotes()` - Listen to real-time updates

## Security Services

### Security Service

Handles data encryption and security features.

```dart
final securityService = SecurityService();

// Initialize
await securityService.initialize();

// Encrypt data
final encrypted = securityService.encrypt('sensitive data');

// Decrypt data
final decrypted = securityService.decrypt(encrypted);

// Encrypt note content
final encryptedNote = securityService.encryptNote('note content');

// Decrypt note content
final decryptedNote = securityService.decryptNote(encryptedNote);

// Hash password
final hashedPassword = securityService.hashPassword('password', 'salt');

// Generate salt
final salt = securityService.generateSalt();

// Generate secure token
final token = securityService.generateSecureToken();

// Validate password strength
final strength = securityService.validatePasswordStrength('password123');

// Store secure data
await securityService.storeSecureData('key', 'value');

// Retrieve secure data
final value = await securityService.getSecureData('key');

// Remove secure data
await securityService.removeSecureData('key');

// Encrypt file
final encryptedFile = securityService.encryptFile(fileBytes);

// Decrypt file
final decryptedFile = securityService.decryptFile(encryptedFile);
```

**Methods:**
- `initialize()` - Initialize security service
- `encrypt(String plainText)` - Encrypt text
- `decrypt(String encryptedText)` - Decrypt text
- `encryptNote(String content)` - Encrypt note content
- `decryptNote(String encryptedContent)` - Decrypt note content
- `hashPassword(String password, String salt)` - Hash password
- `generateSalt()` - Generate secure salt
- `generateSecureToken()` - Generate secure token
- `validatePasswordStrength(String password)` - Validate password strength
- `storeSecureData(String key, String value)` - Store secure data
- `getSecureData(String key)` - Retrieve secure data
- `removeSecureData(String key)` - Remove secure data
- `encryptFile(Uint8List fileData)` - Encrypt file
- `decryptFile(Uint8List encryptedData)` - Decrypt file

### Password Strength

```dart
enum PasswordStrength {
  weak,
  medium,
  strong,
}
```

## Analytics Services

### Analytics Service

Tracks user behavior and performance metrics.

```dart
final analyticsService = AnalyticsService();

// Initialize
await analyticsService.initialize();

// Track event
analyticsService.trackEvent('button_clicked', {
  'button_name': 'create_note',
  'screen': 'home',
});

// Track performance
analyticsService.trackPerformance('note_creation', Duration(milliseconds: 500));

// Track error
analyticsService.trackError('api_error', 'Failed to fetch notes', stackTrace);

// Track user action
analyticsService.trackUserAction('note_created', {
  'note_id': 'note123',
  'category': 'work',
});

// Track screen view
analyticsService.trackScreenView('home_screen', {
  'user_id': 'user123',
});

// Track feature usage
analyticsService.trackFeatureUsage('ai_summarization', {
  'note_length': 1000,
});

// Track app lifecycle
analyticsService.trackAppLifecycle('resumed');

// Get analytics data
final data = await analyticsService.getAnalyticsData();

// Clear analytics data
await analyticsService.clearAnalyticsData();

// Force flush events
await analyticsService.forceFlush();
```

**Methods:**
- `initialize()` - Initialize analytics service
- `trackEvent(String eventName, Map<String, dynamic> parameters)` - Track event
- `trackPerformance(String operation, Duration duration, {Map<String, dynamic>? metadata})` - Track performance
- `trackError(String errorType, String errorMessage, StackTrace? stackTrace, {Map<String, dynamic>? context})` - Track error
- `trackUserAction(String action, {Map<String, dynamic>? parameters})` - Track user action
- `trackScreenView(String screenName, {Map<String, dynamic>? parameters})` - Track screen view
- `trackFeatureUsage(String featureName, {Map<String, dynamic>? parameters})` - Track feature usage
- `trackAppLifecycle(String lifecycleState)` - Track app lifecycle
- `getAnalyticsData()` - Get analytics data
- `clearAnalyticsData()` - Clear analytics data
- `forceFlush()` - Force flush events

## Firebase Services

### Firebase Service

Handles Firebase operations.

```dart
final firebaseService = FirebaseService();

// Initialize
await firebaseService.initialize();

// Get current user
final user = firebaseService.currentUser;

// Check if authenticated
final isAuth = firebaseService.isAuthenticated;

// Sign in
final credential = await firebaseService.signInWithEmailAndPassword('email', 'password');

// Create user
final newCredential = await firebaseService.createUserWithEmailAndPassword('email', 'password');

// Sign out
await firebaseService.signOut();

// Track event
await firebaseService.trackEvent('custom_event', {'key': 'value'});

// Set user properties
await firebaseService.setUserProperties({'property': 'value'});

// Upload file
final downloadUrl = await firebaseService.uploadFile('path/file.txt', fileBytes);

// Download file
final fileData = await firebaseService.downloadFile('path/file.txt');

// Delete file
await firebaseService.deleteFile('path/file.txt');
```

**Methods:**
- `initialize()` - Initialize Firebase services
- `currentUser` - Get current user
- `isAuthenticated` - Check if user is authenticated
- `signInWithEmailAndPassword(String email, String password)` - Sign in
- `createUserWithEmailAndPassword(String email, String password)` - Create user
- `signOut()` - Sign out
- `trackEvent(String eventName, Map<String, dynamic> parameters)` - Track event
- `setUserProperties(Map<String, String> properties)` - Set user properties
- `uploadFile(String path, List<int> data)` - Upload file
- `downloadFile(String path)` - Download file
- `deleteFile(String path)` - Delete file

## Voice Services

### Voice Service

Handles speech-to-text and text-to-speech functionality.

```dart
final voiceService = VoiceService();

// Initialize
final isInitialized = await voiceService.initialize();

// Start listening
await voiceService.startListening(
  onResult: (text) {
    print('Recognized: $text');
  },
  onError: (error) {
    print('Error: $error');
  },
  localeId: 'vi_VN',
);

// Stop listening
await voiceService.stopListening();

// Speak text
await voiceService.speak('Hello, this is PandoraX');

// Stop speaking
await voiceService.stopSpeaking();

// Check if speech is available
final isAvailable = await voiceService.isSpeechAvailable();

// Get available languages
final languages = await voiceService.getAvailableLanguages();

// Set TTS language
await voiceService.setTtsLanguage('vi-VN');

// Set speech rate
await voiceService.setSpeechRate(0.8);

// Set volume
await voiceService.setVolume(0.9);

// Check status
final isListening = voiceService.isListening;
final isSpeaking = voiceService.isSpeaking;
final isInitialized = voiceService.isInitialized;

// Dispose
await voiceService.dispose();
```

**Methods:**
- `initialize()` - Initialize voice services
- `startListening({required Function(String) onResult, Function(String)? onError, String localeId = 'vi_VN'})` - Start listening
- `stopListening()` - Stop listening
- `speak(String text)` - Speak text
- `stopSpeaking()` - Stop speaking
- `isSpeechAvailable()` - Check if speech is available
- `getAvailableLanguages()` - Get available languages
- `setTtsLanguage(String languageCode)` - Set TTS language
- `setSpeechRate(double rate)` - Set speech rate
- `setVolume(double volume)` - Set volume
- `dispose()` - Dispose resources

## Error Handling

All services include comprehensive error handling:

```dart
try {
  final result = await service.performOperation();
} catch (e) {
  // Error is automatically logged
  // Handle error appropriately
  AppLogger.error('Operation failed', e);
}
```

## Performance Considerations

- All services are designed for optimal performance
- Async operations are used throughout
- Memory management is handled automatically
- Services are singleton instances to reduce overhead

## Security Considerations

- All sensitive data is encrypted
- API keys are stored securely
- User data is protected with proper authentication
- Local storage is encrypted

## Testing

All services include comprehensive unit tests:

```bash
# Run all tests
melos run test

# Run specific service tests
cd packages/foundation/core_utils && flutter test test/services/
```

## Contributing

When adding new services or modifying existing ones:

1. Follow the established patterns
2. Include comprehensive error handling
3. Add unit tests
4. Update this documentation
5. Follow the coding standards

---

For more information, see the [main README](README.md) or [Contributing Guidelines](CONTRIBUTING.md).
