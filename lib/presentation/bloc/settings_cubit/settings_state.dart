import 'package:equatable/equatable.dart';

enum LocationSettingsStatus {
  loading,
  noPermission,
  disabled,
  granted,
}

enum CompassSettingsStatus {
  loading,
  failure,
  success,
}

class SettingsState extends Equatable {
  final LocationSettingsStatus locationSettingsStatus;
  final CompassSettingsStatus compassSettingsStatus;
  final bool isDarkTheme;
  final bool isScreenAlwaysOn;

  const SettingsState({
    required this.locationSettingsStatus,
    required this.compassSettingsStatus,
    required this.isDarkTheme,
    required this.isScreenAlwaysOn,
  });

  @override
  List<Object> get props => [
        locationSettingsStatus,
        compassSettingsStatus,
        isDarkTheme,
        isScreenAlwaysOn,
      ];

  SettingsState copyWith({
    LocationSettingsStatus? locationSettingsStatus,
    CompassSettingsStatus? compassSettingsStatus,
    bool? isDarkTheme,
    bool? isScreenAlwaysOn,
  }) {
    return SettingsState(
      locationSettingsStatus:
          locationSettingsStatus ?? this.locationSettingsStatus,
      compassSettingsStatus:
          compassSettingsStatus ?? this.compassSettingsStatus,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      isScreenAlwaysOn: isScreenAlwaysOn ?? this.isScreenAlwaysOn,
    );
  }
}
