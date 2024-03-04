import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:susanin/features/settings/data/services/settings_service.dart';
import 'package:susanin/features/settings/data/models/settings_model.dart';
import 'package:susanin/features/settings/domain/entities/settings.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  SettingsRepositoryImpl(this._settingsService);

  final SettingsService _settingsService;
  final _streamController = BehaviorSubject<SettingsEntity>(sync: true);

  @override
  ValueStream<SettingsEntity> get settingsStream {
    final stream = _streamController.stream;
    if (stream.valueOrNull != null) {
      return stream;
    }
    // TODO использовать LocalStorage
    final settingsModel = _settingsService.load();
    final settings = settingsModel?.toEntity() ?? SettingsEntity.empty;
    _streamController.add(settings);
    return stream;
  }

  @override
  Future<void> update(SettingsEntity settings) async {
    final model = SettingsModel.fromEntity(settings);
    // TODO использовать LocalStorage
    await _settingsService.save(model);
    _streamController.add(settings);
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
}
