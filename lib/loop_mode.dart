
/// Base class for loop modes in auto_step.
sealed class AutoStepLoopMode{
  /// Creates a loop mode.
  const AutoStepLoopMode();
}

/// No looping; the stepper stops at the end.
class AutoStepNoLoop extends AutoStepLoopMode{
  /// Creates a no-loop mode.
  const AutoStepNoLoop();
}

/// Loops from the beginning after reaching the end.
///
/// [count] specifies the number of loops, or infinite if null.
class AutoStepLoop extends AutoStepLoopMode{
  /// The number of loops, or null for infinite.
  final int? count;

  /// Creates a loop mode.
  const AutoStepLoop({this.count});
}

/// Loops back and forth between start and end.
///
/// [count] specifies the number of loops, or infinite if null.
class AutoStepReverseLoop extends AutoStepLoopMode{
  /// The number of loops, or null for infinite.
  final int? count;

  /// Creates a reverse-loop mode.
  const AutoStepReverseLoop({this.count});
}
