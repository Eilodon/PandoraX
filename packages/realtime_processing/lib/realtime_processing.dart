library realtime_processing;

// Core real-time services
export 'src/services/realtime_processor.dart';
export 'src/services/event_streamer.dart';
export 'src/services/websocket_client.dart';
export 'src/services/socket_io_client.dart';

// Event handling
export 'src/events/realtime_event.dart';
export 'src/events/event_handler.dart';
export 'src/events/event_router.dart';

// Stream processing
export 'src/streams/stream_processor.dart';
export 'src/streams/stream_transformer.dart';
export 'src/streams/stream_aggregator.dart';

// Models and entities
export 'src/models/realtime_config.dart';
export 'src/models/connection_status.dart';
export 'src/models/stream_metrics.dart';

// Utilities
export 'src/utils/realtime_utils.dart';
export 'src/utils/stream_utils.dart';
