import 'package:geolocator/geolocator.dart';

abstract class PositionState {}

class PositionStateLoading extends PositionState {}

class PositionStateLoaded extends PositionState {
  Stream<Position> positionStream;

  PositionStateLoaded(this.positionStream);
}

class PositionStateError extends PositionState {}

class PositionStateErrorPermissionDenied extends PositionStateError {}

class PositionStateErrorServiceDisabled extends PositionStateError {}
