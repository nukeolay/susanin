import 'package:susanin/data/location/datasources/permission_data_source.dart';
import 'package:susanin/data/location/datasources/position_data_source.dart';
import 'package:susanin/data/location/models/permission_model.dart';
import 'package:susanin/domain/location/entities/permission.dart';
import 'package:susanin/domain/location/entities/position.dart';
import 'package:susanin/domain/location/repositories/repository.dart';

class PositionRepositoryImpl implements PositionRepository {
  final PositionDataSource positionDataSource;
  final PermissionDataSource permissionDataSource;

  PositionRepositoryImpl({
    required this.positionDataSource,
    required this.permissionDataSource,
  });

  @override
  Stream<PositionEntity> get positionStream {
    try {
      return positionDataSource.positionStream.map(
        (event) => PositionEntity(
          longitude: event.longitude,
          latitude: event.latitude,
          accuracy: event.accuracy,
        ),
      );
    } catch (error) {
      // ! TODO узнать какая ошибка появляется если не выдано разрешение при первом старте и какая ошибка появляется если пользователь отказал в выдвче разрешения
      print(error);
      throw error;
    }
  }

  @override
  Future<PermissionEntity> requestPermission() async {
    PermissionModel permission = await permissionDataSource.requestPermission();
    return PermissionEntity(permission.isPermissionGranted);
  }

  // @override
  // Stream<LocationServiceStatusEntity> get locationServiceStatusStream {
  //   return locationServiceStatusDataSource.locationServiceStatusStream.map(
  //     (event) => LocationServiceStatusEntity(
  //       isLocationServiceEnabled: event.isLocationServiceEnabled,
  //     ),
  //   );
  // }
}
