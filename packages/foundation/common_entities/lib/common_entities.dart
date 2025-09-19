/// Common entities package for PandoraX
///
/// This package contains all the base entities and common data structures
/// used across the entire application following Clean Architecture principles.
library common_entities;

// Base entities
export 'entities/base_entity.dart';

// Domain entities
export 'entities/note.dart';
export 'entities/note_statistics.dart';
export 'entities/ai_response.dart';
export 'entities/chat_message.dart';

// Performance entities
export 'entities/performance_config.dart';

// Sync entities
export 'entities/sync_config.dart';

// Theme entities
export 'entities/theme_config.dart';
export 'entities/accessibility_config.dart';

// Security entities
export 'entities/security_event.dart';

// Voice entities
export 'entities/voice_config.dart';

// Reminder entities
export 'entities/reminder.dart';

// ML entities
export 'entities/ml_config.dart';

// Enums
export 'entities/ai_response.dart' show AiResponseType;
export 'entities/chat_message.dart' show ChatMessageType;
