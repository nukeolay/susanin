import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/compass/domain/entities/compass.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';
import 'package:susanin/features/location/domain/entities/position.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/places/domain/entities/place.dart';
import 'package:susanin/core/mixins/pointer_calculations.dart';
import 'package:susanin/features/settings/domain/use_cases/get_active_place_stream.dart';

part 'main_pointer_state.dart';

class MainPointerCubit extends Cubit<MainPointerState> {
  MainPointerCubit({
    required LocationRepository locationRepository,
    required GetActivePlaceStream getActivePlaceStream,
    required CompassRepository compassRepository,
  })  : _locationRepository = locationRepository,
        _getActivePlaceStream = getActivePlaceStream,
        _compassRepository = compassRepository,
        super(MainPointerState.initial) {
    _init();
  }

  final LocationRepository _locationRepository;
  final GetActivePlaceStream _getActivePlaceStream;
  final CompassRepository _compassRepository;
  StreamSubscription<ActivePlaceEvent>? _activePlaceSubscription;
  StreamSubscription<PositionEntity>? _positionSubscription;
  StreamSubscription<CompassEntity>? _compassSubscription;

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
    _positionSubscription = _locationRepository.positionStream.listen((event) {
      emit(state.copyWith(
        locationServiceStatus: event.status,
        userLatitude: event.latitude,
        userLongitude: event.longitude,
        accuracy: event.accuracy,
      ));
    });
  }

  void _updateCompassStatus() {
    _compassSubscription = _compassRepository.compassStream.listen((event) {
      emit(state.copyWith(
        compassStatus: event.status,
        compassNorth: event.north,
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
