import 'package:equatable/equatable.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';

enum LocationsListStatus {
  loading,
  loaded,
  editing,
  loadFailure,
  locationExistsFailure,
  removeFailure,
  updateFailure,
  locationAddFailure,
  unknownFailure,
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
  final double latitude;
  final double longitude;
  final String pointName;

  const EditLocationState({
    required this.latitude,
    required this.longitude,
    required this.pointName,
    required LocationsListStatus status,
    required List<LocationPointEntity> locations,
  }) : super(status: status, locations: locations);

  @override
  EditLocationState copyWith({
    LocationsListStatus? status,
    List<LocationPointEntity>? locations,
    double? latitude,
    double? longitude,
    String? pointName,
  }) {
    return EditLocationState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      pointName: pointName ?? this.pointName,
    );
  }
}
