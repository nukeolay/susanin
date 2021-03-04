import 'package:flutter/cupertino.dart';
import 'package:susanin/domain/model/location_point.dart';

abstract class PointerState {}

class PointerStateInit extends PointerState {}

class PointerStateLoading extends PointerState {}

class PointerStateEmptyList extends PointerState {}

class PointerStateLoaded extends PointerState {
  double distance;
  double azimuth;
  LocationPoint selectedLocationPoint;

  PointerStateLoaded({@required this.distance, @required this.azimuth, @required this.selectedLocationPoint});
}

class PointerStatePointSelected extends PointerState {
  LocationPoint selectedLocationPoint;

  PointerStatePointSelected({@required this.selectedLocationPoint});
}

class PointerStateError extends PointerState {}

class PointerStateErrorPermissionDenied extends PointerStateError {}

class PointerStateErrorPermissionDeniedForever extends PointerStateError {}

class PointerStateErrorServiceDisabled extends PointerStateError {}

class PointerStateErrorNoCompass extends PointerStateError {}
