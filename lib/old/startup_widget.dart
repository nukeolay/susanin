import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:susanin/old/app_data_old.dart';
import 'package:susanin/old/models/gps_permission_stream.dart';
import 'package:susanin/old/pages/home_page.dart';
import 'package:susanin/old/pages/location_service_disabled.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/pages/permission_denied_page.dart';

class StartUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //если разрешение на получение геолокации не выдано то будет эта страница
    if (context.watch<PermissionGPS>() == PermissionGPS.off) {
      return PermissionDeniedPage();
    } else if (context.watch<StatusGPS>() == StatusGPS.off) {
      //если во время навигации отключить GPS, то будет эта страница
      return LocationServiceDisabled();
    } else {
      ApplicationData applicationData = new ApplicationData();
      applicationData.loadPrefs();
      return MultiProvider(
        providers: [
          StreamProvider<CompassEvent>.value(
              value: FlutterCompass.events, initialData: CompassEvent.fromList([0.0, 0.0, 0.0])),
          StreamProvider<Position>.value(
            value: Geolocator.getPositionStream(
                desiredAccuracy: LocationAccuracy.bestForNavigation,
                distanceFilter: 0),
            catchError: (_, __) => null,
          ),
          ChangeNotifierProvider<ApplicationData>.value(value: applicationData),
        ],
        child: HomePage(),
      );
    }
  }
}