import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/features/compass/domain/entities/compass.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';
import 'package:susanin/features/location/domain/entities/position.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/settings/domain/entities/settings.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';

part 'tutorial_settings_state.dart';

class TutorialSettingsCubit extends Cubit<TutorialSettingsState> {
  TutorialSettingsCubit({
    required LocationRepository locationRepository,
    required CompassRepository compassRepository,
    required SettingsRepository settingsRepository,
  })  : _locationRepository = locationRepository,
        _compassRepository = compassRepository,
        _settingsRepository = settingsRepository,
        super(TutorialSettingsState.initial);

  final LocationRepository _locationRepository;
  final CompassRepository _compassRepository;
  final SettingsRepository _settingsRepository;
  StreamSubscription<PositionEntity>? _positionSubscription;
  StreamSubscription<CompassEntity>? _compassSubscription;
  StreamSubscription<SettingsEntity>? _settingsSubscription;

  void init() {
    _updateTheme();
    _updateCompassStatus();
    _updateLocationServiceStatus();
  }

  @override
  Future<void> close() async {
    await _compassSubscription?.cancel();
    await _positionSubscription?.cancel();
    await _settingsSubscription?.cancel();
    super.close();
  }

  Future<void> getPermission() async {
    final locationStatus = await _locationRepository.requestPermission();
    emit(state.copyWith(locationStatus: locationStatus));
  }

  Future<void> toggleTheme() {
    return _settingsRepository.setTheme(
      state.isDarkTheme ? ThemeMode.light : ThemeMode.dark,
    );
  }

  void _updateTheme() {
    final settings =
        _settingsRepository.settingsStream.valueOrNull ?? SettingsEntity.empty;
    emit(state.copyWith(isDarkTheme: settings.themeMode.isDark));
    _settingsSubscription ??= _settingsRepository.settingsStream.listen((event) {
      emit(state.copyWith(isDarkTheme: event.themeMode.isDark));
    });
  }

  void _updateLocationServiceStatus() {
    _positionSubscription ??= _locationRepository.positionStream.listen((event) {
      emit(state.copyWith(locationStatus: event.status));
    });
  }

  void _updateCompassStatus() {
    _compassSubscription ??= _compassRepository.compassStream.listen((event) {
      emit(state.copyWith(compassStatus: event.status));
    });
  }
}
