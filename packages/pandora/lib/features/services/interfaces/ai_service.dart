/// AI Service Interface
/// 
/// Defines the contract for AI services in the application
abstract class AIService {
  /// Generate a response from a prompt
  Future<String> generateResponse(String prompt);
  
  /// Get suggestions based on input
  Future<List<String>> getSuggestions(String input);
  
  /// Create embedding for text content
  Future<List<double>> createEmbedding(String content);
  
  /// Check if AI service is available
  Future<bool> isAvailable();
  
  /// Get AI model information
  Future<Map<String, dynamic>> getModelInfo();
}
