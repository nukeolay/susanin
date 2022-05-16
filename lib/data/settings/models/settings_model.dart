import 'package:susanin/domain/settings/entities/settings.dart';

class SettingsModel extends SettingsEntity {
  const SettingsModel({
    required bool isDarkTheme,
    required bool isFirstTime,
    required String activeLocationId,
  }) : super(
          isDarkTheme: isDarkTheme,
          isFirstTime: isFirstTime,
          activeLocationId: activeLocationId,
        );

  Map<String, dynamic> toJson() => {
        'isDarkTheme': isDarkTheme,
        'isFirstTime': isFirstTime,
        'activeLocationId': activeLocationId,
      };

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      isDarkTheme: json["isDarkTheme"] as bool,
      isFirstTime: json["isFirstTime"] as bool,
      activeLocationId: json["activeLocationId"] as String,
    );
  }
}
