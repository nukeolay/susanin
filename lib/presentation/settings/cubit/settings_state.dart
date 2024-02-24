part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.locationServiceStatus,
    required this.compassStatus,
    required this.isScreenAlwaysOn,
  });

  final LocationStatus locationServiceStatus;
  final CompassStatus compassStatus;
  final bool isScreenAlwaysOn;

  static const initial = SettingsState(
    locationServiceStatus: LocationStatus.loading,
    compassStatus: CompassStatus.loading,
    isScreenAlwaysOn: false,
  );

  SettingsState copyWith({
    LocationStatus? locationServiceStatus,
    CompassStatus? compassStatus,
    bool? isDarkTheme,
    bool? isScreenAlwaysOn,
  }) {
    return SettingsState(
      locationServiceStatus:
          locationServiceStatus ?? this.locationServiceStatus,
      compassStatus: compassStatus ?? this.compassStatus,
      isScreenAlwaysOn: isScreenAlwaysOn ?? this.isScreenAlwaysOn,
    );
  }

  @override
  List<Object> get props => [
        locationServiceStatus,
        compassStatus,
        isScreenAlwaysOn,
      ];
}
