import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/location_service/failure.dart';
import 'package:susanin/domain/location/entities/location_service_properties.dart';
import 'package:susanin/domain/location/entities/position.dart';

abstract class LocationServiceRepository {
  Either<Failure, Stream<PositionEntity>> get positionStream;
  Future<LocationServicePropertiesEntity> get properties;
  Future<bool> requestPermission();
}
