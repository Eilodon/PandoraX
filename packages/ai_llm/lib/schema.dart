import 'package:isar/isar.dart';

part 'schema.g.dart';

@collection
class ModelCacheEntry {
  Id id = Isar.autoIncrement;
  
  @Index(unique: true)
  late String key;
  
  late String filePath;
  late int size;
  late bool pinned;
  late int lastAccess;
  late String version;
  late String modelId;
  late String modelName;
  late String compressionType;
  late String checksum;
  late int downloadTime;
  late int accessCount;
  late String downloadSource;
  @ignore
  late Map<String, String> metadata;
  
  ModelCacheEntry();
  
  ModelCacheEntry.create({
    required this.key,
    required this.filePath,
    required this.size,
    this.pinned = false,
    required this.lastAccess,
    required this.version,
    required this.modelId,
    required this.modelName,
    this.compressionType = 'none',
    this.checksum = '',
    this.downloadTime = 0,
    this.accessCount = 0,
    this.downloadSource = 'unknown',
    this.metadata = const {},
  });

  /// Get file age in days
  int get ageInDays {
    final now = DateTime.now().millisecondsSinceEpoch;
    return (now - lastAccess) ~/ (1000 * 60 * 60 * 24);
  }

  /// Check if entry is expired (older than 30 days and not pinned)
  bool get isExpired => !pinned && ageInDays > 30;

  /// Get access frequency (accesses per day)
  double get accessFrequency {
    if (ageInDays == 0) return accessCount.toDouble();
    return accessCount / ageInDays;
  }

  /// Get priority score for eviction (lower = more likely to be evicted)
  double get evictionPriority {
    if (pinned) return double.infinity;
    
    // Base score on access frequency and recency
    final recencyScore = 1.0 / (ageInDays + 1);
    final frequencyScore = accessFrequency;
    
    return recencyScore + frequencyScore;
  }
}
