import 'package:equatable/equatable.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';

enum LocationsListStatus {
  loading,
  loaded,
  deleted,
  updated,
  editing,
  failure,
}

class LocationsListState extends Equatable {
  final LocationsListStatus status;
  final List<LocationPointEntity> locations;
  final String activeLocationId;

  const LocationsListState({
    required this.status,
    required this.locations,
    required this.activeLocationId,
  });

  @override
  List<Object> get props => [status, locations, activeLocationId];

  LocationsListState copyWith({
    LocationsListStatus? status,
    List<LocationPointEntity>? locations,
    String? activeLocationId,
  }) {
    return LocationsListState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
      activeLocationId: activeLocationId ?? this.activeLocationId,
    );
  }
}

class EditLocationState extends LocationsListState {
  final String id;
  final double latitude;
  final double longitude;
  final String name;

  const EditLocationState({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.name,
    required LocationsListStatus status,
    required List<LocationPointEntity> locations,
    required String activeLocationId,
  }) : super(
          status: status,
          locations: locations,
          activeLocationId: activeLocationId,
        );

  @override
  EditLocationState copyWith({
    LocationsListStatus? status,
    List<LocationPointEntity>? locations,
    String? activeLocationId,
    double? latitude,
    double? longitude,
    String? name,
  }) {
    return EditLocationState(
      id: id,
      status: status ?? this.status,
      locations: locations ?? this.locations,
      activeLocationId: activeLocationId ?? this.activeLocationId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      name: name ?? this.name,
    );
  }

  @override
  List<Object> get props => [
        latitude,
        longitude,
        name,
        status,
        locations,
        id,
        activeLocationId,
      ];
}
