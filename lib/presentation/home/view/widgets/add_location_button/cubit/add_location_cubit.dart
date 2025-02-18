import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:susanin/features/location/domain/entities/position.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/places/domain/entities/icon_entity.dart';
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

  void onLongPressAdd(String pointName) {
    emit(
      state.copyWith(
        status: AddLocationStatus.editing,
        name: _generateName(pointName),
      ),
    );
  }

  Future<void> onPressAdd({
    required String pointName,
    required IconEntity icon,
  }) async {
    emit(state.copyWith(status: AddLocationStatus.loading));
    await _addLocation(
      latitude: state.latitude,
      longitude: state.longitude,
      notes: state.notes,
      name: _generateName(pointName),
      icon: icon,
    );
  }

  Future<void> onSaveLocation({
    required String latitude,
    required String longitude,
    required String notes,
    required String name,
    required IconEntity icon,
  }) async {
    emit(state.copyWith(status: AddLocationStatus.loading));
    final doubleLatitude = double.tryParse(latitude);
    final doubleLongitude = double.tryParse(longitude);
    if (doubleLatitude == null || doubleLongitude == null) return;
    await _addLocation(
      latitude: doubleLatitude,
      longitude: doubleLongitude,
      notes: notes,
      name: name,
      icon: icon,
    );
  }

  Future<void> _addLocation({
    required double latitude,
    required double longitude,
    required String notes,
    required String name,
    required IconEntity icon,
  }) async {
    try {
      final newPlace = PlaceEntity(
        id: 'id_${DateTime.now()}',
        latitude: latitude,
        longitude: longitude,
        notes: notes,
        name: name,
        creationTime: DateTime.now(),
        icon: icon,
      );
      _placesRepository.create(newPlace);
      emit(state.copyWith(status: AddLocationStatus.normal));
    } catch (error) {
      emit(state.copyWith(status: AddLocationStatus.failure));
    }
  }

  String _generateName(String pointName) {
    final dateTime = DateTime.now().toString();
    return '$pointName ${dateTime.substring(dateTime.length - 6)}';
  }
}
