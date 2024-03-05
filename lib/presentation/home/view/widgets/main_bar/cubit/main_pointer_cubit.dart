import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/features/compass/domain/entities/compass.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';
import 'package:susanin/features/location/domain/entities/position.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/places/domain/entities/place_entity.dart';
import 'package:susanin/core/mixins/pointer_calculations.dart';
import 'package:susanin/features/places/domain/entities/places_entity.dart';
import 'package:susanin/features/places/domain/repositories/places_repository.dart';

part 'main_pointer_state.dart';

class MainPointerCubit extends Cubit<MainPointerState> {
  MainPointerCubit({
    required LocationRepository locationRepository,
    required PlacesRepository placesRepository,
    required CompassRepository compassRepository,
  })  : _locationRepository = locationRepository,
        _placesRepository = placesRepository,
        _compassRepository = compassRepository,
        super(MainPointerState.initial) {
    _init();
  }

  final LocationRepository _locationRepository;
  final PlacesRepository _placesRepository;
  final CompassRepository _compassRepository;
  StreamSubscription<PlacesEntity>? _activePlaceSubscription;
  StreamSubscription<PositionEntity>? _positionSubscription;
  StreamSubscription<CompassEntity>? _compassSubscription;

  Future<void> _init() async {
    _updateActivePlace();
    _updatePasition();
    _updateCompassStatus();
  }

  void _updateActivePlace() {
    final stream = _placesRepository.placesStream;
    final initialEvent = stream.valueOrNull;
    emit(state.copyWith(activePlace: initialEvent?.activePlace));
    _activePlaceSubscription = stream.listen((event) {
      emit(state.copyWith(activePlace: event.activePlace));
    });
  }

  void _updatePasition() {
    _positionSubscription = _locationRepository.positionStream.listen((event) {
      emit(
        state.copyWith(
          locationServiceStatus: event.status,
          userLatitude: event.latitude,
          userLongitude: event.longitude,
          accuracy: event.accuracy,
        ),
      );
    });
  }

  void _updateCompassStatus() {
    _compassSubscription = _compassRepository.compassStream.listen((event) {
      emit(
        state.copyWith(
          compassStatus: event.status,
          compassNorth: event.north,
        ),
      );
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
