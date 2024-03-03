import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/compass/domain/entities/compass.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';
import 'package:susanin/features/location/domain/entities/position.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/settings/domain/use_cases/get_settings.dart';
import 'package:susanin/core/mixins/pointer_calculations.dart';

part 'demo_pointer_state.dart';

class DemoPointerCubit extends Cubit<DemoPointerState> {
  DemoPointerCubit({
    required GetSettings getSettings,
    required LocationRepository locationRepository,
    required CompassRepository compassRepository,
  })  : _getSettings = getSettings,
        _locationRepository = locationRepository,
        _compassRepository = compassRepository,
        super(DemoPointerState.initial) {
    _init();
  }

  final GetSettings _getSettings;
  final LocationRepository _locationRepository;
  final CompassRepository _compassRepository;

  StreamSubscription<PositionEntity>? _positionSubscription;
  StreamSubscription<CompassEntity>? _compassSubscription;

  void _init() {
    final settings = _getSettings(const NoParams());
    emit(state.copyWith(isFirstTime: settings.isFirstTime));
    _positionSubscription =
        _locationRepository.positionStream.listen(_positionEventHandler);
    _compassSubscription =
        _compassRepository.compassStream.listen(_compassEventHandler);
  }

  @override
  Future<void> close() async {
    await _positionSubscription?.cancel();
    await _compassSubscription?.cancel();
    return super.close();
  }

  void _compassEventHandler(CompassEntity entity) {
    emit(state.copyWith(
      hasCompass: entity.status.isSuccess ? true : false,
      compassNorth: entity.north,
    ));
  }

  void _positionEventHandler(PositionEntity entity) {
    emit(state.copyWith(
      locationServiceStatus: entity.status,
      userLatitude: entity.latitude,
      userLongitude: entity.longitude,
      accuracy: entity.accuracy,
    ));
  }
}
