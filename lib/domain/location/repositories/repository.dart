import 'package:susanin/domain/location/entities/permission.dart';
import 'package:susanin/domain/location/entities/position.dart';

abstract class PositionRepository {
  Stream<PositionEntity> get positionStream;
  Future<PermissionEntity> requestPermission();
  // Stream<LocationServiceStatusEntity> get locationServiceStatusStream;
}
