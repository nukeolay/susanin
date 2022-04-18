import 'package:dartz/dartz.dart';

import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/core/usecases/usecase.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/domain/location_points/repositories/repository.dart';

class LoadLocations
    extends UseCase<Future<Either<Failure, List<LocationPointEntity>>>> {
  final LocationPointsRepository _locationPointsRepository;
  LoadLocations(this._locationPointsRepository);
  @override
  Future<Either<Failure, List<LocationPointEntity>>> call() async {
    return await _locationPointsRepository.locations;
  }
}
