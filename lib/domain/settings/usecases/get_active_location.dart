import 'package:dartz/dartz.dart';

import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/core/usecases/usecase.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/domain/location_points/repositories/repository.dart';
import 'package:susanin/domain/settings/repositories/repository.dart';

class GetActiveLocation extends UseCase<Either<Failure, LocationPointEntity>> {
  final LocationPointsRepository _locationPointsRepository;
  final SettingsRepository _settingsRepository;

  GetActiveLocation({
    required LocationPointsRepository locationPointsRepository,
    required SettingsRepository settingsRepository,
  })  : _locationPointsRepository = locationPointsRepository,
        _settingsRepository = settingsRepository;

  @override
  Either<Failure, LocationPointEntity> call() {
    late final String _activeLocationId;
    late final List<LocationPointEntity> _locations;
    _settingsRepository.settingsOrFailure.fold(
      (failure) => Left(failure),
      (settings) => _activeLocationId = settings.activeLocationId,
    );
    _locationPointsRepository.locationsOrFailure.fold(
      (failure) => Left(failure),
      (locations) => _locations = locations,
    );
    final index =
        _locations.indexWhere((location) => location.id == _activeLocationId);
    if (index != -1) {
      return Right(_locations[index]);
    } else {
      return Left(ActiveLocationEmptyFailure());
    }
  }
}
