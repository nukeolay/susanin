import 'package:susanin/domain/location/entities/location_service_properties.dart';
import 'package:susanin/domain/location/entities/position.dart';

abstract class LocationServiceRepository {
  Future<Stream<PositionEntity>> get positionStream;
  Future<LocationServicePropertiesEntity> get properties;
  Future<bool> requestPermission();
  // Stream<LocationServiceStatusEntity> get locationServiceStatusStream;
}
