import 'package:susanin/data/position/geolocator/model/position_geolocator_model.dart';
import 'package:susanin/domain/position/entities/position.dart';

class PositionMapper {
  static PositionEntity fromGeolocator(PositionGeolocatorModel geolocatorPosition) {
    return PositionEntity(
      longitude: geolocatorPosition.longitude,
      latitude: geolocatorPosition.latitude,
      accuracy: geolocatorPosition.accuracy,
    );
  }
}
