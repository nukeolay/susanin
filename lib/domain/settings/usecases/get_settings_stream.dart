import 'package:dartz/dartz.dart';

import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/core/usecases/usecase.dart';
import 'package:susanin/domain/settings/entities/settings.dart';
import 'package:susanin/domain/settings/repositories/repository.dart';

class GetSettingsStream
    extends UseCase<Stream<Either<Failure, SettingsEntity>>> {
  final SettingsRepository _settingsRepository;
  GetSettingsStream(this._settingsRepository);
  @override
  Stream<Either<Failure, SettingsEntity>> call() {
    return _settingsRepository.settingsStream;
  }
}
