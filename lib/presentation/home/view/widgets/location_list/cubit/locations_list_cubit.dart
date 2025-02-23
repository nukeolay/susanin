import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import 'package:susanin/features/places/domain/entities/place_entity.dart';
import 'package:susanin/features/places/domain/entities/places_entity.dart';
import 'package:susanin/features/places/domain/entities/icon_entity.dart';
import 'package:susanin/features/places/domain/repositories/places_repository.dart';

part 'locations_list_state.dart';

class LocationsListCubit extends Cubit<LocationsListState> {
  LocationsListCubit({
    required PlacesRepository placesRepository,
  })  : _placesRepository = placesRepository,
        super(const LocationsListInitialState());

  final PlacesRepository _placesRepository;

  StreamSubscription<PlacesEntity>? _placesSubscription;

  void init() {
    _placesSubscription ??= _placesRepository.placesStream.listen(
      _placesHandler,
    );
  }

  void _placesHandler(PlacesEntity? places) {
    final currentState = state;
    switch (currentState) {
      case LocationsListInitialState():
        emit(
          LocationsListLoadedState(
            status: LocationsListStatus.updated,
            places: places?.places ?? [],
            previousPlaces: const [],
            activePlaceId: places?.activePlace?.id ?? '',
          ),
        );
      case LocationsListLoadedState():
        final previousPlaces = [...currentState.places];
        emit(
          currentState.copyWith(
            status: LocationsListStatus.updated,
            places: places?.places ?? [],
            previousPlaces: previousPlaces,
            activePlaceId: places?.activePlace?.id,
          ),
        );
    }
  }

  @override
  Future<void> close() async {
    await _placesSubscription?.cancel();
    super.close();
  }

  Future<void> onDeleteLocation({required String id}) async {
    final currentState = state;
    if (currentState is! LocationsListLoadedState) {
      return;
    }
    final deleteLocationResult = await _placesRepository.delete(id);
    if (deleteLocationResult) {
      emit(currentState.copyWith(status: LocationsListStatus.deleted));
    } else {
      emit(currentState.copyWith(status: LocationsListStatus.failure));
    }
  }

  Future<void> onPressed({required String id}) async {
    await _placesRepository.select(id);
  }

  Future<void> onLongPressEdit({required String id}) async {
    await _placesRepository.select(id);
    final currentState = state;
    if (currentState is! LocationsListLoadedState) {
      return;
    }
    emit(
      currentState.copyWith(
        activePlaceId: id,
        status: LocationsListStatus.editing,
        places: currentState.places,
      ),
    );
  }

  void onBottomSheetClose() {
    final currentState = state;
    if (currentState is! LocationsListLoadedState) {
      return;
    }
    emit(currentState.copyWith(status: LocationsListStatus.updated));
  }

  Future<void> onSaveLocation({
    required String id,
    required String latitude,
    required String longitude,
    required String notes,
    required String newLocationName,
    required IconEntity icon,
  }) async {
    final currentState = state;
    if (currentState is! LocationsListLoadedState) {
      return;
    }
    final doubleLatitude = double.tryParse(latitude);
    final doubleLongitude = double.tryParse(longitude);
    if (doubleLatitude == null || doubleLongitude == null) return;
    final location = currentState.places.firstWhere(
      (element) => element.id == id,
    );
    final updatedLocation = location.copyWith(
      latitude: doubleLatitude,
      longitude: doubleLongitude,
      notes: notes,
      name: newLocationName,
      icon: icon,
    );
    final updateLocationResult = await _placesRepository.update(
      updatedLocation,
    );
    if (updateLocationResult) {
      emit(currentState.copyWith(status: LocationsListStatus.updated));
    } else {
      emit(currentState.copyWith(status: LocationsListStatus.failure));
    }
  }

  Future<bool> onShare(PlaceEntity place) async {
    final shareLink =
        '${place.name} https://www.google.com/maps/search/?api=1&query='
        '${place.latitude},${place.longitude}';
    await Share.share(shareLink);
    return false;
  }
}
