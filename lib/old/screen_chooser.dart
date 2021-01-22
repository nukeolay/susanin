import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/app_data_old.dart';
import 'package:susanin/pages/no_location_page.dart';
import 'package:susanin/pages/show_direction_page.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/waiting_widget.dart';

class ScreenChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!context
        .watch<ApplicationData>()
        .loaded) {
      return Center(child: WaitingWidget("not loaded"));
    } else {
      try {
        if (context
            .watch<ApplicationData>()
            .getLocationPointListStorage
            .isEmpty) {
          return NoLocationPage();
        } else {
          context
              .watch<Position>().latitude;
          return ShowDirectionPage();
        }
      } catch (e) {
        return Center(child: WaitingWidget(e));
      }
    }
  }
}
