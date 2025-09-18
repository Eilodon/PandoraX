/// Micro-interaction Service for Phase 5 Advanced UX
/// 
/// This service provides haptic feedback, sound effects, and visual feedback
/// for enhanced user interactions and engagement.
library micro_interaction_service;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:core/core.dart';

/// Micro-interaction service for enhanced UX
class MicroInteractionService {
  static MicroInteractionService? _instance;
  static MicroInteractionService get instance => _instance ??= MicroInteractionService._();
  
  MicroInteractionService._();
  
  final LoggingService _logger = LoggingService.instance;
  
  // ============================================================================
  // HAPTIC FEEDBACK
  // ============================================================================
  
  /// Light haptic feedback for subtle interactions
  void lightImpact() {
    try {
      HapticFeedback.lightImpact();
      _logger.debug('Light haptic feedback triggered');
    } catch (e) {
      _logger.warning('Failed to trigger light haptic feedback: $e');
    }
  }
  
  /// Medium haptic feedback for standard interactions
  void mediumImpact() {
    try {
      HapticFeedback.mediumImpact();
      _logger.debug('Medium haptic feedback triggered');
    } catch (e) {
      _logger.warning('Failed to trigger medium haptic feedback: $e');
    }
  }
  
  /// Heavy haptic feedback for important interactions
  void heavyImpact() {
    try {
      HapticFeedback.heavyImpact();
      _logger.debug('Heavy haptic feedback triggered');
    } catch (e) {
      _logger.warning('Failed to trigger heavy haptic feedback: $e');
    }
  }
  
  /// Selection haptic feedback for UI selections
  void selectionClick() {
    try {
      HapticFeedback.selectionClick();
      _logger.debug('Selection haptic feedback triggered');
    } catch (e) {
      _logger.warning('Failed to trigger selection haptic feedback: $e');
    }
  }
  
  /// Vibrate for custom duration
  void vibrate({Duration duration = const Duration(milliseconds: 50)}) {
    try {
      HapticFeedback.vibrate();
      _logger.debug('Vibrate haptic feedback triggered for ${duration.inMilliseconds}ms');
    } catch (e) {
      _logger.warning('Failed to trigger vibrate haptic feedback: $e');
    }
  }
  
  // ============================================================================
  // SOUND EFFECTS
  // ============================================================================
  
  /// Play success sound
  void playSuccessSound() {
    _playSound('success');
  }
  
  /// Play error sound
  void playErrorSound() {
    _playSound('error');
  }
  
  /// Play warning sound
  void playWarningSound() {
    _playSound('warning');
  }
  
  /// Play info sound
  void playInfoSound() {
    _playSound('info');
  }
  
  /// Play click sound
  void playClickSound() {
    _playSound('click');
  }
  
  /// Play notification sound
  void playNotificationSound() {
    _playSound('notification');
  }
  
  /// Play typing sound
  void playTypingSound() {
    _playSound('typing');
  }
  
  /// Play swipe sound
  void playSwipeSound() {
    _playSound('swipe');
  }
  
  /// Play custom sound
  void playCustomSound(String soundType) {
    _playSound(soundType);
  }
  
  /// Internal method to play sound
  void _playSound(String soundType) {
    try {
      // In a real implementation, you would use audio packages like audioplayers
      // For now, we'll just log the sound request
      _logger.debug('Playing sound: $soundType');
      
      // Trigger haptic feedback as audio alternative
      switch (soundType) {
        case 'success':
          lightImpact();
          break;
        case 'error':
          heavyImpact();
          break;
        case 'warning':
          mediumImpact();
          break;
        case 'info':
          selectionClick();
          break;
        case 'click':
          selectionClick();
          break;
        case 'notification':
          mediumImpact();
          break;
        case 'typing':
          lightImpact();
          break;
        case 'swipe':
          lightImpact();
          break;
        default:
          selectionClick();
      }
    } catch (e) {
      _logger.warning('Failed to play sound $soundType: $e');
    }
  }
  
  // ============================================================================
  // VISUAL FEEDBACK
  // ============================================================================
  
