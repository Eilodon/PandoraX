import '../entities/memory_entry.dart';
import '../repositories/memory_repository.dart';
import '../services/event_bus_service.dart';
import '../entities/cac_event.dart';

class SaveMemoryUseCase {
  final MemoryRepository _memoryRepository;
  final EventBusService _eventBusService;

  SaveMemoryUseCase(this._memoryRepository, this._eventBusService);

  Future<void> execute(MemoryEntry memory) async {
    await _memoryRepository.saveMemory(memory);
    _eventBusService.publishEvent(
      CacEvent.memoryCreated(
        memoryId: memory.id,
        content: memory.content,
        source: memory.source,
        timestamp: memory.timestamp,
      ),
    );
  }
}
