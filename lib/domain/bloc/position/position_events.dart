import 'package:geolocator/geolocator.dart';

abstract class PositionEvent {}

class PositionEventGetLocationService extends PositionEvent {}

class PositionEventError extends PositionEvent {}

class PositionEventErrorServiceDisabled extends PositionEventError {}

class PositionEventLocationChanged extends PositionEvent {
  Position position;

  PositionEventLocationChanged({this.position});
}