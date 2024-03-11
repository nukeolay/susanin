part of 'demo_pointer_cubit.dart';

class DemoPointerState extends Equatable with PointerCalculations {
  const DemoPointerState({
    required this.locationServiceStatus,
    required this.isFirstTime,
    required this.hasCompass,
    required this.accuracy,
    required this.locationLatitude,
    required this.locationLongitude,
    required this.userLatitude,
    required this.userLongitude,
    required this.compassNorth,
  });

  final LocationStatus locationServiceStatus;
  final bool isFirstTime; // ! TODO возможно не требуется
  final bool
      hasCompass; // ! TODO если сделать compassNorth nullable то можно это свойство убрать
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

  static const initial = DemoPointerState(
    locationServiceStatus: LocationStatus.loading,
    isFirstTime: false,
    hasCompass: true,
    accuracy: 0,
    locationLatitude: 34.134057,
    locationLongitude: -118.321569,
    userLatitude: 0,
    userLongitude: 0,
    compassNorth: 0,
  );

  bool get isFailure => locationServiceStatus.isFailure;

  DemoPointerState copyWith({
    LocationStatus? locationServiceStatus,
    bool? isFirstTime,
    bool? hasCompass,
    double? accuracy,
    double? locationLatitude,
    double? locationLongitude,
    double? userLatitude,
    double? userLongitude,
    double? compassNorth,
  }) {
    return DemoPointerState(
      locationServiceStatus:
          locationServiceStatus ?? this.locationServiceStatus,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      hasCompass: hasCompass ?? this.hasCompass,
      accuracy: accuracy ?? this.accuracy,
      locationLatitude: locationLatitude ?? this.locationLatitude,
      locationLongitude: locationLongitude ?? this.locationLongitude,
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
      compassNorth: compassNorth ?? this.compassNorth,
    );
  }

  @override
  List<Object> get props => [
        compassNorth,
        userLatitude,
        userLongitude,
        locationLatitude,
        locationLongitude,
        accuracy,
        // pointerArc // bearing // distance

        compassNorth,
        locationServiceStatus,
        isFirstTime,
        hasCompass,
        locationLatitude,
        locationLongitude,
        userLatitude,
        userLongitude,
      ];
}
