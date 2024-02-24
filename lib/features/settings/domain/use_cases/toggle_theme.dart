import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/settings/domain/entities/settings.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';

class ToggleTheme extends UseCase<Future<bool>, NoParams> {
  const ToggleTheme(this._settingsRepository);

  final SettingsRepository _settingsRepository;

  @override
  Future<bool> call(NoParams params) async {
    final settings =
        _settingsRepository.settingsStream.valueOrNull ?? SettingsEntity.empty;
    try {
      final newSettings = settings.copyWith(
        themeMode: settings.themeMode.isDark ? ThemeMode.light : ThemeMode.dark,
      );
      await _settingsRepository.save(newSettings);
      return true;
    } catch (error) {
      return false;
    }
  }
}
