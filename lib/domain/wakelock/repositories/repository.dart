import 'package:susanin/domain/wakelock/entities/wakelock.dart';

abstract class WakelockRepository {
  Future<WakelockEntity> get wakelock;
  Future<void> enable();
  Future<void> disable();
}
