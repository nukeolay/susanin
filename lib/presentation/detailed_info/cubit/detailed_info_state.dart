part of 'detailed_info_cubit.dart';

class DetailedInfoState extends Equatable with PointerCalculations {
  const DetailedInfoState({
    required this.placeId,
    required this.place,
    required this.locationServiceStatus,
    required this.hasCompass,
    required this.compassNorth,
    required this.accuracy,
    required this.userLatitude,
    required this.userLongitude,
    required this.isScreenAlwaysOn,
  });

  DetailedInfoState.initial(this.placeId)
      : locationServiceStatus = LocationStatus.loading,
        place = PlaceEntity.empty(),
        hasCompass = true,
        compassNorth = 0,
        isScreenAlwaysOn = false,
        accuracy = 0,
        userLatitude = 0,
        userLongitude = 0;

  final String placeId;
  final PlaceEntity place;
  final LocationStatus locationServiceStatus;
  final bool hasCompass;
  String get locationName => place.name;
  String get notes => place.notes;
  @override
  final double compassNorth;
  @override
  final double accuracy;
  @override
  double get locationLatitude => place.latitude;
  @override
  double get locationLongitude => place.longitude;
  @override
  final double userLatitude;
  @override
  final double userLongitude;
  final bool isScreenAlwaysOn;

  DetailedInfoState copyWith({
    String? placeId,
    PlaceEntity? place,
    LocationStatus? locationServiceStatus,
    bool? hasCompass,
    double? compassNorth,
    double? accuracy,
    double? userLatitude,
    double? userLongitude,
    bool? isScreenAlwaysOn,
  }) {
    return DetailedInfoState(
      placeId: placeId ?? this.placeId,
      place: place ?? this.place,
      locationServiceStatus:
          locationServiceStatus ?? this.locationServiceStatus,
      hasCompass: hasCompass ?? this.hasCompass,
      compassNorth: compassNorth ?? this.compassNorth,
      accuracy: accuracy ?? this.accuracy,
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
      isScreenAlwaysOn: isScreenAlwaysOn ?? this.isScreenAlwaysOn,
    );
  }

  @override
  List<Object> get props => [
        placeId,
        place,
        locationServiceStatus,
        hasCompass,
        compassNorth,
        accuracy,
        userLatitude,
        userLongitude,
        isScreenAlwaysOn,
      ];
}
