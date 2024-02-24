import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:susanin/features/places/data/models/place_model.dart';
import 'package:susanin/features/places/domain/entities/place.dart';
import 'package:susanin/features/places/domain/repositories/places_repository.dart';
import 'package:susanin/features/places/data/services/places_service.dart';

class PlacesRepositoryImpl extends PlacesRepository {
  PlacesRepositoryImpl(this._placesService);

  final PlacesService _placesService;
  BehaviorSubject<List<PlaceEntity>>? _streamController;

  BehaviorSubject<List<PlaceEntity>> _initStreamController() {
    final streamController = BehaviorSubject<List<PlaceEntity>>();
    final places = _placesService.load();
    streamController.add(places.map((e) => e.toEntity()).toList());
    return streamController;
  }

  @override
  ValueStream<List<PlaceEntity>> get placesStream {
    final controller = _streamController ??= _initStreamController();
    return controller.stream;
  }

  @override
  Future<void> save(List<PlaceEntity> places) async {
    final models = places.map((place) => PlaceModel.fromEntity(place)).toList();
    await _placesService.save(models);
    final loadedLocations = _placesService.load();
    final controller = _streamController ??= _initStreamController();
    controller.add(loadedLocations.map((e) => e.toEntity()).toList());
  }
}
