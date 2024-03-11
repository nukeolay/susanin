part of 'main_pointer_cubit.dart';

class MainPointerState extends Equatable with PointerCalculations {
  const MainPointerState({
    required this.locationServiceStatus,
    required this.compassStatus,
    required this.compassNorth,
    required this.accuracy,
    required this.userLatitude,
    required this.userLongitude,
    required this.activePlace,
  });

  final LocationStatus locationServiceStatus;
  final CompassStatus compassStatus;
  @override
  final double compassNorth;
  @override
  final double accuracy;
  @override
  double get locationLatitude => activePlace.latitude;
  @override
  double get locationLongitude => activePlace.longitude;
  @override
  final double userLatitude;
  @override
  final double userLongitude;
  final PlaceEntity activePlace;

  static final initial = MainPointerState(
    compassNorth: 0,
    activePlace: PlaceEntity.empty(),
    compassStatus: CompassStatus.loading,
    locationServiceStatus: LocationStatus.loading,
    accuracy: 0,
    userLongitude: 0,
    userLatitude: 0,
  );

  String get placeName => activePlace.name;

  bool get isLoading {
    final isCompassLoading = compassStatus == CompassStatus.loading;
    final isLocationLoading = locationServiceStatus == LocationStatus.loading;
    return isCompassLoading || isLocationLoading;
  }

  bool get isFailure =>
      locationServiceStatus.isDisabled ||
      locationServiceStatus.isNotPermitted ||
      locationServiceStatus.isUnknownError;

  bool get isEmpty => activePlace == PlaceEntity.empty();

  MainPointerState copyWith({
    LocationStatus? locationServiceStatus,
    CompassStatus? compassStatus,
    double? compassNorth,
    double? accuracy,
    double? userLatitude,
    double? userLongitude,
    PlaceEntity? activePlace,
  }) {
    return MainPointerState(
      locationServiceStatus:
          locationServiceStatus ?? this.locationServiceStatus,
      compassStatus: compassStatus ?? this.compassStatus,
      compassNorth: compassNorth ?? this.compassNorth,
      accuracy: accuracy ?? this.accuracy,
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
      activePlace: activePlace ?? this.activePlace,
    );
  }

  @override
  List<Object> get props => [
        locationServiceStatus,
        compassStatus,
        compassNorth,
        accuracy,
        locationLatitude,
        locationLongitude,
        userLatitude,
        userLongitude,
        activePlace,
      ];
}
