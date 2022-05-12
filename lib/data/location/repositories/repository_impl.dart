import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/exceptions.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/data/location/platform/location_service_permission_platform.dart';
import 'package:susanin/data/location/platform/position_platform.dart';
import 'package:susanin/domain/location/entities/position.dart';
import 'package:susanin/domain/location/repositories/repository.dart';

class LocationServiceRepositoryImpl implements LocationServiceRepository {
  final PositionPlatform position;
  final LocationServicePermissionPlatform properties;

  LocationServiceRepositoryImpl({
    required this.position,
    required this.properties,
  }) {
    _init();
  }

  final StreamController<Either<Failure, PositionEntity>> _streamController =
      StreamController.broadcast();

  @override
  Stream<Either<Failure, PositionEntity>> get positionStream =>
      _streamController.stream;

  void _init() async {
    position.positionStream.listen((event) {
      _streamController.add(Right(PositionEntity(
        longitude: event.longitude,
        latitude: event.latitude,
        accuracy: event.accuracy,
      )));
    }).onError((error) async {
      if (error is LocationServiceDisabledException) {
        _streamController.add(Left(LocationServiceDisabledFailure()));
      } else if (error is LocationServiceDeniedException) {
        _streamController.add(Left(LocationServiceDeniedFailure()));
      } else if (error is LocationServiceDeniedForeverException) {
        _streamController.add(Left(LocationServiceDeniedForeverFailure()));
      } else {
        _streamController.add(Left(LocationServiceUnknownFailure()));
      }
      await Future.delayed(const Duration(
          milliseconds: 1000)); // pause before next try after error
      _init();
    });
  }

  @override
  Future<bool> requestPermission() {
    return properties.requestPermission();
  }
}
