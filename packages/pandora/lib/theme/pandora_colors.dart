import 'package:flutter/material.dart';

class PandoraColors {
  // Primary colors
  static const Color primary = Color(0xFF2196F3);
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFFBBDEFB);
  
  // Secondary colors
  static const Color secondary = Color(0xFF03DAC6);
  static const Color secondaryDark = Color(0xFF018786);
  static const Color secondaryLight = Color(0xFF80CBC4);
  
  // Accent colors
  static const Color accent = Color(0xFFFF4081);
  static const Color accentDark = Color(0xFFE91E63);
  static const Color accentLight = Color(0xFFFF80AB);
  
  // Background colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  
  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB3FFFFFF);
  static const Color textHintDark = Color(0xFF61FFFFFF);
  
  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // AI specific colors
  static const Color aiPrimary = Color(0xFF9C27B0);
  static const Color aiSecondary = Color(0xFF673AB7);
  static const Color aiAccent = Color(0xFFE91E63);
  
  // Memory type colors
  static const Color memoryExplicit = Color(0xFF2196F3);
  static const Color memoryImplicit = Color(0xFF9C27B0);
  static const Color memoryEmotional = Color(0xFFE91E63);
  static const Color memoryTemporal = Color(0xFFFF9800);
  static const Color memorySpatial = Color(0xFF4CAF50);
  static const Color memorySocial = Color(0xFF00BCD4);
  static const Color memoryAIGenerated = Color(0xFF673AB7);
  static const Color memorySystem = Color(0xFF607D8B);
  
  // Gradient colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient aiGradient = LinearGradient(
    colors: [aiPrimary, aiSecondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [background, surface],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Shadow colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowDark = Color(0x4D000000);
  
  // Border colors
  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color borderMedium = Color(0xFFBDBDBD);
  static const Color borderDark = Color(0xFF757575);
  
  // Overlay colors
  static const Color overlayLight = Color(0x1AFFFFFF);
  static const Color overlayMedium = Color(0x33FFFFFF);
  static const Color overlayDark = Color(0x4DFFFFFF);
  
  // Get color by name
  static Color getColorByName(String name) {
    switch (name.toLowerCase()) {
      case 'primary':
        return primary;
      case 'secondary':
        return secondary;
      case 'accent':
        return accent;
      case 'success':
        return success;
      case 'warning':
        return warning;
      case 'error':
        return error;
      case 'info':
        return info;
      default:
        return primary;
    }
  }
  
  // Get memory type color
  static Color getMemoryTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'explicit':
        return memoryExplicit;
      case 'implicit':
        return memoryImplicit;
      case 'emotional':
        return memoryEmotional;
      case 'temporal':
        return memoryTemporal;
      case 'spatial':
        return memorySpatial;
      case 'social':
        return memorySocial;
      case 'ai_generated':
        return memoryAIGenerated;
      case 'system':
        return memorySystem;
      default:
        return memoryExplicit;
    }
  }
}
