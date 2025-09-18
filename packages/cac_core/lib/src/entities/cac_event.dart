/// CAC Event
/// 
/// Represents events in the Cognitive Augmentation Core system
class CacEvent {
  final String type;
  final Map<String, dynamic> data;

  const CacEvent({
    required this.type,
    required this.data,
  });

  factory CacEvent.memoryCreated({
    required String memoryId,
    required String content,
    required String source,
    required DateTime timestamp,
  }) {
    return CacEvent(
      type: 'memory_created',
      data: {
        'memoryId': memoryId,
        'content': content,
        'source': source,
        'timestamp': timestamp.toIso8601String(),
      },
    );
  }

  factory CacEvent.memoryUpdated({
    required String memoryId,
    required String content,
    required String source,
    required DateTime timestamp,
  }) {
    return CacEvent(
      type: 'memory_updated',
      data: {
        'memoryId': memoryId,
        'content': content,
        'source': source,
        'timestamp': timestamp.toIso8601String(),
      },
    );
  }

  factory CacEvent.memoryDeleted({
    required String memoryId,
  }) {
    return CacEvent(
      type: 'memory_deleted',
      data: {
        'memoryId': memoryId,
      },
    );
  }

  factory CacEvent.noteCreated({
    required String noteId,
    required String title,
    required String content,
    required DateTime timestamp,
  }) {
    return CacEvent(
      type: 'note_created',
      data: {
        'noteId': noteId,
        'title': title,
        'content': content,
        'timestamp': timestamp.toIso8601String(),
      },
    );
  }

  factory CacEvent.noteUpdated({
    required String noteId,
    required String title,
    required String content,
    required DateTime timestamp,
  }) {
    return CacEvent(
      type: 'note_updated',
      data: {
        'noteId': noteId,
        'title': title,
        'content': content,
        'timestamp': timestamp.toIso8601String(),
      },
    );
  }

  factory CacEvent.noteDeleted({
    required String noteId,
  }) {
    return CacEvent(
      type: 'note_deleted',
      data: {
        'noteId': noteId,
      },
    );
  }
}