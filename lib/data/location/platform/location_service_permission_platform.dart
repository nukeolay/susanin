import 'package:geolocator/geolocator.dart';

abstract class LocationServicePermissionPlatform {
  Future<bool> requestPermission();
}

class LocationServicePropertiesPlatformImpl
    implements LocationServicePermissionPlatform {
  @override
  Future<bool> requestPermission() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }
}
