import 'dart:async';
import '../entities/cac_event.dart';

abstract class EventBusService {
  Stream<CacEvent> get eventStream;
  void publishEvent(CacEvent event);
  Stream<T> eventsOfType<T extends CacEvent>();
  void dispose();
}
