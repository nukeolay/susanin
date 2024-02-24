import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/places/domain/entities/place.dart';
import 'package:susanin/features/places/domain/repositories/places_repository.dart';
import 'package:susanin/features/settings/domain/use_cases/set_active_place.dart';

class AddPlace extends UseCase<Future<PlaceEntity>, AddParams> {
  const AddPlace({
    required PlacesRepository placesRepository,
    required SetActivePlace setActivePlace,
  })  : _placesRepository = placesRepository,
        _setActiveLocation = setActivePlace;

  final PlacesRepository _placesRepository;
  final SetActivePlace _setActiveLocation;

  @override
  Future<PlaceEntity> call(AddParams params) async {
    final places = _placesRepository.placesStream.valueOrNull ?? [];
    final newLocation = PlaceEntity(
      id: 'id_${DateTime.now()}',
      latitude: params.latitude,
      longitude: params.longitude,
      name: params.name,
      creationTime: DateTime.now(),
    );
    places.add(newLocation);
    await _placesRepository.save(places);
    await _setActiveLocation(SetPlaceParams(placeId: newLocation.id));
    return newLocation;
  }
}

class AddParams extends Params {
  const AddParams({
    required this.longitude,
    required this.latitude,
    required this.name,
  });

  final double longitude;
  final double latitude;
  final String name;

  @override
  List<Object?> get props => [longitude, latitude, name];
}
