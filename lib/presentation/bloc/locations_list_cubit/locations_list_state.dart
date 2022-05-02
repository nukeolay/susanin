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

  const LocationsListState({
    required this.status,
    required this.locations,
  });

  @override
  List<Object> get props => [status, locations];

  LocationsListState copyWith({
    LocationsListStatus? status,
    List<LocationPointEntity>? locations,
  }) {
    return LocationsListState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
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
  }) : super(status: status, locations: locations);

  @override
  EditLocationState copyWith({
    LocationsListStatus? status,
    List<LocationPointEntity>? locations,
    double? latitude,
    double? longitude,
    String? name,
  }) {
    return EditLocationState(
      id: id,
      status: status ?? this.status,
      locations: locations ?? this.locations,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      name: name ?? this.name,
    );
  }

  @override
  List<Object> get props => [latitude, longitude, name, status, locations];
}
