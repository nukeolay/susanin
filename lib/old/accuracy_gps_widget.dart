import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/generated/l10n.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/app_data_old.dart';
import 'package:provider/provider.dart';

class AccuracyGpsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (context.watch<ApplicationData>().isShortAccuracyForm) {
      return IconButton(
          icon: Icon(Icons.my_location,
              size: 24,
              color:
              context.watch<ApplicationData>().getAccuracyMarkerColor(context.watch<Position>().accuracy)),
          enableFeedback: true,
          onPressed: () {
            context.read<ApplicationData>().switchShortAccuracyForm();
          });
    } else {
      return TextButton(
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "${S.of(context).tipLocationAccuracy} ${context.watch<Position>().accuracy.toStringAsFixed(0)} ${S.of(context).metres}",
              style: TextStyle(
                color:
                context.watch<ApplicationData>().getAccuracyMarkerColor(context.watch<Position>().accuracy),
              ),
            )
          ],
        ),
        onPressed: () {
          context.read<ApplicationData>().switchShortAccuracyForm();
        },
      );
    }
  }
}
