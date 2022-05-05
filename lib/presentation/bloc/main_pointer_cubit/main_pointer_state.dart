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

enum LocationsListStatus {
  loading,
  loaded,
  failure,
}

enum SettingsStatus {
  loading,
  loaded,
  failure,
}

class MainPointerState extends Equatable {
  final LocationServiceStatus locationServiceStatus;
  final CompassStatus compassStatus;
  final LocationsListStatus locationsListStatus;
  final SettingsStatus settingsStatus;
  final String activeLocationId;
  final double userLatitude;
  final double userLongitude;
  final String pointName;
  final double pointLatitude;
  final double pointLongitude;
  final List<LocationPointEntity> locations;
  final double positionAccuracy;
  final double angle;
  final double compassAccuracy;
  final int distance;
  final double laxity;

  const MainPointerState({
    required this.locationServiceStatus,
    required this.compassStatus,
    required this.locationsListStatus,
    required this.settingsStatus,
    required this.activeLocationId,
    required this.userLatitude,
    required this.userLongitude,
    required this.pointName,
    required this.pointLatitude,
    required this.pointLongitude,
    required this.locations,
    required this.positionAccuracy,
    required this.angle,
    required this.compassAccuracy,
    required this.distance,
    required this.laxity,
  });

  @override
  List<Object> get props => [
        locationServiceStatus,
        compassStatus,
        locationsListStatus,
        settingsStatus,
        activeLocationId,
        userLatitude,
        userLongitude,
        pointName,
        pointLatitude,
        pointLongitude,
        locations,
        positionAccuracy,
        angle,
        compassAccuracy,
        distance,
        laxity,
      ];

  MainPointerState copyWith({
    LocationServiceStatus? locationServiceStatus,
    CompassStatus? compassStatus,
    LocationsListStatus? locationsListStatus,
    SettingsStatus? settingsStatus,
    String? activeLocationId,
    double? userLatitude,
    double? userLongitude,
    String? pointName,
    double? pointLatitude,
    double? pointLongitude,
    List<LocationPointEntity>? locations,
    double? positionAccuracy,
    double? angle,
    double? compassAccuracy,
    int? distance,
    double? laxity,
  }) {
    return MainPointerState(
      locationServiceStatus:
          locationServiceStatus ?? this.locationServiceStatus,
      compassStatus: compassStatus ?? this.compassStatus,
      locationsListStatus: locationsListStatus ?? this.locationsListStatus,
      settingsStatus: settingsStatus ?? this.settingsStatus,
      activeLocationId: activeLocationId ?? this.activeLocationId,
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
      pointName: pointName ?? this.pointName,
      pointLatitude: pointLatitude ?? this.pointLatitude,
      pointLongitude: pointLongitude ?? this.pointLongitude,
      locations: locations ?? this.locations,
      positionAccuracy: positionAccuracy ?? this.positionAccuracy,
      angle: angle ?? this.angle,
      compassAccuracy: compassAccuracy ?? this.compassAccuracy,
      distance: distance ?? this.distance,
      laxity: laxity ?? this.laxity,
    );
  }
}
