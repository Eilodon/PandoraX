import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cac_core/cac_core.dart';

@LazySingleton(as: EventBusService)
class EventBusServiceImpl implements EventBusService {
  final BehaviorSubject<CacEvent> _eventSubject = BehaviorSubject<CacEvent>();

  @override
  Stream<CacEvent> get eventStream => _eventSubject.stream;

  @override
  void publishEvent(CacEvent event) {
    _eventSubject.add(event);
  }

  @override
  Stream<T> eventsOfType<T extends CacEvent>() {
    return _eventSubject.stream.where((event) => event is T).cast<T>();
  }

  @override
  void dispose() {
    _eventSubject.close();
  }
}
