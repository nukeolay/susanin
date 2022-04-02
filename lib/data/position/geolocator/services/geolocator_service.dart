import 'package:geolocator/geolocator.dart';
import 'package:susanin/data/position/errors/errors.dart';
import 'package:susanin/data/position/geolocator/model/position_geolocator_model.dart';

class GeolocatorService {
  final GeolocatorPlatform _geolocator;

  GeolocatorService(this._geolocator);

  final LocationSettings _locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: 0,
  );

  Future<PositionGeolocatorModel> load() async {
    try {
      Position position = await _geolocator.getCurrentPosition(
        locationSettings: _locationSettings,
      );
      return PositionGeolocatorModel(
        longitude: position.longitude,
        latitude: position.latitude,
        accuracy: position.accuracy,
      );
    } catch (error) {
      // ! TODO тут ловить все исключения и переделывать в мои GpsOff и GpsPermisson
      throw GpsOffError();
    }
  }
}
