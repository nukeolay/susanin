import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/domain/location_points/repositories/repository.dart';
import 'package:susanin/data/location_points/datasources/location_points_data_source.dart';

class LocationPointsRepositoryImpl extends LocationPointsRepository {
  final LocationsDataSource locationsDataSource;

  LocationPointsRepositoryImpl(this.locationsDataSource) {
    _init();
  }

  final StreamController<Either<Failure, List<LocationPointEntity>>>
      _streamController = StreamController();

  void _init() async {
    try {
      final locations = await locationsDataSource.loadLocations();
      _streamController.add(Right(locations));
    } catch (error) {
      _streamController.add(Left(LoadLocationPointsFailure()));
    }
  }

  @override
  get locationsStream => _streamController.stream.asBroadcastStream();

  @override
  Future<void> saveLocations(List<LocationPointEntity> locations) async {
    final _locationsOrFailure = await _streamController.stream.last;
    _locationsOrFailure.fold((failure) {
      _streamController.add(Left(failure));
    }, (locations) async {
      await locationsDataSource.saveLocations(locations);
      _streamController.add(Right(locations));
    });
  }

  // @override
  // Future<void> saveLocation(LocationPointEntity locationPoint) async {
  //   (await _locationsOrFailure).fold((failure) {
  //     _streamController.add(Left(failure));
  //   }, (locations) async {
  //     if (locations.indexWhere((savedLocation) =>
  //             savedLocation.pointName == locationPoint.pointName) ==
  //         -1) {
  //       locations.add(locationPoint);
  //       await locationsDataSource.saveLocations(locations);
  //       _streamController.add(Right(locations));
  //     } else {
  //       _streamController.add(Left(LocationPointExistsFailure()));
  //     }
  //   });
  // }

  // @override
  // Future<void> deleteLocation(String locationName) async {
  //   (await _locationsOrFailure).fold((failure) {
  //     _streamController.add(Left(failure));
  //   }, (locations) async {
  //     try {
  //       locations.removeWhere(
  //           (savedLocation) => savedLocation.pointName == locationName);
  //       await locationsDataSource.saveLocations(locations);
  //       _streamController.add(Right(locations));
  //     } catch (error) {
  //       _streamController.add(Left(LocationPointExistsFailure()));
  //     }
  //   });
  // }

  // @override
  // Future<void> renameLocation({
  //   required String oldLocationName,
  //   required String newLocationName,
  // }) async {
  //   (await _locationsOrFailure).fold((failure) {
  //     _streamController.add(Left(failure));
  //   }, (locations) async {
  //     try {
  //       final locationIndex = locations.indexWhere(
  //           (savedLocation) => savedLocation.pointName == oldLocationName);
  //       final locationWithNewName =
  //           locations[locationIndex].copyWith(pointName: newLocationName);
  //       locations[locationIndex] = locationWithNewName;
  //       await locationsDataSource.saveLocations(locations);
  //       _streamController.add(Right(locations));
  //     } catch (error) {
  //       _streamController.add(Left(LocationPointExistsFailure()));
  //     }
  //   });
  // }
}
