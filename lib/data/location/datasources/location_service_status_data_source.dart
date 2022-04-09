// import 'package:geolocator/geolocator.dart';
// import 'package:susanin/data/location/models/location_service_status_model.dart';

// abstract class LocationServiceStatusDataSource {
//   Stream<LocationServiceStatusModel> get locationServiceStatusStream;
// }

// class LocationServiceStatusDataSourceImpl
//     implements LocationServiceStatusDataSource {
//   @override
//   Stream<LocationServiceStatusModel> get locationServiceStatusStream {
//     return Geolocator.getServiceStatusStream().map((event) {
//       if (event == ServiceStatus.disabled) {
//         return const LocationServiceStatusModel(
//           isLocationServiceEnabled: false,
//         );
//       } else {
//         return const LocationServiceStatusModel(
//           isLocationServiceEnabled: true,
//         );
//       }
//     });
//   }
// }
