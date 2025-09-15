/// Common enums used across Pandora UI components
library common_enums;

/// Animation type enum for consistent animation sizing
enum AnimationType {
  micro,
  small,
  medium,
  large,
  extraLarge,
}

/// Performance level enum for optimization settings
enum PerformanceLevel {
  high,
  medium,
  low,
}

/// Animation performance level enum
enum AnimationPerformanceLevel {
  low,
  medium,
  high,
  ultra,
}

/// Performance card variant enum
enum PerformanceCardVariant {
  standard,
  compact,
  expanded,
  minimal,
  detailed,
}

/// Performance card size enum
enum PerformanceCardSize {
  small,
  medium,
  large,
  extraLarge,
}

/// Performance card state enum
enum PerformanceCardState {
  idle,
  loading,
  success,
  error,
  warning,
}

/// Memory optimization level enum
enum MemoryOptimizationLevel {
  none,
  basic,
  advanced,
  maximum,
}

/// Mobile navigation type enum
enum MobileNavigationType {
  bottom,
  top,
  drawer,
  tabs,
}

/// Mobile navigation variant enum
enum MobileNavigationVariant {
  standard,
  compact,
  expanded,
  minimal,
}

/// Mobile navigation size enum
enum MobileNavigationSize {
  small,
  medium,
  large,
  extraLarge,
}

/// Mobile navigation state enum
enum MobileNavigationState {
  idle,
  loading,
  success,
  error,
  disabled,
}

/// Mobile text field variant enum
enum MobileTextFieldVariant {
  standard,
  outlined,
  filled,
  underlined,
}

/// Mobile text field size enum
enum MobileTextFieldSize {
  small,
  medium,
  large,
  extraLarge,
}

/// Mobile text field state enum
enum MobileTextFieldState {
  idle,
  focused,
  error,
  success,
  disabled,
}

/// Swipe direction enum
enum SwipeDirection {
  left,
  right,
  up,
  down,
}

/// Tooltip position enum
enum TooltipPosition {
  top,
  bottom,
  left,
  right,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}
