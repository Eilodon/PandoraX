/// Mascot System Enums
/// 
/// Contains all enums related to the mascot interaction system.

/// User actions that can trigger mascot responses
enum UserAction {
  idle,
  createNote,
  completeTask,
  aiProcessing,
  error,
  sync,
  openApp,
  closeApp,
  search,
  filter,
}

/// Types of interactions with the mascot
enum MascotInteraction {
  tap,
  longPress,
  doubleTap,
  swipe,
  voiceCommand,
  gesture,
}

/// Mascot mood states
enum MascotMood {
  neutral,
  happy,
  excited,
  tired,
  confused,
  proud,
  sad,
  thinking,
}

/// Mascot animation types
enum MascotAnimation {
  idle,
  wave,
  jump,
  spin,
  bounce,
  fade,
  scale,
  slide,
}

/// Mascot size variants
enum MascotSize {
  small,
  medium,
  large,
  extraLarge,
}

/// Mascot position on screen
enum MascotPosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  center,
  floating,
}
