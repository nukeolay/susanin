import 'package:geolocator/geolocator.dart';
import 'package:susanin/data/location/errors/errors.dart';
import 'package:susanin/data/location/models/position_model.dart';

abstract class PositionDataSource {
  Stream<PositionModel> get positionStream;
}

class PositionDataSourceImpl implements PositionDataSource {
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: 1,
  );

  @override
  Stream<PositionModel> get positionStream {
    // bool serviceEnabled;
    // LocationPermission permission;
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   print('LocationServiceDisabledError');
    //   throw LocationServiceDisabledError();
    // }
    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator
    //       .requestPermission(); // ! TODO запрашиваю разрешение, лучше кидать исключение и в UI его обрабатывать
    //   if (permission == LocationPermission.denied) {
    //     throw LocationServicePermissionError();
    //   }
    // }
    // if (permission == LocationPermission.deniedForever) {
    //   throw LocationServicePermissionError();
    // }

    try {
      return Geolocator.getPositionStream(locationSettings: locationSettings)
          .map(
        (event) => PositionModel(
          longitude: event.longitude,
          latitude: event.latitude,
          accuracy: event.accuracy,
        ),
      );
    } catch (error) {
      throw LocationServiceError();
    }
  }
}
