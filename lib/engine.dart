import 'package:flutter/material.dart';
import 'dart:math';
import 'const_values.dart';
import 'cylinder_view.dart';

class Engine extends StatelessWidget {
  Widget buildShell() {
    return Container(
      height: ShellHeight,
      width: ShellWidth,
      decoration: BoxDecoration(
          color: ShellColor,
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0))),
    );
  }

  Widget buildCylinder(int atIndex, int totalCount) {
    double cylinderMargin =
        (ShellWidth - ShellPadding * 2 - CylinderWidth * CylinderCount) / (CylinderCount - 1);
    double cylinderOffsetX = ShellPadding + (cylinderMargin + CylinderWidth) * atIndex;
    double angleOffset = 2 * pi * atIndex / totalCount;
    return Cylinder(angleOffset, pi * 2.0 + angleOffset, cylinderOffsetX);
  }

  Widget buildJacket(int atIndex, int totalCount) {
    double jacketWidth = CylinderWidth + 2;
    double jacketHeight = CylinderHeight + 2 * CrankshaftRadius + 5;
    double cylinderMargin =
        (ShellWidth - ShellPadding * 2 - CylinderWidth * CylinderCount) / (CylinderCount - 1);
    double cylinderOffsetX = ShellPadding + (cylinderMargin + CylinderWidth) * atIndex;
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
    return Positioned(
      child: Container(height: CrankshaftRodRadius * 2, width: ShellWidth, color: CrankshaftColor),
      left: 0.0,
      top: ShellHeight + ConnectRodHeight - CrankshaftRadius - CrankshaftRodRadius,
    );
  }

  Widget buildCrankshaftGap(int atIndex, int totalCount) {
    double crankshaftGapWidth = ConnectRodWidth + 2 + CrankshaftFlatWidth * 2;
    double cylinderMargin =
        (ShellWidth - ShellPadding * 2 - CylinderWidth * CylinderCount) / (CylinderCount - 1);
    double cylinderOffsetX = ShellPadding + (cylinderMargin + CylinderWidth) * atIndex;
    double offsetX = cylinderOffsetX + CylinderWidth / 2 - crankshaftGapWidth / 2;
    return Positioned(
      child: Row(
        children: <Widget>[
          Container(
              height: CrankshaftRadiusWithBorder * 2,
              width: CrankshaftFlatWidth,
              color: CrankshaftColor),
          Container(
              height: CrankshaftRodRadius * 2, width: ConnectRodWidth + 2, color: BackgroundColor),
          Container(
              height: CrankshaftRadiusWithBorder * 2,
              width: CrankshaftFlatWidth,
              color: CrankshaftColor),
        ],
      ),
      left: offsetX,
      top: ShellHeight + ConnectRodHeight - CrankshaftRadiusWithBorder - CrankshaftRadius,
    );
  }

  List<Widget> buildChildren() {
    List<Widget> children = [];
    children.add(buildShell());
    children.add(buildCrankshaft());
    for (var i = 0; i < CylinderCount; i++) {
      children.add(buildCrankshaftGap(i, CylinderCount));
      children.add(buildJacket(i, CylinderCount));
      children.add(buildCylinder(i, CylinderCount));
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: EngineHeight,
      width: ShellWidth,
      color: BackgroundColor,
      child: Stack(
        children: buildChildren(),
      ),
    );
  }
}
