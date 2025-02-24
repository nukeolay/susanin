import 'package:rxdart/rxdart.dart';

import '../entities/wakelock_status.dart';

abstract class WakelockRepository {
  
  ValueStream<WakelockStatus> get wakelockStream;
  Future<WakelockStatus> toggle();
}
