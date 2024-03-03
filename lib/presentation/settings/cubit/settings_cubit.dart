import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/compass/domain/entities/compass.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';
import 'package:susanin/features/location/domain/entities/position.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/location/domain/use_cases/request_permission.dart';
import 'package:susanin/features/wakelock/domain/entities/wakelock_status.dart';
import 'package:susanin/features/wakelock/domain/use_cases/get_wakelock_status.dart';
import 'package:susanin/features/wakelock/domain/use_cases/toggle_wakelock.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required LocationRepository locationRepository,
    required CompassRepository compassRepository,
    required RequestPermission requestPermission,
    required GetWakelockStatus getWakelockStatus,
    required ToggleWakelock toggleWakelock,
  })  : _locationRepository = locationRepository,
        _compassRepository = compassRepository,
        _requestPermission = requestPermission,
        _getWakelockStatus = getWakelockStatus,
        _toggleWakelock = toggleWakelock,
        super(SettingsState.initial) {
    _init();
  }

  final LocationRepository _locationRepository;
  final CompassRepository _compassRepository;
  final RequestPermission _requestPermission;
  final GetWakelockStatus _getWakelockStatus;
  final ToggleWakelock _toggleWakelock;
  StreamSubscription<CompassEntity>? _compassSubscription;
  StreamSubscription<PositionEntity>? _positionSubscription;

  void _init() {
    _updateWakelockStatus();
    _compassSubscription =
        _compassRepository.compassStream.listen(_compassEventHandler);
    _positionSubscription =
        _locationRepository.positionStream.listen(_positionEventHandler);
  }

  void _compassEventHandler(CompassEntity entity) {
    emit(state.copyWith(compassStatus: entity.status));
  }

  void _positionEventHandler(PositionEntity entity) {
    emit(state.copyWith(locationServiceStatus: entity.status));
  }

  Future<void> getPermission() async {
    final status = await _requestPermission(const NoParams());
    emit(state.copyWith(locationServiceStatus: status));
  }

  Future<void> toggleWakelock() async {
    await _toggleWakelock(const NoParams());
    await _updateWakelockStatus();
  }

  Future<void> _updateWakelockStatus() async {
    final wakelockStatus = await _getWakelockStatus(const NoParams());
    emit(state.copyWith(isScreenAlwaysOn: wakelockStatus.isEnabled));
  }

  @override
  Future<void> close() async {
    await _compassSubscription?.cancel();
    await _positionSubscription?.cancel();
    super.close();
  }
}