  /// Create ripple effect for tap interactions
  Widget createRippleEffect({
    required Widget child,
    required VoidCallback onTap,
    Color? rippleColor,
    BorderRadius? borderRadius,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          selectionClick();
          onTap();
        },
        borderRadius: borderRadius ?? BorderRadius.circular(DesignTokens.radiusBase),
        splashColor: rippleColor ?? DesignTokens.primary.withOpacity(0.1),
        highlightColor: rippleColor ?? DesignTokens.primary.withOpacity(0.05),
        child: child,
      ),
    );
  }
  
  /// Create press effect for button interactions
  Widget createPressEffect({
    required Widget child,
    required VoidCallback onPressed,
    Color? pressColor,
    Duration duration = const Duration(milliseconds: 100),
  }) {
    return GestureDetector(
      onTapDown: (_) {
        mediumImpact();
        playClickSound();
      },
      onTapUp: (_) => onPressed(),
      onTapCancel: () {},
      child: AnimatedContainer(
        duration: duration,
        curve: DesignTokens.curveEaseInOut,
        child: child,
      ),
    );
  }
  
  /// Create hover effect for mouse interactions
  Widget createHoverEffect({
    required Widget child,
    Color? hoverColor,
    Duration duration = const Duration(milliseconds: 200),
  }) {
    return MouseRegion(
      onEnter: (_) {
        lightImpact();
      },
      child: AnimatedContainer(
        duration: duration,
        curve: DesignTokens.curveEaseInOut,
        child: child,
      ),
    );
  }
  
  /// Create focus effect for keyboard navigation
  Widget createFocusEffect({
    required Widget child,
    Color? focusColor,
    double focusWidth = 2.0,
  }) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          selectionClick();
        }
      },
      child: AnimatedContainer(
        duration: DesignTokens.durationFast,
        decoration: BoxDecoration(
          border: Border.all(
            color: focusColor ?? DesignTokens.primary,
            width: focusWidth,
          ),
          borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
        ),
        child: child,
      ),
    );
  }
  
  // ============================================================================
  // INTERACTION PATTERNS
  // ============================================================================
  
  /// Success interaction pattern
  void successInteraction() {
    playSuccessSound();
    lightImpact();
    _logger.info('Success interaction triggered');
  }
  
  /// Error interaction pattern
  void errorInteraction() {
    playErrorSound();
    heavyImpact();
    _logger.warning('Error interaction triggered');
  }
  
  /// Warning interaction pattern
  void warningInteraction() {
    playWarningSound();
    mediumImpact();
    _logger.warning('Warning interaction triggered');
  }
  
  /// Info interaction pattern
  void infoInteraction() {
    playInfoSound();
    selectionClick();
    _logger.info('Info interaction triggered');
  }
  
  /// Click interaction pattern
  void clickInteraction() {
    playClickSound();
    selectionClick();
    _logger.debug('Click interaction triggered');
  }
  
  /// Long press interaction pattern
  void longPressInteraction() {
    playNotificationSound();
    heavyImpact();
    _logger.debug('Long press interaction triggered');
  }
  
  /// Swipe interaction pattern
  void swipeInteraction() {
    playSwipeSound();
    lightImpact();
    _logger.debug('Swipe interaction triggered');
  }
  
  /// Typing interaction pattern
  void typingInteraction() {
    playTypingSound();
    lightImpact();
    _logger.debug('Typing interaction triggered');
  }
  
  // ============================================================================
  // ACCESSIBILITY
  // ============================================================================
  
  /// Announce to screen readers
  void announceToScreenReader(String message) {
    try {
      // In a real implementation, you would use accessibility services
      _logger.info('Screen reader announcement: $message');
    } catch (e) {
      _logger.warning('Failed to announce to screen reader: $e');
    }
  }
  
  /// Provide audio feedback for accessibility
  void provideAudioFeedback(String feedbackType) {
    switch (feedbackType) {
      case 'success':
        playSuccessSound();
        break;
      case 'error':
        playErrorSound();
        break;
      case 'warning':
        playWarningSound();
        break;
      case 'info':
        playInfoSound();
        break;
      default:
        playClickSound();
    }
  }
  
  // ============================================================================
  // CUSTOMIZATION
  // ============================================================================
  
  /// Enable/disable haptic feedback
  bool _hapticEnabled = true;
  bool get hapticEnabled => _hapticEnabled;
  
  void setHapticEnabled(bool enabled) {
    _hapticEnabled = enabled;
    _logger.info('Haptic feedback ${enabled ? 'enabled' : 'disabled'}');
  }
  
  /// Enable/disable sound effects
  bool _soundEnabled = true;
  bool get soundEnabled => _soundEnabled;
  
  void setSoundEnabled(bool enabled) {
    _soundEnabled = enabled;
    _logger.info('Sound effects ${enabled ? 'enabled' : 'disabled'}');
  }
  
  /// Enable/disable visual feedback
  bool _visualEnabled = true;
  bool get visualEnabled => _visualEnabled;
  
  void setVisualEnabled(bool enabled) {
    _visualEnabled = enabled;
    _logger.info('Visual feedback ${enabled ? 'enabled' : 'disabled'}');
  }
  
  /// Check if all feedback is enabled
  bool get allFeedbackEnabled => _hapticEnabled && _soundEnabled && _visualEnabled;
  
  /// Enable/disable all feedback
  void setAllFeedbackEnabled(bool enabled) {
    _hapticEnabled = enabled;
    _soundEnabled = enabled;
    _visualEnabled = enabled;
    _logger.info('All feedback ${enabled ? 'enabled' : 'disabled'}');
  }
}
