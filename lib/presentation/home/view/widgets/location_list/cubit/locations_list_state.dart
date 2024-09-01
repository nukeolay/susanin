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
  });

  final LocationsListStatus status;
  final List<PlaceEntity> places;
  final String activePlaceId;

  static const initial = LocationsListState(
    status: LocationsListStatus.loading,
    places: [],
    activePlaceId: '',
  );

  PlaceEntity? get activePlace => places.firstWhereOrNull(
        (location) => location.id == activePlaceId,
      );

  LocationsListState copyWith({
    LocationsListStatus? status,
    List<PlaceEntity>? places,
    String? activePlaceId,
  }) {
    return LocationsListState(
      status: status ?? this.status,
      places: places ?? this.places,
      activePlaceId: activePlaceId ?? this.activePlaceId,
    );
  }

  @override
  List<Object> get props => [status, places, activePlaceId];
}
