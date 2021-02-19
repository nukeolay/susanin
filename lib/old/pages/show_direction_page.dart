import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/app_data_old.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/accuracy_gps_widget.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/presentation/widgets/location_list_widget.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/point_name.dart';
import 'package:provider/provider.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/small_compass_widget.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/test_direction_widget.dart';
import 'package:susanin/generated/l10n.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/top_info_page.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/waiting_widget.dart';

class ShowDirectionPage extends StatelessWidget {
  String showDistance(BuildContext context, double distance) {
    if (distance < 5)
      return S.of(context).lessThan5Metres;
    else if (distance < 1000)
      return "${distance.toStringAsFixed(0)} ${S.of(context).metres}";
    else
      return "${(distance / 1000).toStringAsFixed(0)} ${S.of(context).kilometres}";
  }

  Widget topBlock(
      BuildContext context, double distance, double resultDirection) {
    try {
      if (!context.watch<ApplicationData>().loaded) {
        return Center(child: WaitingWidget("not loaded"));
      } else if (context
          .watch<ApplicationData>()
          .getLocationPointListStorage
          .isEmpty) {
        return Card(
          elevation: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TopInfoPage(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).warningPleasePress,
                      style: TextStyle(fontSize: 20)),
                  CircleAvatar(
                      child: Icon(Icons.add_location_alt,
                          color: Colors.white),
                      radius: 20.0,
                      backgroundColor: Colors.green),
                ],
              ),
              Text(
                S.of(context).warningToSaveLocation,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 6.0, bottom: 70.0),
                child: Text(
                  S.of(context).warningInstruction,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 18, color: Colors.black),
                ),
              ),
            ],
          ),
        );
      } else if (context.watch<Position>() == null) {
        return WaitingWidget("Position is null");
      } else {
        return Card(
          elevation: 1,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallCompassWidget(),
                  AccuracyGpsWidget(),
                ],
              ),
              showDirection(distance, resultDirection),
              SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    showDistance(context, distance),
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.green),
                  ),
                  PointName(),
                ],
              ),
            ],
          ),
        );
      }
    } catch (e) {
      return Center(child: WaitingWidget("catched error $e"));
    }
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
    double result = 0.0; //обнулил на случай если в блоке try окажется, что нет сохраненных локаций
    double distance = 0.0;
    try {
      double _bearing = -Geolocator.bearingBetween(
          _position.latitude,
          _position.longitude,
          _applicationData.getLocationPoint.pointLatitude,
          _applicationData.getLocationPoint.pointLongitude);
      result = _compassDirection + _bearing;
      distance = Geolocator.distanceBetween(
          _position.latitude,
          _position.longitude,
          _applicationData.getLocationPoint.pointLatitude,
          _applicationData.getLocationPoint.pointLongitude);
    }
    catch(e) {
      print("Error: no locations");
    }

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
                    topBlock(context, distance, result),
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
