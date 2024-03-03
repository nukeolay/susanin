import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/places/domain/repositories/places_repository.dart';
import 'package:susanin/features/settings/domain/entities/settings.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';
import 'package:susanin/features/settings/domain/use_cases/set_active_place.dart';

class DeletePlace extends UseCase<Future<bool>, DeleteParams> {
  const DeletePlace({
    required PlacesRepository placesRepository,
    required SetActivePlace setActivePlace,
    required SettingsRepository settingsRepository,
  })  : _placesRepository = placesRepository,
        _setActivePlace = setActivePlace,
        _settingsRepository = settingsRepository;

  final PlacesRepository _placesRepository;
  final SetActivePlace _setActivePlace;
  final SettingsRepository _settingsRepository;

  @override
  Future<bool> call(DeleteParams params) async {
    try {
      final places = _placesRepository.placesStream.valueOrNull ?? [];
      final settings = _settingsRepository.settingsStream.valueOrNull ??
          SettingsEntity.empty;
      final activeLocationId = settings.activePlaceId;
      final index = places.indexWhere(
        (savedLocation) => savedLocation.id == params.placeId,
      );
      places.removeAt(index);
      final String newActivePlaceId;
      // checking if deleted place was not active
      if (activeLocationId != params.placeId) {
        // updating places list
        await _placesRepository.create(places);
        return true;
      }
      if (places.isEmpty) {
        newActivePlaceId = '';
      } else {
        final newIndex = index == 0 ? 0 : index - 1;
        newActivePlaceId = places[newIndex].id;
      }
      await _setActivePlace(SetPlaceParams(placeId: newActivePlaceId));
      // updating places list
      await _placesRepository.create(places);
      return true;
    } catch (error) {
      return false;
    }
  }
}

class DeleteParams extends Params {
  const DeleteParams({
    required this.placeId,
  });

  final String placeId;

  @override
  List<Object?> get props => [placeId];
}
