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

class EditPlaceState extends LocationsListState {
  const EditPlaceState({
    required this.latitude,
    required this.longitude,
    required this.name,
    required super.status,
    required super.places,
    required super.activePlaceId,
    required this.place,
    required this.notes,
  });
  final double latitude;
  final double longitude;
  final String name;
  final String notes;
  final PlaceEntity place;

  @override
  EditPlaceState copyWith({
    LocationsListStatus? status,
    List<PlaceEntity>? places,
    String? activePlaceId,
    double? latitude,
    double? longitude,
    String? name,
    PlaceEntity? place,
    String? notes,
  }) {
    return EditPlaceState(
      status: status ?? this.status,
      places: places ?? this.places,
      activePlaceId: activePlaceId ?? this.activePlaceId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      name: name ?? this.name,
      place: place ?? this.place,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object> get props => [
        latitude,
        longitude,
        name,
        status,
        places,
        activePlaceId,
        place,
        notes,
      ];
}
