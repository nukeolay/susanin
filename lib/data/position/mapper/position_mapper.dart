import 'package:susanin/data/position/geolocator/model/position_geolocator_model.dart';
import 'package:susanin/domain/position/entities/position.dart';

class PositionMapper {
  static PositionEntity fromGeolocator(PositionGeolocatorModel positionGeolocatorModel) {
    return PositionEntity(
      longitude: positionGeolocatorModel.longitude,
      latitude: positionGeolocatorModel.latitude,
      accuracy: positionGeolocatorModel.accuracy,
    );
  }

  // static PositionGeolocatorModel toGeolocator(PositionEntity positionEntity) {
  //   return PositionGeolocatorModel(
  //     singleFlips: hints.singleFlips,
  //     solutionsNumber: hints.solutionsNumber,
  //   );
  // }
}
