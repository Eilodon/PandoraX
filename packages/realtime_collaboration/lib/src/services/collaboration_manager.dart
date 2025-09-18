import 'dart:async';
import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import 'package:rxdart/rxdart.dart';

import '../models/collaboration_session.dart';
import '../models/collaboration_user.dart';
import '../models/operation.dart';
import '../models/presence.dart';
import '../communication/websocket_client.dart';
import '../communication/socket_io_client.dart';
import '../communication/message_router.dart';
import '../features/cursor_tracking.dart';
import '../features/selection_sharing.dart';
import '../features/comment_system.dart';
import '../features/version_control.dart';
import '../features/permission_manager.dart';
import '../services/conflict_resolver.dart';
import '../services/presence_manager.dart';

/// Main collaboration manager for real-time editing
class CollaborationManager {
  static final CollaborationManager _instance = CollaborationManager._internal();
  factory CollaborationManager() => _instance;
  CollaborationManager._internal();

  static final Logger _logger = Logger();
  static final Uuid _uuid = const Uuid();
  
  // Core services
  late WebSocketClient _webSocketClient;
  late SocketIOClient _socketIOClient;
  late MessageRouter _messageRouter;
  late ConflictResolver _conflictResolver;
  late PresenceManager _presenceManager;
  
  // Collaboration features
  late CursorTracker _cursorTracker;
  late SelectionSharer _selectionSharer;
  late CommentSystem _commentSystem;
  late VersionController _versionController;
  late PermissionManager _permissionManager;
  
  // State
  bool _isInitialized = false;
  bool _isConnected = false;
  CollaborationSession? _currentSession;
  CollaborationUser? _currentUser;
  
  // Streams
  final BehaviorSubject<CollaborationSession?> _sessionController = 
      BehaviorSubject.seeded(null);
  final BehaviorSubject<List<CollaborationUser>> _usersController = 
      BehaviorSubject.seeded([]);
  final BehaviorSubject<List<Presence>> _presenceController = 
      BehaviorSubject.seeded([]);
  final StreamController<Operation> _operationController = 
      StreamController.broadcast();
  final StreamController<CollaborationEvent> _eventController = 
      StreamController.broadcast();

  /// Initialize collaboration manager
  Future<void> initialize({
    String? serverUrl,
    String? userId,
    String? userName,
  }) async {
    if (_isInitialized) return;

    _logger.i('Initializing Collaboration Manager...');
    
    try {
      // Initialize core services
      _webSocketClient = WebSocketClient();
      _socketIOClient = SocketIOClient();
      _messageRouter = MessageRouter();
      _conflictResolver = ConflictResolver();
      _presenceManager = PresenceManager();
      
      await _webSocketClient.initialize(serverUrl ?? 'ws://localhost:8080');
      await _socketIOClient.initialize(serverUrl ?? 'http://localhost:3000');
      await _messageRouter.initialize();
      await _conflictResolver.initialize();
      await _presenceManager.initialize();
      
      // Initialize collaboration features
      _cursorTracker = CursorTracker();
      _selectionSharer = SelectionSharer();
      _commentSystem = CommentSystem();
      _versionController = VersionController();
      _permissionManager = PermissionManager();
      
      await _cursorTracker.initialize();
      await _selectionSharer.initialize();
      await _commentSystem.initialize();
      await _versionController.initialize();
      await _permissionManager.initialize();
      
      // Set up current user
      if (userId != null && userName != null) {
        _currentUser = CollaborationUser(
          id: userId,
          name: userName,
          email: '',
          avatar: '',
          isOnline: true,
          lastSeen: DateTime.now(),
        );
      }
      
      // Set up event listeners
      _setupEventListeners();
      
      _isInitialized = true;
      _logger.i('Collaboration Manager initialized successfully');
      
    } catch (e) {
      _logger.e('Failed to initialize Collaboration Manager: $e');
      rethrow;
    }
  }

  /// Set up event listeners
  void _setupEventListeners() {
    // WebSocket events
    _webSocketClient.messageStream.listen(_handleWebSocketMessage);
    _webSocketClient.connectionStream.listen(_handleConnectionChange);
    
    // Socket.IO events
    _socketIOClient.messageStream.listen(_handleSocketIOMessage);
    _socketIOClient.connectionStream.listen(_handleConnectionChange);
    
    // Operation events
    _operationController.stream.listen(_handleOperation);
    
    // Presence events
    _presenceManager.presenceStream.listen(_handlePresenceChange);
  }

  /// Handle WebSocket messages
  void _handleWebSocketMessage(String message) {
    try {
      final data = jsonDecode(message);
      _messageRouter.routeMessage(data);
    } catch (e) {
      _logger.e('Failed to handle WebSocket message: $e');
    }
  }

