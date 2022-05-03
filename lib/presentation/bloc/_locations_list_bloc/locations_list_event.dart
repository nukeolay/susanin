import 'package:equatable/equatable.dart';

abstract class LocationsListEvent extends Equatable {
  const LocationsListEvent();

  @override
  List<Object> get props => [];
}

class OnDeleteLocation extends LocationsListEvent {
  const OnDeleteLocation({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class OnLongPressEdit extends LocationsListEvent {
  const OnLongPressEdit({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  final String name;
  final double latitude;
  final double longitude;

  @override
  List<Object> get props => [name, latitude, longitude];
}

class OnSaveLocation extends LocationsListEvent {
  const OnSaveLocation({
    required this.latitude,
    required this.longitude,
    required this.oldLocationName,
    required this.newLocationName,
  });

  final double latitude;
  final double longitude;
  final String oldLocationName;
  final String newLocationName;

  @override
  List<Object> get props =>
      [latitude, longitude, oldLocationName, newLocationName];
}

class OnBottomSheetClose extends LocationsListEvent {
  const OnBottomSheetClose();
}
