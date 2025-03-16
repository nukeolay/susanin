import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
;
import '../../../../../../core/mixins/pointer_calculations.dart';
import '../../../../../../features/compass/domain/entities/compass.dart';
import '../../../../../../features/compass/domain/repositories/compass_repository.dart';
import '../../../../../../features/location/domain/entities/position.dart';
import '../../../../../../features/location/domain/repositories/location_repository.dart';
import '../../../../../../features/places/domain/entities/place_entity.dart';
import '../../../../../../features/places/domain/entities/places_entity.dart';
import '../../../../../../features/places/domain/repositories/places_repository.dart';

part 'main_pointer_state.dart';

class MainPointerCubit extends Cubit<MainPointerState> {
  MainPointerCubit({
    required LocationRepository locationRepository,
    required PlacesRepository placesRepository,
    required CompassRepository compassRepository,
  })  : _locationRepository = locationRepository,
        _placesRepository = placesRepository,
        _compassRepository = compassRepository,
        super(MainPointerState.initial);

  final LocationRepository _locationRepository;
  final PlacesRepository _placesRepository;
  final CompassRepository _compassRepository;
  StreamSubscription<PlacesEntity>? _activePlaceSubscription;
  StreamSubscription<PositionEntity>? _positionSubscription;
  StreamSubscription<CompassEntity>? _compassSubscription;

  Future<void> init() async {
    _updateActivePlace();
    _updatePasition();
    _updateCompass();
  }

  void _updateActivePlace() {
    final stream = _placesRepository.placesStream;
    final initialEvent = stream.valueOrNull;
    emit(state.copyWith(activePlace: initialEvent?.activePlace));
    _activePlaceSubscription ??= stream.listen(
      (event) {
        if (event.activePlace == null) {
          emit(state.copyWith(activePlace: PlaceEntity.empty()));
        } else {
          emit(state.copyWith(activePlace: event.activePlace));
        }
      },
    );
  }

  void _updatePasition() {
    _positionSubscription ??= _locationRepository.positionStream.listen(
      (event) {
        emit(
          state.copyWith(
            locationServiceStatus: event.status,
            userLatitude: event.latitude,
            userLongitude: event.longitude,
            accuracy: event.accuracy,
          ),
        );
      },
    );
  }

  void _updateCompass() {
    _compassSubscription ??= _compassRepository.compassStream.listen(
      (event) {
        emit(
          state.copyWith(
            compassStatus: event.status,
            compassNorth: event.north,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    await _positionSubscription?.cancel();
    await _compassSubscription?.cancel();
    await _activePlaceSubscription?.cancel();
    return super.close();
  }
}