  /// Handle Socket.IO messages
  void _handleSocketIOMessage(Map<String, dynamic> message) {
    try {
      _messageRouter.routeMessage(message);
    } catch (e) {
      _logger.e('Failed to handle Socket.IO message: $e');
    }
  }

  /// Handle connection changes
  void _handleConnectionChange(bool connected) {
    _isConnected = connected;
    _eventController.add(CollaborationEvent.connectionChanged(connected));
    
    if (connected && _currentSession != null) {
      _rejoinSession();
    }
  }

  /// Handle operations
  void _handleOperation(Operation operation) {
    if (_currentSession == null) return;
    
    try {
      // Apply operation locally
      _applyOperation(operation);
      
      // Broadcast to other users
      _broadcastOperation(operation);
      
      // Update version control
      _versionController.addOperation(operation);
      
    } catch (e) {
      _logger.e('Failed to handle operation: $e');
    }
  }

  /// Handle presence changes
  void _handlePresenceChange(List<Presence> presence) {
    _presenceController.add(presence);
    
    // Update users list
    final users = presence.map((p) => p.user).toList();
    _usersController.add(users);
  }

  /// Create a new collaboration session
  Future<CollaborationSession> createSession({
    required String documentId,
    required String documentName,
    required String documentType,
    String? password,
    List<String>? allowedUsers,
    Map<String, dynamic>? metadata,
  }) async {
    if (!_isInitialized) {
      throw StateError('Collaboration Manager not initialized');
    }
    
    if (_currentUser == null) {
      throw StateError('No current user set');
    }
    
    try {
      final session = CollaborationSession(
        id: _uuid.v4(),
        documentId: documentId,
        documentName: documentName,
        documentType: documentType,
        ownerId: _currentUser!.id,
        password: password,
        allowedUsers: allowedUsers ?? [],
        metadata: metadata ?? {},
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isActive: true,
      );
      
      // Create session on server
      await _createSessionOnServer(session);
      
      // Join session locally
      await _joinSession(session);
      
      _eventController.add(CollaborationEvent.sessionCreated(session));
      
      return session;
      
    } catch (e) {
      _logger.e('Failed to create session: $e');
      rethrow;
    }
  }

  /// Join an existing collaboration session
  Future<void> joinSession(String sessionId, {String? password}) async {
    if (!_isInitialized) {
      throw StateError('Collaboration Manager not initialized');
    }
    
    if (_currentUser == null) {
      throw StateError('No current user set');
    }
    
    try {
      // Get session from server
      final session = await _getSessionFromServer(sessionId);
      
      // Verify password if required
      if (session.password != null && session.password != password) {
        throw StateError('Invalid password');
      }
      
      // Check if user is allowed
      if (session.allowedUsers.isNotEmpty && 
          !session.allowedUsers.contains(_currentUser!.id)) {
        throw StateError('User not allowed in this session');
      }
      
      // Join session
      await _joinSession(session);
      
      _eventController.add(CollaborationEvent.sessionJoined(session));
      
    } catch (e) {
      _logger.e('Failed to join session: $e');
      rethrow;
    }
  }

  /// Leave current session
  Future<void> leaveSession() async {
    if (_currentSession == null) return;
    
    try {
      // Leave session on server
      await _leaveSessionOnServer(_currentSession!.id);
      
      // Clear local state
      _currentSession = null;
      _sessionController.add(null);
      _usersController.add([]);
      _presenceController.add([]);
      
      _eventController.add(CollaborationEvent.sessionLeft());
      
    } catch (e) {
      _logger.e('Failed to leave session: $e');
    }
  }

  /// Send operation to other users
  void sendOperation(Operation operation) {
    if (_currentSession == null) return;
    
    // Add to operation stream
    _operationController.add(operation);
  }

  /// Send cursor position
  void sendCursorPosition(int position) {
    if (_currentSession == null || _currentUser == null) return;
    
    _cursorTracker.updateCursor(_currentUser!.id, position);
  }

  /// Send selection range
  void sendSelection(int start, int end) {
    if (_currentSession == null || _currentUser == null) return;
    
    _selectionSharer.updateSelection(_currentUser!.id, start, end);
  }

  /// Add comment
  Future<void> addComment({
    required int position,
    required String content,
    String? parentId,
  }) async {
    if (_currentSession == null || _currentUser == null) return;
    
    try {
      final comment = await _commentSystem.addComment(
        sessionId: _currentSession!.id,
        userId: _currentUser!.id,
        position: position,
        content: content,
        parentId: parentId,
      );
      
      _eventController.add(CollaborationEvent.commentAdded(comment));
      
    } catch (e) {
      _logger.e('Failed to add comment: $e');
    }
  }

