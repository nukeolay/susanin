import 'package:susanin/features/wakelock/domain/entities/wakelock_status.dart';

abstract class WakelockRepository {
  // TODO заменить на stream
  Future<WakelockStatus> get wakelockStatus;
  Future<WakelockStatus> toggle();
}
