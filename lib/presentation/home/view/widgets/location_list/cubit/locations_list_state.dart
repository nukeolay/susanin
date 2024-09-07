part of 'locations_list_cubit.dart';

enum LocationsListStatus {
  loading,
  loaded,
  deleted,
  updated,
  editing,
  failure,
}

class LocationsListState extends Equatable {
  const LocationsListState({
    required this.status,
    required this.places,
    required this.activePlaceId,
    required this.previousPlaces,
  });

  final LocationsListStatus status;
  final List<PlaceEntity> places;
  final List<PlaceEntity> previousPlaces;
  final String activePlaceId;
  List<PlaceEntity> get removedItems =>
      previousPlaces.where((place) => !places.contains(place)).toList();

  static const initial = LocationsListState(
    status: LocationsListStatus.loading,
    places: [],
    previousPlaces: [],
    activePlaceId: '',
  );

  PlaceEntity? get activePlace => places.firstWhereOrNull(
        (location) => location.id == activePlaceId,
      );

  LocationsListState copyWith({
    LocationsListStatus? status,
    List<PlaceEntity>? places,
    List<PlaceEntity>? previousPlaces,
    String? activePlaceId,
  }) {
    return LocationsListState(
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
