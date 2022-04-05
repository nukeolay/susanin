import 'package:susanin/domain/position/entities/position.dart';
import 'package:susanin/domain/position/repositories/repository.dart';

// class GetPositionStream {
//   final PositionRepository _positionRepository;
//   GetPositionStream(this._positionRepository);
//   Stream<PositionEntity> call({int refreshPeriod = 1000}) async* {
//     while (true) {
//       await Future.delayed(Duration(milliseconds: refreshPeriod));
//       yield await _positionRepository.position;
//     }
//   }
// }

class GetPositionStream {
  final PositionRepository _positionRepository;
  GetPositionStream(this._positionRepository);
  Stream<PositionEntity> call() {
    return _positionRepository.position;
  }
}
