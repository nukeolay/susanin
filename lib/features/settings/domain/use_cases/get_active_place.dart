import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/places/domain/entities/place.dart';
import 'package:susanin/features/places/domain/repositories/places_repository.dart';
import 'package:susanin/features/settings/domain/entities/settings.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';

class GetActivePlace extends UseCase<PlaceEntity?, NoParams> {
  const GetActivePlace({
    required PlacesRepository placesRepository,
    required SettingsRepository settingsRepository,
  })  : _placesRepository = placesRepository,
        _settingsRepository = settingsRepository;

  final PlacesRepository _placesRepository;
  final SettingsRepository _settingsRepository;

  @override
  PlaceEntity? call(NoParams params) {
    final settings =
        _settingsRepository.settingsStream.valueOrNull ?? SettingsEntity.empty;
    final activePlaceId = settings.activePlaceId;
    final places = _placesRepository.placesStream.valueOrNull ?? [];
    final index = places.indexWhere((place) => place.id == activePlaceId);
    if (index == -1) return null;
    return places[index];
  }
}
