import 'package:susanin/features/settings/domain/entities/settings.dart';

class SettingsModel {
  const SettingsModel({
    required this.isDarkTheme,
    required this.isFirstTime,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      isDarkTheme: json['isDarkTheme'] as bool,
      isFirstTime: json['isFirstTime'] as bool,
    );
  }

  factory SettingsModel.fromEntity(SettingsEntity entity) {
    return SettingsModel(
      isDarkTheme: entity.themeMode.isDark,
      isFirstTime: entity.isFirstTime,
    );
  }

  final bool isDarkTheme;
  final bool isFirstTime;

  Map<String, dynamic> toJson() => {
        'isDarkTheme': isDarkTheme,
        'isFirstTime': isFirstTime,
      };

  SettingsEntity toEntity() {
    return SettingsEntity(
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      isFirstTime: isFirstTime,
    );
  }
}
