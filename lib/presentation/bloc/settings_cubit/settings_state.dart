import 'package:equatable/equatable.dart';

enum LocationSettingsStatus {
  loading,
  noPermission,
  granted,
}

enum CompassSettingsStatus {
  loading,
  failure,
  success,
}

enum WakelockSettingsStatus {
  loading,
  enabled,
  disabled,
}

class SettingsState extends Equatable {
  final LocationSettingsStatus locationSettingsStatus;
  final CompassSettingsStatus compassSettingsStatus;
  final WakelockSettingsStatus wakelockSettingsStatus;
  final bool isDarkTheme;
  final bool isAutoScreenOff;

  const SettingsState({
    required this.locationSettingsStatus,
    required this.compassSettingsStatus,
    required this.wakelockSettingsStatus,
    required this.isDarkTheme,
    required this.isAutoScreenOff,
  });

  @override
  List<Object> get props => [
        locationSettingsStatus,
        compassSettingsStatus,
        wakelockSettingsStatus,
        isDarkTheme,
        isAutoScreenOff,
      ];

  SettingsState copyWith({
    LocationSettingsStatus? locationSettingsStatus,
    CompassSettingsStatus? compassSettingsStatus,
    WakelockSettingsStatus? wakelockSettingsStatus,
    bool? isDarkTheme,
    bool? isAutoScreenOff,
  }) {
    return SettingsState(
      locationSettingsStatus:
          locationSettingsStatus ?? this.locationSettingsStatus,
      compassSettingsStatus:
          compassSettingsStatus ?? this.compassSettingsStatus,
      wakelockSettingsStatus:
          wakelockSettingsStatus ?? this.wakelockSettingsStatus,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      isAutoScreenOff: isAutoScreenOff ?? this.isAutoScreenOff,
    );
  }
}
