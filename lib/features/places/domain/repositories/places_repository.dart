import 'package:rxdart/rxdart.dart';

import '../entities/place_entity.dart';
import '../entities/places_entity.dart';

abstract class PlacesRepository {
  ValueStream<PlacesEntity> get placesStream;
  Future<bool> create(PlaceEntity place);
  Future<bool> update(PlaceEntity place);
  Future<bool> select(String placeId);
  Future<bool> delete(String placeId);
}
