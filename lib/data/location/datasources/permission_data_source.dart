import 'package:geolocator/geolocator.dart';
import 'package:susanin/data/location/models/permission_model.dart';

abstract class PermissionDataSource {
  Future<PermissionModel> requestPermission();
}

class PermissionDataSourceImpl implements PermissionDataSource {
  @override
  Future<PermissionModel> requestPermission() async {
    print('Request Permission');
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return PermissionModel(true);
    } else {
      return PermissionModel(false);
    }
  }
}
