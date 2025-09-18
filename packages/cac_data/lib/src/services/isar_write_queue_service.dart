import 'dart:async';
import 'dart:collection';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@LazySingleton()
class IsarWriteQueueService {
  final Queue<Future<void> Function()> _queue = Queue();
  final Logger _logger = Logger();
  bool _isProcessing = false;
  Timer? _processingTimer;

  IsarWriteQueueService() {
    _startProcessing();
  }

  Future<void> add(Future<void> Function() task) async {
    _queue.add(task);
    _logger.d('Task added to queue. Queue size: ${_queue.length}');
  }

  void _startProcessing() {
    _processingTimer = Timer.periodic(
      const Duration(milliseconds: 100),
      (_) => _processQueue(),
    );
  }

  Future<void> _processQueue() async {
    if (_isProcessing || _queue.isEmpty) return;
    
    _isProcessing = true;
    try {
      while (_queue.isNotEmpty) {
        final task = _queue.removeFirst();
        try {
          await task();
          _logger.d('Task completed successfully');
        } catch (e) {
          _logger.e('Task failed: $e');
          // Re-queue failed task or handle error
        }
      }
    } finally {
      _isProcessing = false;
    }
  }

  void dispose() {
    _processingTimer?.cancel();
    _queue.clear();
  }
}
