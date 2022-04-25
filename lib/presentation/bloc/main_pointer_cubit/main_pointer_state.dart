import 'package:equatable/equatable.dart';
import 'package:susanin/domain/compass/entities/compass.dart';
import 'package:susanin/domain/location/entities/position.dart';

enum MainPointerStatus {
  loading,
  loaded,
  serviceFailure,
  permissionFailure,
  unknownFailure,
}

class MainPointerState extends Equatable {
  final PositionEntity position;
  final CompassEntity compass;
  final bool isCompassError;
  final MainPointerStatus status;
  // ! TODO поля не entities а нужные для UI - угол и расстояние.

  const MainPointerState({
    required this.position,
    required this.compass,
    required this.isCompassError,
    required this.status,
  });

  @override
  List<Object> get props => [
        position,
        compass,
        isCompassError,
        status,
      ];

  MainPointerState copyWith({
    PositionEntity? position,
    CompassEntity? compass,
    bool? isCompassError,
    MainPointerStatus? status,
  }) {
    return MainPointerState(
      position: position ?? this.position,
      compass: compass ?? this.compass,
      isCompassError: isCompassError ?? this.isCompassError,
      status: status ?? this.status,
    );
  }
}
