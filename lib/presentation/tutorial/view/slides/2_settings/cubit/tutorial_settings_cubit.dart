import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/compass/domain/entities/compass.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';
import 'package:susanin/features/location/domain/entities/position.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/settings/domain/entities/settings.dart';
import 'package:susanin/features/settings/domain/use_cases/get_theme_mode.dart';
import 'package:susanin/features/location/domain/use_cases/request_permission.dart';
import 'package:susanin/features/settings/domain/use_cases/toggle_theme.dart';

part 'tutorial_settings_state.dart';

class TutorialSettingsCubit extends Cubit<TutorialSettingsState> {
  TutorialSettingsCubit({
    required LocationRepository locationRepository,
    required CompassRepository compassRepository,
    required RequestPermission requestPermission,
    required GetThemeMode getThemeMode,
    required ToggleTheme toggleTheme,
  })  : _locationRepository = locationRepository,
        _compassRepository = compassRepository,
        _requestPermission = requestPermission,
        _getThemeMode = getThemeMode,
        _toggleTheme = toggleTheme,
        super(TutorialSettingsState.initial) {
    _init();
  }

  final LocationRepository _locationRepository;
  final CompassRepository _compassRepository;
  final RequestPermission _requestPermission;
  final GetThemeMode _getThemeMode;
  final ToggleTheme _toggleTheme;
  StreamSubscription<PositionEntity>? _positionSubscription;
  StreamSubscription<CompassEntity>? _compassSubscription;

  void _init() {
    _updateTheme();
    _updateCompassStatus();
    _updateLocationServiceStatus();
  }

  @override
  Future<void> close() async {
    await _compassSubscription?.cancel();
    await _positionSubscription?.cancel();
    super.close();
  }

  Future<void> getPermission() async {
    final locationStatus = await _requestPermission(const NoParams());
    emit(state.copyWith(locationStatus: locationStatus));
  }

  Future<void> toggleTheme() async {
    emit(state.copyWith(isDarkTheme: !state.isDarkTheme));
    await _toggleTheme(const NoParams());
  }

  void _updateTheme() {
    final themeMode = _getThemeMode(const NoParams());
    emit(state.copyWith(isDarkTheme: themeMode.isDark));
  }

  void _updateLocationServiceStatus() {
    _positionSubscription = _locationRepository.positionStream.listen((event) {
      emit(state.copyWith(locationStatus: event.status));
    });
  }

  void _updateCompassStatus() {
    _compassSubscription = _compassRepository.compassStream.listen((event) {
      emit(state.copyWith(compassStatus: event.status));
    });
  }
}
