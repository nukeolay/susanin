import 'package:equatable/equatable.dart';

class SettingsEntity extends Equatable {
  final bool isDarkTheme;
  final bool isFirstTime;
  final String activeLocationId;

  const SettingsEntity({
    required this.isDarkTheme,
    required this.isFirstTime,
    required this.activeLocationId,
  });

  SettingsEntity copyWith(
      {bool? isDarkTheme, bool? isFirstTime, String? activeLocationId}) {
    return SettingsEntity(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      activeLocationId: activeLocationId ?? this.activeLocationId,
    );
  }

  @override
  String toString() {
    return 'SettingsEntity {isDarkTheme: $isDarkTheme, isFirstTime: $isFirstTime, activeLocationId: $activeLocationId}';
  }

  @override
  List<Object?> get props => [isDarkTheme, isFirstTime, activeLocationId];
}
