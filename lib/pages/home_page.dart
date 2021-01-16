import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/app_data_old.dart';
import 'package:provider/provider.dart';
import 'package:susanin/pages/show_direction_page.dart';
import 'package:susanin/widgets/waiting_widget.dart';

import 'no_location_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    try {
      if (!context.watch<ApplicationData>().loaded) {
        return Center(child: WaitingWidget("not loaded"));
      } else if (context.watch<Position>() == null) {
        return WaitingWidget("Position is null");
      } else {
        return ShowDirectionPage();
      }
    } catch (e) {
      return Center(child: WaitingWidget("catched error $e"));
    }
  }
}
