library realtime_collaboration;

// Core collaboration services
export 'src/services/collaboration_manager.dart';
export 'src/services/live_editor.dart';
export 'src/services/conflict_resolver.dart';
export 'src/services/presence_manager.dart';

// Real-time communication
export 'src/communication/websocket_client.dart';
export 'src/communication/socket_io_client.dart';
export 'src/communication/message_router.dart';
export 'src/communication/connection_manager.dart';

// Collaboration features
export 'src/features/cursor_tracking.dart';
export 'src/features/selection_sharing.dart';
export 'src/features/comment_system.dart';
export 'src/features/version_control.dart';
export 'src/features/permission_manager.dart';

// Data models
export 'src/models/collaboration_session.dart';
export 'src/models/collaboration_user.dart';
export 'src/models/operation.dart';
export 'src/models/conflict.dart';
export 'src/models/presence.dart';

// State management
export 'src/bloc/collaboration_bloc.dart';
export 'src/bloc/live_editor_bloc.dart';
export 'src/bloc/presence_bloc.dart';

// Utilities
export 'src/utils/collaboration_utils.dart';
export 'src/utils/operation_utils.dart';
export 'src/utils/conflict_utils.dart';
