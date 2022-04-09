import 'package:susanin/domain/location/repositories/repository.dart';

class RequestPermission {
  final PositionRepository _positionRepository;
  RequestPermission(this._positionRepository);
  Future<void> call() async {
    await _positionRepository.requestPermission();
  }
}
