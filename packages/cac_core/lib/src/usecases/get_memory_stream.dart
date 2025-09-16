import 'dart:async';
import '../entities/memory_entry.dart';
import '../repositories/memory_repository.dart';

class GetMemoryStreamUseCase {
  final MemoryRepository _memoryRepository;

  GetMemoryStreamUseCase(this._memoryRepository);

  Stream<MemoryEntry> execute() {
    return _memoryRepository.getMemoryStream();
  }
}
