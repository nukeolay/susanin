import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/domain/model/location_point.dart';

abstract class PointerState {}

class PointerStateLoading extends PointerState {}

class PointerStateEmptyList extends PointerState {}

class PointerStateLoaded extends PointerState {
  Position currentPosition;
  double heading;

  PointerStateLoaded({@required this.currentPosition, @required this.heading});
}

class PointerStatePointSelected extends PointerState {
  LocationPoint selectedLocationPoint;

  PointerStatePointSelected({@required this.selectedLocationPoint});
}

class PointerStateError extends PointerState {}

class PointerStateErrorPermissionDenied extends PointerStateError {}

class PointerStateErrorServiceDisabled extends PointerStateError {}

class PointerStateErrorNoCompass extends PointerStateError {}
