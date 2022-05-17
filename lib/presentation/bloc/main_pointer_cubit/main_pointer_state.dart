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
  final double positionAccuracy;
  final String activeLocationId;
  final double userLatitude;
  final double userLongitude;
  final String pointName;
  final double pointLatitude;
  final double pointLongitude;
  final List<LocationPointEntity> locations;
  final double angle;
  final double compassAccuracy;
  final String distance;
  final double pointerArc;

  const MainPointerState({
    required this.locationServiceStatus,
    required this.compassStatus,
    required this.locationsListStatus,
    required this.settingsStatus,
    required this.positionAccuracy,
    required this.activeLocationId,
    required this.userLatitude,
    required this.userLongitude,
    required this.pointName,
    required this.pointLatitude,
    required this.pointLongitude,
    required this.locations,
    required this.angle,
    required this.compassAccuracy,
    required this.distance,
    required this.pointerArc,
  });

  @override
  List<Object> get props => [
        locationServiceStatus,
        compassStatus,
        locationsListStatus,
        settingsStatus,
        positionAccuracy,
        activeLocationId,
        userLatitude,
        userLongitude,
        pointName,
        pointLatitude,
        pointLongitude,
        locations,
        angle,
        compassAccuracy,
        distance,
        pointerArc,
      ];

  MainPointerState copyWith({
    LocationServiceStatus? locationServiceStatus,
    CompassStatus? compassStatus,
    LocationsListStatus? locationsListStatus,
    SettingsStatus? settingsStatus,
    double? positionAccuracy,
    String? activeLocationId,
    double? userLatitude,
    double? userLongitude,
    String? pointName,
    double? pointLatitude,
    double? pointLongitude,
    List<LocationPointEntity>? locations,
    double? angle,
    double? compassAccuracy,
    String? distance,
    double? pointerArc,
  }) {
    return MainPointerState(
      locationServiceStatus:
          locationServiceStatus ?? this.locationServiceStatus,
      compassStatus: compassStatus ?? this.compassStatus,
      locationsListStatus: locationsListStatus ?? this.locationsListStatus,
      settingsStatus: settingsStatus ?? this.settingsStatus,
      positionAccuracy: positionAccuracy ?? this.positionAccuracy,
      activeLocationId: activeLocationId ?? this.activeLocationId,
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
      pointName: pointName ?? this.pointName,
      pointLatitude: pointLatitude ?? this.pointLatitude,
      pointLongitude: pointLongitude ?? this.pointLongitude,
      locations: locations ?? this.locations,
      angle: angle ?? this.angle,
      compassAccuracy: compassAccuracy ?? this.compassAccuracy,
      distance: distance ?? this.distance,
      pointerArc: pointerArc ?? this.pointerArc,
    );
  }

  bool get isLoading {
    final isCompassLoading = compassStatus == CompassStatus.loading;
    final isSettingsLoading = settingsStatus == SettingsStatus.loading;
    final isLocationLoading =
        locationServiceStatus == LocationServiceStatus.loading;
    final isLocationsLoading =
        locationsListStatus == LocationsListStatus.loading;
    return isCompassLoading ||
        isSettingsLoading ||
        isLocationLoading ||
        isLocationsLoading;
  }

  bool get isFailure {
    final isSettingsFailure = settingsStatus == SettingsStatus.failure;
    final isLocationServiceFailure =
        locationServiceStatus == LocationServiceStatus.disabled ||
            locationServiceStatus == LocationServiceStatus.noPermission ||
            locationServiceStatus == LocationServiceStatus.unknownFailure;
    final isLocationsFailure =
        locationsListStatus == LocationsListStatus.loading;
    return isSettingsFailure || isLocationServiceFailure || isLocationsFailure;
  }

  @override
  String toString() {
    return 'LocationServiceStatus: $locationServiceStatus\nCompassStatus: $compassStatus\nLocationsListStatus: $locationsListStatus\nSettingsStatus: $settingsStatus\npositionAccuracy: $positionAccuracy\nactiveLocationId: $activeLocationId\nuserLatitude: $userLatitude\nuserLongitude: $userLongitude\npointName: $pointName\npointLatitude: $pointLatitude\npointLongitude: $pointLongitude\nlocations: $locations\nangle: $angle\ncompassAccuracy: $compassAccuracy\ndistance: $distance\npointerArc: $pointerArc';
  }
}
