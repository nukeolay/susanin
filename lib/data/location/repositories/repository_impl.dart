import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/location_service/exceptions.dart'
    as susanin;
import 'package:susanin/core/errors/location_service/failure.dart';
import 'package:susanin/data/location/datasources/location_service_properties_datasource.dart';
import 'package:susanin/data/location/datasources/position_datasource.dart';
import 'package:susanin/domain/location/entities/location_service_properties.dart';
import 'package:susanin/domain/location/entities/position.dart';
import 'package:susanin/domain/location/repositories/repository.dart';

class LocationServiceRepositoryImpl implements LocationServiceRepository {
  final PositionDataSource positionDataSource;
  final LocationServicePropertiesDataSource propertiesDataSource;

  LocationServiceRepositoryImpl({
    required this.positionDataSource,
    required this.propertiesDataSource,
  });

  @override
  Stream<Either<Failure, PositionEntity>> get positionStream async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 1000));
      try {
        await for (final geolocatorPosition
            in positionDataSource.positionStream) {
          yield Right(PositionEntity(
            longitude: geolocatorPosition.longitude,
            latitude: geolocatorPosition.latitude,
            accuracy: geolocatorPosition.accuracy,
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
    return propertiesDataSource.requestPermission();
  }

  @override
  Future<LocationServicePropertiesEntity> get properties async {
    final _properties = await propertiesDataSource.properties;
    return LocationServicePropertiesEntity(
        isPermissionGranted: _properties.isPermissionGranted,
        isEnabled: _properties.isEnabled);
  }
}
