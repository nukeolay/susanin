import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/core/usecases/usecase.dart';
import 'package:susanin/domain/location_points/repositories/repository.dart';

class UpdateLocation extends UseCaseWithArguments<Future<Either<Failure, bool>>,
    UpdateArgument> {
  final LocationPointsRepository
      _locationPointsRepository; // ! TODO implement update
  UpdateLocation(this._locationPointsRepository);
  @override
  Future<Either<Failure, bool>> call(UpdateArgument argument) async {
    final locationsOrFailure =
        await _locationPointsRepository.locationsStream.last;
    try {
      locationsOrFailure.fold((failure) {
        return Left(failure);
      }, (locations) async {
        final locationIndex = locations.indexWhere((savedLocation) =>
            savedLocation.pointName == argument.oldLocationName);
        if (locationIndex != -1) {
          return Left(LocationPointExistsFailure()); // ! TODO проверить
        } else {
          final updatedLocation = locations[locationIndex].copyWith(
            pointName: argument.newLocationName,
            latitude: argument.latitude,
            longitude: argument.longitude,
          );
          locations[locationIndex] = updatedLocation;
          await _locationPointsRepository.saveLocations(locations);
          return const Right(true);
        }
      });
    } catch (error) {
      return Left(LocationPointRenameFailure());
    }
    return const Right(true);
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
