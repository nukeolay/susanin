import 'package:equatable/equatable.dart';

enum MainPointerStatus {
  loading,
  loaded,
  serviceFailure,
  permissionFailure,
  unknownFailure,
}

class MainPointerState extends Equatable {
  // final String activeLocation;
  final double latitude;
  final double longitude;
  final double positionAccuracy;
  final double angle;
  final double compassAccuracy;
  final bool isCompassError;
  final MainPointerStatus status;
  // ! TODO поля не entities а нужные для UI - угол и расстояние.

  const MainPointerState({
    required this.latitude,
    required this.longitude,
    required this.positionAccuracy,
    required this.angle,
    required this.compassAccuracy,
    required this.isCompassError,
    required this.status,
  });

  @override
  List<Object> get props => [
        latitude,
        longitude,
        positionAccuracy,
        angle,
        compassAccuracy,
        isCompassError,
        status,
      ];

  MainPointerState copyWith({
    double? latitude,
    double? longitude,
    double? positionAccuracy,
    double? angle,
    double? compassAccuracy,
    bool? isCompassError,
    MainPointerStatus? status,
  }) {
    return MainPointerState(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      positionAccuracy: positionAccuracy ?? this.positionAccuracy,
      angle: angle ?? this.angle,
      compassAccuracy: compassAccuracy ?? this.compassAccuracy,
      isCompassError: isCompassError ?? this.isCompassError,
      status: status ?? this.status,
    );
  }
}
