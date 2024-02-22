sealed class AutoStepLoopMode{
  const AutoStepLoopMode();
}

class AutoStepNoLoop extends AutoStepLoopMode{
  const AutoStepNoLoop();
}

class AutoStepLoop extends AutoStepLoopMode{
  final int? count;

  const AutoStepLoop({this.count});
}

class AutoStepReverseLoop extends AutoStepLoopMode{
  final int? count;

  const AutoStepReverseLoop({this.count});
}