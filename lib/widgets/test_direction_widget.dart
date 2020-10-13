import 'dart:math';

import 'package:flutter/material.dart';

class TestDirection extends StatelessWidget {
  final double compass;
  final double bearing;
  final double result;

  TestDirection(this.compass, this.bearing, this.result);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: Colors.black),
        //--------------RESULT---------------
        Transform.rotate(
          angle: -result * (pi / 180),
          child: Icon(Icons.arrow_circle_up_rounded,
              size: 50.0, color: Colors.red[900]),
        ),
        Text(
            "Итог: радианы ${(result * (pi / 180)).toStringAsFixed(3)}, градусы ${(result).toStringAsFixed(0)}°"),
        Divider(color: Colors.black),
        //--------------RESULT---------------
        //--------------COMPASS---------------
        Transform.rotate(
          angle: -compass * (pi / 180),
          child: Icon(Icons.arrow_circle_up_rounded,
              size: 50.0, color: Colors.red[600]),
        ),
        Text(
            "Компасс: радианы ${(compass * (pi / 180)).toStringAsFixed(3)}, градусы ${(compass).toStringAsFixed(0)}°"),
        Divider(color: Colors.black),
        //--------------COMPASS---------------
        //--------------BEARING---------------
        Transform.rotate(
          angle: -bearing * (pi / 180),
          child: Icon(Icons.arrow_circle_up_rounded,
              size: 50.0, color: Colors.red[300]),
        ),
        Text(
            "Азимут: радианы ${(bearing * (pi / 180)).toStringAsFixed(3)}, градусы ${(bearing).toStringAsFixed(0)}°"),
        //--------------BEARING---------------
      ],
    );
  }
}
