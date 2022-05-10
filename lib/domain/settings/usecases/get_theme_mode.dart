import 'package:susanin/core/usecases/usecase.dart';
import 'package:susanin/domain/settings/entities/settings.dart';
import 'package:susanin/domain/settings/repositories/repository.dart';

class GetThemeMode extends UseCase<bool> {
  final SettingsRepository _settingsRepository;
  GetThemeMode(this._settingsRepository);
  @override
  bool call() {
    final settingsOrFailure = _settingsRepository.settingsOrFailure;
    if (settingsOrFailure.isRight()) {
      try {
        final settings = settingsOrFailure.getOrElse(() => const SettingsEntity(
            isDarkTheme: false, isFirstTime: false, activeLocationId: ''));
        return settings.isDarkTheme;
      } catch (error) {
        return false;
      }
    } else {
      return false;
    }
  }
}
