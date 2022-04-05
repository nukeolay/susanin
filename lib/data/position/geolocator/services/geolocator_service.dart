import 'package:geolocator/geolocator.dart';
import 'package:susanin/data/position/errors/errors.dart';
import 'package:susanin/data/position/geolocator/model/position_geolocator_model.dart';

// class GeolocatorService {
//   Future<PositionGeolocatorModel> load() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     print('!!!!!!!!!!!!!!!!!!!!!!!!');
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       print('LocationServiceDisabledError');
//       throw LocationServiceDisabledError();
//     }
//     print('serviceEnabled: $serviceEnabled');

//     permission = await Geolocator.checkPermission();
//     print('permission: ${permission.name}');
//     Geolocator.getPositionStream();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator
//           .requestPermission(); // ! TODO запрашиваю разрешение, лучше это делать в UI (кидать исключение и в UI его обрабатывать)
//       if (permission == LocationPermission.denied) {
//         print('LocationServicePermissonError');
//         throw LocationServicePermissonError();
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       print('LocationServicePermissonError');
//       throw LocationServicePermissonError();
//     }

//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.best,
//     );
//     print('1: ${position.longitude}, 2: ${position.latitude}');
//     return PositionGeolocatorModel(
//       longitude: position.longitude,
//       latitude: position.latitude,
//       accuracy: position.accuracy,
//     );
//   }
// }

class GeolocatorService {
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: 1,
  );

  Stream<PositionGeolocatorModel> load() {
    return Geolocator.getPositionStream(locationSettings: locationSettings).map(
      (event) => PositionGeolocatorModel.fromGeolocator(event),
    );
  }
}
