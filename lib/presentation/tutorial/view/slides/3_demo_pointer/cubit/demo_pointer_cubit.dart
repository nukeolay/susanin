import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:susanin/features/compass/domain/entities/compass.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';
import 'package:susanin/features/location/domain/entities/position.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/settings/domain/entities/settings.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';
import 'package:susanin/core/mixins/pointer_calculations.dart';

part 'demo_pointer_state.dart';

class DemoPointerCubit extends Cubit<DemoPointerState> {
  DemoPointerCubit({
    required LocationRepository locationRepository,
    required CompassRepository compassRepository,
    required SettingsRepository settingsRepository,
  })  : _locationRepository = locationRepository,
        _compassRepository = compassRepository,
        _settingsRepository = settingsRepository,
        super(DemoPointerState.initial) {
    _init();
  }

  final LocationRepository _locationRepository;
  final CompassRepository _compassRepository;
  final SettingsRepository _settingsRepository;

  StreamSubscription<PositionEntity>? _positionSubscription;
  StreamSubscription<CompassEntity>? _compassSubscription;

  void _init() {
    final settings =
        _settingsRepository.settingsStream.valueOrNull ?? SettingsEntity.empty;
    emit(state.copyWith(isFirstTime: settings.isFirstTime));
    _positionSubscription =
        _locationRepository.positionStream.listen(_positionEventHandler);
    _compassSubscription =
        _compassRepository.compassStream.listen(_compassEventHandler);
    if (!settings.isFirstTime) return;
    _toggleFirstTime(settings);
  }

  Future<void> _toggleFirstTime(SettingsEntity settings) async {
    final newSettings = settings.copyWith(isFirstTime: false);
    await _settingsRepository.save(newSettings);
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
