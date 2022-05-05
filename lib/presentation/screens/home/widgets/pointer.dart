import 'dart:math' as math;

import 'package:flutter/material.dart';

class Pointer extends StatelessWidget {
  final double rotateAngle;
  final double accuracyAngle;
  final double pointerSize;
  final double? locationAccuracy;

  const Pointer({
    required this.rotateAngle,
    required this.accuracyAngle,
    required this.pointerSize,
    this.locationAccuracy,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Transform.rotate(
        alignment: Alignment.center,
        angle: rotateAngle,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: pointerSize * 0.7,
              backgroundColor: Colors.green,
            ),
            locationAccuracy != null
                ? CircleAvatar(
                    radius: locationAccuracy,
                    backgroundColor: Colors.redAccent,
                  )
                : CircleAvatar(
                    radius: pointerSize * 0.1,
                    backgroundColor: Colors.white,
                  ),
            Container(
              alignment: Alignment.center,
              transformAlignment: Alignment.center,
              child: CustomPaint(
                painter: CustomArc(
                  accuracyAngle: accuracyAngle,
                  pointerSize: pointerSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomArc extends CustomPainter {
  final double accuracyAngle;
  final double pointerSize;

  CustomArc({required this.accuracyAngle, required this.pointerSize});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
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
