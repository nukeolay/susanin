import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/settings/domain/entities/settings.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';

class GetSettings extends UseCase<SettingsEntity, NoParams> {
  const GetSettings(this._settingsRepository);

  final SettingsRepository _settingsRepository;

  @override
  SettingsEntity call(NoParams params) {
    return _settingsRepository.settingsStream.valueOrNull ??
        SettingsEntity.empty;
  }
}
