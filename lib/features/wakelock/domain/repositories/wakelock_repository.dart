import 'package:susanin/features/wakelock/domain/entities/wakelock_status.dart';

abstract class WakelockRepository {
  Future<WakelockStatus> get wakelockStatus;
  Future<void> enable();
  Future<void> disable();
}
