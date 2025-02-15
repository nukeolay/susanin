import 'dart:math' as math;

import 'package:flutter/material.dart';

class Pointer extends StatelessWidget {
  const Pointer({
    required this.rotateAngle,
    required this.arcRadius,
    required this.radius,
    required this.foregroundColor,
    required this.backGroundColor,
    this.positionAccuracy,
    super.key,
  });

  final double rotateAngle;
  final double arcRadius;
  final double radius;
  final Color foregroundColor;
  final Color backGroundColor;
  final double? positionAccuracy;
  int get scale => 100;

  double _getPositionAccuracyRadius(double positionAccuracy) {
    final ratio = radius / scale; // scale
    if (ratio * positionAccuracy < radius * 0.1) {
      // minimum center circle size
      return 0;
    }
    if (ratio * positionAccuracy >= radius * 0.7) {
      //maximum center circle size
      return radius * 0.7;
    }
    return positionAccuracy * ratio;
  }

  bool _isPositionAccuracyMax(double positionAccuracy) {
    final ratio = radius / scale; // scale
    return ratio * positionAccuracy >= radius * 0.7;
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Transform.rotate(
        angle: rotateAngle,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: radius * 0.7,
              backgroundColor: backGroundColor,
            ),
            if (positionAccuracy != null)
              CircleAvatar(
                radius: _getPositionAccuracyRadius(positionAccuracy!),
                backgroundColor: _isPositionAccuracyMax(positionAccuracy!)
                    ? Theme.of(context).colorScheme.error
                    : foregroundColor.withOpacity(0.2),
              ),
            Container(
              alignment: Alignment.center,
              transformAlignment: Alignment.center,
              child: CustomPaint(
                painter: CustomArc(
                  arcRadius: arcRadius,
                  radius: radius,
                  color: foregroundColor,
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
  const CustomArc({
    required this.arcRadius,
    required this.color,
    required this.radius,
  });

  final double arcRadius;
  final double radius;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paintArc = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.1
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Offset(-radius / 2, -radius / 2) & Size(radius, radius),
      -math.pi / 2 - arcRadius / 2,
      arcRadius,
      false,
      paintArc,
    );
    final paintCircle = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = radius * 0.1;
    canvas.drawCircle(
      Offset.zero,
      radius * 0.07,
      paintCircle,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
