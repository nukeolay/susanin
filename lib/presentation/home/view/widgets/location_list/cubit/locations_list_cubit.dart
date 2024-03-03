import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/places/domain/entities/place.dart';
import 'package:susanin/features/places/domain/use_cases/delete_place.dart';
import 'package:susanin/features/places/domain/use_cases/get_places_stream.dart';
import 'package:susanin/features/places/domain/use_cases/update_place.dart';
import 'package:susanin/features/settings/domain/use_cases/get_active_place_stream.dart';
import 'package:susanin/features/settings/domain/use_cases/set_active_place.dart';

part 'locations_list_state.dart';

class LocationsListCubit extends Cubit<LocationsListState> {
  LocationsListCubit({
    required GetActivePlaceStream getActivePlaceStream,
    required GetPlacesStream getPlacesStream,
    required UpdatePlace updatePlace,
    required DeletePlace deletePlace,
    required SetActivePlace setActivePlace,
  })  : _getActivePlaceStream = getActivePlaceStream,
        _getPlacesStream = getPlacesStream,
        _updatePlace = updatePlace,
        _deletePlace = deletePlace,
        _setActivePlace = setActivePlace,
        super(LocationsListState.initial) {
    _init();
  }

  final GetPlacesStream _getPlacesStream;
  final GetActivePlaceStream _getActivePlaceStream;
  final UpdatePlace _updatePlace;
  final DeletePlace _deletePlace;
  final SetActivePlace _setActivePlace;

  StreamSubscription<ActivePlaceEvent>? _activePlaceSubscription;
  StreamSubscription<List<PlaceEntity>>? _locationsSubscription;

  void _init() {
    // ! TODO проверить, может быть и просто подописка сработает без lastValue
    final activePlaceStream = _getActivePlaceStream(const NoParams());
    final activePlace = activePlaceStream.valueOrNull ?? ActivePlaceEvent.empty;
    _activePlaceHandler(activePlace);
    final placesStream = _getPlacesStream(const NoParams());
    final initialPlaces = placesStream.valueOrNull ?? [];
    _locationsHandler(initialPlaces);
    _activePlaceSubscription = activePlaceStream.listen(_activePlaceHandler);
    _locationsSubscription = placesStream.listen(_locationsHandler);
  }

  void _activePlaceHandler(ActivePlaceEvent activePlaceEvent) {
    final place = activePlaceEvent.entity;
    emit(state.copyWith(activePlaceId: place?.id));
  }

  void _locationsHandler(List<PlaceEntity> places) {
    emit(state.copyWith(
      status: LocationsListStatus.loaded,
      places: places,
    ));
  }

  @override
  Future<void> close() async {
    await _locationsSubscription?.cancel();
    await _activePlaceSubscription?.cancel();
    super.close();
  }

  Future<void> onDeleteLocation({required String id}) async {
    final deleteLocationResult = await _deletePlace(DeleteParams(placeId: id));
    if (deleteLocationResult) {
      emit(state.copyWith(status: LocationsListStatus.deleted));
    } else {
      emit(state.copyWith(status: LocationsListStatus.failure));
    }
  }

  void onPressSetActive({required String id}) {
    _setActivePlace(SetPlaceParams(placeId: id));
  }

  void onLongPressEdit({required String id}) {
    final location = state.places.firstWhere(
      ((location) => location.id == id),
    );
    _setActivePlace(SetPlaceParams(placeId: id));
    emit(EditPlaceState(
      activePlaceId: id,
      status: LocationsListStatus.editing,
      name: location.name,
      latitude: location.latitude,
      longitude: location.longitude,
      places: state.places,
    ));
  }

  void onBottomSheetClose() {
    emit(state.copyWith(status: LocationsListStatus.loaded));
  }

  Future<void> onSaveLocation({
    required String id,
    required double latitude,
    required double longitude,
    required String newLocationName,
  }) async {
    final updateLocationResult = await _updatePlace(
      UpdateParams(
        id: id,
        latitude: latitude,
        longitude: longitude,
        newPlaceName: newLocationName,
      ),
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
