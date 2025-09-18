/// Common Utilities for Phase 4 Architecture
/// 
/// This file contains common utility functions used throughout the application.
library common_utils;

import 'dart:convert';
import 'dart:math';
import 'package:uuid/uuid.dart';

/// Common utility functions
class CommonUtils {
  // Private constructor to prevent instantiation
  CommonUtils._();

  /// Generate a unique ID
  static String generateId() {
    return const Uuid().v4();
  }

  /// Generate a short unique ID (8 characters)
  static String generateShortId() {
    return const Uuid().v4().substring(0, 8);
  }

  /// Check if a string is null or empty
  static bool isNullOrEmpty(String? value) {
    return value == null || value.isEmpty;
  }

  /// Check if a string is not null and not empty
  static bool isNotNullOrEmpty(String? value) {
    return value != null && value.isNotEmpty;
  }

  /// Get a safe string value (returns empty string if null)
  static String safeString(String? value) {
    return value ?? '';
  }

  /// Check if a list is null or empty
  static bool isListNullOrEmpty(List? list) {
    return list == null || list.isEmpty;
  }

  /// Check if a list is not null and not empty
  static bool isListNotNullOrEmpty(List? list) {
    return list != null && list.isNotEmpty;
  }

  /// Get a safe list value (returns empty list if null)
  static List<T> safeList<T>(List<T>? list) {
    return list ?? <T>[];
  }

  /// Check if a map is null or empty
  static bool isMapNullOrEmpty(Map? map) {
    return map == null || map.isEmpty;
  }

  /// Check if a map is not null and not empty
  static bool isMapNotNullOrEmpty(Map? map) {
    return map != null && map.isNotEmpty;
  }

  /// Get a safe map value (returns empty map if null)
  static Map<K, V> safeMap<K, V>(Map<K, V>? map) {
    return map ?? <K, V>{};
  }

