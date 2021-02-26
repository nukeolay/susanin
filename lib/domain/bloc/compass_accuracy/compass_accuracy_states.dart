import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

abstract class CompassAccuracyState {}

class CompassAccuracyStateInit extends CompassAccuracyState {}

class CompassAccuracyStateLoading extends CompassAccuracyState {}

class CompassAccuracyStateLoaded extends CompassAccuracyState {
  Position currentPosition;
  double heading;

  CompassAccuracyStateLoaded({@required this.currentPosition, @required this.heading});
}

class CompassAccuracyStateError extends CompassAccuracyState {}

class CompassAccuracyStateErrorPermissionDenied extends CompassAccuracyStateError {}

class CompassAccuracyStateErrorServiceDisabled extends CompassAccuracyStateError {}

class CompassAccuracyStateErrorNoCompass extends CompassAccuracyStateError {}
