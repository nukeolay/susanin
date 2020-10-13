import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/alerts/info_alert.dart';
import 'package:susanin/models/app_data.dart';
import 'package:susanin/widgets/location_list.dart';
import 'package:susanin/widgets/point_name.dart';
import 'package:provider/provider.dart';
import 'package:susanin/widgets/test_direction_widget.dart';
import 'package:susanin/generated/l10n.dart';

class ShowDirectionPage extends StatelessWidget {
  String showDistance(BuildContext context, double distance) {
    if (distance < 5)
      return S.of(context).lessThan5Metres;
    else
      return "${distance.toStringAsFixed(0)} ${S.of(context).metres}";
  }

  Widget showDirection(double distance, double resultDirection) {
    if (distance < 5) {
      return Icon(Icons.check_circle_rounded, size: 110.0, color: Colors.green);
    } else {
      return Transform.rotate(
        angle: -resultDirection * (pi / 180),
        child: Icon(Icons.arrow_circle_up_rounded,
            size: 110.0, color: Colors.green),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double _compassDirection = context.watch<double>();
    Position _position = context.watch<Position>();
    ApplicationData _applicationData = context.watch<ApplicationData>();
    double compass = _compassDirection ?? 0;
    double bearing = -bearingBetween(
        _position.latitude,
        _position.longitude,
        _applicationData.getLocationPoint.pointLatitude,
        _applicationData.getLocationPoint.pointLongitude);
    double result = compass + bearing;
    double distance = distanceBetween(
        _position.latitude,
        _position.longitude,
        _applicationData.getLocationPoint.pointLatitude,
        _applicationData.getLocationPoint.pointLongitude);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Card(
          elevation: 8,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.info_outline_rounded,
                  //     color: Colors.green,
                  //   ),
                  //   enableFeedback: true,
                  //   tooltip: "Информация",
                  //   onPressed: () => showDialog(
                  //       context: context, builder: (_) => InfoAlert(context)),
                  // ),
                  IconButton(
                    icon: Transform.rotate(
                      angle: -compass * (pi / 180),
                      child: Icon(Icons.keyboard_arrow_up_outlined,
                          size: 24, color: Colors.green),
                    ),
                    tooltip: S.of(context).tipCompass,
                    onPressed: () => showDialog(
                        context: context, builder: (_) => InfoAlert(context)),
                  ),
                  IconButton(
                      icon: Icon(Icons.my_location,
                          size: 24,
                          color: _applicationData
                              .getAccuracyMarkerColor(_position.accuracy)),
                      enableFeedback: true,
                      tooltip:
                          "${S.of(context).tipLocationAccuracy} ${_position.accuracy.toStringAsFixed(0)} ${S.of(context).metres}",
                      onPressed: null)
                ],
              ),
              showDirection(distance, result),
              //TestDirection(compass, bearing, result),
              SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    showDistance(context, distance),
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.green),
                  ),
                  PointName(),
                ],
              ),
            ],
          ),
        ),
        // Divider(color: Colors.green),
        Expanded(child: LocationList()),
      ],
    );
  }
}
