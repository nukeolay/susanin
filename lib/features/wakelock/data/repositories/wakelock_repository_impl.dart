import 'package:susanin/features/wakelock/data/services/wakelock_service.dart';
import 'package:susanin/features/wakelock/domain/entities/wakelock_status.dart';
import 'package:susanin/features/wakelock/domain/repositories/wakelock_repository.dart';

class WakelockRepositoryImpl implements WakelockRepository {
  const WakelockRepositoryImpl(this._wakelockService);

  final WakelockService _wakelockService;

  @override
  Future<WakelockStatus> get wakelockStatus async {
    try {
      final wackelockStatus = await _wakelockService.wakelock;
      return wackelockStatus;
    } catch (error) {
      return WakelockStatus.disabled;
    }
  }

  @override
  Future<void> enable() {
    return _wakelockService.enable();
  }

  @override
  Future<void> disable() {
    return _wakelockService.disable();
  }
}
