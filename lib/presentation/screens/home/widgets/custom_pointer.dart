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
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(radius: pointerSize * 1.2),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Transform.rotate(
            alignment: Alignment.center,
            angle: rotateAngle,
            child: Container(
              alignment: Alignment.center,
              transformAlignment: Alignment.center,
              child: CustomPaint(
                painter: CustomArc(
                  accuracyAngle: accuracyAngle,
                  pointerSize: pointerSize,
                ),
              ),
            ),
          ),
        ),
      ],
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
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    canvas.drawArc(
        Offset(-pointerSize, -pointerSize) &
            Size(pointerSize * 2, pointerSize * 2),
        accuracyAngle / 2 - 1, //radians
        -accuracyAngle / 2 - 1, //radians
        true,
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
