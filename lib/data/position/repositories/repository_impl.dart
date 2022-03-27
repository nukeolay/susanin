import 'package:susanin/domain/position/entities/position.dart';
import 'package:susanin/domain/position/repositories/repository.dart';

class PositionRepositoryImpl implements PositionRepository {
  late Future<PositionEntity> _position;

  @override
  Future<PositionEntity> get position => _position;
}
