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
      final index = locations
          .indexWhere((savedLocation) => savedLocation.id == argument.id);
      if (index == -1) {
        return Left(LocationPointUpdateFailure());
      } else {
        locations[index] = locations[index].copyWith(
          name: argument.newLocationName,
          latitude: argument.latitude,
          longitude: argument.longitude,
        );
        await _locationPointsRepository.save(locations);
        return const Right(true);
      }
    } else {
      return Left(LoadLocationPointsFailure());
    }
  }
}

class UpdateArgument {
  final String id;
  final String newLocationName;
  final double longitude;
  final double latitude;

  UpdateArgument({
    required this.id,
    required this.newLocationName,
    required this.longitude,
    required this.latitude,
  });
}
