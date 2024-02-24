import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/compass/domain/use_cases/get_compass_stream.dart';
import 'package:susanin/features/location/domain/use_cases/get_position_stream.dart';
import 'package:susanin/features/places/domain/entities/place.dart';
import 'package:susanin/core/mixins/pointer_calculations.dart';
import 'package:susanin/features/wakelock/domain/entities/wakelock_status.dart';
import 'package:susanin/features/wakelock/domain/use_cases/get_wakelock_status.dart';
import 'package:susanin/features/wakelock/domain/use_cases/toggle_wakelock.dart';

part 'detailed_info_state.dart';

class DetailedInfoCubit extends Cubit<DetailedInfoState> {
  DetailedInfoCubit({
    required GetPositionStream getPositionStream,
    required GetCompassStream getCompassStream,
    required GetWakelockStatus getWakelockStatus,
    required ToggleWakelock toggleWakelock,
    required PlaceEntity place,
  })  : _getPositionStream = getPositionStream,
        _getCompassStream = getCompassStream,
        _getWakelockStatus = getWakelockStatus,
        _toggleWakelock = toggleWakelock,
        super(DetailedInfoState.initial(place)) {
    _init();
  }

  final GetPositionStream _getPositionStream;
  final GetCompassStream _getCompassStream;
  final GetWakelockStatus _getWakelockStatus;
  final ToggleWakelock _toggleWakelock;

  StreamSubscription<PositionEvent>? _positionSubscription;
  StreamSubscription<CompassEvent>? _compassSubscription;

  void _init() {
    _updateWakelockStatus();
    _positionSubscription =
        _getPositionStream(const NoParams()).listen(_positionEventHandler);
    _compassSubscription =
        _getCompassStream(const NoParams()).listen(_compassEventHandler);
  }

  void _positionEventHandler(PositionEvent event) {
    final position = event.entity;
    final status = event.status;
    final accuracy = position?.accuracy;
    emit(state.copyWith(
      locationServiceStatus: status,
      userLatitude: position?.latitude,
      userLongitude: position?.longitude,
      accuracy: accuracy,
    ));
  }

  void _compassEventHandler(CompassEvent event) {
    final compass = event.entity;
    final status = event.status;
    emit(state.copyWith(
      hasCompass: status.isSuccess ? true : false,
      compassNorth: compass?.north,
    ));
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
    await _positionSubscription?.cancel();
    await _compassSubscription?.cancel();
    super.close();
  }
}
