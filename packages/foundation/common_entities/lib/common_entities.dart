/// Common entities package for PandoraX
///
/// This package contains all the base entities and common data structures
/// used across the entire application following Clean Architecture principles.
library common_entities;

// Base entities
export 'entities/base_entity.dart';

// Domain entities
export 'entities/note.dart';
export 'entities/ai_response.dart';
export 'entities/chat_message.dart';

// Enums
export 'entities/ai_response.dart' show AiResponseType;
export 'entities/chat_message.dart' show ChatMessageType;
