import 'package:susanin/data/wakelock/platform/wakelock_platform.dart';
import 'package:susanin/domain/wakelock/entities/wakelock.dart';
import 'package:susanin/domain/wakelock/repositories/repository.dart';

class WakelockRepositoryImpl implements WakelockRepository {
  final WakelockPlatform wakelockPlatform;

  WakelockRepositoryImpl(this.wakelockPlatform);

  @override
  Future<WakelockEntity> get wakelock => wakelockPlatform.wakelock;

  @override
  Future<void> enable() {
    return wakelockPlatform.enable();
  }

  @override
  Future<void> disable() {
    return wakelockPlatform.disable();
  }
}
