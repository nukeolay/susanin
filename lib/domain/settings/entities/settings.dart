import 'package:equatable/equatable.dart';

class SettingsEntity extends Equatable {
  final bool isDarkTheme;
  final bool isFirstTime;
  final String activeLocation;

  const SettingsEntity({
    required this.isDarkTheme,
    required this.isFirstTime,
    required this.activeLocation,
  });

  SettingsEntity copyWith(
      {bool? isDarkTheme, bool? isFirstTime, String? activeLocation}) {
    return SettingsEntity(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      activeLocation: activeLocation ?? this.activeLocation,
    );
  }

  @override
  String toString() {
    return 'SettingsEntity {isDarkTheme: $isDarkTheme, isFirstTime: $isFirstTime, activeLocation: $activeLocation}';
  }

  @override
  List<Object?> get props => [isDarkTheme, isFirstTime, activeLocation];
}
