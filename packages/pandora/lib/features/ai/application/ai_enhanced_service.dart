import 'package:google_generative_ai/google_generative_ai.dart';

class AiEnhancedService {
  final GenerativeModel _model;

  AiEnhancedService(String apiKey) : _model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  /// Tạo ghi chú tự động từ prompt
  Future<Map<String, String>> generateNoteFromPrompt(String prompt) async {
    try {
      final aiPrompt = '''
Bạn là một trợ lý AI thông minh giúp tạo ghi chú. Dựa trên prompt của người dùng, hãy tạo:
1. Tiêu đề ghi chú ngắn gọn và rõ ràng
2. Nội dung ghi chú chi tiết và hữu ích
3. Danh mục phù hợp (công việc, cá nhân, học tập, sáng tạo, khác)
4. Tags liên quan (tối đa 5 tags)

Prompt: "$prompt"

Trả về kết quả theo format JSON:
{
  "title": "Tiêu đề ghi chú",
  "content": "Nội dung chi tiết...",
  "category": "Danh mục",
  "tags": ["tag1", "tag2", "tag3"]
}
''';

      final contentList = [Content.text(aiPrompt)];
      final response = await _model.generateContent(contentList);
      
      // Parse JSON response (simplified)
      final responseText = response.text ?? '{}';
      return _parseNoteResponse(responseText);
    } catch (e) {
      throw Exception('Failed to generate note: $e');
    }
  }

  /// Phân loại ghi chú tự động
  Future<String> categorizeNote(String title, String content) async {
    try {
      final prompt = '''
Phân loại ghi chú sau vào một trong các danh mục: công việc, cá nhân, học tập, sáng tạo, khác

Tiêu đề: "$title"
Nội dung: "$content"

Chỉ trả về tên danh mục, không có gì khác.
''';

      final contentList = [Content.text(prompt)];
      final response = await _model.generateContent(contentList);
      return response.text?.trim() ?? 'khác';
    } catch (e) {
      return 'khác';
    }
  }

  /// Tạo tags tự động cho ghi chú
  Future<List<String>> generateTags(String title, String content) async {
    try {
      final prompt = '''
Tạo 3-5 tags phù hợp cho ghi chú sau. Tags phải ngắn gọn, tiếng Việt, và liên quan đến nội dung.

Tiêu đề: "$title"
Nội dung: "$content"

Trả về danh sách tags, mỗi tag trên một dòng, không có số thứ tự.
''';

      final contentList = [Content.text(prompt)];
      final response = await _model.generateContent(contentList);
      
      final tags = response.text?.split('\n')
          .where((tag) => tag.trim().isNotEmpty)
          .map((tag) => tag.trim())
          .take(5)
          .toList() ?? [];
      
      return tags;
    } catch (e) {
      return [];
    }
  }

  /// Tạo đề xuất nội dung cho ghi chú
  Future<List<String>> generateContentSuggestions(String title, String content) async {
    try {
      final prompt = '''
Dựa trên ghi chú hiện tại, hãy đề xuất 3 ý tưởng để mở rộng hoặc cải thiện nội dung:

Tiêu đề: "$title"
Nội dung hiện tại: "$content"

Mỗi đề xuất phải ngắn gọn (1-2 câu) và cụ thể.
Trả về mỗi đề xuất trên một dòng, không có số thứ tự.
''';

      final contentList = [Content.text(prompt)];
      final response = await _model.generateContent(contentList);
      
      final suggestions = response.text?.split('\n')
          .where((suggestion) => suggestion.trim().isNotEmpty)
          .map((suggestion) => suggestion.trim())
          .take(3)
          .toList() ?? [];
      
      return suggestions;
    } catch (e) {
      return [];
    }
  }

  /// Tạo nhắc nhở thông minh dựa trên nội dung ghi chú
  Future<Map<String, dynamic>> generateSmartReminder(String title, String content) async {
    try {
      final prompt = '''
Phân tích ghi chú và đề xuất thời gian nhắc nhở phù hợp:

Tiêu đề: "$title"
Nội dung: "$content"

Trả về kết quả theo format JSON:
{
  "suggestedTime": "HH:mm",
  "suggestedDate": "YYYY-MM-DD",
  "reason": "Lý do đề xuất thời gian này",
  "priority": "cao/trung bình/thấp"
}

Nếu ghi chú có tính cấp thiết, đề xuất thời gian gần. Nếu là ghi chú dài hạn, đề xuất thời gian phù hợp.
''';

      final contentList = [Content.text(prompt)];
      final response = await _model.generateContent(contentList);
      
      return _parseReminderResponse(response.text ?? '{}');
    } catch (e) {
      // Fallback to default reminder
      final now = DateTime.now();
      final tomorrow = now.add(const Duration(days: 1));
      return {
        'suggestedTime': '09:00',
        'suggestedDate': '${tomorrow.year}-${tomorrow.month.toString().padLeft(2, '0')}-${tomorrow.day.toString().padLeft(2, '0')}',
        'reason': 'Nhắc nhở mặc định',
        'priority': 'trung bình',
      };
    }
  }

