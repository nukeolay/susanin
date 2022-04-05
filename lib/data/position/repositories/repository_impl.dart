import 'package:susanin/data/position/geolocator/geolocator_util.dart';
import 'package:susanin/domain/position/entities/position.dart';
import 'package:susanin/domain/position/repositories/repository.dart';

class PositionRepositoryImpl implements PositionRepository {
  final GeolocatorUtil _geolocatorUtil;
  PositionRepositoryImpl(this._geolocatorUtil);

  @override
  Stream<PositionEntity> get position => _geolocatorUtil.load();
}
