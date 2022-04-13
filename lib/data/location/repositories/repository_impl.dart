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
    try {
      return Right(positionDataSource.positionStream.map(
        (event) => PositionEntity(
          longitude: event.longitude,
          latitude: event.latitude,
          accuracy: event.accuracy,
        ),
      ));
    } on susanin.LocationServiceDisabledException {
      return Left(LocationServiceDisabledFailure());
    } on susanin.LocationServiceDeniedException {
      return Left(LocationServiceDeniedFailure());
    } on susanin.LocationServiceDeniedForeverException {
      return Left(LocationServiceDeniedForeverFailure());
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
