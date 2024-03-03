import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/compass/domain/entities/compass.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';
import 'package:susanin/features/location/domain/entities/position.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/places/domain/entities/place.dart';
import 'package:susanin/core/mixins/pointer_calculations.dart';
import 'package:susanin/features/wakelock/domain/entities/wakelock_status.dart';
import 'package:susanin/features/wakelock/domain/repositories/wakelock_repository.dart';
import 'package:susanin/features/wakelock/domain/use_cases/toggle_wakelock.dart';

part 'detailed_info_state.dart';

class DetailedInfoCubit extends Cubit<DetailedInfoState> {
  DetailedInfoCubit({
    required LocationRepository locationRepository,
    required CompassRepository compassRepository,
    required WakelockRepository wakelockRepository,
    required ToggleWakelock toggleWakelock,
    required PlaceEntity place,
  })  : _locationRepository = locationRepository,
        _compassRepository = compassRepository,
        _wakelockRepository = wakelockRepository,
        _toggleWakelock = toggleWakelock,
        super(DetailedInfoState.initial(place)) {
    _init();
  }

  final LocationRepository _locationRepository;
  final CompassRepository _compassRepository;
  final WakelockRepository _wakelockRepository;
  final ToggleWakelock _toggleWakelock;

  StreamSubscription<PositionEntity>? _positionSubscription;
  StreamSubscription<CompassEntity>? _compassSubscription;

  void _init() {
    _updateWakelockStatus();
    _positionSubscription =
        _locationRepository.positionStream.listen(_positionEventHandler);
    _compassSubscription =
        _compassRepository.compassStream.listen(_compassEventHandler);
  }

  void _positionEventHandler(PositionEntity entity) {
    emit(state.copyWith(
      locationServiceStatus: entity.status,
      userLatitude: entity.latitude,
      userLongitude: entity.longitude,
      accuracy: entity.accuracy,
    ));
  }

  void _compassEventHandler(CompassEntity entity) {
    emit(state.copyWith(
      hasCompass: entity.status.isSuccess ? true : false,
      compassNorth: entity.north,
    ));
  }

  Future<void> toggleWakelock() async {
    await _toggleWakelock(const NoParams());
    await _updateWakelockStatus();
  }

  Future<void> _updateWakelockStatus() async {
    final wakelockStatus = await _wakelockRepository.wakelockStatus;
    emit(state.copyWith(isScreenAlwaysOn: wakelockStatus.isEnabled));
  }

  @override
  Future<void> close() async {
    await _positionSubscription?.cancel();
    await _compassSubscription?.cancel();
    super.close();
  }
}
