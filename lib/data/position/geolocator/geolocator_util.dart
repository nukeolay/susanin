import 'package:susanin/data/position/geolocator/model/position_geolocator_model.dart';
import 'package:susanin/data/position/geolocator/services/geolocator_service.dart';
import 'package:susanin/data/position/mapper/position_mapper.dart';
import 'package:susanin/domain/position/entities/position.dart';

class GeolocatorUtil {
  final GeolocatorService _geolocatorService;

  GeolocatorUtil(this._geolocatorService);

  Future<PositionEntity> load() async {
    final PositionGeolocatorModel result = await _geolocatorService.load();
    return PositionMapper.fromGeolocator(result);
  }
}
