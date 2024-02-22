library auto_step;

import 'package:flutter/material.dart';

class AutoStepValues<T> extends StatefulWidget {
  const AutoStepValues(
      {super.key, required this.values, required this.duration, required this.builder, this.loop = true,}): assert(values.length == duration.length), assert(values.length != 0);

  final List<T> values;
  final List<Duration> duration;
  final bool loop;
  final Widget Function(T step) builder;

  @override
  State<AutoStepValues<T>> createState() => _AutoStepValuesState<T>();
}

class _AutoStepValuesState<T> extends State<AutoStepValues<T>> {

  late T step;
  int index = 0;

  @override
  void initState() {
    step = widget.values[index];

    super.initState();

    stepping();
  }

  void stepping([int? index]) {
    Future.delayed(widget.duration[this.index], (){
      setState(() {
        if(index == null){
          step = widget.values[++this.index];
        } else {
          this.index = index;
          step = widget.values[this.index];
        }
      });

      if(this.index == widget.values.length - 1 && widget.loop){
        stepping(0);
      } else {
        stepping();
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