  /// Capitalize the first letter of a string
  static String capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }

  /// Capitalize each word in a string
  static String capitalizeWords(String value) {
    if (value.isEmpty) return value;
    return value.split(' ').map((word) => capitalize(word)).join(' ');
  }

  /// Truncate a string to a maximum length
  static String truncate(String value, int maxLength, {String suffix = '...'}) {
    if (value.length <= maxLength) return value;
    return value.substring(0, maxLength) + suffix;
  }

  /// Remove extra whitespace from a string
  static String cleanWhitespace(String value) {
    return value.trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  /// Check if a string contains only digits
  static bool isNumeric(String value) {
    return RegExp(r'^\d+$').hasMatch(value);
  }

  /// Check if a string is a valid email
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// Check if a string is a valid phone number
  static bool isValidPhoneNumber(String phone) {
    return RegExp(r'^\+?[\d\s\-\(\)]+$').hasMatch(phone);
  }

  /// Check if a string is a valid URL
  static bool isValidUrl(String url) {
    try {
      Uri.parse(url);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get the file extension from a file path
  static String getFileExtension(String filePath) {
    final lastDot = filePath.lastIndexOf('.');
    if (lastDot == -1) return '';
    return filePath.substring(lastDot + 1).toLowerCase();
  }

  /// Get the file name from a file path
  static String getFileName(String filePath) {
    final lastSlash = filePath.lastIndexOf('/');
    if (lastSlash == -1) return filePath;
    return filePath.substring(lastSlash + 1);
  }

  /// Get the directory path from a file path
  static String getDirectoryPath(String filePath) {
    final lastSlash = filePath.lastIndexOf('/');
    if (lastSlash == -1) return '';
    return filePath.substring(0, lastSlash);
  }

  /// Check if a number is between two values (inclusive)
  static bool isBetween(num value, num min, num max) {
    return value >= min && value <= max;
  }

  /// Clamp a number between min and max values
  static num clamp(num value, num min, num max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }

  /// Calculate the percentage of a value relative to a total
  static double calculatePercentage(num value, num total) {
    if (total == 0) return 0;
    return (value / total) * 100;
  }

  /// Round a number to a specific number of decimal places
  static double roundToDecimals(double value, int decimals) {
    final multiplier = pow(10, decimals);
    return (value * multiplier).round() / multiplier;
  }

  /// Check if two lists are equal
  static bool listsEqual<T>(List<T> list1, List<T> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }

  /// Check if two maps are equal
  static bool mapsEqual<K, V>(Map<K, V> map1, Map<K, V> map2) {
    if (map1.length != map2.length) return false;
    for (final key in map1.keys) {
      if (!map2.containsKey(key) || map1[key] != map2[key]) return false;
    }
    return true;
  }

  /// Deep copy a list
  static List<T> deepCopyList<T>(List<T> list) {
    return List<T>.from(list);
  }

  /// Deep copy a map
  static Map<K, V> deepCopyMap<K, V>(Map<K, V> map) {
    return Map<K, V>.from(map);
  }

  /// Remove duplicates from a list
  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  /// Group a list by a key function
  static Map<K, List<T>> groupBy<T, K>(List<T> list, K Function(T) keyFunction) {
    final Map<K, List<T>> groups = {};
    for (final item in list) {
      final key = keyFunction(item);
      groups[key] ??= [];
      groups[key]!.add(item);
    }
    return groups;
  }

  /// Sort a list by a key function
  static List<T> sortBy<T, K extends Comparable>(List<T> list, K Function(T) keyFunction) {
    final sortedList = List<T>.from(list);
    sortedList.sort((a, b) => keyFunction(a).compareTo(keyFunction(b)));
    return sortedList;
  }

  /// Filter a list by a predicate function
  static List<T> filter<T>(List<T> list, bool Function(T) predicate) {
    return list.where(predicate).toList();
  }

  /// Map a list with an index
  static List<R> mapIndexed<T, R>(List<T> list, R Function(int index, T item) mapper) {
    return list.asMap().entries.map((entry) => mapper(entry.key, entry.value)).toList();
  }

  /// Find the first item in a list that matches a predicate
  static T? findFirst<T>(List<T> list, bool Function(T) predicate) {
    try {
      return list.firstWhere(predicate);
    } catch (e) {
      return null;
    }
  }

  /// Find the last item in a list that matches a predicate
  static T? findLast<T>(List<T> list, bool Function(T) predicate) {
    try {
      return list.lastWhere(predicate);
    } catch (e) {
      return null;
    }
  }

  /// Check if all items in a list match a predicate
  static bool all<T>(List<T> list, bool Function(T) predicate) {
    return list.every(predicate);
  }

  /// Check if any item in a list matches a predicate
  static bool any<T>(List<T> list, bool Function(T) predicate) {
    return list.any(predicate);
  }

  /// Count items in a list that match a predicate
  static int count<T>(List<T> list, bool Function(T) predicate) {
    return list.where(predicate).length;
  }

  /// Get a random item from a list
  static T? randomItem<T>(List<T> list) {
    if (list.isEmpty) return null;
    final random = Random();
    return list[random.nextInt(list.length)];
  }

  /// Shuffle a list
  static List<T> shuffle<T>(List<T> list) {
    final shuffledList = List<T>.from(list);
    shuffledList.shuffle();
    return shuffledList;
  }

  /// Take the first n items from a list
  static List<T> take<T>(List<T> list, int count) {
    return list.take(count).toList();
  }

  /// Skip the first n items from a list
  static List<T> skip<T>(List<T> list, int count) {
    return list.skip(count).toList();
  }

  /// Chunk a list into smaller lists of a specific size
  static List<List<T>> chunk<T>(List<T> list, int size) {
    final chunks = <List<T>>[];
    for (int i = 0; i < list.length; i += size) {
      chunks.add(list.sublist(i, (i + size).clamp(0, list.length)));
    }
    return chunks;
  }

  /// Flatten a list of lists
  static List<T> flatten<T>(List<List<T>> list) {
    return list.expand((element) => element).toList();
  }

  /// Get the intersection of two lists
  static List<T> intersection<T>(List<T> list1, List<T> list2) {
    return list1.where((item) => list2.contains(item)).toList();
  }

  /// Get the union of two lists
  static List<T> union<T>(List<T> list1, List<T> list2) {
    return [...list1, ...list2].toSet().toList();
  }

  /// Get the difference of two lists
  static List<T> difference<T>(List<T> list1, List<T> list2) {
    return list1.where((item) => !list2.contains(item)).toList();
  }

  /// Check if a list contains all items from another list
  static bool containsAll<T>(List<T> list1, List<T> list2) {
    return list2.every((item) => list1.contains(item));
  }

  /// Check if a list contains any item from another list
  static bool containsAny<T>(List<T> list1, List<T> list2) {
    return list2.any((item) => list1.contains(item));
  }

  /// Get the unique items from a list
  static List<T> unique<T>(List<T> list) {
    return list.toSet().toList();
  }

  /// Get the frequency of items in a list
  static Map<T, int> frequency<T>(List<T> list) {
    final Map<T, int> freq = {};
    for (final item in list) {
      freq[item] = (freq[item] ?? 0) + 1;
    }
    return freq;
  }

  /// Get the most frequent item in a list
  static T? mostFrequent<T>(List<T> list) {
    if (list.isEmpty) return null;
    final freq = frequency(list);
    return freq.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  /// Get the least frequent item in a list
  static T? leastFrequent<T>(List<T> list) {
    if (list.isEmpty) return null;
    final freq = frequency(list);
    return freq.entries.reduce((a, b) => a.value < b.value ? a : b).key;
  }

  /// Check if a string is a valid JSON
  static bool isValidJson(String jsonString) {
    try {
      jsonDecode(jsonString);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Parse a JSON string safely
  static Map<String, dynamic>? parseJson(String jsonString) {
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  /// Convert a map to JSON string safely
  static String? mapToJson(Map<String, dynamic> map) {
    try {
      return jsonEncode(map);
    } catch (e) {
      return null;
    }
  }

  /// Check if a string is a valid UUID
  static bool isValidUuid(String uuid) {
    return RegExp(r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$', caseSensitive: false).hasMatch(uuid);
  }

  /// Check if a string is a valid GUID
  static bool isValidGuid(String guid) {
    return RegExp(r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$', caseSensitive: false).hasMatch(guid);
  }

  /// Check if a string is a valid IP address
  static bool isValidIpAddress(String ip) {
    return RegExp(r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$').hasMatch(ip);
  }

  /// Check if a string is a valid IPv6 address
  static bool isValidIpv6Address(String ip) {
    return RegExp(r'^(?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$').hasMatch(ip);
  }

  /// Check if a string is a valid MAC address
  static bool isValidMacAddress(String mac) {
    return RegExp(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$').hasMatch(mac);
  }

  /// Check if a string is a valid credit card number
  static bool isValidCreditCard(String cardNumber) {
    // Remove spaces and dashes
    final cleaned = cardNumber.replaceAll(RegExp(r'[\s\-]'), '');
    
    // Check if it's all digits and has valid length
    if (!RegExp(r'^\d{13,19}$').hasMatch(cleaned)) return false;
    
    // Luhn algorithm
    int sum = 0;
    bool alternate = false;
    
    for (int i = cleaned.length - 1; i >= 0; i--) {
      int digit = int.parse(cleaned[i]);
      
      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit = (digit % 10) + 1;
        }
      }
      
      sum += digit;
      alternate = !alternate;
    }
    
    return sum % 10 == 0;
  }

  /// Check if a string is a valid ISBN
  static bool isValidIsbn(String isbn) {
    // Remove hyphens and spaces
    final cleaned = isbn.replaceAll(RegExp(r'[\s\-]'), '');
    
    // Check if it's 10 or 13 digits
    if (cleaned.length == 10) {
      return _isValidIsbn10(cleaned);
    } else if (cleaned.length == 13) {
      return _isValidIsbn13(cleaned);
    }
    
    return false;
  }

  /// Check if a string is a valid ISBN-10
  static bool _isValidIsbn10(String isbn) {
    if (!RegExp(r'^\d{9}[\dX]$').hasMatch(isbn)) return false;
    
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(isbn[i]) * (10 - i);
    }
    
    int checkDigit = isbn[9] == 'X' ? 10 : int.parse(isbn[9]);
    return (sum + checkDigit) % 11 == 0;
  }

  /// Check if a string is a valid ISBN-13
  static bool _isValidIsbn13(String isbn) {
    if (!RegExp(r'^\d{13}$').hasMatch(isbn)) return false;
    
    int sum = 0;
    for (int i = 0; i < 12; i++) {
      sum += int.parse(isbn[i]) * (i % 2 == 0 ? 1 : 3);
    }
    
    int checkDigit = (10 - (sum % 10)) % 10;
    return checkDigit == int.parse(isbn[12]);
  }
}
