import 'package:dartz/dartz.dart';

import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/core/usecases/usecase.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/domain/location_points/repositories/repository.dart';

class GetLocations
    extends UseCase<Stream<Either<Failure, List<LocationPointEntity>>>> {
  final LocationPointsRepository _locationPointsRepository;
  GetLocations(this._locationPointsRepository);
  @override
  Stream<Either<Failure, List<LocationPointEntity>>> call() {
    return _locationPointsRepository.locationsStream;
  }
}
