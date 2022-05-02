import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/data/location_points/models/location_point_model.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/domain/location_points/repositories/repository.dart';
import 'package:susanin/data/location_points/datasources/location_points_data_source.dart';

class LocationPointsRepositoryImpl extends LocationPointsRepository {
  final LocationsDataSource locationsDataSource;
  late Either<Failure, List<LocationPointEntity>> _locationsOrFailure;

  LocationPointsRepositoryImpl(this.locationsDataSource) {
    _init();
  }

  final StreamController<Either<Failure, List<LocationPointEntity>>>
      _streamController = StreamController.broadcast();

  void _init() async {
    try {
      final locations = (await Future.value(locationsDataSource
              .load())) // used Future.delayed to fix locations_list_cubit init bug
          .map((location) => LocationPointEntity(
                id: location.id,
                latitude: location.latitude,
                longitude: location.longitude,
                name: location.name,
                creationTime: location.creationTime,
              ))
          .toList();
      _locationsOrFailure = Right(locations);
      _streamController.add(Right(locations));
    } catch (error) {
      _locationsOrFailure = Left(LoadLocationPointsFailure());
      _streamController.add(Left(LoadLocationPointsFailure()));
    }
  }

  @override
  get locationsStream => _streamController.stream;

  @override
  get locationsOrFailure => _locationsOrFailure;

  @override
  Future<void> save(List<LocationPointEntity> locations) async {
    try {
      await locationsDataSource.save(locations
          .map((location) => LocationPointModel(
                id: location.id,
                latitude: location.latitude,
                longitude: location.longitude,
                name: location.name,
                creationTime: location.creationTime,
              ))
          .toList());
      final loadedLocations = locationsDataSource
          .load()
          .map((location) => LocationPointEntity(
                id: location.id,
                latitude: location.latitude,
                longitude: location.longitude,
                name: location.name,
                creationTime: location.creationTime,
              ))
          .toList();
      _locationsOrFailure = Right(loadedLocations);
      _streamController.add(Right(loadedLocations));
    } catch (error) {
      _locationsOrFailure = Left(SaveLocationPointsFailure());
      _streamController.add(Left(SaveLocationPointsFailure()));
    }
  }
}
