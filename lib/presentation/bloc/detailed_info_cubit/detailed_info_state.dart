import 'package:equatable/equatable.dart';

enum LocationServiceStatus {
  loading,
  loaded,
  disabled,
  noPermission,
  unknownFailure,
}

class DetailedInfoState extends Equatable {
  final LocationServiceStatus locationServiceStatus;
  final String errorMessage;
  final bool hasCompass;
  final String distance;
  final double positionAccuracy;
  final double angle;
  final double pointerArc;
  final String locationName;
  final double locationLatitude;
  final double locationLongitude;
  final double userLatitude;
  final double userLongitude;

  const DetailedInfoState({
    required this.locationServiceStatus,
    required this.errorMessage,
    required this.hasCompass,
    required this.distance,
    required this.positionAccuracy,
    required this.angle,
    required this.pointerArc,
    required this.locationName,
    required this.locationLatitude,
    required this.locationLongitude,
    required this.userLatitude,
    required this.userLongitude,
  });

  @override
  List<Object> get props => [
        locationServiceStatus,
        errorMessage,
        hasCompass,
        distance,
        positionAccuracy,
        angle,
        pointerArc,
        locationName,
        locationLatitude,
        locationLongitude,
        userLatitude,
        userLongitude,
      ];

  DetailedInfoState copyWith({
    LocationServiceStatus? locationServiceStatus,
    String? errorMessage,
    bool? hasCompass,
    String? distance,
    double? positionAccuracy,
    double? angle,
    double? pointerArc,
    String? locationName,
    double? locationLatitude,
    double? locationLongitude,
    double? userLatitude,
    double? userLongitude,
  }) {
    return DetailedInfoState(
      locationServiceStatus:
          locationServiceStatus ?? this.locationServiceStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      hasCompass: hasCompass ?? this.hasCompass,
      distance: distance ?? this.distance,
      positionAccuracy: positionAccuracy ?? this.positionAccuracy,
      angle: angle ?? this.angle,
      pointerArc: pointerArc ?? this.pointerArc,
      locationName: locationName ?? this.locationName,
      locationLatitude: locationLatitude ?? this.locationLatitude,
      locationLongitude: locationLongitude ?? this.locationLongitude,
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
    );
  }

  bool get isFailure {
    return locationServiceStatus == LocationServiceStatus.disabled ||
        locationServiceStatus == LocationServiceStatus.noPermission ||
        locationServiceStatus == LocationServiceStatus.unknownFailure;
  }
}
