import 'dart:math' as math;

import 'package:flutter/material.dart';

class Pointer extends StatelessWidget {
  final double rotateAngle;
  final double accuracyAngle;
  final double pointerSize;
  final Color foregroundColor;
  final Color backGroundColor;
  final double? locationAccuracy;
  final Color? centerColor;
  final double? elevation;

  const Pointer({
    required this.rotateAngle,
    required this.accuracyAngle,
    required this.pointerSize,
    required this.foregroundColor,
    required this.backGroundColor,
    this.centerColor,
    this.locationAccuracy,
    this.elevation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Transform.rotate(
          alignment: Alignment.center,
          angle: rotateAngle,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Material(
                elevation: elevation ?? 3,
                borderRadius: BorderRadius.circular(1000),
                child: CircleAvatar(
                  radius: pointerSize * 0.7,
                  backgroundColor: backGroundColor,
                ),
              ),
              locationAccuracy != null
                  ? CircleAvatar(
                      radius: locationAccuracy,
                      backgroundColor: Colors.redAccent, // ! TODO вспомнить зачем это?
                    )
                  : CircleAvatar(
                      radius: pointerSize * 0.15,
                      backgroundColor: centerColor ?? foregroundColor,
                    ),
              Container(
                alignment: Alignment.center,
                transformAlignment: Alignment.center,
                child: CustomPaint(
                  painter: CustomArc(
                    accuracyAngle: accuracyAngle,
                    pointerSize: pointerSize,
                    paintColor: foregroundColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomArc extends CustomPainter {
  final double accuracyAngle;
  final double pointerSize;
  final Color paintColor;

  CustomArc({
    required this.accuracyAngle,
    required this.paintColor,
    required this.pointerSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = paintColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = pointerSize * 0.1
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
        Offset(-pointerSize / 2, -pointerSize / 2) &
            Size(pointerSize, pointerSize),
        -math.pi / 2 - accuracyAngle / 2,
        accuracyAngle,
        false,
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
