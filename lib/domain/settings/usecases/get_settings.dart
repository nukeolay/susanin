import 'package:dartz/dartz.dart';

import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/core/usecases/usecase.dart';
import 'package:susanin/domain/settings/entities/settings.dart';
import 'package:susanin/domain/settings/repositories/repository.dart';

class GetSettings extends UseCase<Either<Failure, SettingsEntity>> {
  final SettingsRepository _settingsRepository;
  GetSettings(this._settingsRepository);
  @override
  Either<Failure, SettingsEntity> call() {
    return _settingsRepository.settingsOrFailure;
  }
}
