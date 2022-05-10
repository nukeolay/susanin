import 'package:susanin/domain/wakelock/entities/wakelockdart';

abstract class WakelockRepository {
  Future<WakelockEntity> get wakelock;
  Future<void> enable();
  Future<void> disable();
}
