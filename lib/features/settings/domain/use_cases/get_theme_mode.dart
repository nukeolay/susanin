import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/settings/domain/entities/settings.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';

class GetThemeMode extends UseCase<ThemeMode, NoParams> {
  const GetThemeMode(this._settingsRepository);

  final SettingsRepository _settingsRepository;

  @override
  ThemeMode call(NoParams params) {
    final settings =
        _settingsRepository.settingsStream.valueOrNull ?? SettingsEntity.empty;
    return settings.themeMode;
  }
}
