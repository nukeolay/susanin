import 'package:geolocator/geolocator.dart';
import 'package:susanin/data/location/models/location_service_properties_model.dart';

abstract class LocationServicePropertiesDataSource {
  Future<bool> requestPermission();
  Future<LocationServicePropertiesModel> get properties;
}

class LocationServicePropertiesDataSourceImpl
    implements LocationServicePropertiesDataSource {
  @override
  Future<bool> requestPermission() async {
    final LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<LocationServicePropertiesModel> get properties async {
    final bool isPermissionGranted;
    final LocationPermission permission = await Geolocator.checkPermission();
    final bool isEnabled = await Geolocator.isLocationServiceEnabled();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      isPermissionGranted = true;
    } else {
      isPermissionGranted = false;
    }
    return LocationServicePropertiesModel(
      isPermissionGranted: isPermissionGranted,
      isEnabled: isEnabled,
    );
  }
}
