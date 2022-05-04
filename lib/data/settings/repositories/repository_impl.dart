import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/data/settings/datasources/settings_data_source.dart';
import 'package:susanin/data/settings/models/settings_model.dart';
import 'package:susanin/domain/settings/entities/settings.dart';
import 'package:susanin/domain/settings/repositories/repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final SettingsDataSource settingsDataSource;
  late Either<Failure, SettingsEntity> _settingsOrFailure;

  SettingsRepositoryImpl(this.settingsDataSource) {
    _init();
  }

  final StreamController<Either<Failure, SettingsEntity>> _streamController =
      StreamController.broadcast();

  void _init() async {
    try {
      final settings = await Future.value(settingsDataSource.load());
      _settingsOrFailure = Right(settings);
      _streamController.add(Right(settings));
    } catch (error) {
      _settingsOrFailure = Left(LoadSettingsFailure());
      _streamController.add(Left(LoadSettingsFailure()));
    }
  }

  @override
  get settingsStream => _streamController.stream;

  @override
  get settingsOrFailure => _settingsOrFailure;

  @override
  Future<void> save(SettingsEntity settings) async {
    try {
      await settingsDataSource.save(SettingsModel(
        isDarkTheme: settings.isDarkTheme,
        isFirstTime: settings.isFirstTime,
        activeLocationId: settings.activeLocationId,
      ));
      final loadedSettings = settingsDataSource.load(); // убрал await
      _settingsOrFailure = Right(loadedSettings);
      _streamController.add(Right(loadedSettings));
    } catch (error) {
      _settingsOrFailure = Left(SaveSettingsFailure());
      _streamController.add(Left(SaveSettingsFailure()));
    }
  }
}
