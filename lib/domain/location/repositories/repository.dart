import 'package:susanin/domain/location/entities/position.dart';

abstract class PositionRepository {
  Stream<PositionEntity> get positionStream;
}
