import 'dart:math' as math;

import 'package:flutter/material.dart';

class CustomPointer extends StatelessWidget {
  final double rotateAngle;
  final double accuracyAngle;
  final double pointerSize;

  const CustomPointer({
    required this.rotateAngle,
    required this.accuracyAngle,
    required this.pointerSize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(pointerSize * 0.5),
      child: Transform.rotate(
        alignment: Alignment.center,
        angle: rotateAngle,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(radius: pointerSize),
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
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = pointerSize / 1.5;
    canvas.drawArc(
        Offset(-pointerSize, -pointerSize + pointerSize * 0.5) &
            Size(pointerSize * 2, pointerSize * 2),
        -math.pi / 2 - accuracyAngle / 2, //radians
        accuracyAngle, //radians
        false,
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
