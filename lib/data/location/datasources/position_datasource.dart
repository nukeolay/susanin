import 'package:geolocator/geolocator.dart';
import 'package:susanin/core/errors/location_errors.dart';
import 'package:susanin/data/location/models/position_model.dart';

abstract class PositionDataSource {
  Stream<PositionModel> get positionStream;
}

class PositionDataSourceImpl implements PositionDataSource {
  // ! TODO удалить этот класс если все получится с SinglePositionDataSourceImpl
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: 0,
  );

  @override
  Stream<PositionModel> get positionStream {
    // bool serviceEnabled;
    // LocationPermission permission;
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   throw LocationServiceDisabledError();
    // }
    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     throw LocationServicePermissionDeniedError();
    //   }
    // }
    // if (permission == LocationPermission.deniedForever) {
    //   throw LocationServicePermissionDeniedForeverError();
    // }

    return Geolocator.getPositionStream(locationSettings: locationSettings).map(
      (event) {
        return PositionModel(
          longitude: event.longitude,
          latitude: event.latitude,
          accuracy: event.accuracy,
        );
      },
    ).handleError(
      (error) {
        print('ERROR');
        if (error.runtimeType == LocationServiceDisabledException) {
          print('LocationServiceDisabledError');
          throw LocationServiceDisabledError();
        } else if (error.runtimeType == PermissionDeniedException) {
          print('LocationServicePermissionDeniedError');
          throw LocationServicePermissionDeniedError();
        } else {
          print('LocationServiceError');
          throw LocationServiceError();
        }
      },
    );
  }
}

class SinglePositionDataSourceImpl implements PositionDataSource {
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: 0,
  );

  @override
  Stream<PositionModel> get positionStream async* {
    // bool serviceEnabled;
    // LocationPermission permission;

    while (true) {
      await Future.delayed(const Duration(milliseconds: 1000));
      // serviceEnabled = await Geolocator.isLocationServiceEnabled();
      // if (!serviceEnabled) {
      //   throw LocationServiceDisabledError();
      // }
      // permission = await Geolocator.checkPermission();
      // if (permission == LocationPermission.denied) {
      //   permission = await Geolocator.requestPermission();
      //   if (permission == LocationPermission.denied) {
      //     throw LocationServicePermissionDeniedError();
      //   }
      // }
      // if (permission == LocationPermission.deniedForever) {
      //   throw LocationServicePermissionDeniedForeverError();
      // }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      yield PositionModel(
        longitude: position.longitude,
        latitude: position.latitude,
        accuracy: position.accuracy,
      );
    }
  }
}
