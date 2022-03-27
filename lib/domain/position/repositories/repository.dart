import 'package:susanin/domain/position/entities/position.dart';

abstract class PositionRepository {
  Future<PositionEntity> get position;

}
