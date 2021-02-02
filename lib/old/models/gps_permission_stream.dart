import 'package:geolocator/geolocator.dart';

enum PermissionGPS {
  on,
  off,
}

enum StatusGPS {
  on,
  off,
}

Stream<PermissionGPS> getPermissionGPS() async* {
  while (true) {
    await Future.delayed(Duration(seconds: 1));
    var locationPermission = await checkPermission();
    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      yield PermissionGPS.off;
    } else {
      yield PermissionGPS.on;
    }
  }
}

Stream<StatusGPS> getStatusGPS() async* {
  while (true) {
    await Future.delayed(Duration(seconds: 1));
    var locationService = await isLocationServiceEnabled();
    if (!locationService) {
      yield StatusGPS.off;
    } else {
      yield StatusGPS.on;
    }
  }
}
