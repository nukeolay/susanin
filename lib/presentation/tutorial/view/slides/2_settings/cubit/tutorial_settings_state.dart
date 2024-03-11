part of 'tutorial_settings_cubit.dart';

class TutorialSettingsState extends Equatable {
  const TutorialSettingsState({
    required this.locationStatus,
    required this.compassStatus,
    required this.isDarkTheme,
    required this.isScreenAlwaysOn,
  });

  final LocationStatus locationStatus;
  final CompassStatus compassStatus;
  final bool isDarkTheme;
  final bool isScreenAlwaysOn;

  static const initial = TutorialSettingsState(
    locationStatus: LocationStatus.loading,
    compassStatus: CompassStatus.loading,
    isDarkTheme: false,
    isScreenAlwaysOn: false,
  );

  TutorialSettingsState copyWith({
    LocationStatus? locationStatus,
    CompassStatus? compassStatus,
    bool? isDarkTheme,
    bool? isScreenAlwaysOn,
  }) {
    return TutorialSettingsState(
      locationStatus: locationStatus ?? this.locationStatus,
      compassStatus: compassStatus ?? this.compassStatus,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      isScreenAlwaysOn: isScreenAlwaysOn ?? this.isScreenAlwaysOn,
    );
  }

  @override
  List<Object> get props => [
        locationStatus,
        compassStatus,
        isDarkTheme,
        isScreenAlwaysOn,
      ];
}
