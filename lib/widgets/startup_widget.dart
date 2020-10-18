import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:susanin/models/app_data.dart';
import 'package:susanin/models/gps_permission_stream.dart';
import 'package:susanin/pages/home_page.dart';
import 'package:susanin/pages/location_service_disabled.dart';
import 'package:susanin/pages/permission_denied_page.dart';

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
          StreamProvider<double>.value(
              value: FlutterCompass.events, initialData: 0.0),
          StreamProvider<Position>.value(
            value: getPositionStream(
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
