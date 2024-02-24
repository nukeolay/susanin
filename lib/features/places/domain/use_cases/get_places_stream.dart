import 'package:rxdart/rxdart.dart';
import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/places/domain/entities/place.dart';
import 'package:susanin/features/places/domain/repositories/places_repository.dart';

class GetPlacesStream
    extends UseCase<ValueStream<List<PlaceEntity>>, NoParams> {
  const GetPlacesStream(this._placesRepository);

  final PlacesRepository _placesRepository;

  @override
  ValueStream<List<PlaceEntity>> call(NoParams params) {
    return _placesRepository.placesStream;
  }
}
