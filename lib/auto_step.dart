library auto_step;

import 'package:flutter/material.dart';
export 'auto_step_switch.dart';
export 'auto_step_values.dart';

class AutoStep extends StatefulWidget {
  const AutoStep(
      {super.key, required this.total, required this.duration, required this.builder, this.loop = true,});

  final int total;
  final Duration duration;
  final bool loop;
  final Widget Function(int step) builder;

  @override
  State<AutoStep> createState() => _AutoStepState();
}

class _AutoStepState extends State<AutoStep> {

  int step = 1;

  @override
  void initState() {
    super.initState();

    stepping();
  }

  void stepping([int? s]) {
    Future.delayed(widget.duration, (){
      setState(() {
        if(s != null){
          step = s;
        } else {
          step++;
        }
      });

      if(step < widget.total){
        stepping();
      } else if(step == widget.total && widget.loop){
        stepping(1);
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
