import 'package:susanin/domain/location/repositories/repository.dart';

class RequestPermission {
  final LocationServiceRepository _positionRepository;
  RequestPermission(this._positionRepository);
  Future<bool> call() async {
    return await _positionRepository.requestPermission();
  }
}
