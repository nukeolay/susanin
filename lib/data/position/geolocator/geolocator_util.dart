import 'package:susanin/data/position/geolocator/model/position_geolocator_model.dart';
import 'package:susanin/data/position/geolocator/services/geolocator_service.dart';
import 'package:susanin/data/position/mapper/position_mapper.dart';
import 'package:susanin/domain/position/entities/position.dart';

class GeolocatorUtil {
  final GeolocatorService _geolocatorService;

  GeolocatorUtil(this._geolocatorService);

  Stream<PositionEntity> load() {
    final Stream<PositionGeolocatorModel> result = _geolocatorService.load();
    return result.map((position) => PositionMapper.fromGeolocator(position));
  }
}
