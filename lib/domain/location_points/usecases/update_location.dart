import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/core/usecases/usecase.dart';
import 'package:susanin/domain/location_points/repositories/repository.dart';

class UpdateLocation extends UseCaseWithArguments<Future<Either<Failure, bool>>,
    UpdateArgument> {
  final LocationPointsRepository _locationPointsRepository;
  UpdateLocation(this._locationPointsRepository);
  @override
  Future<Either<Failure, bool>> call(UpdateArgument argument) async {
    final locationsOrFailure = _locationPointsRepository.locationsOrFailure;
    if (locationsOrFailure.isRight()) {
      final locations = locationsOrFailure.getOrElse(() => []);
      final oldLocationIndex = locations.indexWhere((savedLocation) =>
          savedLocation.pointName == argument.oldLocationName);
      final newLocationIndex = locations.indexWhere((savedLocation) =>
          savedLocation.pointName == argument.newLocationName);
      if (oldLocationIndex != newLocationIndex && newLocationIndex != -1) {
        return Left(LocationPointExistsFailure());
      } else {
        final updatedLocation = locations[oldLocationIndex].copyWith(
          pointName: argument.newLocationName,
          latitude: argument.latitude,
          longitude: argument.longitude,
        );
        locations[oldLocationIndex] = updatedLocation;
        await _locationPointsRepository.saveLocations(locations);
        return const Right(true);
      }
    } else {
      return Left(LoadLocationPointsFailure());
    }
  }
}

class UpdateArgument {
  final String oldLocationName;
  final String newLocationName;
  final double longitude;
  final double latitude;

  UpdateArgument({
    required this.oldLocationName,
    required this.newLocationName,
    required this.longitude,
    required this.latitude,
  });
}
