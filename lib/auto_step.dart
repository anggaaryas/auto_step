library auto_step;

import 'package:auto_step/loop_mode.dart';
import 'package:flutter/material.dart';
export 'auto_step_switch.dart';
export 'auto_step_values.dart';

class AutoStep extends StatefulWidget {
  const AutoStep(
      {super.key, required this.total, required this.duration, required this.builder, this.loopMode = const AutoStepLoop(),});

  final int total;
  final Duration duration;
  final AutoStepLoopMode loopMode;
  final Widget Function(int step) builder;

  @override
  State<AutoStep> createState() => _AutoStepState();
}

class _AutoStepState extends State<AutoStep> {

  int step = 1;
  int? count;
  bool reverse = false;

  @override
  void initState() {
    super.initState();

    stepping();
  }

  void stepping([int? s, bool reverse = false]) {
    Future.delayed(widget.duration, (){
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
        }

      } else{
         stepping(null, this.reverse);
       }
    });
  }

  @override
  void dispose(){

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(step);
  }
}
