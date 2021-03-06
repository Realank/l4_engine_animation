import 'package:flutter/material.dart';
import 'dart:math';
import 'const_values.dart';

class Cylinder extends StatefulWidget {
  final double initAngle;
  final double finalAngle;
  final double hOffset;
  Cylinder(this.initAngle, this.finalAngle, this.hOffset);
  _CylinderState createState() => new _CylinderState();
}

class _CylinderState extends State<Cylinder> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = new AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
//        controller.repeat();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    controller.repeat();
  }

  Widget build(BuildContext context) {
    return new AnimatedCylinder(
        animation: animation,
        initAngle: widget.initAngle,
        finalAngle: widget.finalAngle,
        hOffset: widget.hOffset);
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedCylinder extends AnimatedWidget {
  final double initAngle;
  final double finalAngle;
  final double hOffset;
  final Tween<double> positionTween;
  AnimatedCylinder(
      {Key key, Animation<double> animation, double initAngle, double finalAngle, double hOffset})
      : this.initAngle = initAngle,
        this.finalAngle = finalAngle,
        this.hOffset = hOffset,
        positionTween = Tween<double>(begin: initAngle, end: finalAngle),
        super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Positioned(
      child: Column(
        children: <Widget>[
          Container(
            height: 3.0,
            width: CylinderWidth,
            color: CylinderColor,
          ),
          Container(
            height: 1.0,
            width: CylinderWidth,
            color: Colors.transparent,
          ),
          Container(
            height: 1.0,
            width: CylinderWidth,
            color: CylinderColor,
          ),
          Container(
            height: 1.0,
            width: CylinderWidth,
            color: Colors.transparent,
          ),
          Container(
            height: CylinderHeight - 6,
            width: CylinderWidth,
            color: CylinderColor,
          ),
          Container(
            height: ConnectRodHeight,
            width: ConnectRodWidth,
            decoration: BoxDecoration(
                color: CylinderColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(ConnectRodWidth / 2),
                    bottomRight: Radius.circular(ConnectRodWidth / 2))),
          )
        ],
      ),
      top: ShellHeight -
          CylinderHeight -
          CrankshaftRadius -
          CrankshaftRadius * sin(positionTween.evaluate(animation)),
      left: hOffset,
    );
  }
}