  /// Apply operation locally
  void _applyOperation(Operation operation) {
    // This would apply the operation to the local document
    // Implementation depends on the document type and editor
    _logger.d('Applying operation: ${operation.type}');
  }

  /// Broadcast operation to other users
  void _broadcastOperation(Operation operation) {
    final message = {
      'type': 'operation',
      'sessionId': _currentSession!.id,
      'operation': operation.toJson(),
    };
    
    _webSocketClient.sendMessage(jsonEncode(message));
    _socketIOClient.emit('operation', message);
  }

  /// Create session on server
  Future<void> _createSessionOnServer(CollaborationSession session) async {
    // This would send a request to create the session on the server
    await Future.delayed(Duration(milliseconds: 100)); // Simulate network delay
  }

  /// Get session from server
  Future<CollaborationSession> _getSessionFromServer(String sessionId) async {
    // This would fetch the session from the server
    await Future.delayed(Duration(milliseconds: 100)); // Simulate network delay
    
    // Return mock session for now
    return CollaborationSession(
      id: sessionId,
      documentId: 'doc-123',
      documentName: 'Test Document',
      documentType: 'text',
      ownerId: 'user-123',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isActive: true,
    );
  }

  /// Join session
  Future<void> _joinSession(CollaborationSession session) async {
    _currentSession = session;
    _sessionController.add(session);
    
    // Join on server
    await _joinSessionOnServer(session.id);
    
    // Start presence tracking
    _presenceManager.startTracking(session.id, _currentUser!);
  }

  /// Join session on server
  Future<void> _joinSessionOnServer(String sessionId) async {
    // This would send a request to join the session on the server
    await Future.delayed(Duration(milliseconds: 100)); // Simulate network delay
  }

  /// Leave session on server
  Future<void> _leaveSessionOnServer(String sessionId) async {
    // This would send a request to leave the session on the server
    await Future.delayed(Duration(milliseconds: 100)); // Simulate network delay
  }

  /// Rejoin session after reconnection
  Future<void> _rejoinSession() async {
    if (_currentSession != null) {
      await _joinSession(_currentSession!);
    }
  }

  /// Get current session
  CollaborationSession? get currentSession => _currentSession;

  /// Get current user
  CollaborationUser? get currentUser => _currentUser;

  /// Get users in current session
  List<CollaborationUser> get users => _usersController.value;

  /// Get presence in current session
  List<Presence> get presence => _presenceController.value;

  /// Get session stream
  Stream<CollaborationSession?> get sessionStream => _sessionController.stream;

  /// Get users stream
  Stream<List<CollaborationUser>> get usersStream => _usersController.stream;

  /// Get presence stream
  Stream<List<Presence>> get presenceStream => _presenceController.stream;

  /// Get operation stream
  Stream<Operation> get operationStream => _operationController.stream;

  /// Get event stream
  Stream<CollaborationEvent> get eventStream => _eventController.stream;

  /// Check if connected
  bool get isConnected => _isConnected;

  /// Check if initialized
  bool get isInitialized => _isInitialized;

  /// Dispose resources
  void dispose() {
    _sessionController.close();
    _usersController.close();
    _presenceController.close();
    _operationController.close();
    _eventController.close();
    
    _webSocketClient.dispose();
    _socketIOClient.dispose();
    _messageRouter.dispose();
    _conflictResolver.dispose();
    _presenceManager.dispose();
    _cursorTracker.dispose();
    _selectionSharer.dispose();
    _commentSystem.dispose();
    _versionController.dispose();
    _permissionManager.dispose();
  }
}

/// Collaboration event
class CollaborationEvent {
  final String type;
  final Map<String, dynamic>? data;
  final DateTime timestamp;

  CollaborationEvent._(this.type, this.data, this.timestamp);

  factory CollaborationEvent.sessionCreated(CollaborationSession session) {
    return CollaborationEvent._('session_created', {
      'session': session.toJson(),
    }, DateTime.now());
  }

  factory CollaborationEvent.sessionJoined(CollaborationSession session) {
    return CollaborationEvent._('session_joined', {
      'session': session.toJson(),
    }, DateTime.now());
  }

  factory CollaborationEvent.sessionLeft() {
    return CollaborationEvent._('session_left', null, DateTime.now());
  }

  factory CollaborationEvent.connectionChanged(bool connected) {
    return CollaborationEvent._('connection_changed', {
      'connected': connected,
    }, DateTime.now());
  }

  factory CollaborationEvent.commentAdded(dynamic comment) {
    return CollaborationEvent._('comment_added', {
      'comment': comment,
    }, DateTime.now());
  }
}
