import 'package:geolocator/geolocator.dart';

abstract class PermissionService {
  Future<bool> requestPermission();
  Future<bool> checkPermission();
}

class PermissionServiceImpl implements PermissionService {
  const PermissionServiceImpl();

  bool _isGranted(LocationPermission permission) {
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> requestPermission() async {
    final permission = await Geolocator.requestPermission();
    return _isGranted(permission);
  }

  @override
  Future<bool> checkPermission() async {
    final permission = await Geolocator.checkPermission();
    return _isGranted(permission);
  }
}
