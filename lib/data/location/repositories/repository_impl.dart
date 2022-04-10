import 'package:susanin/data/location/datasources/location_service_properties_datasource.dart';
import 'package:susanin/data/location/datasources/position_datasource.dart';
import 'package:susanin/domain/location/entities/location_service_properties.dart';
import 'package:susanin/domain/location/entities/position.dart';
import 'package:susanin/domain/location/repositories/repository.dart';

class LocationServiceRepositoryImpl implements LocationServiceRepository {
  final PositionDataSource positionDataSource;
  final LocationServicePropertiesDataSource propertiesDataSource;

  LocationServiceRepositoryImpl({
    required this.positionDataSource,
    required this.propertiesDataSource,
  });

  @override
  Stream<PositionEntity> get positionStream {
    return positionDataSource.positionStream.map(
      (event) => PositionEntity(
        longitude: event.longitude,
        latitude: event.latitude,
        accuracy: event.accuracy,
      ),
    );
  }

  @override
  Future<bool> requestPermission() {
    return propertiesDataSource.requestPermission();
  }

  @override
  Future<LocationServicePropertiesEntity> get properties async {
    final _properties = await propertiesDataSource.properties;
    return LocationServicePropertiesEntity(
        isPermissionGranted: _properties.isPermissionGranted,
        isEnabled: _properties.isEnabled);
  }
}
