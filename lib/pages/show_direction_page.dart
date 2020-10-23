import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/alerts/info_alert.dart';
import 'package:susanin/models/app_data.dart';
import 'package:susanin/widgets/accuracy_gps_widget.dart';
import 'package:susanin/widgets/location_list.dart';
import 'package:susanin/widgets/point_name.dart';
import 'package:provider/provider.dart';
import 'package:susanin/widgets/small_compass_widget.dart';
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
    double _compassDirection = context.watch<CompassEvent>().heading ?? 0;
    Position _position = context.watch<Position>();
    ApplicationData _applicationData = context.watch<ApplicationData>();
    double _bearing = -Geolocator.bearingBetween(
        _position.latitude,
        _position.longitude,
        _applicationData.getLocationPoint.pointLatitude,
        _applicationData.getLocationPoint.pointLongitude);
    double result = _compassDirection + _bearing;
    double distance = Geolocator.distanceBetween(
        _position.latitude,
        _position.longitude,
        _applicationData.getLocationPoint.pointLatitude,
        _applicationData.getLocationPoint.pointLongitude);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 4,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SmallCompassWidget(),
                              AccuracyGpsWidget(),
                            ],
                          ),
                          showDirection(distance, result),
                          //TestDirection(_compassDirection, null, _bearing, result),
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
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add_location_alt,
          size: 30,
        ),
        onPressed: () {
          context.read<ApplicationData>().setCurrentLocationAsPoint(
              _position, S.of(context).locationNameTemplate);
        },
        elevation: 10,
        tooltip: S.of(context).addCurrentLocation,
      ),
    );
  }
}
