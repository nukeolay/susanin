import 'package:susanin/domain/location/entities/position.dart';

class PositionModel extends PositionEntity {
  const PositionModel({
    required double longitude,
    required double latitude,
    required double accuracy,
  }) : super(
          longitude: longitude,
          latitude: latitude,
          accuracy: accuracy,
        );
}
