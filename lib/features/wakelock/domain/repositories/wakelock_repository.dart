import 'package:rxdart/rxdart.dart';

import 'package:susanin/features/wakelock/domain/entities/wakelock_status.dart';

abstract class WakelockRepository {
  
  ValueStream<WakelockStatus> get wakelockStream;
  Future<WakelockStatus> toggle();
}
