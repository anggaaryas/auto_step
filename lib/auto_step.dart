
/// The main library for auto_step, providing step-based automatic state changes.
library auto_step;

import 'package:auto_step/loop_mode.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart'; // Add this import
export 'auto_step_switch.dart';
export 'auto_step_values.dart';

/// A widget that automatically steps through a sequence of integers over time.
///
/// [total] specifies the number of steps.
/// [duration] is the delay between steps.
/// [builder] builds the widget for the current step.
/// [loopMode] controls the looping behavior.
class AutoStep extends StatefulWidget {
  /// Creates an [AutoStep] widget.
  const AutoStep(
      {super.key, required this.total, required this.duration, required this.builder, this.loopMode = const AutoStepLoop(),});

  /// The total number of steps.
  final int total;

  /// The duration between each step.
  final Duration duration;

  /// The looping mode for the stepper.
  final AutoStepLoopMode loopMode;

  /// The builder function for the current step.
  final Widget Function(int step) builder;

  @override
  State<AutoStep> createState() => _AutoStepState();
}

/// State for [AutoStep].
class _AutoStepState extends State<AutoStep> {

  /// The current step.
  int step = 1;

  /// The current loop count.
  int? count;

  /// Whether the stepper is reversing.
  bool reverse = false;

  /// The cancelable operation for the step timer.
  CancelableOperation<void>? _operation; // Add this field

  @override
  void initState() {
    super.initState();
    stepping();
  }

  /// Advances the stepper, handling looping and reversing as needed.
  void stepping([int? s, bool reverse = false]) {
    _operation = CancelableOperation.fromFuture(
      Future.delayed(widget.duration),
      onCancel: () {},
    )..value.then((_) {
      if (!mounted) return;
      setState(() {
        if(s != null){
          step = s;
        } else {
          if(reverse){
            step--;
          } else {
            step++;
          }
        }
        this.reverse = reverse;
      });

      if(step == widget.total || (step == 1 && reverse)){
        switch(widget.loopMode){
          case AutoStepNoLoop():
            break;
          case AutoStepLoop():
            final loop = widget.loopMode as AutoStepLoop;
            if(loop.count != null && (count == null || (count! < loop.count!))){
              if(count == null){
                count = 1;
              } else {
                count = count! + 1;
              }
              stepping(1);
            } else if(loop.count == null){
              stepping(1);
            }
            break; // Add missing break
          case AutoStepReverseLoop():
            final loop = widget.loopMode as AutoStepReverseLoop;
            if(this.reverse){
              if(count == null){
                count = 1;
              } else {
                count = count! + 1;
              }
            }
            if(loop.count != null && (count == null || (count! < loop.count!))){
              stepping(null, !this.reverse);
            } else if(loop.count == null){
              stepping(null, !this.reverse);
            }
            break; // Add missing break
        }
      } else{
        stepping(null, this.reverse);
      }
    });
  }

  @override
  void dispose(){
    _operation?.cancel(); // Cancel the operation on dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(step);
  }
}

