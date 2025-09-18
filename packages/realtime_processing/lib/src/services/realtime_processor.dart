import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import '../events/realtime_event.dart';
import '../events/event_handler.dart';
import '../events/event_router.dart';
import '../streams/stream_processor.dart';
import '../streams/stream_transformer.dart';
import '../streams/stream_aggregator.dart';
import '../models/realtime_config.dart';
import '../models/connection_status.dart';
import '../models/stream_metrics.dart';
import 'websocket_client.dart';
import 'socket_io_client.dart';

/// Main real-time processing service
class RealtimeProcessor {
  static final RealtimeProcessor _instance = RealtimeProcessor._internal();
  factory RealtimeProcessor() => _instance;
  RealtimeProcessor._internal();

  static final Logger _logger = Logger();
  static final Uuid _uuid = const Uuid();
  
  // Core services
  late EventRouter _eventRouter;
  late StreamProcessor _streamProcessor;
  late StreamTransformer _streamTransformer;
  late StreamAggregator _streamAggregator;
  
  // Connection clients
  WebSocketClient? _webSocketClient;
  SocketIOClient? _socketIOClient;
  
  // Configuration
  RealtimeConfig? _config;
  
  // State
  bool _isInitialized = false;
  bool _isConnected = false;
  ConnectionStatus _connectionStatus = ConnectionStatus.disconnected;
  
  // Streams
  final StreamController<RealtimeEvent> _eventController = 
      StreamController.broadcast();
  final StreamController<ConnectionStatus> _connectionController = 
      StreamController.broadcast();
  final StreamController<StreamMetrics> _metricsController = 
      StreamController.broadcast();
  
  // Event handlers
  final Map<String, EventHandler> _eventHandlers = {};
  
  // Metrics
  int _eventsProcessed = 0;
  int _eventsFailed = 0;
  DateTime? _lastEventTime;

  /// Initialize real-time processing
  Future<void> initialize({
    RealtimeConfig? config,
  }) async {
    if (_isInitialized) return;

    _logger.i('Initializing Realtime Processor...');
    
    try {
      // Set configuration
      _config = config ?? RealtimeConfig.defaultConfig();
      
      // Initialize core services
      _eventRouter = EventRouter();
      _streamProcessor = StreamProcessor();
      _streamTransformer = StreamTransformer();
      _streamAggregator = StreamAggregator();
      
      // Initialize connection clients
      await _initializeConnectionClients();
      
      // Setup event routing
      _setupEventRouting();
      
      // Setup stream processing
      _setupStreamProcessing();
      
      _isInitialized = true;
      _logger.i('Realtime Processor initialized successfully');
      
    } catch (e) {
      _logger.e('Failed to initialize Realtime Processor: $e');
      rethrow;
    }
  }

  /// Initialize connection clients
  Future<void> _initializeConnectionClients() async {
    if (_config?.webSocketUrl != null) {
      _webSocketClient = WebSocketClient(_config!.webSocketUrl!);
      await _webSocketClient!.initialize();
    }
    
    if (_config?.socketIOUrl != null) {
      _socketIOClient = SocketIOClient(_config!.socketIOUrl!);
      await _socketIOClient!.initialize();
    }
  }

  /// Setup event routing
  void _setupEventRouting() {
    _eventRouter.eventStream.listen((event) {
      _processEvent(event);
    });
  }

  /// Setup stream processing
  void _setupStreamProcessing() {
    // Process events through stream processor
    _eventController.stream
        .transform(_streamTransformer.eventTransformer)
        .listen((event) {
      _streamProcessor.processEvent(event);
    });
    
    // Aggregate metrics
    _streamProcessor.metricsStream.listen((metrics) {
      _metricsController.add(metrics);
    });
  }

  /// Connect to real-time services
  Future<void> connect() async {
    if (!_isInitialized) {
      throw StateError('Realtime Processor not initialized');
    }
    
    if (_isConnected) return;

    _logger.i('Connecting to real-time services...');
    
    try {
      // Connect WebSocket if available
      if (_webSocketClient != null) {
        await _webSocketClient!.connect();
        _webSocketClient!.messageStream.listen(_handleWebSocketMessage);
      }
      
      // Connect Socket.IO if available
      if (_socketIOClient != null) {
        await _socketIOClient!.connect();
        _socketIOClient!.eventStream.listen(_handleSocketIOEvent);
      }
      
      _isConnected = true;
      _connectionStatus = ConnectionStatus.connected;
      _connectionController.add(_connectionStatus);
      
      _logger.i('Connected to real-time services');
      
    } catch (e) {
      _logger.e('Failed to connect to real-time services: $e');
      _connectionStatus = ConnectionStatus.error;
      _connectionController.add(_connectionStatus);
      rethrow;
    }
  }

