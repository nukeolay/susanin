import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';

abstract class LocationPointsRepository {
  Stream<Either<Failure, List<LocationPointEntity>>> get locationsStream;

  Future<void> saveLocations(List<LocationPointEntity> locations);

  // Future<void> saveLocation(LocationPointEntity locationPoint);

  // Future<void> deleteLocation(String locationName);

  // Future<void> renameLocation({
  //   required String oldLocationName,
  //   required String newLocationName,
  // });
}
