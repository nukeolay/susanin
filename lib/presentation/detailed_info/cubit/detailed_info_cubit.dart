import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:susanin/core/mixins/pointer_calculations.dart';
import 'package:susanin/features/compass/domain/entities/compass.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';
import 'package:susanin/features/location/domain/entities/position.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/places/domain/entities/place_entity.dart';
import 'package:susanin/features/places/domain/entities/places_entity.dart';
import 'package:susanin/features/places/domain/repositories/places_repository.dart';
import 'package:susanin/features/wakelock/domain/repositories/wakelock_repository.dart';

part 'detailed_info_state.dart';

class DetailedInfoCubit extends Cubit<DetailedInfoState> {
  DetailedInfoCubit({
    required PlacesRepository placesRepository,
    required LocationRepository locationRepository,
    required CompassRepository compassRepository,
    required WakelockRepository wakelockRepository,
    required String placeId,
  })  : _locationRepository = locationRepository,
        _placesRepository = placesRepository,
        _compassRepository = compassRepository,
        _wakelockRepository = wakelockRepository,
        super(DetailedInfoState.initial(placeId));

  final PlacesRepository _placesRepository;
  final LocationRepository _locationRepository;
  final CompassRepository _compassRepository;
  final WakelockRepository _wakelockRepository;

  StreamSubscription<PlacesEntity>? _placesSubscription;
  StreamSubscription<PositionEntity>? _positionSubscription;
  StreamSubscription<CompassEntity>? _compassSubscription;

  void init() {
    _updateWakelockStatus();
    final placesStream = _placesRepository.placesStream;
    final initialPlaces = placesStream.valueOrNull;
    _placesHandler(initialPlaces);
    _placesSubscription ??= placesStream.listen(_placesHandler);
    _positionSubscription ??=
        _locationRepository.positionStream.listen(_positionEventHandler);
    _compassSubscription ??=
        _compassRepository.compassStream.listen(_compassEventHandler);
  }

  void _placesHandler(PlacesEntity? places) {
    final place = places?.places.firstWhereOrNull(
      (e) => e.id == state.placeId,
    );
    if (place == null) return;
    emit(state.copyWith(place: place));
  }

  void _positionEventHandler(PositionEntity entity) {
    emit(
      state.copyWith(
        locationServiceStatus: entity.status,
        userLatitude: entity.latitude,
        userLongitude: entity.longitude,
        accuracy: entity.accuracy,
      ),
    );
  }

  void _compassEventHandler(CompassEntity entity) {
    emit(
      state.copyWith(
        hasCompass: entity.status.isSuccess,
        compassNorth: entity.north,
      ),
    );
  }

  Future<void> toggleWakelock() async {
    await _wakelockRepository.toggle();
    await _updateWakelockStatus();
  }

  Future<void> _updateWakelockStatus() async {
    final wakelockStatus = await _wakelockRepository.wakelockStatus;
    emit(state.copyWith(isScreenAlwaysOn: wakelockStatus.isEnabled));
  }

  Future<void> onSaveLocation({
    required String latitude,
    required String longitude,
    required String notes,
    required String newLocationName,
  }) async {
    final doubleLatitude = double.tryParse(latitude);
    final doubleLongitude = double.tryParse(longitude);
    if (doubleLatitude == null || doubleLongitude == null) return;
    final updatedPlace = state.place.copyWith(
      latitude: doubleLatitude,
      longitude: doubleLongitude,
      notes: notes,
      name: newLocationName,
    );
    await _placesRepository.update(updatedPlace);
  }

  Future<void> onDeleteLocation() async {
    await _placesRepository.delete(state.placeId);
  }

  @override
  Future<void> close() async {
    await _placesSubscription?.cancel();
    await _positionSubscription?.cancel();
    await _compassSubscription?.cancel();
    super.close();
  }
}