  /// Disconnect from real-time services
  Future<void> disconnect() async {
    if (!_isConnected) return;

    _logger.i('Disconnecting from real-time services...');
    
    try {
      // Disconnect WebSocket
      if (_webSocketClient != null) {
        await _webSocketClient!.disconnect();
      }
      
      // Disconnect Socket.IO
      if (_socketIOClient != null) {
        await _socketIOClient!.disconnect();
      }
      
      _isConnected = false;
      _connectionStatus = ConnectionStatus.disconnected;
      _connectionController.add(_connectionStatus);
      
      _logger.i('Disconnected from real-time services');
      
    } catch (e) {
      _logger.e('Failed to disconnect from real-time services: $e');
    }
  }

  /// Send event to real-time services
  Future<void> sendEvent(RealtimeEvent event) async {
    if (!_isConnected) {
      throw StateError('Not connected to real-time services');
    }
    
    try {
      // Add event ID and timestamp
      final eventWithId = event.copyWith(
        id: _uuid.v4(),
        timestamp: DateTime.now(),
      );
      
      // Send via WebSocket
      if (_webSocketClient != null) {
        await _webSocketClient!.sendMessage(jsonEncode(eventWithId.toJson()));
      }
      
      // Send via Socket.IO
      if (_socketIOClient != null) {
        await _socketIOClient!.emitEvent(eventWithId.type, eventWithId.toJson());
      }
      
      // Process locally
      _processEvent(eventWithId);
      
    } catch (e) {
      _logger.e('Failed to send event: $e');
      _eventsFailed++;
      rethrow;
    }
  }

  /// Process incoming event
  void _processEvent(RealtimeEvent event) {
    try {
      _eventsProcessed++;
      _lastEventTime = DateTime.now();
      
      // Route event to appropriate handler
      _eventRouter.routeEvent(event);
      
      // Emit event to stream
      _eventController.add(event);
      
    } catch (e) {
      _logger.e('Failed to process event: $e');
      _eventsFailed++;
    }
  }

  /// Handle WebSocket message
  void _handleWebSocketMessage(String message) {
    try {
      final data = jsonDecode(message);
      final event = RealtimeEvent.fromJson(data);
      _processEvent(event);
    } catch (e) {
      _logger.e('Failed to handle WebSocket message: $e');
    }
  }

  /// Handle Socket.IO event
  void _handleSocketIOEvent(Map<String, dynamic> data) {
    try {
      final event = RealtimeEvent.fromJson(data);
      _processEvent(event);
    } catch (e) {
      _logger.e('Failed to handle Socket.IO event: $e');
    }
  }

  /// Register event handler
  void registerEventHandler(String eventType, EventHandler handler) {
    _eventHandlers[eventType] = handler;
    _eventRouter.registerHandler(eventType, handler);
  }

  /// Unregister event handler
  void unregisterEventHandler(String eventType) {
    _eventHandlers.remove(eventType);
    _eventRouter.unregisterHandler(eventType);
  }

  /// Get event stream
  Stream<RealtimeEvent> get eventStream => _eventController.stream;

  /// Get connection status stream
  Stream<ConnectionStatus> get connectionStream => _connectionController.stream;

  /// Get metrics stream
  Stream<StreamMetrics> get metricsStream => _metricsController.stream;

  /// Get current connection status
  ConnectionStatus get connectionStatus => _connectionStatus;

  /// Check if connected
  bool get isConnected => _isConnected;

  /// Get current metrics
  StreamMetrics get currentMetrics => StreamMetrics(
    eventsProcessed: _eventsProcessed,
    eventsFailed: _eventsFailed,
    lastEventTime: _lastEventTime,
    connectionStatus: _connectionStatus,
  );

  /// Dispose resources
  void dispose() {
    _eventController.close();
    _connectionController.close();
    _metricsController.close();
    _webSocketClient?.dispose();
    _socketIOClient?.dispose();
  }
}
