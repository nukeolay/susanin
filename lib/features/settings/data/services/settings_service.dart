import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:susanin/core/errors/exceptions.dart';
import 'package:susanin/features/settings/data/models/settings_model.dart';

abstract class SettingsService {
  SettingsModel? load();
  Future<void> save(SettingsModel settings);
}

class SettingsServiceImpl implements SettingsService {
  const SettingsServiceImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;
  static const settingsKey = 'settings';

  @override
  SettingsModel? load() {
    final jsonSettings = sharedPreferences.getString(settingsKey);
    if (jsonSettings == null) {
      return null;
    }
    try {
      final Map<String, dynamic> json = jsonDecode(jsonSettings);
      final settings = SettingsModel.fromJson(json);
      return settings;
    } catch (error) {
      throw LoadSettingsException();
    }
  }

  @override
  Future<void> save(SettingsModel settings) async {
    final jsonSettings = json.encode(settings);
    await sharedPreferences.setString(settingsKey, jsonSettings);
  }
}
