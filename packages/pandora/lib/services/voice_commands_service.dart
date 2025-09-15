import 'package:injectable/injectable.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

/// Intelligent Voice Commands Service
/// Processes voice commands and executes appropriate actions
@injectable
class VoiceCommandsService {
  final GenerativeModel _aiModel;
  
  VoiceCommandsService(String apiKey) : _aiModel = GenerativeModel(
    model: 'gemini-pro',
    apiKey: apiKey,
  );

  /// Process voice command and return structured response
  Future<VoiceCommandResult> processCommand(String command) async {
    try {
      final prompt = '''
Bạn là trợ lý AI thông minh cho ứng dụng PandoraX. Phân tích lệnh giọng nói sau và trả về kết quả theo format JSON:

Lệnh: "$command"

Các loại lệnh hỗ trợ:
1. CREATE_NOTE - Tạo ghi chú mới
2. SEARCH_NOTES - Tìm kiếm ghi chú
3. SET_REMINDER - Đặt nhắc nhở
4. AI_CHAT - Trò chuyện với AI
5. APP_CONTROL - Điều khiển ứng dụng
6. UNKNOWN - Không hiểu lệnh

Trả về JSON:
{
  "action": "ACTION_TYPE",
  "parameters": {
    "title": "Tiêu đề ghi chú",
    "content": "Nội dung",
    "reminder_time": "2024-01-01 10:00",
    "search_query": "từ khóa tìm kiếm"
  },
  "response": "Phản hồi bằng giọng nói",
  "confidence": 0.95
}
''';

      final content = [Content.text(prompt)];
      final response = await _aiModel.generateContent(content);
      
      final responseText = response.text ?? '{}';
      return _parseCommandResult(responseText);
    } catch (e) {
      return VoiceCommandResult(
        action: VoiceCommandAction.UNKNOWN,
        response: 'Xin lỗi, tôi không hiểu lệnh của bạn. Vui lòng thử lại.',
        confidence: 0.0,
      );
    }
  }

  /// Parse AI response to structured result
  VoiceCommandResult _parseCommandResult(String responseText) {
    try {
      // Simple parsing - in production, use proper JSON parsing
      if (responseText.contains('CREATE_NOTE')) {
        return VoiceCommandResult(
          action: VoiceCommandAction.CREATE_NOTE,
          parameters: {'content': _extractContent(responseText)},
          response: 'Tôi sẽ tạo ghi chú cho bạn ngay.',
          confidence: 0.9,
        );
      } else if (responseText.contains('SEARCH_NOTES')) {
        return VoiceCommandResult(
          action: VoiceCommandAction.SEARCH_NOTES,
          parameters: {'search_query': _extractSearchQuery(responseText)},
          response: 'Tôi sẽ tìm kiếm ghi chú cho bạn.',
          confidence: 0.9,
        );
      } else if (responseText.contains('SET_REMINDER')) {
        return VoiceCommandResult(
          action: VoiceCommandAction.SET_REMINDER,
          parameters: {'reminder_time': _extractTime(responseText)},
          response: 'Tôi sẽ đặt nhắc nhở cho bạn.',
          confidence: 0.9,
        );
      } else if (responseText.contains('AI_CHAT')) {
        return VoiceCommandResult(
          action: VoiceCommandAction.AI_CHAT,
          response: 'Tôi sẵn sàng trò chuyện với bạn. Bạn muốn hỏi gì?',
          confidence: 0.9,
        );
      } else {
        return VoiceCommandResult(
          action: VoiceCommandAction.UNKNOWN,
          response: 'Xin lỗi, tôi không hiểu lệnh của bạn.',
          confidence: 0.0,
        );
      }
    } catch (e) {
      return VoiceCommandResult(
        action: VoiceCommandAction.UNKNOWN,
        response: 'Có lỗi xảy ra khi xử lý lệnh.',
        confidence: 0.0,
      );
    }
  }

  String _extractContent(String text) {
    // Simple extraction logic
    return 'Nội dung từ lệnh giọng nói';
  }

  String _extractSearchQuery(String text) {
    // Simple extraction logic
    return 'từ khóa tìm kiếm';
  }

  String _extractTime(String text) {
    // Simple extraction logic
    return '2024-01-01 10:00';
  }
}

/// Voice command result structure
class VoiceCommandResult {
  final VoiceCommandAction action;
  final Map<String, dynamic>? parameters;
  final String response;
  final double confidence;

  VoiceCommandResult({
    required this.action,
    this.parameters,
    required this.response,
    required this.confidence,
  });
}

/// Voice command action types
enum VoiceCommandAction {
  CREATE_NOTE,
  SEARCH_NOTES,
  SET_REMINDER,
  AI_CHAT,
  APP_CONTROL,
  UNKNOWN,
}
