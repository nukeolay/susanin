import 'package:rxdart/rxdart.dart';
import 'package:susanin/features/places/domain/entities/place_entity.dart';
import 'package:susanin/features/places/domain/entities/places_entity.dart';

abstract class PlacesRepository {
  ValueStream<PlacesEntity> get placesStream;
  Future<bool> create(PlaceEntity place);
  Future<bool> update(PlaceEntity place);
  Future<bool> select(String placeId);
  Future<bool> delete(String placeId);
}
