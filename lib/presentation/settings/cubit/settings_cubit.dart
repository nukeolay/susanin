import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/compass/domain/entities/compass.dart';
import '../../../features/compass/domain/repositories/compass_repository.dart';
import '../../../features/location/domain/entities/position.dart';
import '../../../features/location/domain/repositories/location_repository.dart';
import '../../../features/wakelock/domain/entities/wakelock_status.dart';
import '../../../features/wakelock/domain/repositories/wakelock_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required LocationRepository locationRepository,
    required CompassRepository compassRepository,
    required WakelockRepository wakelockRepository,
  })  : _locationRepository = locationRepository,
        _compassRepository = compassRepository,
        _wakelockRepository = wakelockRepository,
        super(SettingsState.initial);

  final LocationRepository _locationRepository;
  final CompassRepository _compassRepository;
  final WakelockRepository _wakelockRepository;
  StreamSubscription<CompassEntity>? _compassSubscription;
  StreamSubscription<PositionEntity>? _positionSubscription;
  StreamSubscription<WakelockStatus>? _wakelockSubscription;

  void init() {
    _compassSubscription ??=
        _compassRepository.compassStream.listen(_compassEventHandler);
    _positionSubscription ??=
        _locationRepository.positionStream.listen(_positionEventHandler);
    _wakelockSubscription ??=
        _wakelockRepository.wakelockStream.listen(_wakelockEventHandler);
  }

  void _compassEventHandler(CompassEntity entity) {
    emit(state.copyWith(compassStatus: entity.status));
  }

  void _positionEventHandler(PositionEntity entity) {
    emit(state.copyWith(locationServiceStatus: entity.status));
  }

  void _wakelockEventHandler(WakelockStatus status) {
    emit(state.copyWith(isScreenAlwaysOn: status.isEnabled));
  }

  Future<void> getPermission() async {
    final status = await _locationRepository.requestPermission();
    emit(state.copyWith(locationServiceStatus: status));
  }

  Future<void> toggleWakelock() => _wakelockRepository.toggle();

  @override
  Future<void> close() async {
    await _compassSubscription?.cancel();
    await _positionSubscription?.cancel();
    await _wakelockSubscription?.cancel();
    super.close();
  }
}
