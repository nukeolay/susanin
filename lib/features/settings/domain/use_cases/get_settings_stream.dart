import 'package:rxdart/rxdart.dart';
import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/settings/domain/entities/settings.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';

class GetSettingsStream
    extends UseCase<ValueStream<SettingsEntity>, NoParams> {
  const GetSettingsStream(this._settingsRepository);

  final SettingsRepository _settingsRepository;

  @override
  ValueStream<SettingsEntity> call(NoParams params) {
    return _settingsRepository.settingsStream;
  }
}
