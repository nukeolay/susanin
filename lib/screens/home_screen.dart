import 'dart:math';
import 'package:flutter/material.dart';
import 'package:susanin/widgets/compass_accuracy_widget.dart';
import 'package:susanin/widgets/location_list_widget.dart';
import 'package:susanin/widgets/main_pointer_widget.dart';
import 'package:susanin/generated/l10n.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/alerts/info_alert.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/app_data_old.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/accuracy_gps_widget.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/point_name.dart';
import 'package:provider/provider.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/small_compass_widget.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/test_direction_widget.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/top_info_page.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/waiting_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double topWidgetHeight = width * 0.3;
    final double padding = width * 0.01;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              width: width * 0.95,
              child: LocationList(),
            ),
          ), // список локаций
          Column(
            children: [
              Container(
                height: 50,
                color: Colors.transparent,
              ),
              Container(
                height: topWidgetHeight,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: width * 0.8,
                      child: MainPointer(), // компасс сусанина
                    ),
                    Container(
                      width: width * 0.2,
                      child: CompassAccuracy(),
                    ),
                  ],
                ),
              ),
            ],
          ), // указатели
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                elevation: 5,
                child: Icon(
                  Icons.add_location_alt,
                  color: Theme.of(context).secondaryHeaderColor,
                  size: 30,
                ),
                onPressed: () {},
                tooltip: S.of(context).addCurrentLocation,
              ),
            ),
          ), // кнопки FAB
        ],
      ),
    );
  }
}
