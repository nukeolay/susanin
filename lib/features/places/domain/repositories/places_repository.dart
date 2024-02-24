import 'package:rxdart/rxdart.dart';
import 'package:susanin/features/places/domain/entities/place.dart';

abstract class PlacesRepository {
  ValueStream<List<PlaceEntity>> get placesStream;
  Future<void> save(List<PlaceEntity> places);
}
