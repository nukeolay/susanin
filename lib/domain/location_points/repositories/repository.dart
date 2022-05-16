import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';

abstract class LocationPointsRepository {
  Stream<Either<Failure, List<LocationPointEntity>>> get locationsStream;
  Either<Failure, List<LocationPointEntity>> get locationsOrFailure;
  Future<void> save(List<LocationPointEntity> locations);
  Future<void> close();
}
