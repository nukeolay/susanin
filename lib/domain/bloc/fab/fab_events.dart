import 'package:geolocator/geolocator.dart';

abstract class FabEvent {}

class FabEventPressed extends FabEvent {
  Position currentPosition;

  FabEventPressed({this.currentPosition});
}

class FabEventLoaded extends FabEvent {}

class FabEventAdded extends FabEvent {}

class FabEventError extends FabEvent {}
