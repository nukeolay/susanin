import 'package:geolocator/geolocator.dart';
import 'package:susanin/core/errors/location_service/exceptions.dart'
    as susanin;
import 'package:susanin/data/location/models/position_model.dart';

abstract class PositionDataSource {
  Stream<PositionModel> get positionStream;
}

class PositionDataSourceImpl implements PositionDataSource {
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: 0,
  );

  @override
  Stream<PositionModel> get positionStream async* {
    bool serviceEnabled;
    LocationPermission permission;
    while (true) {
      await Future.delayed(const Duration(milliseconds: 1000));
      try {
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          throw const LocationServiceDisabledException();
        }
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          throw const PermissionDeniedException(null);
        }

        Position position = await Geolocator.getCurrentPosition();
        yield PositionModel(
          longitude: position.longitude,
          latitude: position.latitude,
          accuracy: position.accuracy,
        );
      } on LocationServiceDisabledException {
        throw susanin.LocationServiceDisabledException();
      } on PermissionDeniedException {
        throw susanin.LocationServiceDeniedException();
      } catch (error) {
        throw susanin.LocationServiceException();
      }
    }
  }
}
