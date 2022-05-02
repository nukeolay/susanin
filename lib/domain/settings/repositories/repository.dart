import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/domain/settings/entities/settings.dart';

abstract class SettingsRepository {
  Stream<Either<Failure, SettingsEntity>> get settingsStream;
  Either<Failure, SettingsEntity> get settingsOrFailure;

  Future<void> save(SettingsEntity settings);
}
