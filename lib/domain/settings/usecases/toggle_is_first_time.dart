import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/core/usecases/usecase.dart';
import 'package:susanin/domain/settings/entities/settings.dart';
import 'package:susanin/domain/settings/repositories/repository.dart';

class ToggleIsFirstTime extends UseCase<Future<Either<Failure, bool>>> {
  final SettingsRepository _settingsRepository;
  ToggleIsFirstTime(this._settingsRepository);
  @override
  Future<Either<Failure, bool>> call() async {
    final settingsOrFailure = _settingsRepository.settingsOrFailure;
    if (settingsOrFailure.isRight()) {
      try {
        final settings = settingsOrFailure.getOrElse(() => const SettingsEntity(
            isDarkTheme: false, isFirstTime: false, activeLocationId: ''));
        final newSettings = settings.copyWith(isFirstTime: false);
        await _settingsRepository.save(newSettings);
        return const Right(true);
      } catch (error) {
        return Left(LoadSettingsFailure());
      }
    } else {
      return Left(LoadSettingsFailure());
    }
  }
}
