import 'package:geolocator/geolocator.dart';
import 'package:susanin/domain/model/location_point.dart';

abstract class MainPointerState {}

class MainPointerStateLoading extends MainPointerState {}

class MainPointerStateEmptyList extends MainPointerState {}

class MainPointerStateLoaded extends MainPointerState {
  Position currentPosition;
  double heading;
  LocationPoint selectedLocationPoint;

  MainPointerStateLoaded({this.currentPosition, this.heading, this.selectedLocationPoint});

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

class MainPointerStateLoadedAddedNew extends MainPointerStateLoaded {
  MainPointerStateLoadedAddedNew({Position currentPosition, double heading, LocationPoint selectedLocationPoint})
      : super(currentPosition: currentPosition, heading: heading, selectedLocationPoint: selectedLocationPoint);
}

class MainPointerStateError extends MainPointerState {}

class MainPointerStateErrorPermissionDenied extends MainPointerStateError {}

class MainPointerStateErrorServiceDisabled extends MainPointerStateError {}

class MainPointerStateErrorNoCompass extends MainPointerStateError {}
