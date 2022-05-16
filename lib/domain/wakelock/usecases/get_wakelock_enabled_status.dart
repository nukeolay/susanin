import 'package:susanin/core/usecases/usecase.dart';
import 'package:susanin/domain/wakelock/repositories/repository.dart';

class GetWakelockEnabledStatus extends UseCase<Future<bool>> {
  final WakelockRepository _wakelockRepository;
  GetWakelockEnabledStatus(this._wakelockRepository);
  @override
  Future<bool> call() async {
    return (await _wakelockRepository.wakelock).isEnabled;
  }
}
