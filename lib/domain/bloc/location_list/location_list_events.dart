import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationListEvent {}

class LocationListEventGetData extends LocationListEvent {}

class LocationListEventPressedSelectLocation extends LocationListEvent {
  int index;

  LocationListEventPressedSelectLocation({@required this.index});
}

class LocationListEventPressedDeleteLocation extends LocationListEvent {
  int index;

  LocationListEventPressedDeleteLocation({@required this.index});
}

class LocationListEventPressedRenameLocation extends LocationListEvent {
  int index;
  String newName;

  LocationListEventPressedRenameLocation({@required this.index, @required this.newName});
}

class LocationListEventAddNewLocation extends LocationListEvent {
  Position currentPosition;

  LocationListEventAddNewLocation({@required this.currentPosition});
}

class LocationListEventError extends LocationListEvent {}

class LocationListEventErrorPermissionDeniedForever extends LocationListEventError {}

class LocationListEventErrorPermissionDenied extends LocationListEventError {}

class LocationListEventErrorServiceDisabled extends LocationListEventError {}

class LocationListEventErrorNoCompass extends LocationListEventError {}