  /// Tóm tắt ghi chú nâng cao
  Future<String> summarizeNoteAdvanced(String title, String content) async {
    try {
      final prompt = '''
Tạo tóm tắt nâng cao cho ghi chú sau. Tóm tắt phải:
1. Nêu bật những điểm chính
2. Có cấu trúc rõ ràng
3. Dễ hiểu và ngắn gọn
4. Có thể bao gồm bullet points nếu cần

Tiêu đề: "$title"
Nội dung: "$content"
''';

      final contentList = [Content.text(prompt)];
      final response = await _model.generateContent(contentList);
      return response.text ?? 'Không thể tạo tóm tắt.';
    } catch (e) {
      throw Exception('Failed to create advanced summary: $e');
    }
  }

  /// Chat với AI nâng cao
  Future<String> chatWithAIEnhanced(String message, {String? context}) async {
    try {
      final systemPrompt = context != null 
          ? 'Bạn là một trợ lý AI thông minh giúp quản lý ghi chú. Ngữ cảnh hiện tại: $context. Hãy trả lời một cách hữu ích và thân thiện.'
          : 'Bạn là một trợ lý AI thông minh giúp quản lý ghi chú. Hãy trả lời một cách hữu ích và thân thiện.';
      
      final prompt = '$systemPrompt\n\nTin nhắn: "$message"';
      final contentList = [Content.text(prompt)];
      final response = await _model.generateContent(contentList);
      return response.text ?? 'Xin lỗi, tôi không thể trả lời tin nhắn này.';
    } catch (e) {
      throw Exception('Failed to chat with AI: $e');
    }
  }

  /// Parse note generation response
  Map<String, String> _parseNoteResponse(String response) {
    try {
      // Simple JSON parsing (in production, use proper JSON parser)
      final title = _extractValue(response, 'title') ?? 'Ghi chú mới';
      final content = _extractValue(response, 'content') ?? 'Nội dung ghi chú';
      final category = _extractValue(response, 'category') ?? 'khác';
      final tags = _extractValue(response, 'tags') ?? '[]';
      
      return {
        'title': title,
        'content': content,
        'category': category,
        'tags': tags,
      };
    } catch (e) {
      return {
        'title': 'Ghi chú mới',
        'content': 'Nội dung ghi chú',
        'category': 'khác',
        'tags': '[]',
      };
    }
  }

  /// Parse reminder response
  Map<String, dynamic> _parseReminderResponse(String response) {
    try {
      final time = _extractValue(response, 'suggestedTime') ?? '09:00';
      final date = _extractValue(response, 'suggestedDate') ?? _getTomorrowDate();
      final reason = _extractValue(response, 'reason') ?? 'Nhắc nhở mặc định';
      final priority = _extractValue(response, 'priority') ?? 'trung bình';
      
      return {
        'suggestedTime': time,
        'suggestedDate': date,
        'reason': reason,
        'priority': priority,
      };
    } catch (e) {
      final now = DateTime.now();
      final tomorrow = now.add(const Duration(days: 1));
      return {
        'suggestedTime': '09:00',
        'suggestedDate': '${tomorrow.year}-${tomorrow.month.toString().padLeft(2, '0')}-${tomorrow.day.toString().padLeft(2, '0')}',
        'reason': 'Nhắc nhở mặc định',
        'priority': 'trung bình',
      };
    }
  }

  /// Extract value from JSON-like string
  String? _extractValue(String json, String key) {
    final pattern = RegExp('"$key":\\s*"([^"]*)"');
    final match = pattern.firstMatch(json);
    return match?.group(1);
  }

  /// Get tomorrow's date in YYYY-MM-DD format
  String _getTomorrowDate() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return '${tomorrow.year}-${tomorrow.month.toString().padLeft(2, '0')}-${tomorrow.day.toString().padLeft(2, '0')}';
  }
}
