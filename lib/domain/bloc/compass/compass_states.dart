import 'package:flutter_compass/flutter_compass.dart';

abstract class CompassState {}

class CompassStateInit extends CompassState {}

class CompassStateCompassLoading extends CompassState {}

class CompassErrorStateNoCompass extends CompassState {}

class CompassStateOk extends CompassState {
  Stream<CompassEvent> compassFlutterStream;
  CompassStateOk(this.compassFlutterStream);
}