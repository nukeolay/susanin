import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/wakelock/domain/entities/wakelock_status.dart';
import 'package:susanin/features/wakelock/domain/repositories/wakelock_repository.dart';

class GetWakelockStatus extends UseCase<Future<WakelockStatus>, NoParams> {
  const GetWakelockStatus(this._wakelockRepository);

  final WakelockRepository _wakelockRepository;

  @override
  Future<WakelockStatus> call(NoParams params) async {
    return _wakelockRepository.wakelockStatus;
  }
}
