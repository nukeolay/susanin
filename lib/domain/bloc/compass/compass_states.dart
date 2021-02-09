import 'package:flutter_compass/flutter_compass.dart';

abstract class MyCompassState {}

class MyCompassStateLoading extends MyCompassState {}

class MyCompassStateLoaded extends MyCompassState {
  Stream<CompassEvent> compassStream;

  MyCompassStateLoaded(this.compassStream);
}

class MyCompassStateError extends MyCompassState {}