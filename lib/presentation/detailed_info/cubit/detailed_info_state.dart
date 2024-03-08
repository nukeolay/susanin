part of 'detailed_info_cubit.dart';

class DetailedInfoState extends Equatable with PointerCalculations {
  const DetailedInfoState({
    required this.locationServiceStatus,
    required this.hasCompass,
    required this.compassNorth,
    required this.accuracy,
    required this.locationName,
    required this.locationLatitude,
    required this.locationLongitude,
    required this.userLatitude,
    required this.userLongitude,
    required this.isScreenAlwaysOn,
  });

  DetailedInfoState.initial(PlaceEntity place)
      : locationServiceStatus = LocationStatus.loading,
        hasCompass = true,
        compassNorth = 0,
        isScreenAlwaysOn = false,
        accuracy = 0,
        locationName = place.name,
        locationLatitude = place.latitude,
        locationLongitude = place.longitude,
        userLatitude = 0,
        userLongitude = 0;

  final LocationStatus locationServiceStatus;
  final bool hasCompass;
  final String locationName;
  @override
  final double compassNorth;
  @override
  final double accuracy;
  @override
  final double locationLatitude;
  @override
  final double locationLongitude;
  @override
  final double userLatitude;
  @override
  final double userLongitude;
  final bool isScreenAlwaysOn;

  DetailedInfoState copyWith({
    LocationStatus? locationServiceStatus,
    bool? hasCompass,
    String? distance,
    double? compassNorth,
    double? accuracy,
    String? locationName,
    double? locationLatitude,
    double? locationLongitude,
    double? userLatitude,
    double? userLongitude,
    bool? isScreenAlwaysOn,
  }) {
    return DetailedInfoState(
      locationServiceStatus:
          locationServiceStatus ?? this.locationServiceStatus,
      hasCompass: hasCompass ?? this.hasCompass,
      compassNorth: compassNorth ?? this.compassNorth,
      accuracy: accuracy ?? this.accuracy,
      locationName: locationName ?? this.locationName,
      locationLatitude: locationLatitude ?? this.locationLatitude,
      locationLongitude: locationLongitude ?? this.locationLongitude,
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
      isScreenAlwaysOn: isScreenAlwaysOn ?? this.isScreenAlwaysOn,
    );
  }

  @override
  List<Object> get props => [
        locationServiceStatus,
        hasCompass,
        compassNorth,
        accuracy,
        locationName,
        locationLatitude,
        locationLongitude,
        userLatitude,
        userLongitude,
        isScreenAlwaysOn,
      ];
}
