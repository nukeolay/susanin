import 'package:geolocator/geolocator.dart';
import 'package:susanin/domain/model/location_point.dart';

abstract class MainPointerEvent {}

class MainPointerEventGetServices extends MainPointerEvent {}

class MainPointerEventCheckPermissionsOnOff extends MainPointerEvent {}

class MainPointerEventChanged extends MainPointerEvent {
  Position currentPosition;
  double heading;

  MainPointerEventChanged({this.currentPosition, this.heading});
}

class MainPointerEventSelectPoint extends MainPointerEvent {
  LocationPoint selectedLocationPoint;

  MainPointerEventSelectPoint({this.selectedLocationPoint});
}

class MainPointerEventError extends MainPointerEvent {}

class MainPointerEventErrorPermissionDeniedForever extends MainPointerEventError {}

class MainPointerEventErrorPermissionDenied extends MainPointerEventError {}

class MainPointerEventErrorServiceDisabled extends MainPointerEventError {}

class MainPointerEventErrorNoCompass extends MainPointerEventError {}
