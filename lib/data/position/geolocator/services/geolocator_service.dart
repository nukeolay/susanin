import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  final GeolocatorPlatform _geolocator;

  GeolocatorService(this._geolocator);

  final LocationSettings _locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: 0,
  );

  Future<Position> load() async {
    return await _geolocator.getCurrentPosition(
        locationSettings: _locationSettings);
  }
}
