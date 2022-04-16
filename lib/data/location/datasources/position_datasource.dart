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
    // timeLimit: Duration(microseconds: 5000),
  );

  @override
  Stream<PositionModel> get positionStream {
    // while (true) {
    //   await Future.delayed(const Duration(milliseconds: 1000));
    //   try {
    //     var temp = await Geolocator.getCurrentPosition();
    //     yield PositionModel(
    //       longitude: temp.longitude,
    //       latitude: temp.latitude,
    //       accuracy: temp.accuracy,
    //     );
    //   } catch (error) {
    //     rethrow;
    //   }
    // }

    return Geolocator.getPositionStream(locationSettings: locationSettings).map(
      (event) {
        print('|||||||EVENT: $event');
        Geolocator.checkPermission;
        return PositionModel(
          longitude: event.longitude,
          latitude: event.latitude,
          accuracy: event.accuracy,
        );
      },
    ).handleError(
      (error) {
        print(
            'Data source error: $error'); // ! TODO тут не всегда появляется ошибка, она идет другим маршрутом?
        if (error.runtimeType == LocationServiceDisabledException) {
          throw susanin.LocationServiceDisabledException();
        } else if (error.runtimeType == PermissionDeniedException) {
          throw susanin.LocationServiceDeniedException();
        } else {
          throw susanin.LocationServiceException();
        }
      },
    );
  }

  // Stream<Position> _geolocatorStream = Geolocator.getPositionStream();
  // await for (Position position in _geolocatorStream) {
  //   yield PositionModel(
  //     longitude: position.longitude,
  //     latitude: position.latitude,
  //     accuracy: position.accuracy,
  //   );
  // }
}
