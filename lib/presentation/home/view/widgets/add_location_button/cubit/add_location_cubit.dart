import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/features/location/domain/entities/position.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/places/domain/entities/place_entity.dart';
import 'package:susanin/features/places/domain/repositories/places_repository.dart';

part 'add_location_state.dart';

class AddLocationCubit extends Cubit<AddLocationState> {
  AddLocationCubit({
    required PlacesRepository placesRepository,
    required LocationRepository locationRepository,
  })  : _placesRepository = placesRepository,
        _locationRepository = locationRepository,
        super(AddLocationState.initial);

  final PlacesRepository _placesRepository;
  final LocationRepository _locationRepository;
  StreamSubscription<PositionEntity>? _positionSubscription;

  void init() {
    _positionSubscription ??= _locationRepository.positionStream.listen(
      _positionEventHandler,
    );
  }

  void _positionEventHandler(PositionEntity entity) {
    emit(
      state.copyWith(
        status: _locationStatusToAddLocationStatus(entity.status),
        latitude: entity.latitude,
        longitude: entity.longitude,
      ),
    );
  }

  AddLocationStatus _locationStatusToAddLocationStatus(LocationStatus status) {
    switch (status) {
      case LocationStatus.disabled:
      case LocationStatus.notPermitted:
      case LocationStatus.unknownError:
        return AddLocationStatus.failure;
      case LocationStatus.loading:
        return AddLocationStatus.loading;
      case LocationStatus.granted:
        return AddLocationStatus.normal;
    }
  }

  @override
  Future<void> close() async {
    await _positionSubscription?.cancel();
    super.close();
  }

  void onLongPressAdd() {
    emit(
      state.copyWith(
        status: AddLocationStatus.editing,
        name: _generateName(),
      ),
    );
  }

  Future<void> onPressAdd() async {
    emit(state.copyWith(status: AddLocationStatus.loading));
    await _addLocation(
      latitude: state.latitude,
      longitude: state.longitude,
      name: _generateName(),
    );
  }

  Future<void> onSaveLocation({
    required String latitude,
    required String longitude,
    required String name,
  }) async {
    emit(state.copyWith(status: AddLocationStatus.loading));
    final doubleLatitude = double.tryParse(latitude);
    final doubleLongitude = double.tryParse(longitude);
    if (doubleLatitude == null || doubleLongitude == null) return;
    await _addLocation(
      latitude: doubleLatitude,
      longitude: doubleLongitude,
      name: name,
    );
  }

  Future<void> _addLocation({
    required double latitude,
    required double longitude,
    required String name,
  }) async {
    try {
      final newPlace = PlaceEntity(
        id: 'id_${DateTime.now()}',
        latitude: latitude,
        longitude: longitude,
        name: name,
        creationTime: DateTime.now(),
      );
      _placesRepository.create(newPlace);
      emit(state.copyWith(status: AddLocationStatus.normal));
    } catch (error) {
      emit(state.copyWith(status: AddLocationStatus.failure));
    }
  }

  String _generateName() {
    final dateTime = DateTime.now().toString();
    return 'point ${dateTime.substring(dateTime.length - 6)}';
  }
}
