import 'package:google_generative_ai/google_generative_ai.dart';

class AiService {
  final GenerativeModel _model;

  AiService(String apiKey) : _model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  Future<String> summarizeText(String text) async {
    try {
      final prompt = 'Summarize the following note: "$text"';
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? 'Could not summarize.';
    } catch (e) {
      throw Exception('Failed to summarize text: $e');
    }
  }

  Future<String> chatWithAI(String message) async {
    try {
      final prompt = 'Bạn là một trợ lý AI thông minh giúp người dùng quản lý ghi chú. Hãy trả lời một cách hữu ích và thân thiện. Tin nhắn: "$message"';
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? 'Xin lỗi, tôi không thể trả lời tin nhắn này.';
    } catch (e) {
      throw Exception('Failed to chat with AI: $e');
    }
  }
}
