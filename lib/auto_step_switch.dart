
/// Provides a widget that switches a boolean value automatically over time.
library auto_step;

import 'package:auto_step/loop_mode.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

/// A widget that automatically toggles a boolean value at a given interval.
///
/// [duration] is the delay between toggles.
/// [builder] builds the widget for the current boolean value.
/// [loop] controls the looping behavior.
class AutoStepSwitch extends StatefulWidget {
  /// Creates an [AutoStepSwitch] widget.
  const AutoStepSwitch(
      {super.key, required this.duration, required this.builder, this.loop = const AutoStepLoop(),});

  /// The duration between each toggle.
  final Duration duration;

  /// The looping mode for the switch.
  final AutoStepLoop loop;

  /// The builder function for the current boolean value.
  final Widget Function(bool step) builder;

  @override
  State<AutoStepSwitch> createState() => _AutoStepSwitchState();
}

/// State for [AutoStepSwitch].
class _AutoStepSwitchState extends State<AutoStepSwitch> {

  /// The current boolean value.
  bool step = false;

  /// The current loop count.
  int? count;

  /// The cancelable operation for the toggle timer.
  CancelableOperation<void>? _operation;

  @override
  void initState() {
    super.initState();
    stepping();
  }

  /// Advances the switch, handling looping as needed.
  void stepping() {
    _operation = CancelableOperation.fromFuture(
      Future.delayed(widget.duration),
      onCancel: () {},
    )..value.then((_) {
      if (!mounted) return;
      setState(() {
        step = !step;
      });

      if (step) {
        if (widget.loop.count == null || widget.loop.count != 0) {
          if (widget.loop.count == null) {
            stepping();
          } else {
            if (count == null) {
              count = 1;
            } else {
              count = count! + 1;
            }

            if (widget.loop.count != count) {
              stepping();
            }
          }
        }
      } else {
        stepping();
      }
    });
  }

  @override
  void dispose() {
    _operation?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(step);
  }
}

