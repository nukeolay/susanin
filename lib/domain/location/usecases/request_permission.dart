import 'package:susanin/core/usecases/usecase.dart';
import 'package:susanin/domain/location/repositories/repository.dart';

class RequestPermission extends UseCase<Future<bool>> {
  final LocationServiceRepository _positionRepository;
  RequestPermission(this._positionRepository);
  @override
  Future<bool> call() async {
    return await _positionRepository.requestPermission();
  }
}
