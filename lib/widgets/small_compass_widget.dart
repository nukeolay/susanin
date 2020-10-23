import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/generated/l10n.dart';
import 'package:susanin/models/app_data.dart';

class SmallCompassWidget extends StatelessWidget {
  ApplicationData _applicationData;
  double _compassDirection;

  SmallCompassWidget(this._applicationData, this._compassDirection);

  @override
  Widget build(BuildContext context) {
    if (_applicationData.shortCompassForm) {
      return IconButton(
        icon: Transform.rotate(
          angle: -_compassDirection * (pi / 180),
          child: Icon(Icons.keyboard_arrow_up_rounded,
              size: 30, color: Colors.green),
        ),
        onPressed: () {
          _applicationData.switchShortCompassForm();
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
          _applicationData.switchShortCompassForm();
        },
      );
    }
  }
}
