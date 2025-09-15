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
  // New actions for "living creature" behavior
  missDeadline,   // When user misses a deadline
  longIdle,       // When user is idle for too long
  directTouch,    // When user touches mascot directly
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
  // New moods for "living creature" behavior
  welcoming,    // When user opens app
  celebrating,  // When user completes task
  sleeping,     // When user is idle for too long
  idle,         // When user is not interacting
  disappointed, // When user misses deadline
  playful,      // When user interacts directly
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
  // New animations for "living creature" behavior
  celebration,  // For task completion
  sleep,        // For idle state
  wake,         // For waking up from sleep
  sad,          // For missed deadlines
  cloud,        // For sad state with cloud
  random,       // For random playful actions
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
