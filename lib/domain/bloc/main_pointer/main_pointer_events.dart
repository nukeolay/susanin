import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/domain/model/location_point.dart';

abstract class MainPointerEvent {}

class MainPointerEventGetServices extends MainPointerEvent {}

class MainPointerEventCheckPermissionsOnOff extends MainPointerEvent {}

class MainPointerEventChanged extends MainPointerEvent {
  Position currentPosition;
  double heading;
  LocationPoint selectedLocationPoint;

  MainPointerEventChanged({@required this.currentPosition, @required this.heading, @required this.selectedLocationPoint});
}

class MainPointerEventServiceEnabled extends MainPointerEvent {}

class MainPointerEventEmptyList extends MainPointerEvent {}

class MainPointerEventSelectPoint extends MainPointerEvent {
  LocationPoint selectedLocationPoint;

  MainPointerEventSelectPoint({@required this.selectedLocationPoint});
}

class MainPointerEventError extends MainPointerEvent {}

class MainPointerEventErrorPermissionDeniedForever extends MainPointerEventError {}

class MainPointerEventErrorPermissionDenied extends MainPointerEventError {}

class MainPointerEventErrorServiceDisabled extends MainPointerEventError {}

class MainPointerEventErrorNoCompass extends MainPointerEventError {}
