import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/domain/compass/usecases/get_compass_stream.dart';
import 'package:susanin/domain/location/usecases/get_position_stream.dart';
import 'package:susanin/domain/location/usecases/request_permission.dart';
import 'package:susanin/domain/wakelock/usecases/get_wakelock_enabled_status.dart';
import 'package:susanin/domain/wakelock/usecases/toggle_wakelock.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final GetPositionStream _getPositionStream;
  final GetCompassStream _getCompassStream;
  final RequestPermission _requestPermission;
  final GetWakelockEnabledStatus _getWakelockEnabledStatus;
  final ToggleWakelock _toggleWakelock;

  SettingsCubit({
    required GetPositionStream getPositionStream,
    required GetCompassStream getCompassStream,
    required RequestPermission requestPermission,
    required GetWakelockEnabledStatus getWakelockEnabledStatus,
    required ToggleWakelock toggleWakelock,
  })  : _getPositionStream = getPositionStream,
        _getCompassStream = getCompassStream,
        _requestPermission = requestPermission,
        _getWakelockEnabledStatus = getWakelockEnabledStatus,
        _toggleWakelock = toggleWakelock,
        super(const SettingsState(
          locationSettingsStatus: LocationSettingsStatus.loading,
          compassSettingsStatus: CompassSettingsStatus.loading,
          wakelockSettingsStatus: WakelockSettingsStatus.loading,
          isDarkTheme: false,
          isAutoScreenOff: false,
        )) {
    _init();
  }

  void _init() {
    _updateCompassStatus();

    _updateLocationServiceStatus();

    _updateWakelockStatus();
  }

  Future<void> getPermission() async {
    final permission = await _requestPermission();
    emit(state.copyWith(
      locationSettingsStatus: permission
          ? LocationSettingsStatus.granted
          : LocationSettingsStatus.noPermission,
    ));
  }

  Future<void> toggleWakelock() async {
    emit(state.copyWith(
      wakelockSettingsStatus: WakelockSettingsStatus.loading,
    ));
    await _toggleWakelock();
    await _updateWakelockStatus();
  }

  Future<void> _updateWakelockStatus() async {
    final wakelockStatus = await _getWakelockEnabledStatus();
    emit(state.copyWith(
      wakelockSettingsStatus: wakelockStatus
          ? WakelockSettingsStatus.enabled
          : WakelockSettingsStatus.disabled,
    ));
  }

  Future<void> _updateLocationServiceStatus() async {
    final currentPosition = await _getPositionStream().first;
    currentPosition.fold((failure) {
      if (failure is LocationServiceDeniedFailure ||
          failure is LocationServiceDeniedForeverFailure) {
        emit(state.copyWith(
            locationSettingsStatus: LocationSettingsStatus.noPermission));
      } else {
        emit(state.copyWith(
            locationSettingsStatus: LocationSettingsStatus.granted));
      }
    },
        (position) => emit(
              state.copyWith(
                locationSettingsStatus: LocationSettingsStatus.granted,
              ),
            ));
  }

  Future<void> _updateCompassStatus() async {
    final compassEvent = await _getCompassStream().first;
    compassEvent.fold((failure) {
      emit(
        state.copyWith(compassSettingsStatus: CompassSettingsStatus.failure),
      );
    }, (compass) {
      emit(
        state.copyWith(compassSettingsStatus: CompassSettingsStatus.success),
      );
    });
  }
}
