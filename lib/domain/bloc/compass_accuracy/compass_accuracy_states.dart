import 'package:geolocator/geolocator.dart';

abstract class CompassAccuracyState {}

class CompassAccuracyStateLoading extends CompassAccuracyState {}

class CompassAccuracyStateLoaded extends CompassAccuracyState {
  Position currentPosition;
  double heading;

  CompassAccuracyStateLoaded({this.currentPosition, this.heading});
}

class CompassAccuracyStateError extends CompassAccuracyState {}

class CompassAccuracyStateErrorPermissionDenied extends CompassAccuracyStateError {}

class CompassAccuracyStateErrorServiceDisabled extends CompassAccuracyStateError {}

class CompassAccuracyStateErrorNoCompass extends CompassAccuracyStateError {}
