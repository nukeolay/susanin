import 'package:susanin/domain/position/entities/position.dart';
import 'package:susanin/domain/position/repositories/repository.dart';

class GetPosition {
  final PositionRepository _positionRepository;
  GetPosition(this._positionRepository);

  Future<PositionEntity> call() async {
    return await _positionRepository.position;
  }
}
