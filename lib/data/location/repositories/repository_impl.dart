import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/exceptions.dart'
    as susanin;
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
  });

  @override
  Stream<Either<Failure, PositionEntity>> get positionStream async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 1000));
      try {
        await for (final positionPlatform
            in position.positionStream) {
          yield Right(PositionEntity(
            longitude: positionPlatform.longitude,
            latitude: positionPlatform.latitude,
            accuracy: positionPlatform.accuracy,
          ));
        }
      } on susanin.LocationServiceDisabledException {
        yield Left(LocationServiceDisabledFailure());
      } on susanin.LocationServiceDeniedException {
        yield Left(LocationServiceDeniedFailure());
      } on susanin.LocationServiceDeniedForeverException {
        yield Left(LocationServiceDeniedForeverFailure());
      } catch (error) {
        yield Left(LocationServiceUnknownFailure());
      }
    }
  }

  @override
  Future<bool> requestPermission() {
    return properties.requestPermission();
  }
}
