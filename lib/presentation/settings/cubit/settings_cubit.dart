import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/compass/domain/use_cases/get_compass_stream.dart';
import 'package:susanin/features/location/domain/use_cases/get_position_stream.dart';
import 'package:susanin/features/location/domain/use_cases/request_permission.dart';
import 'package:susanin/features/wakelock/domain/entities/wakelock_status.dart';
import 'package:susanin/features/wakelock/domain/use_cases/get_wakelock_status.dart';
import 'package:susanin/features/wakelock/domain/use_cases/toggle_wakelock.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required GetPositionStream getPositionStream,
    required GetCompassStream getCompassStream,
    required RequestPermission requestPermission,
    required GetWakelockStatus getWakelockStatus,
    required ToggleWakelock toggleWakelock,
  })  : _getPositionStream = getPositionStream,
        _getCompassStream = getCompassStream,
        _requestPermission = requestPermission,
        _getWakelockStatus = getWakelockStatus,
        _toggleWakelock = toggleWakelock,
        super(SettingsState.initial) {
    _init();
  }

  final GetPositionStream _getPositionStream;
  final GetCompassStream _getCompassStream;
  final RequestPermission _requestPermission;
  final GetWakelockStatus _getWakelockStatus;
  final ToggleWakelock _toggleWakelock;
  StreamSubscription<CompassEvent>? _compassSubscription;
  StreamSubscription<PositionEvent>? _positionSubscription;

  void _init() {
    _updateWakelockStatus();
    _compassSubscription =
        _getCompassStream(const NoParams()).listen(_compassEventHandler);
    _positionSubscription =
        _getPositionStream(const NoParams()).listen(_positionEventHandler);
  }

  void _compassEventHandler(CompassEvent event) {
    final status = event.status;
    emit(state.copyWith(compassStatus: status));
  }

  void _positionEventHandler(PositionEvent event) {
    final status = event.status;
    emit(state.copyWith(locationServiceStatus: status));
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
