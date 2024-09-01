import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:susanin/features/places/domain/entities/place_entity.dart';
import 'package:susanin/features/places/domain/entities/places_entity.dart';
import 'package:susanin/features/places/domain/repositories/places_repository.dart';
import 'package:collection/collection.dart';

part 'locations_list_state.dart';

class LocationsListCubit extends Cubit<LocationsListState> {
  LocationsListCubit({
    required PlacesRepository placesRepository,
  })  : _placesRepository = placesRepository,
        super(LocationsListState.initial);

  final PlacesRepository _placesRepository;

  StreamSubscription<PlacesEntity>? _placesSubscription;

  void init() {
    final placesStream = _placesRepository.placesStream;
    final initialPlaces = placesStream.valueOrNull;
    _placesHandler(initialPlaces);
    _placesSubscription ??= placesStream.listen(_placesHandler);
  }

  void _placesHandler(PlacesEntity? places) {
    emit(
      state.copyWith(
        status: LocationsListStatus.loaded,
        places: places?.places ?? [],
        activePlaceId: places?.activePlace?.id,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _placesSubscription?.cancel();
    super.close();
  }

  Future<void> onDeleteLocation({required String id}) async {
    final deleteLocationResult = await _placesRepository.delete(id);
    if (deleteLocationResult) {
      emit(state.copyWith(status: LocationsListStatus.deleted));
    } else {
      emit(state.copyWith(status: LocationsListStatus.failure));
    }
  }

  Future<void> onPressed({required String id}) async {
    await _placesRepository.select(id);
  }

  Future<void> onLongPressEdit({required String id}) async {
    await _placesRepository.select(id);
    emit(
      EditPlaceState(
        activePlaceId: id,
        status: LocationsListStatus.editing,
        places: state.places,
      ),
    );
  }

  void onBottomSheetClose() {
    emit(state.copyWith(status: LocationsListStatus.loaded));
  }

  Future<void> onSaveLocation({
    required String id,
    required String latitude,
    required String longitude,
    required String notes,
    required String newLocationName,
  }) async {
    final doubleLatitude = double.tryParse(latitude);
    final doubleLongitude = double.tryParse(longitude);
    if (doubleLatitude == null || doubleLongitude == null) return;
    final location = state.places.firstWhere((element) => element.id == id);
    final updatedLocation = location.copyWith(
      latitude: doubleLatitude,
      longitude: doubleLongitude,
      notes: notes,
      name: newLocationName,
    );
    final updateLocationResult = await _placesRepository.update(
      updatedLocation,
    );
    if (updateLocationResult) {
      emit(state.copyWith(status: LocationsListStatus.updated));
    } else {
      emit(state.copyWith(status: LocationsListStatus.failure));
    }
  }

  Future<bool> onShare(PlaceEntity place) async {
    final shareLink =
        '${place.name} https://www.google.com/maps/search/?api=1&query=${place.latitude},${place.longitude}';
    await Share.share(shareLink);
    return false;
  }
}
