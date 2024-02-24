import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/places/domain/entities/place.dart';
import 'package:susanin/features/places/domain/repositories/places_repository.dart';

class UpdatePlace extends UseCase<Future<bool>, UpdateParams> {
  const UpdatePlace(this._placesRepository);

  final PlacesRepository _placesRepository;

  @override
  Future<bool> call(UpdateParams params) async {
    final places = [
      ..._placesRepository.placesStream.valueOrNull ?? <PlaceEntity>[]
    ];
    final index = places.indexWhere((place) => place.id == params.id);
    try {
      final updatedPlace = places[index].copyWith(
        name: params.newPlaceName,
        latitude: params.latitude,
        longitude: params.longitude,
      );
      places[index] = updatedPlace;
      await _placesRepository.save(places);
      return true;
    } catch (error) {
      return false;
    }
  }
}

class UpdateParams extends Params {
  const UpdateParams({
    required this.id,
    required this.newPlaceName,
    required this.longitude,
    required this.latitude,
  });

  final String id;
  final String newPlaceName;
  final double longitude;
  final double latitude;

  @override
  List<Object?> get props => [id, newPlaceName, longitude, latitude];
}
