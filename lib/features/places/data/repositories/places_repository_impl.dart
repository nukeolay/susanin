import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:susanin/core/errors/exceptions.dart';
import 'package:susanin/core/services/local_storage.dart';
import 'package:susanin/features/places/data/models/place_model.dart';
import 'package:susanin/features/places/domain/entities/place_entity.dart';
import 'package:susanin/features/places/domain/entities/places_entity.dart';
import 'package:susanin/features/places/domain/repositories/places_repository.dart';

class PlacesRepositoryImpl extends PlacesRepository {
  PlacesRepositoryImpl(this._localStorage);

  final _placesKey = 'savedLocationStorage';
  final _activeLocationKey = 'activeLocationId';
  final LocalStorage _localStorage;
  BehaviorSubject<PlacesEntity>? _streamController;

  @override
  ValueStream<PlacesEntity> get placesStream {
    final controller = _streamController ??= _initStreamController();
    return controller.stream;
  }

  @override
  Future<bool> create(PlaceEntity place) async {
    try {
      final model = PlaceModel.fromEntity(place);
      final models = await _loadPlaces();
      final updatedModels = [...models, model];
      await _updateStorage(models: updatedModels, place: place);
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<bool> update(PlaceEntity place) async {
    try {
      final model = PlaceModel.fromEntity(place);
      final models = await _loadPlaces();
      final index = models.indexWhere((e) => e.id == model.id);
      models[index] = model;
      await _updateStorage(models: models, place: place);
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<bool> select(String placeId) async {
    try {
      await _saveActivePlaceId(placeId);
      final models = await _loadPlaces();
      final places = models.map((e) => e.toEntity()).toList();
      final activePlace =
          models.firstWhereOrNull((e) => e.id == placeId)?.toEntity();
      final result = PlacesEntity(
        places: places,
        activePlace: activePlace,
      );
      final controller = _streamController ??= _initStreamController();
      controller.add(result);
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<bool> delete(String placeId) async {
    try {
      final models = await _loadPlaces();
      final activeLocationId = await _loadAcivePlaceId();
      final index = models.indexWhere((e) => e.id == placeId);
      models.removeAt(index);
      final String newActivePlaceId;
      // checking if deleted place was not active
      if (activeLocationId != placeId) {
        final activePlace = models
            .firstWhereOrNull((e) => e.id == activeLocationId)
            ?.toEntity();
        await _updateStorage(models: models, place: activePlace);
        return true;
      }
      if (models.isEmpty) {
        newActivePlaceId = '';
      } else {
        final newIndex = index == 0 ? 0 : index - 1;
        newActivePlaceId = models[newIndex].id;
      }
      final activePlace =
          models.firstWhereOrNull((e) => e.id == newActivePlaceId)?.toEntity();
      await _updateStorage(models: models, place: activePlace);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<void> _updateStorage({
    required List<PlaceModel> models,
    required PlaceEntity? place,
  }) async {
    await _savePlaces(models);
    await _saveActivePlaceId(place?.id ?? '');
    final places = models.map((e) => e.toEntity()).toList();
    final result = PlacesEntity(
      places: places,
      activePlace: place,
    );
    final controller = _streamController ??= _initStreamController();
    controller.add(result);
  }

  Future<List<PlaceModel>> _loadPlaces() async {
    final rawData = await _localStorage.load(key: _placesKey);
    if (rawData == null) {
      return const [];
    }
    try {
      final json =
          (jsonDecode(rawData) as List<dynamic>).cast<Map<String, dynamic>>();
      final points =
          json.map((element) => PlaceModel.fromJson(element)).toList();
      return points;
    } catch (error) {
      throw LoadLocationPointsException();
    }
  }

  Future<void> _savePlaces(List<PlaceModel> places) async {
    final jsonLocations = json.encode(places);
    await _localStorage.save(key: _placesKey, data: jsonLocations);
  }

  Future<String?> _loadAcivePlaceId() {
    return _localStorage.load(key: _activeLocationKey);
  }

  Future<void> _saveActivePlaceId(String id) async {
    await _localStorage.save(key: _activeLocationKey, data: id);
  }

  BehaviorSubject<PlacesEntity> _initStreamController() {
    final streamController = BehaviorSubject<PlacesEntity>();
    Future.wait([
      _loadPlaces(),
      _loadAcivePlaceId(),
    ]).then((value) {
      final PlacesEntity result;
      final places = value[0]! as List<PlaceModel>;
      final activePlaceId = value[1] as String?;
      if (places.isEmpty) {
        result = const PlacesEntity(
          places: [],
          activePlace: null,
        );
        streamController.add(result);
      } else {
        final activePlace = places.firstWhereOrNull(
          (element) => element.id == activePlaceId,
        );
        result = PlacesEntity(
          places: places,
          activePlace: activePlace,
        );
        streamController.add(result);
      }
      streamController.add(result);
    });
    return streamController;
  }
}
