import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:susanin/core/errors/exceptions.dart';
import 'package:susanin/data/settings/models/settings_model.dart';

abstract class SettingsDataSource {
  Future<SettingsModel> load();
  Future<void> save(SettingsModel settings);
}

class SettingsDataSourceImpl implements SettingsDataSource {
  final SharedPreferences sharedPreferences;
  static const settingsKey = 'settings';

  const SettingsDataSourceImpl(this.sharedPreferences);

  @override
  Future<SettingsModel> load() async {
    final jsonSettings = sharedPreferences.getString(settingsKey);
    if (jsonSettings == null) {
      return Future.value(const SettingsModel(
        isDarkTheme: false,
        isFirstTime: true,
        activeLocationId: '',
      ));
    } else {
      try {
        final Map<String, dynamic> json = jsonDecode(jsonSettings);
        final SettingsModel settings = SettingsModel.fromJson(json);
        return Future.value(settings);
      } catch (error) {
        throw LoadLocationPointsException();
      }
    }
  }

  @override
  Future<void> save(SettingsModel settings) async {
    final String jsonSettings = json.encode(settings);
    await sharedPreferences.setString(settingsKey, jsonSettings);
  }
}
