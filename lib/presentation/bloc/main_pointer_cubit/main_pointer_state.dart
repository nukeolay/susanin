import 'package:equatable/equatable.dart';
import 'package:susanin/domain/compass/entities/compass.dart';
import 'package:susanin/domain/location/entities/position.dart';

abstract class MainPointerState extends Equatable {
  const MainPointerState();

  @override
  List<Object> get props => [];
}

class MainPointerNoCompass extends MainPointerState {
  @override
  List<Object> get props => [];
}

class MainPointerLoading extends MainPointerState {
  @override
  List<Object> get props => [];
}

class MainPointerInit extends MainPointerState {
  @override
  List<Object> get props => [];
}

class MainPointerLoaded extends MainPointerState {
  final PositionEntity? position;
  final CompassEntity? compass;

  const MainPointerLoaded({
    this.position,
    this.compass,
  });

  @override
  List<Object> get props => [position!, compass!];
}

class MainPointerError extends MainPointerState {
  final bool isServiceEnabled;
  final bool isPermissionGranted;
  final bool isCompassError;
  final bool isUnknownError;

  const MainPointerError({
    this.isUnknownError = false,
    this.isServiceEnabled = false,
    this.isPermissionGranted = false,
    this.isCompassError = false,
  });

  @override
  List<Object> get props => [
        isServiceEnabled,
        isPermissionGranted,
        isCompassError,
        isUnknownError,
      ];
}
