
/// Provides a widget that steps through a list of values automatically over time.
library auto_step;

import 'package:flutter/material.dart';
import 'package:async/async.dart'; // Add this import

import 'loop_mode.dart';

/// A widget that automatically steps through a list of values over time.
///
/// [values] is the list of values to step through.
/// [duration] is the list of durations for each value.
/// [builder] builds the widget for the current value.
/// [loopMode] controls the looping behavior.
class AutoStepValues<T> extends StatefulWidget {
  /// Creates an [AutoStepValues] widget.
  const AutoStepValues(
      {super.key, required this.values, required this.duration, required this.builder, this.loopMode = const AutoStepLoop(),}): assert(values.length == duration.length), assert(values.length != 0);

  /// The list of values to step through.
  final List<T> values;

  /// The list of durations for each value.
  final List<Duration> duration;

  /// The looping mode for the stepper.
  final AutoStepLoopMode loopMode;

  /// The builder function for the current value.
  final Widget Function(T step) builder;

  @override
  State<AutoStepValues<T>> createState() => _AutoStepValuesState<T>();
}

/// State for [AutoStepValues].
class _AutoStepValuesState<T> extends State<AutoStepValues<T>> {

  /// The current value.
  late T step;

  /// The current index in the values list.
  int index = 0;

  /// The current loop count.
  int? count;

  /// Whether the stepper is reversing.
  bool reverse = false;

  /// The cancelable operation for the step timer.
  CancelableOperation<void>? _operation; // Add this field

  @override
  void initState() {
    step = widget.values[index];
    super.initState();
    stepping();
  }

  /// Advances the stepper, handling looping and reversing as needed.
  void stepping([int? index, bool reverse = false]) {
    _operation = CancelableOperation.fromFuture(
      Future.delayed(widget.duration[this.index]),
      onCancel: () {},
    )..value.then((_) {
      if (!mounted) return;
      setState(() {
        if (index == null) {
          if (reverse) {
            step = widget.values[--this.index];
          } else {
            step = widget.values[++this.index];
          }
        } else {
          this.index = index;
          step = widget.values[this.index];
        }
        this.reverse = reverse;
      });

      if (this.index == widget.values.length - 1 || (this.index == 0 && reverse)) {
        switch (widget.loopMode) {
          case AutoStepNoLoop():
            break;
          case AutoStepLoop():
            final loop = widget.loopMode as AutoStepLoop;
            if (loop.count != null && (count == null || (count! < loop.count!))) {
              if (count == null) {
                count = 1;
              } else {
                count = count! + 1;
              }
              stepping(0);
            } else if (loop.count == null) {
              stepping(0);
            }
            break;
          case AutoStepReverseLoop():
            final loop = widget.loopMode as AutoStepReverseLoop;
            if (this.reverse) {
              if (count == null) {
                count = 1;
              } else {
                count = count! + 1;
              }
            }
            if (loop.count != null && (count == null || (count! < loop.count!))) {
              stepping(null, !this.reverse);
            } else if (loop.count == null) {
              stepping(null, !this.reverse);
            }
            break;
        }
      } else {
        stepping(null, this.reverse);
      }
    });
  }

  @override
  void dispose() {
    _operation?.cancel(); // Cancel the operation on dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(step);
  }
}

