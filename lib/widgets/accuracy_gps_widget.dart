import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/generated/l10n.dart';
import 'package:susanin/models/app_data.dart';

class AccuracyGpsWidget extends StatelessWidget {
  ApplicationData _applicationData;
  Position _position;

  AccuracyGpsWidget(this._applicationData, this._position);

  @override
  Widget build(BuildContext context) {
    if (_applicationData.shortAccuracyForm) {
      return IconButton(
          icon: Icon(Icons.my_location,
              size: 24,
              color:
                  _applicationData.getAccuracyMarkerColor(_position.accuracy)),
          enableFeedback: true,
          onPressed: () {
            _applicationData.switchShortAccuracyForm();
          });
    } else {
      return TextButton(
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "${S.of(context).tipLocationAccuracy} ${_position.accuracy.toStringAsFixed(0)} ${S.of(context).metres}",
              style: TextStyle(
                color:
                    _applicationData.getAccuracyMarkerColor(_position.accuracy),
              ),
            )
          ],
        ),
        onPressed: () {
          _applicationData.switchShortAccuracyForm();
        },
      );
    }
  }
}
