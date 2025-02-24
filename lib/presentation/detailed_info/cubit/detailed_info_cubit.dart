import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/mixins/pointer_calculations.dart';
import '../../../features/compass/domain/entities/compass.dart';
import '../../../features/compass/domain/repositories/compass_repository.dart';
import '../../../features/location/domain/entities/position.dart';
import '../../../features/location/domain/repositories/location_repository.dart';
import '../../../features/places/domain/entities/icon_entity.dart';
import '../../../features/places/domain/entities/place_entity.dart';
import '../../../features/places/domain/entities/places_entity.dart';
import '../../../features/places/domain/repositories/places_repository.dart';
import '../../../features/wakelock/domain/entities/wakelock_status.dart';
import '../../../features/wakelock/domain/repositories/wakelock_repository.dart';

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
  StreamSubscription<WakelockStatus>? _wakelockSubscription;

  void init() {
    final placesStream = _placesRepository.placesStream;
    final initialPlaces = placesStream.valueOrNull;
    _placesHandler(initialPlaces);
    _placesSubscription ??= placesStream.listen(_placesHandler);
    _positionSubscription ??=
        _locationRepository.positionStream.listen(_positionEventHandler);
    _compassSubscription ??=
        _compassRepository.compassStream.listen(_compassEventHandler);
    _wakelockSubscription ??=
        _wakelockRepository.wakelockStream.listen(_wakelockEventHandler);
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

  void _wakelockEventHandler(WakelockStatus status) {
    emit(state.copyWith(isScreenAlwaysOn: status.isEnabled));
  }

  Future<void> toggleWakelock() => _wakelockRepository.toggle();

  Future<void> onSaveLocation({
    required String latitude,
    required String longitude,
    required String notes,
    required String newLocationName,
    required IconEntity icon,
  }) async {
    final doubleLatitude = double.tryParse(latitude);
    final doubleLongitude = double.tryParse(longitude);
    if (doubleLatitude == null || doubleLongitude == null) return;
    final updatedPlace = state.place.copyWith(
      latitude: doubleLatitude,
      longitude: doubleLongitude,
      notes: notes,
      name: newLocationName,
      icon: icon,
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
    await _wakelockSubscription?.cancel();
    super.close();
  }
}
