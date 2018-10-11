import 'package:flutter/material.dart';
import 'dart:math';
import 'const_values.dart';
import 'cylinder_view_right.dart';

class EngineRight extends StatelessWidget {
  Widget buildShell() {
    return Container(
        height: ShellHeight,
        width: ShellWidth,
        decoration: BoxDecoration(
            color: ShellColor,
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0))));
  }

  Widget buildCylinder() {
    double cylinderOffsetX = (ShellWidthLeft - CylinderWidth) / 2;
    return CylinderRight(0.0, pi * 2.0, cylinderOffsetX);
  }

  Widget buildJacket(int atIndex, int totalCount) {
    double jacketWidth = CylinderWidth + 2;
    double jacketHeight = CylinderHeight + 2 * CrankshaftRadius + 5;
    double cylinderOffsetX = (ShellWidthLeft - CylinderWidth) / 2;
    double offsetX = cylinderOffsetX - 1;
    return Positioned(
      child: Container(
        width: jacketWidth,
        height: jacketHeight,
        color: BackgroundColor,
      ),
      left: offsetX,
      top: ShellHeight - jacketHeight,
    );
  }

  Widget buildCrankshaft() {
    double offsetX = (ShellWidthLeft - CrankshaftRadiusWithBorder * 2) / 2;
    return Positioned(
      child: Container(
        height: CrankshaftRadiusWithBorder * 2,
        width: CrankshaftRadiusWithBorder * 2,
//        color: CrankshaftColor,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(CrankshaftRadiusWithBorder),
            color: CrankshaftColor),
      ),
      left: offsetX,
      top: ShellHeight + ConnectRodHeight - CrankshaftRadiusWithBorder - CrankshaftRadius,
    );
  }

  List<Widget> buildChildren() {
    List<Widget> children = [];
    children.add(buildShell());
    children.add(buildJacket(0, 1));
    children.add(buildCylinder());
    children.add(buildCrankshaft());

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: EngineHeight,
      width: ShellWidthLeft,
      color: BackgroundColor,
      child: Stack(
        children: buildChildren(),
      ),
    );
  }
}
