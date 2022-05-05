import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/core/usecases/usecase.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/domain/location_points/repositories/repository.dart';
import 'package:susanin/domain/settings/usecases/set_active_location.dart';

class AddLocation extends UseCaseWithArguments<
    Future<Either<Failure, LocationPointEntity>>, LocationArgument> {
  final LocationPointsRepository _locationPointsRepository;
  final SetActiveLocation _setActiveLocation;
  AddLocation({
    required LocationPointsRepository locationPointsRepository,
    required SetActiveLocation setActiveLocation,
  })  : _locationPointsRepository = locationPointsRepository,
        _setActiveLocation = setActiveLocation;

  @override
  Future<Either<Failure, LocationPointEntity>> call(
      LocationArgument argument) async {
    final locationsOrFailure = _locationPointsRepository.locationsOrFailure;
    if (locationsOrFailure.isRight()) {
      try {
        final locations = locationsOrFailure.getOrElse(() => []);
        final newLocation = LocationPointEntity(
          id: 'id_${DateTime.now()}',
          latitude: argument.latitude,
          longitude: argument.longitude,
          name: argument.name,
          creationTime: DateTime.now(),
        );
        locations.add(newLocation);
        await _locationPointsRepository.save(locations);
        await _setActiveLocation(newLocation.id);
        return Right(newLocation);
      } catch (error) {
        return Left(LoadLocationPointsFailure());
      }
    } else {
      return Left(LoadLocationPointsFailure());
    }
  }
}

class LocationArgument {
  final double longitude;
  final double latitude;
  final String name;

  LocationArgument({
    required this.longitude,
    required this.latitude,
    required this.name,
  });
}
