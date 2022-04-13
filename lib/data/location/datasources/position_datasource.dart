import 'package:geolocator/geolocator.dart';
import 'package:susanin/core/errors/location_service/exceptions.dart' as susanin;
import 'package:susanin/data/location/models/position_model.dart';

abstract class PositionDataSource {
  Stream<PositionModel> get positionStream;
}

// class PositionDataSourceImpl implements PositionDataSource {
//   // ! TODO удалить этот класс если все получится с SinglePositionDataSourceImpl
//   final LocationSettings locationSettings = const LocationSettings(
//     accuracy: LocationAccuracy.best,
//     distanceFilter: 0,
//   );

//   @override
//   Future<Stream<PositionModel>> get positionStream async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       throw susanin.LocationServiceDisabledException();
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         throw susanin.LocationServiceDeniedException();
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       throw susanin.LocationServiceDeniedForeverException();
//     }

//     return Geolocator.getPositionStream(locationSettings: locationSettings).map(
//       (event) {
//         return PositionModel(
//           longitude: event.longitude,
//           latitude: event.latitude,
//           accuracy: event.accuracy,
//         );
//       },
//     ).handleError(
//       (error) {
//         if (error.runtimeType == LocationServiceDisabledException) {
//           throw susanin.LocationServiceDisabledException();
//         } else if (error.runtimeType == PermissionDeniedException) {
//           throw susanin.LocationServiceDeniedException();
//         } else {
//           throw susanin.LocationServiceException();
//         }
//       },
//     );
//   }
// }

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
      //   throw susanin.LocationServiceDisabledException();
      // }
      // permission = await Geolocator.checkPermission();
      // if (permission == LocationPermission.denied) {
      //   permission = await Geolocator.requestPermission();
      //   if (permission == LocationPermission.denied) {
      //     throw susanin.LocationServiceDeniedException();
      //   }
      // }
      // if (permission == LocationPermission.deniedForever) {
      //   throw susanin.LocationServiceDeniedForeverException();
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
