library auto_step;

import 'package:auto_step/loop_mode.dart';
import 'package:flutter/material.dart';

class AutoStepSwitch extends StatefulWidget {
  const AutoStepSwitch(
      {super.key, required this.duration, required this.builder, this.loop = const AutoStepLoop(),});

  final Duration duration;
  final AutoStepLoop loop;
  final Widget Function(bool step) builder;

  @override
  State<AutoStepSwitch> createState() => _AutoStepSwitchState();
}

class _AutoStepSwitchState extends State<AutoStepSwitch> {

  bool step = false;
  int? count;

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

      if(step){
        if(widget.loop.count == null || widget.loop.count != 0) {
          if(widget.loop.count == null){
            stepping();
          } else {
            if(count == null){
              count = 1;
            } else {
              count = count! + 1;
            }

            if(widget.loop.count != count){

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
  void dispose(){

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(step);
  }
}
