import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/settings/domain/entities/settings.dart';
import 'package:susanin/features/settings/domain/use_cases/get_theme_mode.dart';
import 'package:susanin/features/compass/domain/use_cases/get_compass_stream.dart';
import 'package:susanin/features/location/domain/use_cases/get_position_stream.dart';
import 'package:susanin/features/location/domain/use_cases/request_permission.dart';
import 'package:susanin/features/settings/domain/use_cases/toggle_theme.dart';

part 'tutorial_settings_state.dart';

class TutorialSettingsCubit extends Cubit<TutorialSettingsState> {
  TutorialSettingsCubit({
    required GetPositionStream getPositionStream,
    required GetCompassStream getCompassStream,
    required RequestPermission requestPermission,
    required GetThemeMode getThemeMode,
    required ToggleTheme toggleTheme,
  })  : _getPositionStream = getPositionStream,
        _getCompassStream = getCompassStream,
        _requestPermission = requestPermission,
        _getThemeMode = getThemeMode,
        _toggleTheme = toggleTheme,
        super(TutorialSettingsState.initial) {
    _init();
  }

  final GetPositionStream _getPositionStream;
  final GetCompassStream _getCompassStream;
  final RequestPermission _requestPermission;
  final GetThemeMode _getThemeMode;
  final ToggleTheme _toggleTheme;
  StreamSubscription<PositionEvent>? _positionSubscription;
  StreamSubscription<CompassEvent>? _compassSubscription;

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
    final stream = _getPositionStream(const NoParams());
    _positionSubscription = stream.listen((event) {
      emit(state.copyWith(locationStatus: event.status));
    });
  }

  void _updateCompassStatus() {
    final stream = _getCompassStream(const NoParams());
    _compassSubscription = stream.listen((event) {
      emit(state.copyWith(compassStatus: event.status));
    });
  }
}
