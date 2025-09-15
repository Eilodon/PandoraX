/// Simple input validation service for testing
class SimpleValidationService {
  /// Validate email address
  static bool isValidEmail(String email) {
    if (email.isEmpty) return false;
    return email.contains('@') && email.contains('.');
  }

  /// Validate required field
  static bool isRequired(String input) {
    return input.trim().isNotEmpty;
  }

  /// Validate input length
  static bool isValidLength(String input, {int minLength = 1, int? maxLength}) {
    if (input.isEmpty) return minLength == 0;
    if (input.length < minLength) return false;
    if (maxLength != null && input.length > maxLength) return false;
    return true;
  }

  /// Sanitize input
  static String sanitizeInput(String input) {
    if (input.isEmpty) return input;
    return input.trim();
  }
}
