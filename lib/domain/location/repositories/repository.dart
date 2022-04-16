import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/location_service/failure.dart';
import 'package:susanin/domain/location/entities/location_service_properties.dart';
import 'package:susanin/domain/location/entities/position.dart';

abstract class LocationServiceRepository {
  Stream<Either<Failure, PositionEntity>> get positionStream;
  // Future<Either<Failure, PositionEntity>> get position;
  Future<LocationServicePropertiesEntity> get properties;
  Future<bool> requestPermission();
}
