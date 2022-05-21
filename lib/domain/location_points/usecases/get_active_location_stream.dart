import 'dart:async';

import 'package:dartz/dartz.dart';

import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/core/usecases/usecase.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/domain/location_points/repositories/repository.dart';
import 'package:susanin/domain/settings/entities/settings.dart';
import 'package:susanin/domain/settings/repositories/repository.dart';

class GetActiveLocationStream
    extends UseCase<Stream<Either<Failure, LocationPointEntity>>> {
  final LocationPointsRepository _locationPointsRepository;
  final SettingsRepository _settingsRepository;
  String _activeLocationId = '';
  List<LocationPointEntity> _locations = [];

  // late final StreamSubscription<Either<Failure, List<LocationPointEntity>>>
  //     _locationsSubscription;
  // late final StreamSubscription<Either<Failure, SettingsEntity>>
  //     _settingsSubscription;

  final StreamController<Either<Failure, LocationPointEntity>>
      _streamController = StreamController.broadcast();

  GetActiveLocationStream({
    required LocationPointsRepository locationPointsRepository,
    required SettingsRepository settingsRepository,
  })  : _locationPointsRepository = locationPointsRepository,
        _settingsRepository = settingsRepository {
    _init();
  }

  void _init() {
    _settingsHandler(_settingsRepository.settingsOrFailure);
    _locationsHandler(_locationPointsRepository.locationsOrFailure);
    // _settingsSubscription =
    _settingsRepository.settingsStream.listen(_settingsHandler);
    // _locationsSubscription =
    _locationPointsRepository.locationsStream.listen(_locationsHandler);
  }

   void _settingsHandler(Either<Failure, SettingsEntity> event) {
    event.fold(
      (failure) => _streamController.add(Left(failure)),
      (settings) {
        _activeLocationId = settings.activeLocationId;
        _dispatch();
      },
    );
  }

  void _locationsHandler(Either<Failure, List<LocationPointEntity>> event) {
    event.fold(
      (failure) => _streamController.add(Left(failure)),
      (locations) {
        _locations = locations;
        _dispatch();
      },
    );
  }

  void _dispatch() {
    final index =
        _locations.indexWhere((location) => location.id == _activeLocationId);
    if (index != -1) {
      _streamController.add(Right(_locations[index]));
    }
  }

  @override
  Stream<Either<Failure, LocationPointEntity>> call() {
    return _streamController.stream;
  }
}
