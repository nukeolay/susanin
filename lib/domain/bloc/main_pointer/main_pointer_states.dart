import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/domain/model/location_point.dart';

abstract class MainPointerState {}

class MainPointerStateLoading extends MainPointerState {}

class MainPointerStateEmptyList extends MainPointerState {}

class MainPointerStateLoaded extends MainPointerState {
  Position currentPosition;
  double heading;
  LocationPoint selectedLocationPoint;

  MainPointerStateLoaded({@required this.currentPosition, @required this.heading, @required this.selectedLocationPoint});

  double getAzimuth() {
    return heading -
        Geolocator.bearingBetween(
            currentPosition.latitude, currentPosition.longitude, selectedLocationPoint.pointLatitude, selectedLocationPoint.pointLongitude);
  }

  double getDistance() {
    return Geolocator.distanceBetween(
        currentPosition.latitude, currentPosition.longitude, selectedLocationPoint.pointLatitude, selectedLocationPoint.pointLongitude);
  }
}

class MainPointerStateError extends MainPointerState {}

class MainPointerStateErrorPermissionDenied extends MainPointerStateError {}

class MainPointerStateErrorServiceDisabled extends MainPointerStateError {}

class MainPointerStateErrorNoCompass extends MainPointerStateError {}
