import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/wakelock/domain/entities/wakelock_status.dart';
import 'package:susanin/features/wakelock/domain/repositories/wakelock_repository.dart';

class ToggleWakelock extends UseCase<Future<WakelockStatus>, NoParams> {
  const ToggleWakelock(this._wakelockRepository);

  final WakelockRepository _wakelockRepository;

  @override
  Future<WakelockStatus> call(NoParams params) async {
    final wakelockStatus = await _wakelockRepository.wakelockStatus;
    if (wakelockStatus.isEnabled) {
      await _wakelockRepository.disable();
    } else {
      await _wakelockRepository.enable();
    }
    return _wakelockRepository.wakelockStatus;
  }
}
