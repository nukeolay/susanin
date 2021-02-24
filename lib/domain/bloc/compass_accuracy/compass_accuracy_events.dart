import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

abstract class CompassAccuracyEvent {}

class CompassAccuracyEventGetServices extends CompassAccuracyEvent {}

class CompassAccuracyEventCheckPermissionsOnOff extends CompassAccuracyEvent {}

class CompassAccuracyEventChanged extends CompassAccuracyEvent {
  Position currentPosition;
  double heading;

  CompassAccuracyEventChanged({@required this.currentPosition, @required this.heading});
}

class CompassAccuracyEventError extends CompassAccuracyEvent {}

class CompassAccuracyEventErrorPermissionDeniedForever extends CompassAccuracyEventError {}

class CompassAccuracyEventErrorPermissionDenied extends CompassAccuracyEventError {}

class CompassAccuracyEventErrorServiceDisabled extends CompassAccuracyEventError {}

class CompassAccuracyEventErrorNoCompass extends CompassAccuracyEventError {}
