import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/domain/model/location_point.dart';

abstract class PointerEvent {}

class PointerEventInit extends PointerEvent {}

class PointerEventChanged extends PointerEvent {
  Position currentPosition;
  double heading;

  PointerEventChanged({@required this.currentPosition, @required this.heading});
}

class PointerEventEmptyList extends PointerEvent {}

class PointerEventSelectPoint extends PointerEvent {
  LocationPoint selectedLocationPoint;

  PointerEventSelectPoint({@required this.selectedLocationPoint});
}

class PointerEventError extends PointerEvent {}

class PointerEventErrorPermissionDenied extends PointerEventError {}

class PointerEventErrorServiceDisabled extends PointerEventError {}

class PointerEventErrorNoCompass extends PointerEventError {}
