import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyAnimation extends StatefulWidget {
  @override
  _MyAnimationState createState() => _MyAnimationState();
}

class _MyAnimationState extends State<MyAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    animation =
        Tween<double>(begin: 0, end: 2 * math.pi).animate(animationController)
          ..addListener(() {
            setState(() {});
          })..addStatusListener((status) {
            if(status==AnimationStatus.completed){
              animationController.reverse();
            }
            else if(status==AnimationStatus.dismissed){
              animationController.forward();
            }
        });
    animationController.forward();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animations'),
      ),
      body: Transform.rotate(
        angle: animation.value,
        child: Center(
          child: Container(
            child: Text(
              "My Animation",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
