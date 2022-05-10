import 'package:susanin/core/usecases/usecase.dart';
import 'package:susanin/domain/wakelock/repositories/repository.dart';

class ToggleWakelock extends UseCase<Future<void>> {
  final WakelockRepository _wakelockRepository;
  ToggleWakelock(this._wakelockRepository);
  @override
  Future<void> call() async {
    final wakelockStatus = (await _wakelockRepository.wakelock).isEnabled;
    if (wakelockStatus) {
      return await _wakelockRepository.disable();
    } else {
      await _wakelockRepository.enable();
    }
  }
}
