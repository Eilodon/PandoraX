import '../entities/embedding.dart';

abstract class AiServiceInterface {
  Future<Embedding> generateEmbedding(String text);
  Future<List<Embedding>> generateEmbeddings(List<String> texts);
  Future<String> generateResponse(String prompt, {Map<String, dynamic>? context});
  Future<Map<String, dynamic>> analyzeText(String text);
}
