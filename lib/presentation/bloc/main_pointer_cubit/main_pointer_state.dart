import 'package:equatable/equatable.dart';

enum MainPointerStatus {
  loading,
  loaded,
  serviceFailure,
  permissionFailure,
  unknownFailure,
}

class MainPointerState extends Equatable {
  final String activeLocationId;
  final double userLatitude;
  final double userLongitude;
  final double positionAccuracy;
  final double angle;
  final double compassAccuracy;
  final bool isCompassError;
  final MainPointerStatus status;
  // ! TODO поля не entities а нужные для UI - угол и расстояние.

  const MainPointerState({
    required this.activeLocationId,
    required this.userLatitude,
    required this.userLongitude,
    required this.positionAccuracy,
    required this.angle,
    required this.compassAccuracy,
    required this.isCompassError,
    required this.status,
  });

  @override
  List<Object> get props => [
        activeLocationId,
        userLatitude,
        userLongitude,
        positionAccuracy,
        angle,
        compassAccuracy,
        isCompassError,
        status,
      ];

  MainPointerState copyWith({
    String? activeLocationId,
    double? userLatitude,
    double? userLongitude,
    double? positionAccuracy,
    double? angle,
    double? compassAccuracy,
    bool? isCompassError,
    MainPointerStatus? status,
  }) {
    return MainPointerState(
      activeLocationId: activeLocationId ?? this.activeLocationId,
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
      positionAccuracy: positionAccuracy ?? this.positionAccuracy,
      angle: angle ?? this.angle,
      compassAccuracy: compassAccuracy ?? this.compassAccuracy,
      isCompassError: isCompassError ?? this.isCompassError,
      status: status ?? this.status,
    );
  }
}
