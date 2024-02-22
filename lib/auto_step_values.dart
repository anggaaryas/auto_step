library auto_step;

import 'package:flutter/material.dart';

import 'loop_mode.dart';

class AutoStepValues<T> extends StatefulWidget {
  const AutoStepValues(
      {super.key, required this.values, required this.duration, required this.builder, this.loopMode = const AutoStepLoop(),}): assert(values.length == duration.length), assert(values.length != 0);

  final List<T> values;
  final List<Duration> duration;
  final AutoStepLoopMode loopMode;
  final Widget Function(T step) builder;

  @override
  State<AutoStepValues<T>> createState() => _AutoStepValuesState<T>();
}

class _AutoStepValuesState<T> extends State<AutoStepValues<T>> {

  late T step;
  int index = 0;
  int? count;
  bool reverse = false;

  @override
  void initState() {
    step = widget.values[index];

    super.initState();

    stepping();
  }

  void stepping([int? index,  bool reverse = false]) {
    Future.delayed(widget.duration[this.index], (){
      setState(() {
        if(index == null){
          if(reverse){
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

      if(this.index == widget.values.length-1 || (this.index == 0 && reverse)){

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
              stepping(0);
            } else if(loop.count == null){
              stepping(0);
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
