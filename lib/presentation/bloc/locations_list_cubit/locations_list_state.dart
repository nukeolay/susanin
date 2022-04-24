import 'package:equatable/equatable.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';

enum LocationsListStatus {
  loading,
  loaded,
  loadFailure,
  locationExistsFailure,
  removeFailure,
  renameFailure,
  locationAddFailure,
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
