import 'package:dartz/dartz.dart';

import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/domain/location_points/repositories/repository.dart';
import 'package:susanin/data/location_points/datasources/location_points_data_source.dart';

class LocationPointsRepositoryImpl extends LocationPointsRepository {
  final LocationPointDataSource locationPointDataSource;

  LocationPointsRepositoryImpl(this.locationPointDataSource);

  @override
  Future<Either<Failure, List<LocationPointEntity>>> get locations async {
    try {
      return Right(
          await locationPointDataSource.loadLocationsFromLocalStorage());
    } catch (error) {
      return Left(LoadLocationPointsFailure());
    }
  }

  @override
  Future<void> saveLocations(List<LocationPointEntity> locations) async {
    await locationPointDataSource.saveLocationsToLocalStorage(locations);
  }
}
