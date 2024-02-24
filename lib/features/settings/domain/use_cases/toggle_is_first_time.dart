import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/settings/domain/entities/settings.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';

class ToggleIsFirstTime extends UseCase<Future<void>, NoParams> {
  const ToggleIsFirstTime(this._settingsRepository);

  final SettingsRepository _settingsRepository;

  @override
  Future<void> call(NoParams params) async {
    final settings =
        _settingsRepository.settingsStream.valueOrNull ?? SettingsEntity.empty;
    final newSettings = settings.copyWith(isFirstTime: false);
    await _settingsRepository.save(newSettings);
  }
}
