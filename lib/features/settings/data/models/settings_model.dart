import 'package:susanin/features/settings/domain/entities/settings.dart';

class SettingsModel {
  const SettingsModel({
    required this.isDarkTheme,
    required this.isFirstTime,
    required this.activePlaceId,
  });

  final bool isDarkTheme;
  final bool isFirstTime;
  final String activePlaceId;

  Map<String, dynamic> toJson() => {
        'isDarkTheme': isDarkTheme,
        'isFirstTime': isFirstTime,
        'activeLocationId': activePlaceId, // TODO move to places feature
      };

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      isDarkTheme: json["isDarkTheme"] as bool,
      isFirstTime: json["isFirstTime"] as bool,
      activePlaceId: json["activeLocationId"] as String,
    );
  }

  factory SettingsModel.fromEntity(SettingsEntity entity) {
    return SettingsModel(
      isDarkTheme: entity.themeMode.isDark ? true : false,
      isFirstTime: entity.isFirstTime,
      activePlaceId: entity.activePlaceId,
    );
  }

  SettingsEntity toEntity() {
    return SettingsEntity(
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      isFirstTime: isFirstTime,
      activePlaceId: activePlaceId,
    );
  }
}
