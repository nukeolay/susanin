import 'package:susanin/data/location/datasources/position_data_source.dart';
import 'package:susanin/domain/location/entities/position.dart';
import 'package:susanin/domain/location/repositories/repository.dart';

class PositionRepositoryImpl implements PositionRepository {
  final PositionDataSource _positionDataSource;
  PositionRepositoryImpl(this._positionDataSource);

  @override
  Stream<PositionEntity> get positionStream =>
      _positionDataSource.positionStream.map(
        (event) => PositionEntity(
          longitude: event.longitude,
          latitude: event.latitude,
          accuracy: event.accuracy,
        ),
      );
}
