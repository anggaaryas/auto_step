library auto_step;

import 'package:flutter/material.dart';

class AutoStepSwitch extends StatefulWidget {
  const AutoStepSwitch(
      {super.key, required this.duration, required this.builder, this.loop = true,});

  final Duration duration;
  final bool loop;
  final Widget Function(bool step) builder;

  @override
  State<AutoStepSwitch> createState() => _AutoStepSwitchState();
}

class _AutoStepSwitchState extends State<AutoStepSwitch> {

  bool step = false;

  @override
  void initState() {
    super.initState();

    stepping();
  }

  void stepping() {
    Future.delayed(widget.duration, (){
      setState(() {
        step = !step;
      });

      if(step && widget.loop){
        stepping();
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
