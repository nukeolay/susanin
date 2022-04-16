import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/location_service/exceptions.dart' as susanin;
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
  Either<Failure, Stream<PositionEntity>> get positionStream {
    return Right(positionDataSource.positionStream.map((event) {
      return PositionEntity(
        longitude: event.longitude,
        latitude: event.latitude,
        accuracy: event.accuracy,
      );
    }).handleError((error) {
      // print('!!!!!!!!!!!!! ERROR HANDLER');
      if (error is susanin.LocationServiceDisabledException) {
        print('!MY! $error');
        return Left(LocationServiceDisabledFailure());
      } else if (error is susanin.LocationServiceDeniedException) {
        print('!MY! $error');
        return Left(LocationServiceDeniedFailure());
      } else if (error is susanin.LocationServiceDeniedForeverException) {
        print('!MY! $error');
        return Left(LocationServiceDeniedForeverFailure());
      } else {
        print('!UNKNOWN ERROR! $error');
        return Left(LocationServiceUnknownFailure());
      }
    }));
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
