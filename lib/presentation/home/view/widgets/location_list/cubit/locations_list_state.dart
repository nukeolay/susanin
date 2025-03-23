part of 'locations_list_cubit.dart';

enum LocationsListStatus {
  deleted,
  updated,
  editing,
  failure,
}

sealed class LocationsListState extends Equatable {
  const LocationsListState();
}

class LocationsListInitialState extends LocationsListState {
  const LocationsListInitialState();

  @override
  List<Object?> get props => const [];
}

class LocationsListLoadedState extends LocationsListState {
  const LocationsListLoadedState({
    required this.status,
    required this.places,
    required this.activePlaceId,
    required this.previousPlaces,
  });

  final LocationsListStatus status;
  final List<PlaceEntity> places;
  final List<PlaceEntity> previousPlaces;
  final String activePlaceId;
  List<PlaceEntity> get removedItems => previousPlaces
      .where(
        (oldPlace) => !places.any((newPlace) => newPlace.id == oldPlace.id),
      )
      .toList();

  PlaceEntity? get activePlace => places.firstWhereOrNull(
        (location) => location.id == activePlaceId,
      );

  LocationsListLoadedState copyWith({
    LocationsListStatus? status,
    List<PlaceEntity>? places,
    List<PlaceEntity>? previousPlaces,
    String? activePlaceId,
  }) {
    return LocationsListLoadedState(
      status: status ?? this.status,
      places: places ?? this.places,
      previousPlaces: previousPlaces ?? this.previousPlaces,
      activePlaceId: activePlaceId ?? this.activePlaceId,
    );
  }

  @override
  List<Object> get props => [
        status,
        places,
        previousPlaces,
        activePlaceId,
      ];
}
