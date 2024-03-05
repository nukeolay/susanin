import 'package:equatable/equatable.dart';

class SettingsEntity extends Equatable {
  const SettingsEntity({
    required this.themeMode,
    required this.isFirstTime,
  });

  final ThemeMode themeMode;
  final bool isFirstTime;

  static const empty = SettingsEntity(
    themeMode: ThemeMode.light,
    isFirstTime: true,
  );

  SettingsEntity copyWith({
    ThemeMode? themeMode,
    bool? isFirstTime,
  }) {
    return SettingsEntity(
      themeMode: themeMode ?? this.themeMode,
      isFirstTime: isFirstTime ?? this.isFirstTime,
    );
  }

  @override
  String toString() {
    return 'SettingsEntity {themeMode: $themeMode, isFirstTime: $isFirstTime}';
  }

  @override
  List<Object?> get props => [themeMode, isFirstTime];
}

enum ThemeMode { dark, light }

extension ThemeModeExtension on ThemeMode {
  bool get isDark => this == ThemeMode.dark;
  bool get isLight => this == ThemeMode.light;
}
