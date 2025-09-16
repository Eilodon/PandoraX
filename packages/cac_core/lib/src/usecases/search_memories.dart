import '../entities/memory_entry.dart';
import '../repositories/memory_repository.dart';

class SearchMemoriesUseCase {
  final MemoryRepository _memoryRepository;

  SearchMemoriesUseCase(this._memoryRepository);

  Future<List<MemoryEntry>> execute(String query) async {
    return await _memoryRepository.searchMemories(query);
  }

  Future<List<MemoryEntry>> executeByType(String type) async {
    return await _memoryRepository.getMemoriesByType(type);
  }

  Future<List<MemoryEntry>> executeWithFilters({
    String? query,
    String? source,
    DateTime? from,
    DateTime? to,
    int? limit,
    int? offset,
  }) async {
    return await _memoryRepository.getMemories(
      limit: limit,
      offset: offset,
      source: source,
      from: from,
      to: to,
    );
  }
}
