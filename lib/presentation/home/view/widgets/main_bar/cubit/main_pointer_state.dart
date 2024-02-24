part of 'main_pointer_cubit.dart';

class MainPointerState extends Equatable with PointerCalculations {
  const MainPointerState({
    required this.locationServiceStatus,
    required this.compassStatus,
    required this.activePlaceStatus,
    required this.compassNorth,
    required this.accuracy,
    required this.userLatitude,
    required this.userLongitude,
    required this.activePlace,
  });

  final LocationStatus locationServiceStatus;
  final CompassStatus compassStatus;
  final ActivePlaceStatus activePlaceStatus;
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
    activePlace: PlaceEntity(
      id: '',
      latitude: 0,
      longitude: 0,
      name: '',
      creationTime: DateTime.now(),
    ),
    compassStatus: CompassStatus.loading,
    activePlaceStatus: ActivePlaceStatus.loading,
    locationServiceStatus: LocationStatus.loading,
    accuracy: 0,
    userLongitude: 0,
    userLatitude: 0,
  );

  String get placeName => activePlace.name;

  bool get isLoading {
    final isCompassLoading = compassStatus == CompassStatus.loading;
    final isLocationLoading = locationServiceStatus == LocationStatus.loading;
    final isActivePlaceLoading = activePlaceStatus.isLoading;
    return isCompassLoading || isLocationLoading || isActivePlaceLoading;
  }

  bool get isFailure {
    final isLocationServiceFailure = locationServiceStatus.isDisabled ||
        locationServiceStatus.isNotPermitted ||
        locationServiceStatus.isUnknownError;
    final isActiveLocationFailure = activePlaceStatus.isFailure;
    return isActiveLocationFailure || isLocationServiceFailure;
  }

  bool get isEmpty => activePlaceStatus.isEmpty;

  MainPointerState copyWith({
    LocationStatus? locationServiceStatus,
    CompassStatus? compassStatus,
    ActivePlaceStatus? activePlaceStatus,
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
      activePlaceStatus: activePlaceStatus ?? this.activePlaceStatus,
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
        activePlaceStatus,
        compassNorth,
        accuracy,
        locationLatitude,
        locationLongitude,
        userLatitude,
        userLongitude,
        activePlace,
      ];
}
