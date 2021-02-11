import 'package:flutter_compass/flutter_compass.dart';

abstract class MyCompassState {}

class MyCompassStateLoading extends MyCompassState {}

class MyCompassStateLoaded extends MyCompassState {
  double heading;
  MyCompassStateLoaded({this.heading});
}

class MyCompassStateError extends MyCompassState {}