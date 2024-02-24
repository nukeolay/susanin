import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:susanin/features/settings/data/services/settings_service.dart';
import 'package:susanin/features/settings/data/models/settings_model.dart';
import 'package:susanin/features/settings/domain/entities/settings.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  SettingsRepositoryImpl(this._settingsService);

  final SettingsService _settingsService;
  final _streamController =
      BehaviorSubject<SettingsEntity>(sync: true);

  @override
  ValueStream<SettingsEntity> get settingsStream {
    final stream = _streamController.stream;
    if (stream.valueOrNull != null) {
      return stream;
    }
    final settingsModel = _settingsService.load();
    final settings = settingsModel?.toEntity() ?? SettingsEntity.empty;
    _streamController.add(settings);
    return stream;
  }

  @override
  Future<void> save(SettingsEntity settings) async {
    final model = SettingsModel.fromEntity(settings);
    await _settingsService.save(model);
    _streamController.add(settings);
  }
}
