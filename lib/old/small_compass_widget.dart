import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:susanin/generated/l10n.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/app_data_old.dart';
import 'package:provider/provider.dart';

class SmallCompassWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _compassDirection = context.watch<CompassEvent>().heading ?? 0;
    if (context.watch<ApplicationData>().isShortCompassForm) {
      return IconButton(
        icon: Transform.rotate(
          angle: -_compassDirection * (pi / 180),
          child: Icon(Icons.keyboard_arrow_up_rounded,
              size: 30, color: Colors.green),
        ),
        onPressed: () {
          context.read<ApplicationData>().switchShortCompassForm();
        },
      );
    } else {
      return TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Transform.rotate(
              angle: -_compassDirection * (pi / 180),
              child: Icon(Icons.keyboard_arrow_up_rounded,
                  size: 30, color: Colors.green),
            ),
            Text(
              S.of(context).tipCompass,
              style: TextStyle(
                color: Colors.green,
              ),
            ),
          ],
        ),
        onPressed: () {
          context.read<ApplicationData>().switchShortCompassForm();
        },
      );
    }
  }
}
