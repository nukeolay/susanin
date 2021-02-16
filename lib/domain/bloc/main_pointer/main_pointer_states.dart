import 'package:geolocator/geolocator.dart';
import 'package:susanin/domain/model/location_point.dart';

abstract class MainPointerState {
  LocationPoint selectedLocationPoint;

  MainPointerState({this.selectedLocationPoint});
}

class MainPointerStateLoading extends MainPointerState {}

class MainPointerStateLoaded extends MainPointerState {
  Position currentPosition;
  double heading;

  MainPointerStateLoaded({this.currentPosition, this.heading});

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
