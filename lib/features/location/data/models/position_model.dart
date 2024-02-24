import 'package:susanin/features/location/domain/entities/position.dart';

class PositionModel extends PositionEntity {
  const PositionModel({
    required super.longitude,
    required super.latitude,
    required super.accuracy,
  });
}
