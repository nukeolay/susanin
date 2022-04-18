import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';

abstract class LocationPointsRepository {
  Future<Either<Failure, List<LocationPointEntity>>> get locations;

  Future<void> saveLocations(List<LocationPointEntity> locations);
}
