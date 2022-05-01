import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/core/usecases/usecase.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/domain/location_points/repositories/repository.dart';

class AddLocation extends UseCaseWithArguments<Future<Either<Failure, bool>>,
    LocationArgument> {
  final LocationPointsRepository _locationPointsRepository;
  AddLocation(this._locationPointsRepository);

  @override
  Future<Either<Failure, bool>> call(LocationArgument argument) async {
    final locationsOrFailure = _locationPointsRepository.locationsOrFailure;
    if (locationsOrFailure.isRight()) {
      final locations = locationsOrFailure.getOrElse(() => []);
      final locationIndex = locations.indexWhere(
          (savedLocation) => savedLocation.pointName == argument.pointName);
      if (locationIndex != -1) {
        return Left(LocationPointExistsFailure());
      } else {
        final newLocation = LocationPointEntity(
          latitude: argument.latitude,
          longitude: argument.longitude,
          pointName: argument.pointName,
          creationTime: DateTime.now(),
        );
        locations.add(newLocation);
        await _locationPointsRepository.saveLocations(locations);
        return const Right(true);
      }
    } else {
      return Left(LoadLocationPointsFailure());
    }
  }
}

class LocationArgument {
  final double longitude;
  final double latitude;
  final String pointName;

  LocationArgument({
    required this.longitude,
    required this.latitude,
    required this.pointName,
  });
}
