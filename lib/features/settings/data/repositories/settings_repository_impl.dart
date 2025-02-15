import 'dart:async';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:susanin/core/services/local_storage.dart';
import 'package:susanin/features/settings/data/models/settings_model.dart';
import 'package:susanin/features/settings/domain/entities/settings.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  SettingsRepositoryImpl(this._localStorage);

  final LocalStorage _localStorage;
  BehaviorSubject<SettingsEntity>? _streamController;
  final _settingsKey = 'settings';

  @override
  ValueStream<SettingsEntity> get settingsStream {
    final controller = _streamController ??= _initStreamController();
    return controller.stream;
  }

  @override
  Future<void> update(SettingsEntity settings) async {
    final model = SettingsModel.fromEntity(settings);
    await _saveSettings(model);
    _streamController?.add(settings);
  }

  @override
  Future<ThemeMode> setTheme(ThemeMode mode) async {
    final settings = settingsStream.valueOrNull ?? SettingsEntity.empty;
    try {
      final newSettings = settings.copyWith(themeMode: mode);
      await update(newSettings);
      return mode;
    } catch (error) {
      return mode.isDark ? ThemeMode.light : ThemeMode.dark;
    }
  }

  BehaviorSubject<SettingsEntity> _initStreamController() {
    final streamController = BehaviorSubject<SettingsEntity>();
    _loadSettings().then((value) {
      final settings = value?.toEntity() ?? SettingsEntity.empty;
      streamController.add(settings);
    });
    return streamController;
  }

  Future<SettingsModel?> _loadSettings() async {
    final rawData = await _localStorage.load(key: _settingsKey);
    if (rawData == null) {
      return null;
    }
    final json = jsonDecode(rawData) as Map<String, dynamic>;
    final settings = SettingsModel.fromJson(json);
    return settings;
  }

  Future<void> _saveSettings(SettingsModel settings) async {
    final jsonSettings = json.encode(settings);
    await _localStorage.save(key: _settingsKey, data: jsonSettings);
  }
}
