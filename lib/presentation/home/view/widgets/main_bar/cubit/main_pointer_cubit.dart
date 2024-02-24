import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/compass/domain/use_cases/get_compass_stream.dart';
import 'package:susanin/features/location/domain/use_cases/get_position_stream.dart';
import 'package:susanin/features/places/domain/entities/place.dart';
import 'package:susanin/core/mixins/pointer_calculations.dart';
import 'package:susanin/features/settings/domain/use_cases/get_active_place_stream.dart';

part 'main_pointer_state.dart';

class MainPointerCubit extends Cubit<MainPointerState> {
  MainPointerCubit({
    required GetPositionStream getPositionStream,
    required GetActivePlaceStream getActivePlaceStream,
    required GetCompassStream getCompassStream,
  })  : _getPositionStream = getPositionStream,
        _getActivePlaceStream = getActivePlaceStream,
        _getCompassStream = getCompassStream,
        super(MainPointerState.initial) {
    _init();
  }

  final GetPositionStream _getPositionStream;
  final GetActivePlaceStream _getActivePlaceStream;
  final GetCompassStream _getCompassStream;
  StreamSubscription<ActivePlaceEvent>? _activePlaceSubscription;
  StreamSubscription<PositionEvent>? _positionSubscription;
  StreamSubscription<CompassEvent>? _compassSubscription;

  void _init() async {
    _updateActivePlace();
    _updatePasition();
    _updateCompassStatus();
  }

  void _updateActivePlace() {
    final stream = _getActivePlaceStream(const NoParams());
    final initialEvent = stream.valueOrNull ?? ActivePlaceEvent.empty;
    emit(state.copyWith(
      activePlaceStatus: initialEvent.status,
      activePlace: initialEvent.entity,
    ));
    _activePlaceSubscription = stream.listen((event) {
      emit(state.copyWith(
        activePlaceStatus: event.status,
        activePlace: event.entity,
      ));
    });
  }

  void _updatePasition() {
    final stream = _getPositionStream(const NoParams());
    _positionSubscription = stream.listen((event) {
      emit(state.copyWith(
        locationServiceStatus: event.status,
        userLatitude: event.entity?.latitude,
        userLongitude: event.entity?.longitude,
        accuracy: event.entity?.accuracy,
      ));
    });
  }

  void _updateCompassStatus() {
    final stream = _getCompassStream(const NoParams());
    _compassSubscription = stream.listen((event) {
      emit(state.copyWith(
        compassStatus: event.status,
        compassNorth: event.entity?.north,
      ));
    });
  }

  @override
  Future<void> close() async {
    await _positionSubscription?.cancel();
    await _compassSubscription?.cancel();
    await _activePlaceSubscription?.cancel();
    super.close();
  }
}
