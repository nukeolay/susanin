import 'package:equatable/equatable.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';

enum LocationServiceStatus {
  loading,
  loaded,
  disabled,
  noPermission,
  unknownFailure,
}

enum CompassStatus {
  loading,
  loaded,
  failure,
}

enum ActiveLocationStatus {
  loading,
  loaded,
  empty,
  failure,
}

class MainPointerState extends Equatable {
  final LocationServiceStatus locationServiceStatus;
  final CompassStatus compassStatus;
  final ActiveLocationStatus activeLocationStatus;
  final String mainText;
  final String subText;
  final double positionAccuracy;
  final double userLatitude;
  final double userLongitude;
  final LocationPointEntity activeLocationPoint;
  final double angle;
  final double pointerArc;

  const MainPointerState({
    required this.locationServiceStatus,
    required this.compassStatus,
    required this.activeLocationStatus,
    required this.mainText,
    required this.subText,
    required this.positionAccuracy,
    required this.userLatitude,
    required this.userLongitude,
    required this.activeLocationPoint,
    required this.angle,
    required this.pointerArc,
  });

  @override
  List<Object> get props => [
        locationServiceStatus,
        compassStatus,
        activeLocationStatus,
        mainText,
        subText,
        positionAccuracy,
        userLatitude,
        userLongitude,
        activeLocationPoint,
        angle,
        pointerArc,
      ];

  MainPointerState copyWith({
    LocationServiceStatus? locationServiceStatus,
    CompassStatus? compassStatus,
    ActiveLocationStatus? activeLocationStatus,
    String? mainText,
    String? subText,
    double? positionAccuracy,
    double? userLatitude,
    double? userLongitude,
    LocationPointEntity? activeLocationPoint,
    double? angle,
    double? pointerArc,
  }) {
    return MainPointerState(
      locationServiceStatus:
          locationServiceStatus ?? this.locationServiceStatus,
      compassStatus: compassStatus ?? this.compassStatus,
      activeLocationStatus: activeLocationStatus ?? this.activeLocationStatus,
      mainText: mainText ?? this.mainText,
      subText: subText ?? this.subText,
      positionAccuracy: positionAccuracy ?? this.positionAccuracy,
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
      activeLocationPoint: activeLocationPoint ?? this.activeLocationPoint,
      angle: angle ?? this.angle,
      pointerArc: pointerArc ?? this.pointerArc,
    );
  }

  bool get isLoading {
    final isCompassLoading = compassStatus == CompassStatus.loading;
    final isLocationLoading =
        locationServiceStatus == LocationServiceStatus.loading;
    final isActiveLocationLoading =
        activeLocationStatus == ActiveLocationStatus.loading;
    return isCompassLoading || isLocationLoading || isActiveLocationLoading;
  }

  bool get isFailure {
    final isLocationServiceFailure =
        locationServiceStatus == LocationServiceStatus.disabled ||
            locationServiceStatus == LocationServiceStatus.noPermission ||
            locationServiceStatus == LocationServiceStatus.unknownFailure;
    final isActiveLocationFailure =
        activeLocationStatus == ActiveLocationStatus.failure;
    return isActiveLocationFailure || isLocationServiceFailure;
  }

  bool get isEmpty => activeLocationStatus == ActiveLocationStatus.empty;
}
