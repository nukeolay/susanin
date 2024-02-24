import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/settings/domain/entities/settings.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';

class SetActivePlace extends UseCase<Future<bool>, SetPlaceParams> {
  const SetActivePlace(this._settingsRepository);

  final SettingsRepository _settingsRepository;

  @override
  Future<bool> call(SetPlaceParams params) async {
    final settings =
        _settingsRepository.settingsStream.valueOrNull ?? SettingsEntity.empty;
    try {
      final newSettings = settings.copyWith(activePlaceId: params.placeId);
      await _settingsRepository.save(newSettings);
      return true;
    } catch (error) {
      return false;
    }
  }
}

class SetPlaceParams extends Params {
  const SetPlaceParams({
    required this.placeId,
  });

  final String placeId;

  @override
  List<Object?> get props => [placeId];
}
