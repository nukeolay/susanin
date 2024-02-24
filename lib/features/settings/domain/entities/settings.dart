import 'package:equatable/equatable.dart';

class SettingsEntity extends Equatable {
  const SettingsEntity({
    required this.themeMode,
    required this.isFirstTime,
    required this.activePlaceId,
  });

  final ThemeMode themeMode;
  final bool isFirstTime;
  final String activePlaceId;

  static const empty = SettingsEntity(
    themeMode: ThemeMode.light,
    isFirstTime: true,
    activePlaceId: '',
  );

  SettingsEntity copyWith({
    ThemeMode? themeMode,
    bool? isFirstTime,
    String? activePlaceId,
  }) {
    return SettingsEntity(
      themeMode: themeMode ?? this.themeMode,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      activePlaceId: activePlaceId ?? this.activePlaceId,
    );
  }

  @override
  String toString() {
    return 'SettingsEntity {themeMode: $themeMode, isFirstTime: $isFirstTime, activePlaceId: $activePlaceId}';
  }

  @override
  List<Object?> get props => [themeMode, isFirstTime, activePlaceId];
}

enum ThemeMode { dark, light }

extension ThemeModeExtension on ThemeMode {
  bool get isDark => this == ThemeMode.dark;
  bool get isLight => this == ThemeMode.light;
}
